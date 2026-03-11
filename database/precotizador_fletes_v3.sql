DROP DATABASE IF EXISTS precotizador_fletes_v3;
CREATE DATABASE precotizador_fletes_v3;
USE precotizador_fletes_v3;

-- =====================================
-- USUARIOS
-- =====================================

CREATE TABLE Privilegio (
    IdPrivilegio CHAR(1),
    NombrePrivilegio VARCHAR(13) NOT NULL,

    PRIMARY KEY (IdPrivilegio),
    UNIQUE (NombrePrivilegio)

) ENGINE=InnoDB;

CREATE TABLE Usuario (
    IdUsuario SMALLINT UNSIGNED AUTO_INCREMENT,
    NombreUsuario VARCHAR(50) NOT NULL,
    Contrasena VARCHAR(60) NOT NULL,
    IdPrivilegio CHAR(1) NOT NULL,

    PRIMARY KEY (IdUsuario),

    UNIQUE (NombreUsuario),

    INDEX (IdPrivilegio),

    FOREIGN KEY (IdPrivilegio)
    REFERENCES Privilegio(IdPrivilegio)
    ON UPDATE CASCADE
    ON DELETE RESTRICT

) ENGINE=InnoDB;

CREATE TABLE Sesion (
    IdSesion INT UNSIGNED AUTO_INCREMENT,
    IdUsuario SMALLINT UNSIGNED NOT NULL,
    FechaInicio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FechaFin DATETIME,

    PRIMARY KEY (IdSesion),

    INDEX idx_sesion_usuario (IdUsuario),

    CONSTRAINT FK_Sesion_Usuario
        FOREIGN KEY (IdUsuario)
        REFERENCES Usuario(IdUsuario)
        ON UPDATE CASCADE
        ON DELETE CASCADE

) ENGINE=InnoDB;

CREATE TABLE cliente (
    IdCliente INT UNSIGNED AUTO_INCREMENT,
    NombreEmpresa VARCHAR(100) NOT NULL,
    NombrePersona VARCHAR(100),
    FechaRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (IdCliente)

) ENGINE=InnoDB;

-- =====================================
-- PRODUCTOS
-- =====================================

CREATE TABLE Marca (
    IdMarca CHAR(4),
    NombreMarca VARCHAR(15) NOT NULL,

    PRIMARY KEY (IdMarca),
    UNIQUE (NombreMarca)

) ENGINE=InnoDB;

CREATE TABLE Modelo (
    IdModelo SMALLINT UNSIGNED AUTO_INCREMENT,
    IdMarca CHAR(4) NOT NULL,
    NombreModelo VARCHAR(80) NOT NULL,

    PRIMARY KEY (IdModelo),

    UNIQUE (IdMarca, NombreModelo),

    INDEX (IdMarca),

    FOREIGN KEY (IdMarca)
    REFERENCES Marca(IdMarca)
    ON UPDATE CASCADE
    ON DELETE CASCADE

) ENGINE=InnoDB;

