-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: precotizador_fletes_v2
-- ------------------------------------------------------
-- Server version	8.4.7

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `compra`
--

DROP TABLE IF EXISTS `compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compra` (
  `IdCompra` int unsigned NOT NULL AUTO_INCREMENT,
  `CodigoProducto` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CantidadProducto` smallint unsigned NOT NULL,
  `ValorMercancia` decimal(12,2) NOT NULL,
  `FechaCompra` datetime DEFAULT NULL,
  PRIMARY KEY (`IdCompra`),
  KEY `idx_compra_producto` (`CodigoProducto`),
  CONSTRAINT `FK_Compra_Producto` FOREIGN KEY (`CodigoProducto`) REFERENCES `producto` (`CodigoProducto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envio`
--

DROP TABLE IF EXISTS `envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envio` (
  `IdEnvio` int unsigned NOT NULL AUTO_INCREMENT,
  `IdCompra` int unsigned NOT NULL,
  `IdEstado` tinyint unsigned NOT NULL,
  `CostoEnvio` decimal(12,2) NOT NULL,
  `CostoSeguro` decimal(12,2) DEFAULT NULL,
  `CostoTotal` decimal(12,2) DEFAULT NULL,
  `FechaEnvio` datetime DEFAULT NULL,
  PRIMARY KEY (`IdEnvio`),
  KEY `idx_envio_compra` (`IdCompra`),
  KEY `idx_envio_estado` (`IdEstado`),
  CONSTRAINT `FK_Envio_Compra` FOREIGN KEY (`IdCompra`) REFERENCES `compra` (`IdCompra`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_Envio_Estado` FOREIGN KEY (`IdEstado`) REFERENCES `estado` (`IdEstado`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envio`
--

LOCK TABLES `envio` WRITE;
/*!40000 ALTER TABLE `envio` DISABLE KEYS */;
/*!40000 ALTER TABLE `envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado` (
  `IdEstado` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `NombreEstado` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`IdEstado`),
  UNIQUE KEY `uq_estado_nombre` (`NombreEstado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marca`
--

DROP TABLE IF EXISTS `marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marca` (
  `IdMarca` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NombreMarca` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`IdMarca`),
  UNIQUE KEY `uq_marca_nombre` (`NombreMarca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca`
--

LOCK TABLES `marca` WRITE;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modelo`
--

DROP TABLE IF EXISTS `modelo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modelo` (
  `IdModelo` smallint unsigned NOT NULL AUTO_INCREMENT,
  `IdMarca` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NombreModelo` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`IdModelo`),
  UNIQUE KEY `uq_modelo_marca_nombre` (`IdMarca`,`NombreModelo`),
  KEY `idx_modelo_marca` (`IdMarca`),
  CONSTRAINT `FK_Modelo_Marca` FOREIGN KEY (`IdMarca`) REFERENCES `marca` (`IdMarca`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modelo`
--

LOCK TABLES `modelo` WRITE;
/*!40000 ALTER TABLE `modelo` DISABLE KEYS */;
/*!40000 ALTER TABLE `modelo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paquete`
--

DROP TABLE IF EXISTS `paquete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paquete` (
  `IdPaquete` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Tamano` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`IdPaquete`),
  UNIQUE KEY `uq_paquete_tamano` (`Tamano`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paquete`
--

LOCK TABLES `paquete` WRITE;
/*!40000 ALTER TABLE `paquete` DISABLE KEYS */;
/*!40000 ALTER TABLE `paquete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilegio`
--

DROP TABLE IF EXISTS `privilegio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privilegio` (
  `IdPrivilegio` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NombrePrivilegio` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`IdPrivilegio`),
  UNIQUE KEY `uq_privilegio_nombre` (`NombrePrivilegio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilegio`
--

LOCK TABLES `privilegio` WRITE;
/*!40000 ALTER TABLE `privilegio` DISABLE KEYS */;
/*!40000 ALTER TABLE `privilegio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `CodigoProducto` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IdModelo` smallint unsigned NOT NULL,
  `DescripcionProducto` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PrecioUSD` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`CodigoProducto`),
  KEY `idx_producto_modelo` (`IdModelo`),
  CONSTRAINT `FK_Producto_Modelo` FOREIGN KEY (`IdModelo`) REFERENCES `modelo` (`IdModelo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productopaquete`
--

DROP TABLE IF EXISTS `productopaquete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productopaquete` (
  `IdProductoPaquete` int unsigned NOT NULL AUTO_INCREMENT,
  `CodigoProducto` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IdPaquete` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Cantidad` tinyint unsigned DEFAULT '1',
  PRIMARY KEY (`IdProductoPaquete`),
  KEY `idx_pp_producto` (`CodigoProducto`),
  KEY `idx_pp_paquete` (`IdPaquete`),
  CONSTRAINT `FK_ProductoPaquete_Paquete` FOREIGN KEY (`IdPaquete`) REFERENCES `paquete` (`IdPaquete`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_ProductoPaquete_Producto` FOREIGN KEY (`CodigoProducto`) REFERENCES `producto` (`CodigoProducto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productopaquete`
--

LOCK TABLES `productopaquete` WRITE;
/*!40000 ALTER TABLE `productopaquete` DISABLE KEYS */;
/*!40000 ALTER TABLE `productopaquete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesion`
--

DROP TABLE IF EXISTS `sesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesion` (
  `IdSesion` int unsigned NOT NULL AUTO_INCREMENT,
  `IdUsuario` smallint unsigned NOT NULL,
  `FechaInicio` datetime NOT NULL,
  `FechaFin` datetime DEFAULT NULL,
  PRIMARY KEY (`IdSesion`),
  KEY `idx_sesion_usuario` (`IdUsuario`),
  CONSTRAINT `FK_Sesion_Usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `usuario` (`IdUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesion`
--

LOCK TABLES `sesion` WRITE;
/*!40000 ALTER TABLE `sesion` DISABLE KEYS */;
/*!40000 ALTER TABLE `sesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarifaflete`
--

DROP TABLE IF EXISTS `tarifaflete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarifaflete` (
  `IdTarifaFlete` smallint unsigned NOT NULL AUTO_INCREMENT,
  `IdEstado` tinyint unsigned NOT NULL,
  `IdPaquete` char(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Costo` decimal(10,2) NOT NULL,
  PRIMARY KEY (`IdTarifaFlete`),
  UNIQUE KEY `uq_tarifa_estado_paquete` (`IdEstado`,`IdPaquete`),
  KEY `idx_tarifa_estado` (`IdEstado`),
  KEY `idx_tarifa_paquete` (`IdPaquete`),
  CONSTRAINT `FK_TarifaFlete_Estado` FOREIGN KEY (`IdEstado`) REFERENCES `estado` (`IdEstado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_TarifaFlete_Paquete` FOREIGN KEY (`IdPaquete`) REFERENCES `paquete` (`IdPaquete`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifaflete`
--

LOCK TABLES `tarifaflete` WRITE;
/*!40000 ALTER TABLE `tarifaflete` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarifaflete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `IdUsuario` smallint unsigned NOT NULL AUTO_INCREMENT,
  `NombreUsuario` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Correo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Contrasena` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `IdPrivilegio` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE KEY `uq_usuario_correo` (`Correo`),
  UNIQUE KEY `uq_usuario_nombre` (`NombreUsuario`),
  KEY `idx_usuario_privilegio` (`IdPrivilegio`),
  CONSTRAINT `FK_Usuario_Privilegio` FOREIGN KEY (`IdPrivilegio`) REFERENCES `privilegio` (`IdPrivilegio`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'precotizador_fletes_v2'
--

--
-- Dumping routines for database 'precotizador_fletes_v2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 14:06:11
