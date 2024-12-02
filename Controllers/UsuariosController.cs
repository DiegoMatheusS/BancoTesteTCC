using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Models;
using TCCEcoCria.Data;
using TCCEcoCria.Models;
using TCCEcoCria.Utils;

namespace TCCEcoCria.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class UsuariosController : ControllerBase
    {
        private readonly DataContext _context;
        private readonly IConfiguration _configuration;

        public UsuariosController(DataContext context, IConfiguration configuration)
        {
            _context = context;
            _configuration = configuration;
        }

        private string CriarToken(Usuario usuario)
        {
            List<Claim> claims = new()
            {
                new Claim(ClaimTypes.NameIdentifier, usuario.IdUsuario.ToString()),
                new Claim(ClaimTypes.Name, usuario.NomeUsuario),
                new Claim(ClaimTypes.Role, usuario.Perfil)
            };

            SymmetricSecurityKey key = new(Encoding.UTF8.GetBytes(_configuration["ConfiguracaoToken:Chave"]));

            SigningCredentials creds = new(key, SecurityAlgorithms.HmacSha512Signature);

            SecurityTokenDescriptor tokenDescriptor = new()
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.Now.AddDays(1),
                SigningCredentials = creds
            };

            JwtSecurityTokenHandler tokenHandler = new();
            SecurityToken token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        private async Task<bool> UsuarioExistente(string email)
        {
            return await _context.TB_USUARIOS.AnyAsync(x => x.EmailUsuario.ToLower() == email.ToLower());
        }

        [AllowAnonymous]
        [HttpPost("Registrar")]
        public async Task<IActionResult> RegistrarUsuario([FromBody] Usuario user)
        {
            if (await UsuarioExistente(user.EmailUsuario))
                return BadRequest("E-mail já cadastrado.");

            Criptografia.CriarPasswordHash(user.PasswordUsuario, out byte[] hash, out byte[] salt);
            user.PasswordUsuario = string.Empty;
            user.PasswordHash = hash;
            user.PasswordSalt = salt;

            await _context.TB_USUARIOS.AddAsync(user);
            await _context.SaveChangesAsync();

            return Ok(user.IdUsuario);
        }

        [AllowAnonymous]
        [HttpPost("Autenticar")]
        public async Task<IActionResult> AutenticarUsuario([FromBody] Usuario credenciais)
        {
            Usuario? usuario = await _context.TB_USUARIOS
                .FirstOrDefaultAsync(x => x.EmailUsuario.ToLower() == credenciais.EmailUsuario.ToLower());

            if (usuario == null || !Criptografia.VerificarPasswordHash(credenciais.PasswordUsuario, usuario.PasswordHash, usuario.PasswordSalt))
                return BadRequest("Usuário ou senha inválidos.");

            usuario.DataAcesso = DateTime.Now;
            _context.TB_USUARIOS.Update(usuario);
            await _context.SaveChangesAsync();

            usuario.PasswordHash = null;
            usuario.PasswordSalt = null;
            usuario.Token = CriarToken(usuario);

            return Ok(usuario);
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetUsuarios()
        {
            List<Usuario> lista = await _context.TB_USUARIOS.ToListAsync();
            return Ok(lista);
        }

        [HttpGet("{usuarioId}")]
        public async Task<IActionResult> GetUsuario(int usuarioId)
        {
            Usuario? usuario = await _context.TB_USUARIOS
                .FirstOrDefaultAsync(x => x.IdUsuario == usuarioId);

            return Ok(usuario);
        }

        [HttpPut("AtualizarEmail")]
        public async Task<IActionResult> AtualizarEmail([FromBody] Usuario u)
        {
            Usuario? usuario = await _context.TB_USUARIOS
                .FirstOrDefaultAsync(x => x.IdUsuario == u.IdUsuario);

            if (usuario == null)
                return NotFound("Usuário não encontrado.");

            usuario.EmailUsuario = u.EmailUsuario;

            _context.Entry(usuario).Property(x => x.EmailUsuario).IsModified = true;
            await _context.SaveChangesAsync();

            return Ok("E-mail atualizado com sucesso.");
        }

        [HttpPost("RecuperarSenha")]
        public async Task<IActionResult> RecuperarSenha([FromBody] Usuario modelo)
        {
            try
            {
                // Verifica se o e-mail existe no banco de dados
                Usuario? usuario = await _context.TB_USUARIOS
                    .FirstOrDefaultAsync(x => x.EmailUsuario.ToLower() == modelo.EmailUsuario.ToLower());

                if (usuario == null)
                    return BadRequest("E-mail não encontrado.");

                // Criptografa a nova senha fornecida
                Criptografia.CriarPasswordHash(modelo.PasswordUsuario, out byte[] hash, out byte[] salt);
                usuario.PasswordHash = hash;
                usuario.PasswordSalt = salt;

                // Atualiza a senha no banco de dados
                _context.TB_USUARIOS.Update(usuario);
                await _context.SaveChangesAsync();

                return Ok("Senha atualizada com sucesso.");
            }
            catch (Exception ex)
            {
                return BadRequest($"Erro ao atualizar a senha: {ex.Message}");
            }
        }
    }
}
