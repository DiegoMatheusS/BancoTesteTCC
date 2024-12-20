﻿IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
CREATE TABLE [TB_COMENTARIOS] (
    [IdComentario] int NOT NULL IDENTITY,
    [MomentoComentario] datetime2 NOT NULL,
    [TextoComentario] Varchar(200) NOT NULL,
    CONSTRAINT [PK_TB_COMENTARIOS] PRIMARY KEY ([IdComentario])
);

CREATE TABLE [TB_ORDEMGRANDEZA] (
    [IdOrdemGrandeza] int NOT NULL IDENTITY,
    [DescricaoOrdemGrandeza] Varchar(200) NOT NULL,
    CONSTRAINT [PK_TB_ORDEMGRANDEZA] PRIMARY KEY ([IdOrdemGrandeza])
);

CREATE TABLE [TB_PREMIOS] (
    [IdPremio] int NOT NULL IDENTITY,
    [DescricaoPremio] Varchar(200) NOT NULL,
    [QuantidadePremio] int NOT NULL,
    [PontosPremio] int NOT NULL,
    CONSTRAINT [PK_TB_PREMIOS] PRIMARY KEY ([IdPremio])
);

CREATE TABLE [TB_PUBLICACAO] (
    [IdPublicacao] int NOT NULL IDENTITY,
    [DataPublicacao] datetime2 NOT NULL,
    [TituloPublicacao] Varchar(200) NOT NULL,
    [TextoPublicacao] Varchar(200) NOT NULL,
    CONSTRAINT [PK_TB_PUBLICACAO] PRIMARY KEY ([IdPublicacao])
);

CREATE TABLE [TB_TIPOPONTO] (
    [IdTipoPonto] int NOT NULL IDENTITY,
    [DescricaoTipoPonto] Varchar(200) NOT NULL,
    [StatusTipoPonto] bit NOT NULL,
    CONSTRAINT [PK_TB_TIPOPONTO] PRIMARY KEY ([IdTipoPonto])
);

CREATE TABLE [TB_TROCAS] (
    [IdTroca] int NOT NULL IDENTITY,
    [MomentoTroca] datetime2 NOT NULL,
    CONSTRAINT [PK_TB_TROCAS] PRIMARY KEY ([IdTroca])
);

CREATE TABLE [TB_USUARIOS] (
    [IdUsuario] int NOT NULL IDENTITY,
    [NomeUsuario] Varchar(200) NOT NULL,
    [Latitude] float NULL,
    [Longitude] float NULL,
    [Perfil] Varchar(200) NOT NULL DEFAULT 'Cliente',
    [EmailUsuario] Varchar(200) NOT NULL,
    [PasswordHash] varbinary(max) NULL,
    [PasswordSalt] varbinary(max) NULL,
    [DataAcesso] datetime2 NULL,
    CONSTRAINT [PK_TB_USUARIOS] PRIMARY KEY ([IdUsuario])
);

CREATE TABLE [TB_MATERIAIS] (
    [IdMaterial] int NOT NULL IDENTITY,
    [NomeMaterial] Varchar(200) NOT NULL,
    [IdOrdemGrandeza] int NOT NULL,
    [Material] int NOT NULL,
    [OrdemDeGrandezaIdOrdemGrandeza] int NULL,
    CONSTRAINT [PK_TB_MATERIAIS] PRIMARY KEY ([IdMaterial]),
    CONSTRAINT [FK_TB_MATERIAIS_TB_ORDEMGRANDEZA_OrdemDeGrandezaIdOrdemGrandeza] FOREIGN KEY ([OrdemDeGrandezaIdOrdemGrandeza]) REFERENCES [TB_ORDEMGRANDEZA] ([IdOrdemGrandeza])
);

CREATE TABLE [TB_PONTOS] (
    [IdPonto] int NOT NULL IDENTITY,
    [NomePonto] Varchar(200) NOT NULL,
    [EnderecoPonto] Varchar(200) NOT NULL,
    [CepEndereco] int NOT NULL,
    [UfEndereco] Varchar(200) NOT NULL,
    [CidadeEndereco] Varchar(200) NOT NULL,
    [IdTipoPonto] int NOT NULL,
    CONSTRAINT [PK_TB_PONTOS] PRIMARY KEY ([IdPonto]),
    CONSTRAINT [FK_TB_PONTOS_TB_TIPOPONTO_IdTipoPonto] FOREIGN KEY ([IdTipoPonto]) REFERENCES [TB_TIPOPONTO] ([IdTipoPonto]) ON DELETE CASCADE
);

