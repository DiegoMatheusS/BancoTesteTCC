using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using TCCEcoCria.Data;
using TCCEcoCria.Interfaces;
using TCCEcoCria.Services;
using AutoMapper;
using TCCEcoCria.Rest;
using TCCEcoCria.Mappings;

var builder = WebApplication.CreateBuilder(args);

// Configuração do banco de dados
builder.Services.AddDbContext<DataContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("ConexaoSomee"));
});
builder.Services.AddDbContext<DataContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("ConexaoSomee")));

// Configuração dos serviços
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSingleton<IEnderecoServices, EnderecoService>();
builder.Services.AddSingleton<IBrasilApi, BrasilApiRest>();

builder.Services.AddAutoMapper(typeof(EnderecoMapping));

builder.Services.AddControllers();

// Configuração de Autenticação (comentado, mas pronto para uso)
builder.Services.AddAuthentication("Bearer")
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(builder.Configuration.GetSection("ConfiguracaoToken:Chave").Value)),
            ValidateIssuer = false,
            ValidateAudience = false
        };
    });

builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo { Title = "Minha API", Version = "v1" });
});

var app = builder.Build();

// Configuração do pipeline de requisições
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication(); // Habilita a autenticação
app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
});

// Habilita o Swagger
app.UseSwagger();

// Habilita a UI do Swagger
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "Minha API V1");
});

app.Run();