CREATE TABLE Producto (
    CodigoProducto VARCHAR(10),
    IdModelo SMALLINT UNSIGNED NOT NULL,
    DescripcionProducto VARCHAR(120),
    PrecioUSD DECIMAL(10,2),
    Largo DECIMAL(8,3),
    Ancho DECIMAL(8,2),
    Alto DECIMAL(8,2),
    Peso DECIMAL(8,2),

    PRIMARY KEY (CodigoProducto),

    INDEX (IdModelo),

    FOREIGN KEY (IdModelo)
        REFERENCES Modelo(IdModelo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- =====================================
-- PAQUETES
-- =====================================

CREATE TABLE Paquete (
    IdPaquete CHAR(2),
    Tamano VARCHAR(15) NOT NULL,
    LargoPaquete DECIMAL(6,2) NOT NULL,
    AnchoPaquete DECIMAL(6,2) NOT NULL,
    AltoPaquete DECIMAL(6,2) NOT NULL,
    PesoMaximoPaquete DECIMAL(6,2) NOT NULL,

    PRIMARY KEY (IdPaquete),
    UNIQUE (Tamano)

) ENGINE=InnoDB;

CREATE TABLE ProductoPaquete (
    IdProductoPaquete INT UNSIGNED AUTO_INCREMENT,
    CodigoProducto VARCHAR(10) NOT NULL,
    IdPaquete CHAR(2) NOT NULL,
    Cantidad TINYINT UNSIGNED DEFAULT 1,

    PRIMARY KEY (IdProductoPaquete),

    INDEX (CodigoProducto),
    INDEX (IdPaquete),

    FOREIGN KEY (CodigoProducto)
        REFERENCES Producto(CodigoProducto)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (IdPaquete)
        REFERENCES Paquete(IdPaquete)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

) ENGINE=InnoDB;

-- =====================================
-- DESTINOS
-- =====================================

CREATE TABLE Estado (
    IdEstado TINYINT UNSIGNED AUTO_INCREMENT,
    NombreEstado VARCHAR(40) NOT NULL,

    PRIMARY KEY (IdEstado),
    UNIQUE (NombreEstado)

) ENGINE=InnoDB;

CREATE TABLE TarifaFlete (
    IdTarifaFlete SMALLINT UNSIGNED AUTO_INCREMENT,
    IdEstado TINYINT UNSIGNED NOT NULL,
    IdPaquete CHAR(2) NOT NULL,
    Costo DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (IdTarifaFlete),

    UNIQUE (IdEstado, IdPaquete),

    INDEX (IdEstado),
    INDEX (IdPaquete),

    FOREIGN KEY (IdEstado)
        REFERENCES Estado(IdEstado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (IdPaquete)
        REFERENCES Paquete(IdPaquete)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

) ENGINE=InnoDB;

-- =====================================
-- PRECOTIZACION
-- =====================================

CREATE TABLE precotizacion (
    IdPrecotizacion INT UNSIGNED AUTO_INCREMENT,
    IdUsuario SMALLINT UNSIGNED,
    IdCliente INT UNSIGNED NOT NULL,
    IdEstado TINYINT UNSIGNED NOT NULL,
    FechaPrecotizacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    CantidadProductos SMALLINT UNSIGNED,
    CostoEnvioEstimado DECIMAL(12,2),
    CostoSeguroEstimado DECIMAL(12,2),
    CostoTotalEstimado DECIMAL(12,2),

    PRIMARY KEY (IdPrecotizacion),

    INDEX idx_precotizacion_usuario (IdUsuario),
    INDEX idx_precotizacion_cliente (IdCliente),
    INDEX idx_precotizacion_estado (IdEstado),

    CONSTRAINT FK_Precotizacion_Usuario
        FOREIGN KEY (IdUsuario)
        REFERENCES usuario(IdUsuario)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CONSTRAINT FK_Precotizacion_Cliente
        FOREIGN KEY (IdCliente)
        REFERENCES cliente(IdCliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT FK_Precotizacion_Estado
        FOREIGN KEY (IdEstado)
        REFERENCES estado(IdEstado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

) ENGINE=InnoDB;

CREATE TABLE precotizaciondetalle (
    IdPrecotizacionDetalle INT UNSIGNED AUTO_INCREMENT,
    IdPrecotizacion INT UNSIGNED NOT NULL,
    CodigoProducto VARCHAR(10) NOT NULL,
    NombreProducto VARCHAR(100) NOT NULL,
    Cantidad SMALLINT UNSIGNED NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    SubtotalProducto DECIMAL(12,2) NOT NULL,
    PaquetesUtilizados SMALLINT UNSIGNED,
    CostoEnvioProducto DECIMAL(12,2),

    PRIMARY KEY (IdPrecotizacionDetalle),

    INDEX idx_precotizaciondetalle_precotizacion (IdPrecotizacion),
    INDEX idx_precotizaciondetalle_producto (CodigoProducto),

    CONSTRAINT FK_PrecotizacionDetalle_Precotizacion
        FOREIGN KEY (IdPrecotizacion)
        REFERENCES precotizacion(IdPrecotizacion)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_PrecotizacionDetalle_Producto
        FOREIGN KEY (CodigoProducto)
        REFERENCES producto(CodigoProducto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT

) ENGINE=InnoDB;
