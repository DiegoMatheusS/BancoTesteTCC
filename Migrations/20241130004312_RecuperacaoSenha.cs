using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ECOCRIA.Migrations
{
    /// <inheritdoc />
    public partial class RecuperacaoSenha : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "TB_EMAIL",
                columns: table => new
                {
                    Remetente = table.Column<string>(type: "Varchar(200)", maxLength: 200, nullable: false),
                    RemetentePassword = table.Column<string>(type: "Varchar(200)", maxLength: 200, nullable: false),
                    Destinatario = table.Column<string>(type: "Varchar(200)", maxLength: 200, nullable: false),
                    DestinatarioCopia = table.Column<string>(type: "Varchar(200)", maxLength: 200, nullable: false),
                    DominioPrimario = table.Column<string>(type: "Varchar(200)", maxLength: 200, nullable: false),
                    PortaPrimaria = table.Column<int>(type: "int", nullable: false),
                    Assunto = table.Column<string>(type: "Varchar(200)", maxLength: 200, nullable: false),
                    Mensagem = table.Column<string>(type: "Varchar(200)", maxLength: 200, nullable: false)
                },
                constraints: table =>
                {
                });

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 1,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 43, 12, 362, DateTimeKind.Local).AddTicks(973));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 2,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 43, 12, 362, DateTimeKind.Local).AddTicks(974));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 3,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 43, 12, 362, DateTimeKind.Local).AddTicks(975));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 4,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 43, 12, 362, DateTimeKind.Local).AddTicks(976));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 5,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 43, 12, 362, DateTimeKind.Local).AddTicks(977));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 6,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 43, 12, 362, DateTimeKind.Local).AddTicks(977));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 7,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 43, 12, 362, DateTimeKind.Local).AddTicks(978));

            migrationBuilder.UpdateData(
                table: "TB_COMENTARIOS",
                keyColumn: "IdComentario",
                keyValue: 1,
                column: "MomentoComentario",
                value: new DateTime(2024, 11, 29, 21, 43, 12, 362, DateTimeKind.Local).AddTicks(890));

            migrationBuilder.UpdateData(
                table: "TB_USUARIOS",
                keyColumn: "IdUsuario",
                keyValue: 1,
                column: "PasswordHash",
                value: new byte[] { 133, 84, 51, 47, 87, 207, 59, 61, 131, 217, 25, 57, 35, 39, 238, 159, 201, 111, 221, 192, 236, 202, 8, 117, 42, 152, 140, 78, 251, 6, 122, 23, 88, 129, 110, 213, 196, 129, 219, 192, 115, 212, 147, 190, 149, 94, 76, 138, 219, 74, 103, 21, 108, 123, 27, 60, 198, 135, 145, 22, 151, 210, 164, 253, 103, 100, 14, 214, 108, 107, 202, 91, 228, 225, 183, 181, 206, 193, 153, 150, 53, 204, 174, 62, 223, 96, 102, 166, 97, 43, 207, 68, 207, 208, 190, 48, 65, 121, 185, 19, 45, 79, 151, 173, 179, 5, 239, 146, 14, 213, 87, 19, 245, 108, 151, 19, 153, 59, 234, 39, 64, 255, 132, 155, 123, 92, 187, 42 });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TB_EMAIL");

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 1,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 39, 49, 659, DateTimeKind.Local).AddTicks(761));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 2,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 39, 49, 659, DateTimeKind.Local).AddTicks(763));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 3,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 39, 49, 659, DateTimeKind.Local).AddTicks(764));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 4,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 39, 49, 659, DateTimeKind.Local).AddTicks(765));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 5,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 39, 49, 659, DateTimeKind.Local).AddTicks(766));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 6,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 39, 49, 659, DateTimeKind.Local).AddTicks(766));

            migrationBuilder.UpdateData(
                table: "TB_COLETAS",
                keyColumn: "IdColeta",
                keyValue: 7,
                column: "MomentoColeta",
                value: new DateTime(2024, 11, 29, 21, 39, 49, 659, DateTimeKind.Local).AddTicks(767));

            migrationBuilder.UpdateData(
                table: "TB_COMENTARIOS",
                keyColumn: "IdComentario",
                keyValue: 1,
                column: "MomentoComentario",
                value: new DateTime(2024, 11, 29, 21, 39, 49, 659, DateTimeKind.Local).AddTicks(659));

            migrationBuilder.UpdateData(
                table: "TB_USUARIOS",
                keyColumn: "IdUsuario",
                keyValue: 1,
                column: "PasswordHash",
                value: new byte[] { 39, 224, 43, 129, 20, 219, 1, 78, 4, 216, 45, 52, 199, 37, 191, 118, 210, 55, 208, 230, 196, 10, 52, 38, 14, 90, 223, 165, 150, 150, 84, 65, 70, 224, 213, 141, 217, 139, 20, 202, 212, 238, 230, 231, 218, 171, 120, 14, 38, 66, 232, 158, 134, 37, 114, 61, 206, 126, 110, 115, 25, 198, 31, 198, 118, 109, 245, 119, 124, 118, 96, 81, 169, 95, 201, 185, 220, 58, 211, 95, 212, 147, 109, 180, 23, 100, 175, 145, 165, 70, 40, 250, 234, 251, 231, 228, 58, 244, 1, 234, 123, 29, 60, 12, 129, 218, 233, 51, 189, 44, 27, 198, 189, 248, 54, 187, 16, 154, 28, 74, 113, 91, 170, 20, 156, 195, 111, 142 });
        }
    }
}
