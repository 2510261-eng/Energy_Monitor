-- Script para crear la base de datos y tablas
-- Ajuste el nombre del archivo y ejecútelo en SQL Server Management Studio

CREATE DATABASE SistemaConsumoDB;
GO
USE SistemaConsumoDB;
GO

-- Tabla Usuarios
CREATE TABLE Usuarios (
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Correo NVARCHAR(200) NOT NULL UNIQUE,
    Contrasena NVARCHAR(256) NOT NULL,
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- Tabla Dispositivos
CREATE TABLE Dispositivos (
    IdDispositivo INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario INT NOT NULL FOREIGN KEY REFERENCES Usuarios(IdUsuario) ON DELETE CASCADE,
    NombreDispositivo NVARCHAR(200) NOT NULL,
    PotenciaWatts FLOAT NOT NULL,
    HorasUsoDiario FLOAT NOT NULL,
    DiasUsoMes INT NOT NULL,
    ConsumoMensualKwh FLOAT NOT NULL,
    FechaRegistro DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- Procedimientos almacenados para Usuarios
CREATE PROCEDURE sp_InsertUsuario
    @Nombre NVARCHAR(100),
    @Correo NVARCHAR(200),
    @Contrasena NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Usuarios (Nombre, Correo, Contrasena)
    VALUES (@Nombre, @Correo, @Contrasena);
    SELECT SCOPE_IDENTITY() AS NewId;
END
GO

CREATE PROCEDURE sp_ValidateUser
    @Correo NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdUsuario, Nombre, Correo, Contrasena FROM Usuarios WHERE Correo = @Correo;
END
GO

-- Procedimientos almacenados para Dispositivos
CREATE PROCEDURE sp_InsertDispositivo
    @IdUsuario INT,
    @NombreDispositivo NVARCHAR(200),
    @PotenciaWatts FLOAT,
    @HorasUsoDiario FLOAT,
    @DiasUsoMes INT,
    @ConsumoMensualKwh FLOAT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Dispositivos (IdUsuario, NombreDispositivo, PotenciaWatts, HorasUsoDiario, DiasUsoMes, ConsumoMensualKwh)
    VALUES (@IdUsuario, @NombreDispositivo, @PotenciaWatts, @HorasUsoDiario, @DiasUsoMes, @ConsumoMensualKwh);
    SELECT SCOPE_IDENTITY() AS NewId;
END
GO

CREATE PROCEDURE sp_UpdateDispositivo
    @IdDispositivo INT,
    @NombreDispositivo NVARCHAR(200),
    @PotenciaWatts FLOAT,
    @HorasUsoDiario FLOAT,
    @DiasUsoMes INT,
    @ConsumoMensualKwh FLOAT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE Dispositivos
    SET NombreDispositivo = @NombreDispositivo,
        PotenciaWatts = @PotenciaWatts,
        HorasUsoDiario = @HorasUsoDiario,
        DiasUsoMes = @DiasUsoMes,
        ConsumoMensualKwh = @ConsumoMensualKwh
    WHERE IdDispositivo = @IdDispositivo;
END
GO

CREATE PROCEDURE sp_DeleteDispositivo
    @IdDispositivo INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM Dispositivos WHERE IdDispositivo = @IdDispositivo;
END
GO

CREATE PROCEDURE sp_GetDispositivosByUser
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT IdDispositivo, NombreDispositivo, PotenciaWatts, HorasUsoDiario, DiasUsoMes, ConsumoMensualKwh, FechaRegistro
    FROM Dispositivos
    WHERE IdUsuario = @IdUsuario
    ORDER BY FechaRegistro DESC;
END
GO

CREATE PROCEDURE sp_GetDashboardStats
    @IdUsuario INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        COUNT(*) AS TotalDispositivos,
        ISNULL(SUM(ConsumoMensualKwh),0) AS ConsumoTotalMensual,
        CASE WHEN COUNT(*) = 0 THEN 0 ELSE ISNULL(AVG(ConsumoMensualKwh),0) END AS ConsumoPromedio
    FROM Dispositivos
    WHERE IdUsuario = @IdUsuario;
END
GO


--consulta y demostracion 
USE SistemaConsumoDB;
GO

SELECT
    D.IdDispositivo,
    U.Nombre AS Usuario,
    D.NombreDispositivo,
    D.PotenciaWatts,
    D.HorasUsoDiario,
    D.DiasUsoMes,
    D.ConsumoMensualKwh,
    D.FechaRegistro
FROM Dispositivos D
INNER JOIN Usuarios U
    ON D.IdUsuario = U.IdUsuario
ORDER BY D.FechaRegistro DESC;