CREATE TABLE [TB_PARCEIROS] (
    [IdParceiro] int NOT NULL IDENTITY,
    [NomeParceiro] Varchar(200) NOT NULL,
    [StatusParceiro] bit NOT NULL,
    [DoacaoParceiro] float NOT NULL,
    [DataDoacao] datetime2 NOT NULL,
    [IdUsuario] int NULL,
    [UsuarioIdUsuario] int NULL,
    CONSTRAINT [PK_TB_PARCEIROS] PRIMARY KEY ([IdParceiro]),
    CONSTRAINT [FK_TB_PARCEIROS_TB_USUARIOS_UsuarioIdUsuario] FOREIGN KEY ([UsuarioIdUsuario]) REFERENCES [TB_USUARIOS] ([IdUsuario])
);

CREATE TABLE [TB_COLETAS] (
    [IdColeta] int NOT NULL IDENTITY,
    [MomentoColeta] datetime2 NOT NULL,
    [IdPonto] int NULL,
    [IdUsuario] int NULL,
    CONSTRAINT [PK_TB_COLETAS] PRIMARY KEY ([IdColeta]),
    CONSTRAINT [FK_TB_COLETAS_TB_PONTOS_IdPonto] FOREIGN KEY ([IdPonto]) REFERENCES [TB_PONTOS] ([IdPonto]),
    CONSTRAINT [FK_TB_COLETAS_TB_USUARIOS_IdUsuario] FOREIGN KEY ([IdUsuario]) REFERENCES [TB_USUARIOS] ([IdUsuario])
);

CREATE TABLE [TB_PONTOSMATERIAIS] (
    [IdPontoMaterial] int NOT NULL,
    [DescricaoPontomaterial] Varchar(200) NOT NULL,
    [StatusPontoMaterial] bit NOT NULL,
    [IdPonto] int NOT NULL,
    [IdMaterial] int NOT NULL,
    [MateriaisIdMaterial] int NULL,
    [PontosIdPonto] int NULL,
    CONSTRAINT [FK_TB_PONTOSMATERIAIS_TB_MATERIAIS_MateriaisIdMaterial] FOREIGN KEY ([MateriaisIdMaterial]) REFERENCES [TB_MATERIAIS] ([IdMaterial]),
    CONSTRAINT [FK_TB_PONTOSMATERIAIS_TB_PONTOS_PontosIdPonto] FOREIGN KEY ([PontosIdPonto]) REFERENCES [TB_PONTOS] ([IdPonto])
);

CREATE TABLE [TB_COLETAITENS] (
    [IdItemColeta] int NOT NULL IDENTITY,
    [QuantidadeColeta] int NOT NULL,
    [IdColeta] int NULL,
    [IdMaterial] int NULL,
    [IdOrdemGrandeza] int NULL,
    CONSTRAINT [PK_TB_COLETAITENS] PRIMARY KEY ([IdItemColeta]),
    CONSTRAINT [FK_TB_COLETAITENS_TB_COLETAS_IdColeta] FOREIGN KEY ([IdColeta]) REFERENCES [TB_COLETAS] ([IdColeta]),
    CONSTRAINT [FK_TB_COLETAITENS_TB_MATERIAIS_IdMaterial] FOREIGN KEY ([IdMaterial]) REFERENCES [TB_MATERIAIS] ([IdMaterial]),
    CONSTRAINT [FK_TB_COLETAITENS_TB_ORDEMGRANDEZA_IdOrdemGrandeza] FOREIGN KEY ([IdOrdemGrandeza]) REFERENCES [TB_ORDEMGRANDEZA] ([IdOrdemGrandeza])
);

