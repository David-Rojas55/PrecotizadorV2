CREATE DATABASE  IF NOT EXISTS `precotizador_fletes_v1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `precotizador_fletes_v1`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: precotizador_fletes_v1
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
  `IdCompra` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CodigoProducto` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Cantidad` int DEFAULT NULL,
  `ValorMercancia` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`IdCompra`),
  KEY `CodigoProducto` (`CodigoProducto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compra`
--

LOCK TABLES `compra` WRITE;
/*!40000 ALTER TABLE `compra` DISABLE KEYS */;
INSERT INTO `compra` VALUES ('C000001','P000001',2,300.00);
/*!40000 ALTER TABLE `compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprapaquete`
--

DROP TABLE IF EXISTS `comprapaquete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comprapaquete` (
  `IdCompraPaquete` int NOT NULL AUTO_INCREMENT,
  `IdCompra` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IdPaquete` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Cantidad` int DEFAULT NULL,
  PRIMARY KEY (`IdCompraPaquete`),
  KEY `IdCompra` (`IdCompra`),
  KEY `IdPaquete` (`IdPaquete`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprapaquete`
--

LOCK TABLES `comprapaquete` WRITE;
/*!40000 ALTER TABLE `comprapaquete` DISABLE KEYS */;
INSERT INTO `comprapaquete` VALUES (1,'C000001','S',1),(2,'C000001','M',1);
/*!40000 ALTER TABLE `comprapaquete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envio`
--

DROP TABLE IF EXISTS `envio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `envio` (
  `IdEnvio` int NOT NULL AUTO_INCREMENT,
  `IdCompra` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IdEstadoDestino` int DEFAULT NULL,
  `PesoTotal` decimal(10,2) DEFAULT NULL,
  `CostoEnvio` decimal(10,2) DEFAULT NULL,
  `CostoSeguro` decimal(10,2) DEFAULT NULL,
  `CostoTotal` decimal(10,2) DEFAULT NULL,
  `FechaCotizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`IdEnvio`),
  KEY `IdCompra` (`IdCompra`),
  KEY `IdEstadoDestino` (`IdEstadoDestino`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envio`
--

LOCK TABLES `envio` WRITE;
/*!40000 ALTER TABLE `envio` DISABLE KEYS */;
/*!40000 ALTER TABLE `envio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `IdEstado` int NOT NULL AUTO_INCREMENT,
  `NombreEstado` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IdEstado`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'Aguascalientes'),(2,'Baja California'),(3,'Baja California Sur'),(4,'Campeche'),(5,'Chiapas'),(6,'Chihuahua'),(7,'Ciudad de México'),(8,'Coahuila'),(9,'Colima'),(10,'Durango'),(11,'Estado de México'),(12,'Guanajuato'),(13,'Guerrero'),(14,'Hidalgo'),(15,'Jalisco'),(16,'Michoacán'),(17,'Morelos'),(18,'Nayarit'),(19,'Nuevo León'),(20,'Oaxaca'),(21,'Puebla'),(22,'Querétaro'),(23,'Quintana Roo'),(24,'San Luis Potosí'),(25,'Sinaloa'),(26,'Sonora'),(27,'Tabasco'),(28,'Tamaulipas'),(29,'Tlaxcala'),(30,'Veracruz'),(31,'Yucatán'),(32,'Zacatecas');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paquete`
--

DROP TABLE IF EXISTS `paquete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paquete` (
  `IdPaquete` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Tamano` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Largo` int DEFAULT NULL,
  `Ancho` int DEFAULT NULL,
  `Alto` int DEFAULT NULL,
  `Peso` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`IdPaquete`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paquete`
--

LOCK TABLES `paquete` WRITE;
/*!40000 ALTER TABLE `paquete` DISABLE KEYS */;
INSERT INTO `paquete` VALUES ('Ch','Chico',30,20,10,2.50),('Me','Mediano',60,40,30,5.00),('Gr','Grande',120,80,60,10.00);
/*!40000 ALTER TABLE `paquete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilegio`
--

DROP TABLE IF EXISTS `privilegio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privilegio` (
  `IdPrivilegio` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NombrePrivilegio` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IdPrivilegio`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilegio`
--

LOCK TABLES `privilegio` WRITE;
/*!40000 ALTER TABLE `privilegio` DISABLE KEYS */;
INSERT INTO `privilegio` VALUES ('A','Admin'),('U','Usuario');
/*!40000 ALTER TABLE `privilegio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `Codigo` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `MarcaProducto` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NombreProducto` varchar(70) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DescripcionProducto` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PrecioUSD` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES ('P000001','Sony','Audifonos','Audifonos Bluetooth',150.00),('P000002','LG','Monitor','Monitor 24 pulgadas',320.00),('P000003','Samsung','Tablet','Tablet 10 pulgadas',280.00);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesiones`
--

DROP TABLE IF EXISTS `sesiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesiones` (
  `IdSesion` int NOT NULL AUTO_INCREMENT,
  `IdUsuario` int DEFAULT NULL,
  `FechaIngreso` datetime DEFAULT NULL,
  `FechaSalida` datetime DEFAULT NULL,
  PRIMARY KEY (`IdSesion`),
  KEY `IdUsuario` (`IdUsuario`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
/*!40000 ALTER TABLE `sesiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarifaenvio`
--

DROP TABLE IF EXISTS `tarifaenvio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarifaenvio` (
  `IdTarifa` int NOT NULL AUTO_INCREMENT,
  `IdEstado` int DEFAULT NULL,
  `PesoMin` decimal(10,2) DEFAULT NULL,
  `PesoMax` decimal(10,2) DEFAULT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`IdTarifa`),
  KEY `IdEstado` (`IdEstado`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifaenvio`
--

LOCK TABLES `tarifaenvio` WRITE;
/*!40000 ALTER TABLE `tarifaenvio` DISABLE KEYS */;
INSERT INTO `tarifaenvio` VALUES (1,15,0.00,5.00,120.00),(2,15,5.00,10.00,180.00),(3,15,10.00,20.00,250.00),(4,19,0.00,5.00,150.00),(5,19,5.00,10.00,210.00),(6,19,10.00,20.00,300.00),(7,7,0.00,5.00,90.00),(8,7,5.00,10.00,140.00),(9,7,10.00,20.00,200.00);
/*!40000 ALTER TABLE `tarifaenvio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `IdUsuario` int NOT NULL AUTO_INCREMENT,
  `NombreUsuario` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Contrasena` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `IdPrivilegio` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IdUsuario`),
  KEY `IdPrivilegio` (`IdPrivilegio`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'precotizador_fletes_v1'
--

--
-- Dumping routines for database 'precotizador_fletes_v1'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-09 15:11:02
