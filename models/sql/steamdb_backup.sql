-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: steamdb
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Acción'),(2,'Aventura'),(3,'RPG'),(4,'Terror');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id_compra` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_compra`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (1,1,'2025-08-26 12:36:45'),(2,2,'2025-08-26 12:36:45');
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desarrolladores`
--

DROP TABLE IF EXISTS `desarrolladores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desarrolladores` (
  `id_desarrollador` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `pais` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_desarrollador`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desarrolladores`
--

LOCK TABLES `desarrolladores` WRITE;
/*!40000 ALTER TABLE `desarrolladores` DISABLE KEYS */;
INSERT INTO `desarrolladores` VALUES (1,'Valve','EEUU'),(2,'CD Projekt','Polonia'),(3,'Rockstar Games','EEUU');
/*!40000 ALTER TABLE `desarrolladores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_compra`
--

DROP TABLE IF EXISTS `detalle_compra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_compra` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_compra` int DEFAULT NULL,
  `id_juego` int DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_compra` (`id_compra`),
  KEY `id_juego` (`id_juego`),
  CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`),
  CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id_juego`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_compra`
--

LOCK TABLES `detalle_compra` WRITE;
/*!40000 ALTER TABLE `detalle_compra` DISABLE KEYS */;
INSERT INTO `detalle_compra` VALUES (1,1,1),(2,1,2),(3,2,3);
/*!40000 ALTER TABLE `detalle_compra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `juego_categoria`
--

DROP TABLE IF EXISTS `juego_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juego_categoria` (
  `id_juego` int NOT NULL,
  `id_categoria` int NOT NULL,
  PRIMARY KEY (`id_juego`,`id_categoria`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `juego_categoria_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id_juego`),
  CONSTRAINT `juego_categoria_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `juego_categoria`
--

LOCK TABLES `juego_categoria` WRITE;
/*!40000 ALTER TABLE `juego_categoria` DISABLE KEYS */;
INSERT INTO `juego_categoria` VALUES (3,1),(2,2),(3,2),(2,3),(1,4);
/*!40000 ALTER TABLE `juego_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `juego_desarrollador`
--

DROP TABLE IF EXISTS `juego_desarrollador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juego_desarrollador` (
  `id_juego` int NOT NULL,
  `id_desarrollador` int NOT NULL,
  PRIMARY KEY (`id_juego`,`id_desarrollador`),
  KEY `id_desarrollador` (`id_desarrollador`),
  CONSTRAINT `juego_desarrollador_ibfk_1` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id_juego`),
  CONSTRAINT `juego_desarrollador_ibfk_2` FOREIGN KEY (`id_desarrollador`) REFERENCES `desarrolladores` (`id_desarrollador`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `juego_desarrollador`
--

LOCK TABLES `juego_desarrollador` WRITE;
/*!40000 ALTER TABLE `juego_desarrollador` DISABLE KEYS */;
INSERT INTO `juego_desarrollador` VALUES (1,1),(2,2),(3,3);
/*!40000 ALTER TABLE `juego_desarrollador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `juegos`
--

DROP TABLE IF EXISTS `juegos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juegos` (
  `id_juego` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text,
  `fecha_lanzamiento` date DEFAULT NULL,
  `precio` decimal(6,2) NOT NULL,
  `disponible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_juego`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `juegos`
--

LOCK TABLES `juegos` WRITE;
/*!40000 ALTER TABLE `juegos` DISABLE KEYS */;
INSERT INTO `juegos` VALUES (1,'Half-Life 3','Shooter de Valve','2025-01-01',59.99,0),(2,'Counter Strike 2','Shooter competitivo en línea','2023-09-27',15.99,1),(3,'The Witcher 3','RPG de mundo abierto','2015-05-19',29.99,1),(4,'GTA V','Acción en mundo abierto','2013-09-17',19.99,1),(5,'Cyberpunk 2077','RPG futurista','2020-12-10',49.99,1),(6,'Stardew Valley','Juego de granjas','2018-06-02',8.00,1);
/*!40000 ALTER TABLE `juegos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfiles`
--

DROP TABLE IF EXISTS `perfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfiles` (
  `id_perfil` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `nickname` varchar(50) NOT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_perfil`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `perfiles_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfiles`
--

LOCK TABLES `perfiles` WRITE;
/*!40000 ALTER TABLE `perfiles` DISABLE KEYS */;
INSERT INTO `perfiles` VALUES (1,1,'Raulo99','Argentina','Amante de los FPS'),(2,2,'Carliitaa','Chile','Juego de todo un poco'),(3,3,'LuchoGamer','México','Fan de los RPG'),(4,4,'JuanitoGamer','Argentina','Amante de los indies'),(5,5,'MRAlejojo','Argentina','ElMasGroso');
/*!40000 ALTER TABLE `perfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resenas`
--

DROP TABLE IF EXISTS `resenas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resenas` (
  `id_resena` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `id_juego` int DEFAULT NULL,
  `calificacion` int DEFAULT NULL,
  `comentario` text,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_resena`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_juego` (`id_juego`),
  CONSTRAINT `resenas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `resenas_ibfk_2` FOREIGN KEY (`id_juego`) REFERENCES `juegos` (`id_juego`),
  CONSTRAINT `resenas_chk_1` CHECK ((`calificacion` between 1 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resenas`
--

LOCK TABLES `resenas` WRITE;
/*!40000 ALTER TABLE `resenas` DISABLE KEYS */;
INSERT INTO `resenas` VALUES (4,1,1,1,'Muy buen juego competitivo','2025-08-26 15:37:10'),(5,2,3,10,'El mejor mundo abierto','2025-08-26 15:37:10'),(6,3,2,8,'Gran historia y personajes','2025-08-26 15:37:10'),(7,4,4,4,'Muy divertido, ya parchearon varios bugs','2025-09-02 14:06:50'),(8,5,5,10,'Muy lindo jueguito se puede tener muchas vacas y chanchos','2025-09-02 14:06:50');
/*!40000 ALTER TABLE `resenas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasenia` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Matías','matias@gmail.com','$2b$10$rpjxhTQ959KMuUnfPZ2w/umid4P78Mug7VPTVsScWC7ZPh7s9EeM.','1998-05-10',1,'+54 9 353 7654321'),(2,'Carla','carla@hotmail.com','$2b$10$6skiywwHSjmLA7VfZdbqQ.ja646tBGnEMYNN33JtPAqIfYVJYx5ny','2001-11-22',1,'+54 9 353 4176645'),(3,'Luis','luis@yahoo.com','$2b$10$lMJKoncksSntZGn8nweTsebcOw5UHe4qBFmgGVTLukhfIpFWSINii','1995-03-15',1,'+54 9 353 4578543'),(4,'Juan','juanito@gmail.com','$2b$10$JCMvavQd6YloUk5NuWXMWuu6MHx2EJxB51K0uiLNgbQ6eGWg.gVXS','2000-07-14',1,NULL),(5,'Alejo','alejojo@gmail.com','$2b$10$AmxXeE7buCI4SQhv1BAwP..nK54xM1l/pgDePbDAtlbI9ICIjd2ra','2003-07-14',1,NULL),(6,'Raul','raul@steam.com','$2b$10$RZS9p.XeKgnlPjEQTw2VQelvSdT1C1fxCzTNLhemsxdGjN3UNb4Qy','2000-12-12',1,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-14 12:10:44