CREATE TABLE [TB_PONTUACAO] (
    [IdPontuacao] int NOT NULL IDENTITY,
    [QuantidadePontos] int NOT NULL,
    [StatusPontos] bit NOT NULL,
    [IdUsuario] int NULL,
    [IdColeta] int NULL,
    [UsuarioIdUsuario] int NULL,
    [ColetasIdColeta] int NULL,
    CONSTRAINT [PK_TB_PONTUACAO] PRIMARY KEY ([IdPontuacao]),
    CONSTRAINT [FK_TB_PONTUACAO_TB_COLETAS_ColetasIdColeta] FOREIGN KEY ([ColetasIdColeta]) REFERENCES [TB_COLETAS] ([IdColeta]),
    CONSTRAINT [FK_TB_PONTUACAO_TB_USUARIOS_UsuarioIdUsuario] FOREIGN KEY ([UsuarioIdUsuario]) REFERENCES [TB_USUARIOS] ([IdUsuario])
);

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdItemColeta', N'IdColeta', N'IdMaterial', N'IdOrdemGrandeza', N'QuantidadeColeta') AND [object_id] = OBJECT_ID(N'[TB_COLETAITENS]'))
    SET IDENTITY_INSERT [TB_COLETAITENS] ON;
INSERT INTO [TB_COLETAITENS] ([IdItemColeta], [IdColeta], [IdMaterial], [IdOrdemGrandeza], [QuantidadeColeta])
VALUES (1, NULL, NULL, NULL, 1),
(2, NULL, NULL, NULL, 2),
(3, NULL, NULL, NULL, 1),
(4, NULL, NULL, NULL, 2),
(5, NULL, NULL, NULL, 1),
(6, NULL, NULL, NULL, 2),
(7, NULL, NULL, NULL, 1);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdItemColeta', N'IdColeta', N'IdMaterial', N'IdOrdemGrandeza', N'QuantidadeColeta') AND [object_id] = OBJECT_ID(N'[TB_COLETAITENS]'))
    SET IDENTITY_INSERT [TB_COLETAITENS] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdColeta', N'IdPonto', N'IdUsuario', N'MomentoColeta') AND [object_id] = OBJECT_ID(N'[TB_COLETAS]'))
    SET IDENTITY_INSERT [TB_COLETAS] ON;
INSERT INTO [TB_COLETAS] ([IdColeta], [IdPonto], [IdUsuario], [MomentoColeta])
VALUES (1, NULL, NULL, '2024-12-02T17:47:02.3407911+00:00'),
(2, NULL, NULL, '2024-12-02T17:47:02.3408157+00:00'),
(3, NULL, NULL, '2024-12-02T17:47:02.3408161+00:00'),
(4, NULL, NULL, '2024-12-02T17:47:02.3408163+00:00'),
(5, NULL, NULL, '2024-12-02T17:47:02.3408164+00:00'),
(6, NULL, NULL, '2024-12-02T17:47:02.3408165+00:00'),
(7, NULL, NULL, '2024-12-02T17:47:02.3408167+00:00');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdColeta', N'IdPonto', N'IdUsuario', N'MomentoColeta') AND [object_id] = OBJECT_ID(N'[TB_COLETAS]'))
    SET IDENTITY_INSERT [TB_COLETAS] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdComentario', N'MomentoComentario', N'TextoComentario') AND [object_id] = OBJECT_ID(N'[TB_COMENTARIOS]'))
    SET IDENTITY_INSERT [TB_COMENTARIOS] ON;
INSERT INTO [TB_COMENTARIOS] ([IdComentario], [MomentoComentario], [TextoComentario])
VALUES (1, '2024-12-02T17:47:02.3396834+00:00', 'Blabla');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdComentario', N'MomentoComentario', N'TextoComentario') AND [object_id] = OBJECT_ID(N'[TB_COMENTARIOS]'))
    SET IDENTITY_INSERT [TB_COMENTARIOS] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdMaterial', N'IdOrdemGrandeza', N'Material', N'NomeMaterial', N'OrdemDeGrandezaIdOrdemGrandeza') AND [object_id] = OBJECT_ID(N'[TB_MATERIAIS]'))
    SET IDENTITY_INSERT [TB_MATERIAIS] ON;
INSERT INTO [TB_MATERIAIS] ([IdMaterial], [IdOrdemGrandeza], [Material], [NomeMaterial], [OrdemDeGrandezaIdOrdemGrandeza])
VALUES (1, 0, 1, 'Garrafa Pet', NULL),
(2, 0, 4, 'Papelão', NULL),
(3, 0, 1, 'Saco Plástico', NULL),
(4, 0, 2, 'Lata de Feijoada', NULL),
(5, 0, 2, 'Latinha', NULL),
(6, 0, 1, 'Garrafa Pet', NULL),
(7, 0, 3, 'Jarra de Vidro', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdMaterial', N'IdOrdemGrandeza', N'Material', N'NomeMaterial', N'OrdemDeGrandezaIdOrdemGrandeza') AND [object_id] = OBJECT_ID(N'[TB_MATERIAIS]'))
    SET IDENTITY_INSERT [TB_MATERIAIS] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdParceiro', N'DataDoacao', N'DoacaoParceiro', N'IdUsuario', N'NomeParceiro', N'StatusParceiro', N'UsuarioIdUsuario') AND [object_id] = OBJECT_ID(N'[TB_PARCEIROS]'))
    SET IDENTITY_INSERT [TB_PARCEIROS] ON;
INSERT INTO [TB_PARCEIROS] ([IdParceiro], [DataDoacao], [DoacaoParceiro], [IdUsuario], [NomeParceiro], [StatusParceiro], [UsuarioIdUsuario])
VALUES (1, '0001-01-01T00:00:00.0000000', 500.0E0, NULL, 'Empresa BlaBla', CAST(0 AS bit), NULL),
(2, '0001-01-01T00:00:00.0000000', 500.0E0, NULL, 'Market Empresa', CAST(0 AS bit), NULL),
(3, '0001-01-01T00:00:00.0000000', 500.0E0, NULL, 'Empresa Eletro', CAST(0 AS bit), NULL),
(4, '0001-01-01T00:00:00.0000000', 500.0E0, NULL, 'Empresa Papel', CAST(0 AS bit), NULL),
(5, '0001-01-01T00:00:00.0000000', 500.0E0, NULL, 'Empresa Rainiken', CAST(0 AS bit), NULL),
(6, '0001-01-01T00:00:00.0000000', 500.0E0, NULL, 'Empresa squol', CAST(0 AS bit), NULL),
(7, '0001-01-01T00:00:00.0000000', 500.0E0, NULL, 'Empresa suifiti', CAST(0 AS bit), NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdParceiro', N'DataDoacao', N'DoacaoParceiro', N'IdUsuario', N'NomeParceiro', N'StatusParceiro', N'UsuarioIdUsuario') AND [object_id] = OBJECT_ID(N'[TB_PARCEIROS]'))
    SET IDENTITY_INSERT [TB_PARCEIROS] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdTipoPonto', N'DescricaoTipoPonto', N'StatusTipoPonto') AND [object_id] = OBJECT_ID(N'[TB_TIPOPONTO]'))
    SET IDENTITY_INSERT [TB_TIPOPONTO] ON;
INSERT INTO [TB_TIPOPONTO] ([IdTipoPonto], [DescricaoTipoPonto], [StatusTipoPonto])
VALUES (1, 'Ferro velho em geral', CAST(0 AS bit)),
(2, 'Reciclagem', CAST(0 AS bit)),
(3, 'Reciclagem em geral', CAST(0 AS bit)),
(4, 'Ecoponto', CAST(0 AS bit)),
(5, 'Recilagem de metais', CAST(0 AS bit)),
(6, 'Recilcagem de papel e celulose', CAST(0 AS bit)),
(7, 'Recilcagem ', CAST(0 AS bit));
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdTipoPonto', N'DescricaoTipoPonto', N'StatusTipoPonto') AND [object_id] = OBJECT_ID(N'[TB_TIPOPONTO]'))
    SET IDENTITY_INSERT [TB_TIPOPONTO] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdUsuario', N'DataAcesso', N'EmailUsuario', N'Latitude', N'Longitude', N'NomeUsuario', N'PasswordHash', N'PasswordSalt', N'Perfil') AND [object_id] = OBJECT_ID(N'[TB_USUARIOS]'))
    SET IDENTITY_INSERT [TB_USUARIOS] ON;
INSERT INTO [TB_USUARIOS] ([IdUsuario], [DataAcesso], [EmailUsuario], [Latitude], [Longitude], [NomeUsuario], [PasswordHash], [PasswordSalt], [Perfil])
VALUES (1, NULL, 'seuEmail@gmail.com', -23.520024100000001E0, -46.596497999999997E0, 'admin', 0x3B21C1BEE12E872A2C427A27E29F687000C836ACDEE549B1C930950076929FB22B7DA462D9E568CE269268A7D2AB6F8AC65F7C8DA2843022190E4641FA47D3FDDFDBB1847CDDA017578876D4E90F8E6BE2F487FE1014EA436DE7EB8A55EA0B5BAADD9E9028DBAFB9A4CA94CFC757D733974BEF1EFD3FAAB4B79B69127D11847F, NULL, 'Admin');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdUsuario', N'DataAcesso', N'EmailUsuario', N'Latitude', N'Longitude', N'NomeUsuario', N'PasswordHash', N'PasswordSalt', N'Perfil') AND [object_id] = OBJECT_ID(N'[TB_USUARIOS]'))
    SET IDENTITY_INSERT [TB_USUARIOS] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdPonto', N'CepEndereco', N'CidadeEndereco', N'EnderecoPonto', N'IdTipoPonto', N'NomePonto', N'UfEndereco') AND [object_id] = OBJECT_ID(N'[TB_PONTOS]'))
    SET IDENTITY_INSERT [TB_PONTOS] ON;
INSERT INTO [TB_PONTOS] ([IdPonto], [CepEndereco], [CidadeEndereco], [EnderecoPonto], [IdTipoPonto], [NomePonto], [UfEndereco])
VALUES (1, 1986, 'São Paulo', 'Rua São Quirino, 468 - Vila Guilherme', 1, 'São Quirino Sucatas', 'SP'),
(2, 2995, 'São Paulo', 'R. Santa Clara, 350 - Brás', 2, 'Reciclagem, Sucatas e Aparas Farpec', 'SP'),
(3, 2995, 'São Paulo', 'R. Dr. Miguel Paulo Capalbo, 75 - Pari', 3, 'Helio & Richard Reciclagem', 'SP'),
(4, 2054, 'São Paulo', 'Rua José Bernardo Pinto, 1480 - Vila Guilherme', 4, 'Ecoponto Vila Guilherme', 'SP'),
(5, 2103, 'São Paulo', 'Av. Guilherme Cotching, 726 - Vila Maria Baixa', 5, 'Latasa Reciclagem', 'SP'),
(6, 2004, 'São Paulo', 'R. Henrique Felipe da Costa, 650 - Vila Guilherme', 6, 'Ciclopel Com de Aparas de Papel', 'SP'),
(7, 2104, 'São Paulo', 'R. Eli, 190 - Vila Maria Baixa', 7, 'COLETATEC', 'SP');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'IdPonto', N'CepEndereco', N'CidadeEndereco', N'EnderecoPonto', N'IdTipoPonto', N'NomePonto', N'UfEndereco') AND [object_id] = OBJECT_ID(N'[TB_PONTOS]'))
    SET IDENTITY_INSERT [TB_PONTOS] OFF;

CREATE INDEX [IX_TB_COLETAITENS_IdColeta] ON [TB_COLETAITENS] ([IdColeta]);

CREATE INDEX [IX_TB_COLETAITENS_IdMaterial] ON [TB_COLETAITENS] ([IdMaterial]);

CREATE INDEX [IX_TB_COLETAITENS_IdOrdemGrandeza] ON [TB_COLETAITENS] ([IdOrdemGrandeza]);

CREATE INDEX [IX_TB_COLETAS_IdPonto] ON [TB_COLETAS] ([IdPonto]);

CREATE INDEX [IX_TB_COLETAS_IdUsuario] ON [TB_COLETAS] ([IdUsuario]);

CREATE INDEX [IX_TB_MATERIAIS_OrdemDeGrandezaIdOrdemGrandeza] ON [TB_MATERIAIS] ([OrdemDeGrandezaIdOrdemGrandeza]);

CREATE INDEX [IX_TB_PARCEIROS_UsuarioIdUsuario] ON [TB_PARCEIROS] ([UsuarioIdUsuario]);

CREATE INDEX [IX_TB_PONTOS_IdTipoPonto] ON [TB_PONTOS] ([IdTipoPonto]);

CREATE INDEX [IX_TB_PONTOSMATERIAIS_MateriaisIdMaterial] ON [TB_PONTOSMATERIAIS] ([MateriaisIdMaterial]);

CREATE INDEX [IX_TB_PONTOSMATERIAIS_PontosIdPonto] ON [TB_PONTOSMATERIAIS] ([PontosIdPonto]);

CREATE INDEX [IX_TB_PONTUACAO_ColetasIdColeta] ON [TB_PONTUACAO] ([ColetasIdColeta]);

CREATE INDEX [IX_TB_PONTUACAO_UsuarioIdUsuario] ON [TB_PONTUACAO] ([UsuarioIdUsuario]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20241202174702_InitialCreate', N'9.0.0');

COMMIT;
GO

