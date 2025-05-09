-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: proyecto_final
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (5,'Almacen'),(4,'Gerente'),(6,'Vendedor');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (70,4,36),(72,4,44),(62,4,52),(74,4,60),(66,4,84),(68,5,34),(64,5,36),(67,5,42),(63,5,44),(65,5,60);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add user',7,'add_customuser'),(26,'Can change user',7,'change_customuser'),(27,'Can delete user',7,'delete_customuser'),(28,'Can view user',7,'view_customuser'),(29,'Can add Cliente',8,'add_cliente'),(30,'Can change Cliente',8,'change_cliente'),(31,'Can delete Cliente',8,'delete_cliente'),(32,'Can view Cliente',8,'view_cliente'),(33,'Can add producto',9,'add_producto'),(34,'Can change producto',9,'change_producto'),(35,'Can delete producto',9,'delete_producto'),(36,'Can view producto',9,'view_producto'),(37,'Can add empleado',10,'add_empleado'),(38,'Can change empleado',10,'change_empleado'),(39,'Can delete empleado',10,'delete_empleado'),(40,'Can view empleado',10,'view_empleado'),(41,'Can add categoria',11,'add_categoria'),(42,'Can change categoria',11,'change_categoria'),(43,'Can delete categoria',11,'delete_categoria'),(44,'Can view categoria',11,'view_categoria'),(45,'Can add detalle venta',12,'add_detalleventa'),(46,'Can change detalle venta',12,'change_detalleventa'),(47,'Can delete detalle venta',12,'delete_detalleventa'),(48,'Can view detalle venta',12,'view_detalleventa'),(49,'Can add venta',13,'add_venta'),(50,'Can change venta',13,'change_venta'),(51,'Can delete venta',13,'delete_venta'),(52,'Can view venta',13,'view_venta'),(53,'Can add transferencia',14,'add_transferencia'),(54,'Can change transferencia',14,'change_transferencia'),(55,'Can delete transferencia',14,'delete_transferencia'),(56,'Can view transferencia',14,'view_transferencia'),(57,'Can add suministradores',15,'add_suministradores'),(58,'Can change suministradores',15,'change_suministradores'),(59,'Can delete suministradores',15,'delete_suministradores'),(60,'Can view suministradores',15,'view_suministradores'),(61,'Can add site',16,'add_site'),(62,'Can change site',16,'change_site'),(63,'Can delete site',16,'delete_site'),(64,'Can view site',16,'view_site'),(65,'Can add email verification token',17,'add_emailverificationtoken'),(66,'Can change email verification token',17,'change_emailverificationtoken'),(67,'Can delete email verification token',17,'delete_emailverificationtoken'),(68,'Can view email verification token',17,'view_emailverificationtoken'),(69,'Can add movimiento producto',18,'add_movimientoproducto'),(70,'Can change movimiento producto',18,'change_movimientoproducto'),(71,'Can delete movimiento producto',18,'delete_movimientoproducto'),(72,'Can view movimiento producto',18,'view_movimientoproducto'),(73,'Can add factura',19,'add_factura'),(74,'Can change factura',19,'change_factura'),(75,'Can delete factura',19,'delete_factura'),(76,'Can view factura',19,'view_factura'),(77,'Can add Detalle de Devolución',20,'add_detalledevolucion'),(78,'Can change Detalle de Devolución',20,'change_detalledevolucion'),(79,'Can delete Detalle de Devolución',20,'delete_detalledevolucion'),(80,'Can view Detalle de Devolución',20,'view_detalledevolucion'),(81,'Can add Devolución',21,'add_devolucion'),(82,'Can change Devolución',21,'change_devolucion'),(83,'Can delete Devolución',21,'delete_devolucion'),(84,'Can view Devolución',21,'view_devolucion'),(85,'Can add conversation',22,'add_conversation'),(86,'Can change conversation',22,'change_conversation'),(87,'Can delete conversation',22,'delete_conversation'),(88,'Can view conversation',22,'view_conversation');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$nU3CWFmvqWhDgPtdMxbnUf$t/FULvmFc/DRlvzKInAEo6yKIE0LFknJwVyWLpYeaT8=',NULL,1,'angel1','','','angelalexanderperezmartinez47@gmail.com',1,1,'2025-02-06 21:27:55.043480');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-02-06 21:37:18.265087','2','angelalexanderperezmartinez47',1,'[{\"added\": {}}]',7,1),(2,'2025-02-08 01:45:37.524980','5','angelalexanderperezmartinez47',1,'[{\"added\": {}}]',7,1),(3,'2025-02-08 01:47:54.332250','5','angelalexanderperezmartinez47',3,'',7,1),(4,'2025-02-08 01:48:07.713074','7','angelalexanderperezmartinez47',1,'[{\"added\": {}}]',7,1),(5,'2025-02-08 01:51:54.955440','7','prueba',3,'',7,1),(6,'2025-02-08 01:51:54.955440','4','fauna',3,'',7,1),(7,'2025-02-09 14:23:53.599636','8','20230551',1,'[{\"added\": {}}]',7,1),(8,'2025-02-09 14:29:59.630147','8','madiba',3,'',7,1),(9,'2025-02-09 14:30:12.278680','9','20230551',1,'[{\"added\": {}}]',7,1),(10,'2025-02-09 19:06:57.545016','9','madiba',3,'',7,1),(11,'2025-02-09 19:06:57.545016','3','bryan',3,'',7,1),(12,'2025-02-09 19:09:00.019023','10','gaby epre',1,'[{\"added\": {}}]',10,1),(13,'2025-02-09 19:14:14.963204','1','lady martines',1,'[{\"added\": {}}]',8,1),(14,'2025-02-09 19:25:39.927044','3','bruan poi',1,'[{\"added\": {}}]',8,1),(15,'2025-02-09 21:05:40.688865','12','prueba marti',1,'[{\"added\": {}}]',10,1),(16,'2025-02-09 21:08:33.441348','12','prueba marti',3,'',10,1),(17,'2025-02-09 21:08:49.732638','22','angelalexanderperezmartinez39',3,'',7,1),(18,'2025-02-09 21:12:46.018464','14','ewsf fdc',1,'[{\"added\": {}}]',10,1),(19,'2025-02-09 21:12:55.364429','14','ewsf fdc',3,'',10,1),(20,'2025-02-09 21:13:07.775434','25','angelalexanderperezmartinez39',3,'',7,1),(21,'2025-02-09 23:45:19.668139','21','00000-00000-1',3,'',7,1),(22,'2025-02-09 23:45:19.668139','16','00000-00000-0',3,'',7,1),(23,'2025-02-09 23:45:19.668139','15','20230551',3,'',7,1),(24,'2025-02-09 23:45:32.295782','33','20230551',1,'[{\"added\": {}}]',7,1),(25,'2025-02-13 19:15:51.655679','1','Laptop Victus',1,'[{\"added\": {}}]',9,1),(26,'2025-02-13 19:21:38.024270','2','ergsdfv',1,'[{\"added\": {}}]',9,1),(27,'2025-02-13 19:21:49.004552','2','ergsdfv',3,'',9,1),(28,'2025-02-13 19:24:19.527969','3','4wetg',1,'[{\"added\": {}}]',9,1),(29,'2025-02-14 13:41:46.558735','3','4wetg',3,'',9,1),(30,'2025-02-14 13:43:20.859885','4','ergv',1,'[{\"added\": {}}]',9,1),(31,'2025-02-14 13:43:27.262782','4','ergv',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',9,1),(32,'2025-02-14 13:43:42.480401','4','ergv',2,'[{\"changed\": {\"fields\": [\"Image\"]}}]',9,1),(33,'2025-02-14 13:43:57.231777','4','ergv',3,'',9,1),(34,'2025-02-14 14:12:23.516319','33','madiba',2,'[{\"changed\": {\"fields\": [\"Active\", \"profile_image\"]}}]',7,1),(35,'2025-02-14 14:14:07.345564','33','madiba',2,'[{\"changed\": {\"fields\": [\"Active\", \"profile_image\"]}}]',7,1),(36,'2025-02-14 14:15:18.289311','33','madiba',2,'[{\"changed\": {\"fields\": [\"Active\", \"profile_image\"]}}]',7,1),(37,'2025-02-14 15:54:09.957537','34','20230551',1,'[{\"added\": {}}]',7,1),(38,'2025-02-14 15:54:27.543440','34','20230551',3,'',7,1),(39,'2025-02-14 15:56:36.580902','2','angel',3,'',7,1),(40,'2025-02-23 23:00:52.218867','1','Laptop',1,'[{\"added\": {}}]',11,1),(41,'2025-02-24 16:37:29.870586','5','laptop',1,'[{\"added\": {}}]',9,1),(42,'2025-02-24 16:39:03.027927','5','laptop',2,'[{\"changed\": {\"fields\": [\"Stock\"]}}]',9,1),(43,'2025-02-24 16:54:35.314293','6','efsgv',1,'[{\"added\": {}}]',9,1),(44,'2025-02-24 16:55:40.494436','6','efsgv',3,'',9,1),(45,'2025-02-24 16:55:40.494436','5','laptop',3,'',9,1),(46,'2025-02-24 23:04:25.785828','7','trshfdv',1,'[{\"added\": {}}]',9,1),(47,'2025-02-24 23:12:24.892000','7','trshfdv',3,'',9,1),(48,'2025-02-24 23:13:39.572446','1','Laptop',3,'',11,1),(49,'2025-02-24 23:16:54.238838','27','Rodillo',3,'',9,1),(50,'2025-02-24 23:16:54.238838','26','Brocha',3,'',9,1),(51,'2025-02-24 23:16:54.238838','25','Pintura acrílica',3,'',9,1),(52,'2025-02-24 23:16:54.238838','24','Cemento',3,'',9,1),(53,'2025-02-24 23:16:54.238838','23','Soldadora',3,'',9,1),(54,'2025-02-24 23:16:54.238838','22','Disco de corte',3,'',9,1),(55,'2025-02-24 23:16:54.238838','21','Generador',3,'',9,1),(56,'2025-02-24 23:16:54.238838','20','Compresor de aire',3,'',9,1),(57,'2025-02-24 23:16:54.238838','19','Escalera',3,'',9,1),(58,'2025-02-24 23:16:54.238838','18','Sierra circular',3,'',9,1),(59,'2025-02-24 23:16:54.238838','17','Botas industriales',3,'',9,1),(60,'2025-02-24 23:16:54.238838','16','Lentes de protección',3,'',9,1),(61,'2025-02-24 23:16:54.238838','15','Guantes de seguridad',3,'',9,1),(62,'2025-02-24 23:16:54.238838','14','Cinta métrica',3,'',9,1),(63,'2025-02-24 23:16:54.238838','13','Clavos',3,'',9,1),(64,'2025-02-24 23:16:54.238838','12','Taladro eléctrico',3,'',9,1),(65,'2025-02-24 23:16:54.238838','11','Sierra manual',3,'',9,1),(66,'2025-02-24 23:16:54.238838','10','Llave inglesa',3,'',9,1),(67,'2025-02-24 23:16:54.238838','9','Destornillador',3,'',9,1),(68,'2025-02-24 23:16:54.238838','8','Martillo',3,'',9,1),(69,'2025-02-24 23:38:36.804609','48','RDSFCZX',1,'[{\"added\": {}}]',9,1),(70,'2025-02-24 23:49:20.943375','48','RDSFCZX',2,'[{\"changed\": {\"fields\": [\"Activo\"]}}]',9,1),(71,'2025-02-25 23:46:18.300770','35','20230ed551',1,'[{\"added\": {}}]',7,1),(72,'2025-02-26 00:05:21.141789','36','dhxfdgh',1,'[{\"added\": {}}]',7,1),(73,'2025-02-26 00:06:55.554455','1','Venta 1 - 2025-02-25 18:06:40-06:00',1,'[{\"added\": {}}]',13,1),(74,'2025-02-26 00:07:10.117502','1','Venta 1 - 2025-02-26 00:06:40+00:00',3,'',13,1),(75,'2025-02-26 00:25:47.623436','2','Venta 2 - 2025-02-26 00:25:47.618883+00:00',1,'[{\"added\": {}}]',13,1),(76,'2025-03-03 14:53:31.377464','37','20230551',1,'[{\"added\": {}}]',7,1),(77,'2025-03-03 22:28:17.689332','49','caja',1,'[{\"added\": {}}]',9,1),(78,'2025-03-03 23:48:09.096682','49','caja',3,'',9,1),(79,'2025-03-03 23:48:33.822896','50','caja',1,'[{\"added\": {}}]',9,1),(80,'2025-03-03 23:55:46.289710','51','caja1',1,'[{\"added\": {}}]',9,1),(81,'2025-03-04 13:30:16.100195','52','d',1,'[{\"added\": {}}]',9,1),(82,'2025-03-04 13:38:07.808489','54','dgf',1,'[{\"added\": {}}]',9,1),(83,'2025-03-04 13:47:37.598513','55','dsf',1,'[{\"added\": {}}]',9,1),(84,'2025-03-04 13:52:50.485664','56','23',1,'[{\"added\": {}}]',9,1),(85,'2025-03-04 13:53:12.114316','57','12',1,'[{\"added\": {}}]',9,1),(86,'2025-03-04 14:01:08.109872','58','e',1,'[{\"added\": {}}]',9,1),(87,'2025-03-05 14:55:40.637960','59','yoel',1,'[{\"added\": {}}]',9,1),(88,'2025-03-05 14:57:46.131254','60','angel',1,'[{\"added\": {}}]',9,1),(89,'2025-03-05 14:59:49.467917','61','12',1,'[{\"added\": {}}]',9,1),(90,'2025-03-05 15:00:58.584589','62','13',1,'[{\"added\": {}}]',9,1),(91,'2025-03-05 15:08:54.577495','63','122',1,'[{\"added\": {}}]',9,1),(92,'2025-03-05 15:09:37.444008','64','ew',1,'[{\"added\": {}}]',9,1),(93,'2025-03-05 15:51:39.928928','70','rfds',1,'[{\"added\": {}}]',9,1),(94,'2025-03-05 15:54:13.097145','72','3re',1,'[{\"added\": {}}]',9,1),(95,'2025-03-05 16:00:56.184085','75','e',1,'[{\"added\": {}}]',9,1),(96,'2025-03-05 16:01:34.019076','77','re',1,'[{\"added\": {}}]',9,1),(97,'2025-03-05 16:10:12.602998','70','rfds',3,'',9,1),(98,'2025-03-05 16:15:02.801123','38','yoensiar',1,'[{\"added\": {}}]',7,1),(99,'2025-03-05 16:16:31.397880','38','yoensiar',3,'',7,1),(100,'2025-03-05 16:17:00.617369','39','angelalexanderperezmartinez39',1,'[{\"added\": {}}]',7,1),(101,'2025-03-05 16:18:31.090304','40','yoensiar',1,'[{\"added\": {}}]',7,1),(102,'2025-03-05 16:19:56.290151','40','yoensiar',3,'',7,1),(103,'2025-03-05 16:20:27.901184','41','yoensiar',1,'[{\"added\": {}}]',7,1),(104,'2025-03-05 16:24:45.456813','41','yoensiar',3,'',7,1),(105,'2025-03-05 16:25:01.753453','42','yoensiar',1,'[{\"added\": {}}]',7,1),(106,'2025-03-05 16:27:38.382578','39','angelalexanderperezmartinez39',3,'',7,1),(107,'2025-03-05 16:27:54.015346','43','angelalexanderperezmartinez39',1,'[{\"added\": {}}]',7,1),(108,'2025-03-05 16:32:08.964154','43','39angel',3,'',7,1),(109,'2025-03-05 16:42:51.376716','42','yoensiar',3,'',7,1),(110,'2025-03-05 17:42:36.395656','78','sd',1,'[{\"added\": {}}]',9,1),(111,'2025-03-21 09:05:54.628551','79','er',1,'[{\"added\": {}}]',9,1),(112,'2025-03-21 15:52:11.410919','32','Taladro eléctrico',2,'[{\"changed\": {\"fields\": [\"Activo\"]}}]',9,1),(113,'2025-03-21 15:52:36.701104','32','Taladro eléctrico',2,'[{\"changed\": {\"fields\": [\"Activo\"]}}]',9,1),(114,'2025-03-25 17:58:26.279174','79','er',2,'[{\"changed\": {\"fields\": [\"Descuento\"]}}]',9,1),(115,'2025-03-27 19:07:04.635135','29','Destornilladore',2,'[{\"changed\": {\"fields\": [\"Nombre\", \"Categoria\"]}}]',9,1),(116,'2025-03-27 19:08:36.555959','30','Llave inglesaaa',2,'[{\"changed\": {\"fields\": [\"Nombre\", \"Categoria\"]}}]',9,1),(117,'2025-03-28 00:55:02.886860','1','rijo',1,'[{\"added\": {}}]',15,1),(118,'2025-03-28 00:55:38.570152','2','miguel',1,'[{\"added\": {}}]',15,1),(119,'2025-03-28 00:56:36.072927','3','Ercilio',1,'[{\"added\": {}}]',15,1),(120,'2025-03-30 18:19:34.287361','40','Venta #40 - angel2 - 10000.00',3,'',13,1),(121,'2025-03-30 18:19:34.287361','39','Venta #39 - angel2 - 50000.00',3,'',13,1),(122,'2025-03-31 13:48:58.171676','1','admin',1,'[{\"added\": {}}]',3,1),(123,'2025-03-31 14:24:17.927602','44','angelalexanderperezmartinez39',1,'[{\"added\": {}}]',7,1),(124,'2025-03-31 23:36:32.676534','35','20230ed551',2,'[{\"changed\": {\"fields\": [\"profile_image\", \"Groups\", \"User permissions\"]}}]',7,1),(125,'2025-03-31 23:58:13.538551','2','nada',1,'[{\"added\": {}}]',3,1),(126,'2025-03-31 23:58:43.615147','35','20230ed551',2,'[{\"changed\": {\"fields\": [\"profile_image\", \"Groups\", \"User permissions\"]}}]',7,1),(127,'2025-03-31 23:59:31.058889','35','20230ed551',2,'[{\"changed\": {\"fields\": [\"profile_image\", \"Groups\"]}}]',7,1),(128,'2025-03-31 23:59:45.570084','1','admin',3,'',3,1),(129,'2025-03-31 23:59:45.570084','2','nada',3,'',3,1),(130,'2025-04-01 00:19:51.347015','3','dfs',1,'[{\"added\": {}}]',3,1),(131,'2025-04-01 00:33:19.193330','3','dfs',3,'',3,1),(132,'2025-04-01 00:44:27.959991','4','Gerente',1,'[{\"added\": {}}]',3,1),(133,'2025-04-01 00:47:44.525954','44','angel21',2,'[{\"changed\": {\"fields\": [\"Grupos\"]}}]',7,1),(134,'2025-04-01 01:51:14.710990','5','Almacen',1,'[{\"added\": {}}]',3,1),(135,'2025-04-01 01:51:32.027594','37','20230551',2,'[{\"changed\": {\"fields\": [\"Es staff\", \"Grupos\"]}}]',7,1),(136,'2025-04-01 01:52:23.040345','37','20230551',3,'',7,1),(137,'2025-04-01 01:53:35.169608','45','angelalexanderperezmartinez12',1,'[{\"added\": {}}]',7,1),(138,'2025-04-01 01:59:47.333573','6','Vendedor',1,'[{\"added\": {}}]',3,1),(139,'2025-04-01 02:00:02.617261','46','dawaryramirezmontero',1,'[{\"added\": {}}]',7,1),(140,'2025-04-01 02:19:44.765463','46','dawary',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',7,1),(141,'2025-04-01 02:21:41.018226','46','dawary',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',7,1),(142,'2025-04-01 02:23:32.934030','46','dawary',2,'[{\"changed\": {\"fields\": [\"Active\"]}}]',7,1),(143,'2025-04-07 00:05:58.140802','80','dsafs',1,'[{\"added\": {}}]',9,1),(144,'2025-04-07 00:06:46.747996','81','angel2',1,'[{\"added\": {}}]',9,1),(145,'2025-04-07 00:54:03.503601','82','erfdsf',1,'[{\"added\": {}}]',9,1),(146,'2025-04-07 00:55:35.887642','83','terf',1,'[{\"added\": {}}]',9,1),(147,'2025-04-07 00:58:13.969488','84','fdcv',1,'[{\"added\": {}}]',9,1),(148,'2025-04-07 01:01:28.634678','85','qfesdx',1,'[{\"added\": {}}]',9,1),(149,'2025-04-07 01:09:07.246151','86','efdsgfc',1,'[{\"added\": {}}]',9,1),(150,'2025-04-17 17:28:44.579311','77','re',2,'[{\"changed\": {\"fields\": [\"Descripcion\"]}}]',9,1),(151,'2025-04-17 17:28:52.216874','72','3re',2,'[{\"changed\": {\"fields\": [\"Descripcion\"]}}]',9,1),(152,'2025-05-04 17:24:04.129230','4','Gerente',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(153,'2025-05-04 21:09:38.947936','5','Almacen',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(154,'2025-05-04 21:24:58.341935','4','Gerente',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(155,'2025-05-04 21:27:35.584305','4','Gerente',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(156,'2025-05-04 21:43:03.608549','4','Gerente',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(157,'2025-05-05 01:35:36.724119','7','Grupo prueba',1,'[{\"added\": {}}]',3,1),(158,'2025-05-05 02:02:17.510217','7','Grupo prueba',2,'[{\"changed\": {\"fields\": [\"Permissions\"]}}]',3,1),(159,'2025-05-05 13:48:02.720852','7','Grupo prueba',3,'',3,1),(160,'2025-05-05 14:16:59.213534','11','prueba',1,'[{\"added\": {}}]',11,1),(161,'2025-05-05 14:35:10.501162','11','prueba2',2,'[{\"changed\": {\"fields\": [\"nombre_categoria\", \"descripcion_categoria\"]}}]',11,1),(162,'2025-05-05 14:46:07.804180','11','prueba2',3,'',11,1),(163,'2025-05-05 15:28:09.179504','8','Admin',1,'[{\"added\": {}}]',3,1),(164,'2025-05-05 15:30:20.009851','4','Prueba',1,'[{\"added\": {}}]',15,1),(165,'2025-05-05 15:41:29.887380','4','Prueba2',2,'[{\"changed\": {\"fields\": [\"Nombre proveedor\", \"Telefono\", \"Email\", \"Direccion\"]}}]',15,1),(166,'2025-05-05 16:16:58.811096','4','Prueba2',3,'',15,1),(167,'2025-05-05 16:37:36.518954','87','Prueba',1,'[{\"added\": {}}]',9,1),(168,'2025-05-05 16:37:52.077642','87','Prueba2',2,'[{\"changed\": {\"fields\": [\"Nombre\", \"Marca\", \"Descripcion\", \"Categoria\"]}}]',9,1),(169,'2025-05-05 16:38:07.018818','87','Prueba2',3,'',9,1),(170,'2025-05-05 17:32:43.156984','45','angel3',3,'',7,1),(171,'2025-05-05 17:53:04.589838','51','angelalexanderperezmartinez12',1,'[{\"added\": {}}]',7,1),(172,'2025-05-05 17:53:14.459587','51','angelalexanderperezmartinez12',3,'',7,1),(173,'2025-05-05 18:09:25.373373','52','angelalexanderperezmartinez12',1,'[{\"added\": {}}]',7,1),(174,'2025-05-05 18:09:33.944168','52','angelalexanderperezmartinez12',3,'',7,1),(175,'2025-05-05 18:10:38.016412','53','angelalexanderperezmartinez12',1,'[{\"added\": {}}]',7,1),(176,'2025-05-05 18:10:58.634435','53','angelalexanderperezmartinez12',3,'',7,1),(177,'2025-05-05 18:11:27.224856','54','angelalexanderperezmartinez12',1,'[{\"added\": {}}]',7,1),(178,'2025-05-05 18:12:34.028116','35','20230ed551',2,'[{\"changed\": {\"fields\": [\"Es superusuario\", \"Es staff\", \"Grupo\"]}}]',7,1),(179,'2025-05-05 18:13:06.636695','36','dhxfdgh',3,'',7,1),(180,'2025-05-05 19:28:51.061358','8','Admin',3,'',3,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(22,'bot','conversation'),(8,'clientes','cliente'),(5,'contenttypes','contenttype'),(10,'empleados','empleado'),(11,'productos','categoria'),(18,'productos','movimientoproducto'),(9,'productos','producto'),(15,'productos','suministradores'),(20,'returns','detalledevolucion'),(21,'returns','devolucion'),(6,'sessions','session'),(16,'sites','site'),(7,'users','customuser'),(17,'users','emailverificationtoken'),(12,'ventas','detalleventa'),(19,'ventas','factura'),(14,'ventas','transferencia'),(13,'ventas','venta');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-02-06 21:27:08.488255'),(2,'auth','0001_initial','2025-02-06 21:27:09.781909'),(3,'admin','0001_initial','2025-02-06 21:27:10.643820'),(4,'admin','0002_logentry_remove_auto_add','2025-02-06 21:27:10.681515'),(5,'admin','0003_logentry_add_action_flag_choices','2025-02-06 21:27:10.702754'),(6,'contenttypes','0002_remove_content_type_name','2025-02-06 21:27:11.066961'),(7,'auth','0002_alter_permission_name_max_length','2025-02-06 21:27:11.475689'),(8,'auth','0003_alter_user_email_max_length','2025-02-06 21:27:11.547340'),(9,'auth','0004_alter_user_username_opts','2025-02-06 21:27:11.562464'),(10,'auth','0005_alter_user_last_login_null','2025-02-06 21:27:11.867628'),(11,'auth','0006_require_contenttypes_0002','2025-02-06 21:27:11.896734'),(12,'auth','0007_alter_validators_add_error_messages','2025-02-06 21:27:11.919124'),(13,'auth','0008_alter_user_username_max_length','2025-02-06 21:27:12.282492'),(14,'auth','0009_alter_user_last_name_max_length','2025-02-06 21:27:12.712054'),(15,'auth','0010_alter_group_name_max_length','2025-02-06 21:27:12.790086'),(16,'auth','0011_update_proxy_permissions','2025-02-06 21:27:12.820940'),(17,'auth','0012_alter_user_first_name_max_length','2025-02-06 21:27:13.189578'),(18,'sessions','0001_initial','2025-02-06 21:27:13.327805'),(19,'users','0001_initial','2025-02-06 21:28:38.537358'),(20,'users','0002_customuser_cargo','2025-02-08 16:55:12.606314'),(21,'clientes','0001_initial','2025-02-08 17:08:23.424213'),(22,'productos','0001_initial','2025-02-08 17:16:50.224230'),(23,'empleados','0001_initial','2025-02-08 18:23:46.580708'),(24,'users','0003_alter_customuser_cargo','2025-02-08 18:29:56.055411'),(25,'empleados','0002_remove_empleado_salario','2025-02-08 19:15:39.356551'),(26,'users','0004_remove_customuser_cargo_customuser_is_client','2025-02-09 23:44:51.031628'),(27,'productos','0002_remove_producto_updated_at_and_more','2025-02-13 19:08:39.097155'),(28,'productos','0003_producto_updated_at','2025-02-13 19:08:55.619798'),(29,'users','0005_alter_customuser_email','2025-02-14 15:56:40.778929'),(30,'productos','0004_producto_marca_alter_producto_descripcion','2025-02-23 22:06:23.028981'),(31,'productos','0005_categoria_producto_categoria','2025-02-23 22:38:11.458458'),(32,'productos','0006_rename_categoria_categorias','2025-02-23 22:38:11.615406'),(33,'productos','0007_remove_producto_categoria_delete_categorias','2025-02-23 22:38:11.704607'),(34,'productos','0008_categoria','2025-02-23 22:38:11.750872'),(35,'productos','0009_producto_categoria','2025-02-23 23:05:41.941809'),(36,'productos','0010_alter_producto_categoria','2025-02-26 00:01:37.789198'),(37,'ventas','0001_initial','2025-02-26 00:01:38.165873'),(38,'ventas','0002_alter_detalleventa_subtotal_alter_venta_fecha_venta_and_more','2025-02-26 00:13:06.798364'),(39,'ventas','0003_alter_venta_metodo_pago','2025-02-26 00:16:53.403350'),(40,'ventas','0004_remove_venta_cliente_remove_venta_empleado_and_more','2025-02-26 00:58:13.394555'),(41,'productos','0011_producto_codigo_qr','2025-03-03 21:09:24.786137'),(42,'productos','0012_remove_producto_codigo_qr','2025-03-04 12:00:41.049684'),(43,'productos','0013_producto_codigo_qr','2025-03-04 12:08:48.494969'),(44,'ventas','0005_initial','2025-03-10 18:59:24.152649'),(45,'ventas','0006_detalleventa_itbis','2025-03-10 20:35:29.652336'),(46,'ventas','0007_transferencia','2025-03-10 21:23:59.337528'),(47,'ventas','0008_transferencia_correo_cliente_and_more','2025-03-10 22:56:06.190338'),(48,'ventas','0009_transferencia_tipo_cuenta','2025-03-12 15:41:00.299162'),(49,'productos','0014_producto_costo_producto_descuento','2025-03-24 15:23:49.262189'),(50,'ventas','0010_detalleventa_cantidad_descuento_and_more','2025-03-25 17:26:53.892466'),(51,'productos','0015_suministradores','2025-03-28 00:38:54.937188'),(52,'productos','0016_alter_suministradores_options_and_more','2025-03-28 00:46:49.713277'),(53,'productos','0017_alter_suministradores_email_and_more','2025-03-28 00:51:16.648853'),(54,'productos','0018_alter_suministradores_email','2025-03-28 00:55:58.002794'),(55,'productos','0019_producto_suministrador','2025-03-28 00:59:49.085991'),(56,'users','0006_remove_customuser_is_client','2025-03-31 14:18:48.373386'),(57,'users','0007_customuser_group_alter_customuser_groups','2025-04-01 14:42:23.239692'),(58,'sites','0001_initial','2025-04-02 01:01:50.859312'),(59,'sites','0002_alter_domain_unique','2025-04-02 01:01:50.915120'),(60,'users','0008_emailverificationtoken','2025-04-03 18:41:15.920527'),(61,'users','0009_alter_customuser_profile_image','2025-04-06 23:43:53.129891'),(62,'productos','0020_movimientoproducto','2025-04-06 23:52:43.421579'),(63,'productos','0021_alter_movimientoproducto_tipo_movimiento','2025-04-06 23:58:41.651958'),(64,'ventas','0011_factura','2025-04-07 21:02:59.947768'),(65,'returns','0001_initial','2025-04-09 20:35:09.383123'),(66,'returns','0002_detalledevolucion_inventario_repuesto','2025-04-12 01:22:37.473592'),(67,'productos','0022_movimientoproducto_ultima_alerta_stock','2025-04-15 02:10:56.005407'),(68,'productos','0023_remove_movimientoproducto_ultima_alerta_stock','2025-04-15 02:11:10.019755'),(69,'productos','0024_producto_ultima_alerta_stock','2025-04-15 02:11:32.458035'),(70,'bot','0001_initial','2025-04-19 15:47:46.852059');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('00xuapsm7l5uyrksde55fg86jeo5bico','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1uC8hq:WcASWA3Nopt_rixj4Q-NZOxzfoIwlua818iXdKZdjQU','2025-05-20 03:10:54.865952'),('0k74cyywrxyh7nn3ju5aapf0ohw4h7uv','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1tga08:oXLUu06erq8cH8EuRQyegZIkRlypddsfXn4gtGwud1Q','2025-02-22 01:51:20.367345'),('2y4dqgm95aeeolq75ssbq8fz7mu1gmf8','.eJxVjDsOwjAQRO_iGllZ28uuKek5g-XPCgeQI8VJhbg7iZQCutG8N_NWIa5LDWuXOYxFXRQ6dfotU8xPaTspj9juk85TW-Yx6V3RB-36NhV5XQ_376DGXre1MOI5I0STmezgLRIZFkjIUjxZU7acPVhgIAQUMoiDRDTOMXqvPl_cLDZz:1uC2pk:Lh5qiyJRT9c8gThtzi9zcfXd3AVvVQX4Ael1fAUR_SI','2025-05-19 20:54:40.365086'),('3b6vsttnkcm1atkw5y5qy4uodqpaif11','eyJfcGFzc3dvcmRfcmVzZXRfdG9rZW4iOiJjbmxuamstYmE3MGQyY2UzM2Y5NDVmODQyZDA5NTZlNWMzZjczYjMifQ:1tzmrv:IVRK1dROsUSEgbCpY6mBABnp-rLfgPxVzcWx56YxC3s','2025-04-16 01:26:15.013806'),('49jad8kj30uvuynndskiw07wbnzk0xtj','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1tnK6w:MPMi2Hdl5oHVQNNwpasuyvs04dESDIRcNrYcBnH3xjg','2025-03-12 16:18:14.428352'),('88a4zax0fskhuq8z3vrl8efbkaigu9dv','e30:1tzG4Z:2N67drXecN9wzl-FZu8iIx97PTqqMQuGW0XFRkRt4Wg','2025-04-14 14:25:07.219447'),('8ekpa8zukqarxxvucvp31f5qx4dyiw4y','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1uC8gh:CAzV1ntAFc6heVXpou2aP29DebZkh1h0XkUm6S4mpuA','2025-05-20 03:09:43.501785'),('9uyv1tvanlqt5dfb2zmkralzl6d8vb1b','e30:1tixJj:0_Q3bghpK6FRF0_lZ3jok45KW5YrIaPDE01IllOidEE','2025-02-28 15:09:23.886793'),('adyde3l18495eory9a6xn0qlmcsfcb32','.eJxVjDsOwjAQBe_iGln-x1DS5wzWer2LA8iR4qRC3B0ipYD2zcx7iQTbWtPWaUlTERfhgjj9jhnwQW0n5Q7tNkuc27pMWe6KPGiX41zoeT3cv4MKvX5rEz0DK9C6oC7OErriCQ2CdS4yKa9MoCHY7FGHiBwggLODYjYUz1m8PyCQOI8:1u0S8r:1bXOlL9LiK2Bkc2FHnB0Tw4_Lu8kbhxHEoKNqptmsvs','2025-04-17 21:30:29.185137'),('az27zutm2bxww7t3osq04s670gbcj91v','.eJxVjEEOgjAQRe_StWlaOhVw6Z4zkJnOx6IGEgor492VhIVu_3vvv0zP25r7rWDpRzUXQ9Gcfkfh9MC0E73zdJttmqd1GcXuij1osd2seF4P9-8gc8nfWsiHxJCa2gBCakADmjCcfctt5YAmBRZIcEGVyKnEGJUpedQMrcz7AzFVOU0:1tzQrY:kyBf3_8CLXV-W90LaEEQXTmD7wEvquEsZ3GLFJ0HuUI','2025-04-15 01:56:24.360770'),('c53hoz9anct6yprvqfwhy79cvfrmjbim','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1uAdHC:EAGimzB7QaWrNKTOz56Zk50H0xfe8VcDV9Uyfoa0V4E','2025-05-15 23:25:10.344742'),('c911mbnzn1qjt7eyhrd6n0b3qs1eztm2','e30:1tixL0:ukOCqbP2NQza9EeQPQhqaeL2Xzz3hoWDI0QqO-9EC1M','2025-02-28 15:10:42.128165'),('c9bsff09hxah1xjcfj70s15hwq102hb6','.eJxVjDsOwjAQBe_iGlle_01JzxmsXX9wADlSnFSIu0OkFNC-mXkvFnFbW9xGWeKU2ZlpzU6_I2F6lL6TfMd-m3ma-7pMxHeFH3Tw65zL83K4fwcNR_vWDmzNViUoQvocDLnqJPmssAoFKMioWgIaaxJqr5KRAIGAvK9YQFT2_gAJnjgu:1tzG5x:BhktXPKVVVojkTXeEcwu-wSjul3STnC8vNQ3v4U1Lwk','2025-04-14 14:26:33.474297'),('e2m5aiw672u1gm0vupwxyshntuvkua6y','e30:1tnK6R:2Mm3IwBKQOq0tExn0z41B_NNtok91ZG8x53eZwAridE','2025-03-12 16:17:43.364730'),('ee9rdf73n48c7hav2z6hcbnq1jz2pxkh','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1twjQc:HyBRRxBlKrTh18BSbUAKOTSYLP9l2v8ZlXYWMll5aGI','2025-04-07 15:09:26.523559'),('erjjrhsn3fhqfo32gk63hnc9epe604bw','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1uC8p5:pnT9HIb9eRXwDXN2n-lLvpOliBSHsvdSzloV6b9Vj5A','2025-05-20 03:18:23.906321'),('ewmddn7s64knvbh3pztfhbrkfmsx80gs','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1thdZ6:5Ev86E0XlCZrjKnQivTv3-ae0Hcs-yc8ILndaYIfRjY','2025-02-24 23:51:48.202457'),('izzpjjic0nzs1295r3161t0e36j5g7mi','.eJxVjEEOwiAQRe_C2hAKDBSX7j0DGWbAVg0kpV0Z765NutDtf-_9l4i4rVPcel7izOIsjBGn3zEhPXLdCd-x3pqkVtdlTnJX5EG7vDbOz8vh_h1M2KdvHcas2AbDBVVQCAAaiLKHAiNadp6KDw4SKc0WktLjAIq85oFzso7F-wMGQTgL:1thWJN:ewCitQis3-P4PwkKgfMD7XvI0oPehu25XDJCUhVpP1Y','2025-02-24 16:07:05.500304'),('kgg4kd8659bvttm2x4frhs9gnjoz708p','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1uCGsX:sp9taKtIRQuPY0BXRZeCjgh2YBpXorVdwWbvfqCQJTk','2025-05-20 11:54:29.316451'),('m2vnw4hn565db5njy9fe5d1n8fdqtwif','.eJxVjDsOwjAQBe_iGln-x1DS5wzWer2LA8iR4qRC3B0ipYD2zcx7iQTbWtPWaUlTERfhgjj9jhnwQW0n5Q7tNkuc27pMWe6KPGiX41zoeT3cv4MKvX5rEz0DK9C6oC7OErriCQ2CdS4yKa9MoCHY7FGHiBwggLODYjYUz1m8PyCQOI8:1u0SK1:7f1v4AthNGVdPXXGw2mrJt2DsDKyunhfA2eX7QfDD2A','2025-04-17 21:42:01.481847'),('oskwysr2maaomn574pdhw8z6pkdemfuk','e30:1tsQSv:moWAIEbZZFhwrn5_Mtj0tJvRo1TEFEzFNvYp6RRN1BE','2025-03-26 18:06:01.269481'),('qeiecwginwrhjms9y0un8t9bq7xehc3i','.eJxVjDsOwjAQRO_iGllZ28uuKek5g-XPCgeQI8VJhbg7iZQCutG8N_NWIa5LDWuXOYxFXRQ6dfotU8xPaTspj9juk85TW-Yx6V3RB-36NhV5XQ_376DGXre1MOI5I0STmezgLRIZFkjIUjxZU7acPVhgIAQUMoiDRDTOMXqvPl_cLDZz:1uC3kT:EY63VTXoz67F70dX9YU-5z_Nm3HxB5jQa8th4tVgNS8','2025-05-19 21:53:17.776825'),('rf2jo3vvj0oruv7atseiriuft967b5g0','e30:1tzR0I:j50-yLsgxJ2Z1GGz8jj2qVMaDsrXuFOP2Qmoii0Dsic','2025-04-15 02:05:26.224936'),('rjms5u3hppmagznh98bat3yvjn0b11zo','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1tkAzK:sk0Y_ufO_Gn-WbQhuFHrJsJnoGL-xw_b2Cf_AbKBFuQ','2025-03-03 23:57:22.626515'),('rs0eu5ff87xz6njlooao90was6bc20w1','.eJxVjEEOwiAQRe_C2hAKDBSX7j0DGWbAVg0kpV0Z765NutDtf-_9l4i4rVPcel7izOIsjBGn3zEhPXLdCd-x3pqkVtdlTnJX5EG7vDbOz8vh_h1M2KdvHcas2AbDBVVQCAAaiLKHAiNadp6KDw4SKc0WktLjAIq85oFzso7F-wMGQTgL:1tsQYA:Gc4gwApnSgST-KUSFgvUP0feDx7n83dcYOpnCv-cr2k','2025-03-26 18:11:26.184580'),('sc1fg9fmrrjtpd49h8u32r1lbdvhzxt9','.eJxVjDsOwjAQBe_iGlmsvf5R0ucM1sZe4wBypDipEHeHSCmgfTPzXiLStta4dV7ilMVFoBan33Gk9OC2k3yndptlmtu6TKPcFXnQLoc58_N6uH8HlXr91kUrxFyCzgXC2ZiSiJRNyM56gOCcNRCUR6UNmgSgwKJ3hckCs0ss3h_qIDcq:1tprep:_QsmN0-rPfkevYolD7s0ZqUvuSNvftnbEFXVvyS9ZDc','2025-03-19 16:31:43.319645'),('sjlrdwonl6yfivfffbml25ly4yoo9d7s','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1twqnM:wCrz5gggFQ-b4pc6LZBkbic3EzIHkJWpe0C0K_lJZGs','2025-04-07 23:01:24.914019'),('xq1l4jdw9q57q64jutfvgz989zfsdb1w','e30:1tzR2H:MBvIOxvMVVOnA4HSsgDEDwbbZwsJm6_bmPYm2V96-1g','2025-04-15 02:07:29.892877'),('znhykdd4fwrskz7djxd6wjgu2n5t1lmq','.eJxVjMsOwiAURP-FtSE8ysul-34DuVxAqgaS0q6M_y5NutDlzDkzb-Jh34rfe1r9EsmVcHL57QLgM9UDxAfUe6PY6rYugR4KPWmnc4vpdTvdv4MCvYy1MZzpJBG1M0yjUJILO6GxRrrA1MSthBGU01mIHMOAOiuOFjA7pR35fAGixTZ3:1th83Q:RhKTOvgfTsce_h48uRcjFtXHzIuACzwKPGjgGr__Ksk','2025-02-23 14:13:00.503361');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'localhost','PuntoXpress');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_categoria`
--

DROP TABLE IF EXISTS `productos_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_categoria` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(255) NOT NULL,
  `descripcion_categoria` longtext,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre_categoria` (`nombre_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_categoria`
--

LOCK TABLES `productos_categoria` WRITE;
/*!40000 ALTER TABLE `productos_categoria` DISABLE KEYS */;
INSERT INTO `productos_categoria` VALUES (1,'Electrónica','Productos electrónicos como teléfonos, laptops y accesorios.'),(2,'Hogar','Artículos para el hogar como muebles y electrodomésticos.'),(3,'Deportes','Equipos y accesorios deportivos para diversas disciplinas.'),(4,'Moda','Ropa, calzado y accesorios de moda.'),(5,'Salud y Belleza','Productos para el cuidado personal, salud y belleza.'),(6,'Automotriz','Accesorios y repuestos para vehículos.'),(7,'Juguetes','Juguetes y artículos para niños de todas las edades.'),(8,'Alimentos','Productos alimenticios y bebidas.'),(9,'Ferretería','Herramientas y materiales para construcción y reparación.'),(10,'Libros y Papelería','Libros, cuadernos y artículos de oficina.');
/*!40000 ALTER TABLE `productos_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_movimientoproducto`
--

DROP TABLE IF EXISTS `productos_movimientoproducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_movimientoproducto` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tipo_movimiento` varchar(20) NOT NULL,
  `cantidad` int unsigned NOT NULL,
  `stock_antes` int unsigned NOT NULL,
  `stock_despues` int unsigned NOT NULL,
  `descripcion` longtext,
  `fecha` datetime(6) NOT NULL,
  `producto_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `productos_movimiento_producto_id_27baf6e4_fk_productos` (`producto_id`),
  CONSTRAINT `productos_movimiento_producto_id_27baf6e4_fk_productos` FOREIGN KEY (`producto_id`) REFERENCES `productos_producto` (`id_producto`),
  CONSTRAINT `productos_movimientoproducto_chk_1` CHECK ((`cantidad` >= 0)),
  CONSTRAINT `productos_movimientoproducto_chk_2` CHECK ((`stock_antes` >= 0)),
  CONSTRAINT `productos_movimientoproducto_chk_3` CHECK ((`stock_despues` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=365 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_movimientoproducto`
--

LOCK TABLES `productos_movimientoproducto` WRITE;
/*!40000 ALTER TABLE `productos_movimientoproducto` DISABLE KEYS */;
INSERT INTO `productos_movimientoproducto` VALUES (1,'SALIDA',1,17,16,'Venta realizada','2025-04-07 00:00:55.809001',30),(2,'CREACION',20,0,20,'Producto creado','2025-04-07 00:05:58.078308',80),(3,'ACTUALIZACION',0,20,20,'Producto actualizado sin cambio de stock','2025-04-07 00:05:58.140802',80),(4,'CREACION',100,0,100,'Producto creado','2025-04-07 00:06:46.687248',81),(5,'ACTUALIZACION',0,100,100,'Producto actualizado sin cambio de stock','2025-04-07 00:06:46.742156',81),(6,'ENTRADA',84,16,100,'Cambio automático de stock','2025-04-07 00:08:03.124507',30),(7,'ACTUALIZACION',0,100,100,'Producto actualizado sin cambio de stock','2025-04-07 00:08:42.466821',30),(8,'ENTRADA',1,100,101,'Cambio automático de stock','2025-04-07 00:09:08.310719',30),(9,'SALIDA',3,101,98,'Venta realizada','2025-04-07 00:10:03.885037',30),(10,'SALIDA',3,95,92,'Venta realizada','2025-04-07 00:10:36.556834',30),(11,'SALIDA',1,89,88,'Venta realizada','2025-04-07 00:12:25.723239',30),(12,'SALIDA',1,88,87,'Cambio automático de stock','2025-04-07 00:12:25.739132',30),(13,'SALIDA',2,87,85,'Venta realizada','2025-04-07 00:15:48.396923',30),(14,'SALIDA',40,83,43,'Venta realizada','2025-04-07 00:17:02.605370',30),(15,'SALIDA',4,3,0,'Venta realizada','2025-04-07 00:19:12.556803',30),(16,'SALIDA',3,0,0,'Venta realizada','2025-04-07 00:19:19.509671',30),(17,'SALIDA',2,0,0,'Venta realizada','2025-04-07 00:19:26.979546',30),(18,'ENTRADA',30,0,30,'Cambio automático de stock','2025-04-07 00:23:23.897590',30),(19,'SALIDA',1,30,29,'Venta realizada','2025-04-07 00:23:40.668634',30),(20,'SALIDA',1,28,27,'Venta realizada','2025-04-07 00:26:29.054261',30),(21,'SALIDA',10,26,16,'Venta realizada','2025-04-07 00:28:22.184900',30),(22,'SALIDA',2,6,4,'Venta realizada','2025-04-07 00:32:08.630996',30),(23,'ENTRADA',98,2,100,'Cambio automático de stock','2025-04-07 00:39:51.776683',30),(24,'SALIDA',40,100,60,'Venta realizada','2025-04-07 00:40:04.046715',30),(25,'ENTRADA',10,0,10,'Cambio automático de stock','2025-04-07 00:40:44.620426',29),(26,'ACTUALIZACION',0,60,60,'Actualización de datos del producto','2025-04-07 00:44:31.689590',30),(27,'ENTRADA',1,60,61,'Modificación de stock (entrada)','2025-04-07 00:44:42.228258',30),(28,'ACTUALIZACION',0,60,61,'Actualización de datos del producto','2025-04-07 00:44:42.228258',30),(29,'ENTRADA',1,61,62,'Modificación de stock (entrada)','2025-04-07 00:45:00.400443',30),(30,'ACTUALIZACION',0,61,62,'Actualización de datos del producto','2025-04-07 00:45:00.406609',30),(31,'ACTUALIZ STOCK',2,64,66,'Actualización y stock','2025-04-07 00:50:14.242489',30),(32,'SALIDA',1,10,9,'Venta realizada','2025-04-07 00:50:39.576008',29),(33,'ACTUALIZACION',0,66,66,'Actualización datos','2025-04-07 00:50:52.077074',30),(34,'ACTUALIZ STOCK',1,66,67,'Actualizacion y stock','2025-04-07 00:51:04.167962',30),(35,'ACTUALIZACION',1,67,68,'Actualización y stock','2025-04-07 00:53:25.704349',30),(36,'ACTUALIZACION',0,68,68,'Actualización datos','2025-04-07 00:53:33.517044',30),(37,'SALIDA',1,9,8,'Venta realizada','2025-04-07 00:53:44.468558',29),(38,'CREACION',34,0,34,'Producto creado','2025-04-07 00:54:03.448212',82),(39,'ACTUALIZACION',0,34,34,'Actualización datos','2025-04-07 00:54:03.502161',82),(40,'CREACION',243,0,243,'Producto creado','2025-04-07 00:55:35.783701',83),(41,'ACTUALIZACION',0,243,243,'Actualización datos','2025-04-07 00:55:35.886799',83),(42,'CREACION',332,0,332,'Producto creado','2025-04-07 00:58:13.846619',84),(43,'ACTUALIZACION',0,332,332,'Actualización datos','2025-04-07 00:58:13.967502',84),(44,'CREACION',123,0,123,'Producto creado','2025-04-07 01:01:28.525562',85),(45,'SALIDA',1,8,7,'Venta realizada','2025-04-07 01:02:10.207242',29),(46,'ACTUALIZACION',3,7,10,'Actualización y stock','2025-04-07 01:02:24.840435',29),(47,'ACTUALIZACION',1,10,11,'Actualización y stock','2025-04-07 01:02:39.610555',29),(48,'ACTUALIZACION',2,68,70,'Actualización y stock','2025-04-07 01:03:14.546019',30),(49,'ACTUALIZACION',2,70,72,'Actualización y stock','2025-04-07 01:04:58.714469',30),(50,'ACTUALIZACION',0,72,72,'Actualización datos','2025-04-07 01:05:39.543523',30),(51,'ENTRADA',1,72,73,'Ingreso de stock','2025-04-07 01:06:21.280158',30),(52,'ENTRADA',1,73,74,'Ingreso de stock','2025-04-07 01:06:35.794222',30),(53,'ACTUALIZACION',0,74,74,'Actualización datos','2025-04-07 01:06:48.888903',30),(54,'ACTUALIZACION',0,74,74,'Actualización datos','2025-04-07 01:08:18.593908',30),(55,'ENTRADA',1,74,75,'Ingreso de stock','2025-04-07 01:08:25.295837',30),(56,'ACTUALIZACION',1,75,76,'Actualización y stock','2025-04-07 01:08:33.926056',30),(57,'SALIDA',1,11,10,'Venta realizada','2025-04-07 01:08:45.790090',29),(58,'CREACION',35,0,35,'Producto creado','2025-04-07 01:09:07.142837',86),(59,'SALIDA',1,10,9,'Venta realizada','2025-04-07 15:08:25.134973',29),(60,'SALIDA',12,76,64,'Venta realizada','2025-04-07 15:09:12.288409',30),(61,'SALIDA',1,75,74,'Venta realizada','2025-04-07 15:09:21.464945',35),(62,'SALIDA',60,64,4,'Venta realizada','2025-04-07 15:16:42.346109',30),(63,'SALIDA',1,9,8,'Venta realizada','2025-04-07 15:34:00.314980',29),(64,'SALIDA',1,8,7,'Venta realizada','2025-04-07 15:34:39.946638',29),(65,'SALIDA',1,7,6,'Venta realizada','2025-04-08 00:30:56.431461',29),(66,'SALIDA',1,6,5,'Venta realizada','2025-04-08 00:35:54.747912',29),(67,'SALIDA',1,4,3,'Venta realizada','2025-04-08 00:37:32.349644',30),(68,'SALIDA',1,5,4,'Venta realizada','2025-04-08 00:38:33.445140',29),(69,'SALIDA',1,3,2,'Venta realizada','2025-04-08 00:39:24.200498',30),(70,'SALIDA',1,2,1,'Venta realizada','2025-04-08 00:40:14.016625',30),(71,'SALIDA',1,4,3,'Venta realizada','2025-04-08 00:47:25.123864',29),(72,'SALIDA',1,3,2,'Venta realizada','2025-04-08 00:47:54.830977',29),(73,'SALIDA',1,25,24,'Venta realizada','2025-04-08 00:53:37.133730',31),(74,'SALIDA',1,24,23,'Venta realizada','2025-04-08 00:53:37.147085',31),(75,'SALIDA',1,23,22,'Venta realizada','2025-04-08 00:53:37.171448',31),(76,'SALIDA',3,2,0,'Venta realizada','2025-04-08 00:53:37.186116',29),(77,'SALIDA',2,20,18,'Venta realizada','2025-04-08 00:53:37.200128',80),(78,'SALIDA',1,12,11,'Venta realizada','2025-04-08 00:53:37.210388',60),(79,'SALIDA',4,362,358,'Venta realizada','2025-04-08 00:53:37.228238',79),(80,'SALIDA',1,1,0,'Venta realizada','2025-04-08 00:57:32.273581',30),(81,'SALIDA',1,22,21,'Venta realizada','2025-04-08 00:58:48.335287',31),(82,'SALIDA',1,21,20,'Venta realizada','2025-04-08 00:59:19.230754',31),(83,'SALIDA',1,20,19,'Venta realizada','2025-04-08 01:01:15.290717',31),(84,'SALIDA',1,19,18,'Venta realizada','2025-04-08 01:02:29.309515',31),(85,'SALIDA',1,74,73,'Venta realizada','2025-04-08 01:03:53.283604',35),(86,'SALIDA',1,18,17,'Venta realizada','2025-04-08 01:04:28.857088',31),(87,'SALIDA',1,17,16,'Venta realizada','2025-04-08 01:04:52.663974',31),(88,'SALIDA',1,16,15,'Venta realizada','2025-04-08 14:39:21.119401',31),(89,'SALIDA',1,15,14,'Venta realizada','2025-04-08 14:39:48.922759',31),(90,'SALIDA',1,14,13,'Venta realizada','2025-04-09 00:47:55.741109',31),(91,'SALIDA',1,13,12,'Venta realizada','2025-04-09 00:48:01.757981',31),(92,'SALIDA',1,73,72,'Venta realizada','2025-04-09 00:49:10.519889',35),(93,'SALIDA',1,12,11,'Venta realizada','2025-04-09 00:49:49.276396',31),(94,'SALIDA',1,11,10,'Venta realizada','2025-04-09 00:59:09.065853',31),(95,'SALIDA',1,10,9,'Venta realizada','2025-04-09 01:00:19.488779',31),(96,'SALIDA',1,72,71,'Venta realizada','2025-04-09 01:00:59.980806',35),(97,'SALIDA',2,358,356,'Venta realizada','2025-04-10 01:51:43.107825',79),(98,'SALIDA',1,9,8,'Venta realizada','2025-04-10 02:08:34.360491',31),(99,'SALIDA',1,11,10,'Venta realizada','2025-04-10 02:08:34.392240',55),(100,'SALIDA',1,11,10,'Venta realizada','2025-04-10 02:08:34.408263',60),(101,'SALIDA',1,71,70,'Venta realizada','2025-04-10 02:08:34.424449',35),(102,'SALIDA',1,35,34,'Venta realizada','2025-04-10 02:08:34.456182',86),(103,'SALIDA',1,100,99,'Venta realizada','2025-04-10 02:08:34.472058',81),(104,'SALIDA',2,10,8,'Venta realizada','2025-04-10 02:08:34.497625',60),(105,'SALIDA',1,8,7,'Venta realizada','2025-04-10 16:17:17.357849',31),(106,'SALIDA',1,7,6,'Venta realizada','2025-04-12 01:13:04.108587',31),(107,'SALIDA',1,356,355,'Venta realizada','2025-04-12 01:13:04.124674',79),(108,'SALIDA',1,355,354,'Venta realizada','2025-04-12 02:18:05.668869',79),(109,'ENTRADA',1,6,7,'Ingreso de stock','2025-04-12 02:31:37.784139',31),(110,'ENTRADA',1,10,11,'Ingreso de stock','2025-04-12 02:31:37.797870',55),(111,'ENTRADA',2,8,10,'Ingreso de stock','2025-04-12 02:31:37.812284',60),(112,'ENTRADA',1,70,71,'Ingreso de stock','2025-04-12 02:31:37.822116',35),(113,'ENTRADA',1,34,35,'Ingreso de stock','2025-04-12 02:31:37.861074',86),(114,'ENTRADA',1,99,100,'Ingreso de stock','2025-04-12 02:31:37.881394',81),(115,'ENTRADA',2,10,12,'Ingreso de stock','2025-04-12 02:31:37.928703',60),(116,'ENTRADA',30,0,30,'Ingreso de stock','2025-04-12 02:33:35.245448',29),(117,'SALIDA',30,30,0,'Venta realizada','2025-04-12 02:33:50.657813',29),(118,'ENTRADA',30,0,30,'Ingreso de stock','2025-04-12 02:35:06.118083',29),(119,'SALIDA',1,354,353,'Venta realizada','2025-04-12 02:56:53.692781',79),(120,'SALIDA',1,353,352,'Venta realizada','2025-04-12 03:00:19.915690',79),(121,'SALIDA',1,352,351,'Venta realizada','2025-04-12 03:00:52.899920',79),(122,'SALIDA',1,351,350,'Venta realizada','2025-04-12 03:03:02.086371',79),(123,'SALIDA',1,7,6,'Venta realizada','2025-04-13 23:19:57.029015',31),(124,'SALIDA',1,30,29,'Venta realizada','2025-04-13 23:24:03.296078',29),(125,'SALIDA',1,350,349,'Venta realizada','2025-04-13 23:35:51.788429',79),(126,'SALIDA',1,6,5,'Venta realizada','2025-04-13 23:35:51.808971',31),(127,'SALIDA',1,349,348,'Venta realizada','2025-04-13 23:36:25.905761',79),(128,'SALIDA',1,5,4,'Venta realizada','2025-04-13 23:36:25.919956',31),(129,'SALIDA',1,348,347,'Venta realizada','2025-04-13 23:36:38.213239',79),(130,'SALIDA',1,4,3,'Venta realizada','2025-04-13 23:36:38.226201',31),(131,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-13 23:40:00.107721',31),(132,'SALIDA',1,4,3,'Venta realizada','2025-04-13 23:46:50.348136',31),(133,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-14 01:26:10.394259',31),(134,'SALIDA',1,4,3,'Venta realizada','2025-04-14 01:28:47.810015',31),(135,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-14 01:29:04.037597',31),(136,'SALIDA',1,71,70,'Venta realizada','2025-04-14 01:30:54.336159',35),(137,'ENTRADA',1,70,71,'Ingreso de stock','2025-04-14 01:31:10.729240',35),(138,'SALIDA',1,4,3,'Venta realizada','2025-04-14 01:32:25.859962',31),(139,'SALIDA',1,71,70,'Venta realizada','2025-04-14 01:32:25.872650',35),(140,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-14 01:32:41.522424',31),(141,'ENTRADA',1,70,71,'Ingreso de stock','2025-04-14 01:32:41.539886',35),(142,'SALIDA',1,4,3,'Venta realizada','2025-04-14 01:37:32.716258',31),(143,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-14 01:37:50.234707',31),(144,'SALIDA',1,4,3,'Venta realizada','2025-04-14 01:41:05.909731',31),(145,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-14 01:41:21.829647',31),(146,'SALIDA',1,29,28,'Venta realizada','2025-04-14 01:42:52.497459',29),(147,'SALIDA',1,28,27,'Venta realizada','2025-04-14 01:42:52.516791',29),(148,'SALIDA',1,4,3,'Venta realizada','2025-04-14 01:42:52.534854',31),(149,'SALIDA',1,71,70,'Venta realizada','2025-04-14 01:42:52.554631',35),(150,'SALIDA',1,52,51,'Venta realizada','2025-04-14 01:42:52.574190',36),(151,'ENTRADA',1,27,28,'Ingreso de stock','2025-04-14 01:43:18.643416',29),(152,'ENTRADA',1,28,29,'Ingreso de stock','2025-04-14 01:43:18.650946',29),(153,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-14 01:43:18.664757',31),(154,'ENTRADA',1,70,71,'Ingreso de stock','2025-04-14 01:43:18.678057',35),(155,'ENTRADA',1,51,52,'Ingreso de stock','2025-04-14 01:43:18.689954',36),(156,'SALIDA',1,71,70,'Venta realizada','2025-04-14 01:49:31.805313',35),(157,'ENTRADA',1,70,71,'Ingreso de stock','2025-04-14 01:49:47.445260',35),(158,'SALIDA',1,4,3,'Venta realizada','2025-04-14 01:53:01.714626',31),(159,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-14 01:53:14.893965',31),(160,'SALIDA',1,29,28,'Venta realizada','2025-04-14 01:56:49.242096',29),(161,'ENTRADA',1,28,29,'Ingreso de stock','2025-04-14 01:57:05.443255',29),(162,'SALIDA',1,29,28,'Venta realizada','2025-04-14 02:03:53.450305',29),(164,'SALIDA',1,4,3,'Venta realizada','2025-04-14 02:05:20.136404',31),(166,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-14 02:06:09.611732',31),(167,'SALIDA',1,28,27,'Venta realizada','2025-04-14 02:08:09.587246',29),(168,'ENTRADA',1,27,28,'Ingreso de stock','2025-04-14 02:08:28.864690',29),(169,'SALIDA',1,28,27,'Venta realizada','2025-04-15 00:31:22.758283',29),(170,'ENTRADA',1,27,28,'Ingreso de stock','2025-04-15 00:31:41.837323',29),(171,'SALIDA',1,28,27,'Venta realizada','2025-04-15 00:32:58.719631',29),(172,'ENTRADA',1,27,28,'Ingreso de stock','2025-04-15 00:33:12.944842',29),(173,'SALIDA',1,28,27,'Venta realizada','2025-04-15 00:44:04.402597',29),(174,'ENTRADA',1,27,28,'Ingreso de stock','2025-04-15 00:44:43.610051',29),(175,'SALIDA',1,28,27,'Venta realizada','2025-04-15 00:46:13.134192',29),(176,'ENTRADA',1,27,28,'Ingreso de stock','2025-04-15 00:46:26.476148',29),(177,'SALIDA',1,28,27,'Venta realizada','2025-04-15 00:47:08.307494',29),(178,'ENTRADA',1,27,28,'Ingreso de stock','2025-04-15 00:47:19.393570',29),(179,'SALIDA',1,4,3,'Venta realizada','2025-04-15 00:48:39.293916',31),(180,'ENTRADA',1,3,4,'Ingreso de stock','2025-04-15 00:48:53.848431',31),(181,'SALIDA',1,347,346,'Venta realizada','2025-04-15 00:49:32.344725',79),(182,'SALIDA',1,71,70,'Venta realizada','2025-04-15 00:49:32.360286',35),(183,'ENTRADA',1,346,347,'Ingreso de stock','2025-04-15 00:49:51.919153',79),(184,'ENTRADA',1,70,71,'Ingreso de stock','2025-04-15 00:49:51.935052',35),(185,'ENTRADA',50,0,50,'Ingreso de stock','2025-04-15 01:05:23.484006',30),(186,'ENTRADA',46,4,50,'Ingreso de stock','2025-04-15 01:05:28.038464',31),(187,'ENTRADA',50,0,50,'Ingreso de stock','2025-04-15 01:05:32.456078',32),(188,'ACTUALIZACION',30,20,50,'Actualización y stock','2025-04-15 01:05:39.781566',37),(189,'ENTRADA',45,5,50,'Ingreso de stock','2025-04-15 01:05:48.247424',38),(190,'ACTUALIZACION',43,7,50,'Actualización y stock','2025-04-15 01:05:55.342774',43),(191,'ACTUALIZACION',42,8,50,'Actualización y stock','2025-04-15 01:06:01.608606',39),(192,'ACTUALIZACION',46,4,50,'Actualización y stock','2025-04-15 01:06:08.761825',40),(193,'ACTUALIZACION',50,0,50,'Actualización y stock','2025-04-15 01:06:14.926810',41),(194,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:06:22.503645',50),(195,'ACTUALIZACION',40,10,50,'Actualización y stock','2025-04-15 01:06:29.690347',51),(196,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:06:36.752690',52),(197,'ENTRADA',32,18,50,'Ingreso de stock','2025-04-15 01:06:52.301629',80),(198,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:06:59.078408',78),(199,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:07:04.029177',77),(200,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:07:09.397582',75),(201,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:07:15.689470',57),(202,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:07:20.795449',62),(203,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:07:25.717339',61),(204,'ENTRADA',47,3,50,'Ingreso de stock','2025-04-15 01:07:30.209813',64),(205,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:07:34.460158',59),(206,'ENTRADA',143,12,155,'Ingreso de stock','2025-04-15 01:07:41.800679',63),(207,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:07:46.397769',72),(208,'ENTRADA',48,2,50,'Ingreso de stock','2025-04-15 01:07:51.160746',58),(209,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:07:55.890456',60),(210,'ENTRADA',40,10,50,'Ingreso de stock','2025-04-15 01:08:01.132463',54),(211,'ENTRADA',39,11,50,'Ingreso de stock','2025-04-15 01:08:06.584715',55),(212,'ENTRADA',38,12,50,'Ingreso de stock','2025-04-15 01:08:19.244100',56),(213,'SALIDA',10,28,18,'Venta realizada','2025-04-15 01:13:01.773665',29),(214,'ENTRADA',32,18,50,'Ingreso de stock','2025-04-15 01:39:21.436801',29),(215,'SALIDA',49,50,1,'Venta realizada','2025-04-15 01:39:42.595349',29),(216,'SALIDA',30,50,20,'Venta realizada','2025-04-15 01:45:29.631210',31),(217,'SALIDA',1,1,0,'Venta realizada','2025-04-15 01:46:17.006473',29),(218,'ENTRADA',50,0,50,'Ingreso de stock','2025-04-15 02:04:48.287840',29),(219,'ENTRADA',30,20,50,'Ingreso de stock','2025-04-15 02:04:53.886036',31),(220,'SALIDA',30,50,20,'Venta realizada','2025-04-15 02:07:17.663408',56),(221,'ACTUALIZACION',0,20,20,'Actualización datos','2025-04-15 02:12:23.913280',56),(222,'SALIDA',40,50,10,'Venta realizada','2025-04-15 02:12:45.723222',30),(223,'ACTUALIZACION',0,10,10,'Actualización datos','2025-04-15 02:12:48.500791',30),(224,'SALIDA',50,50,0,'Venta realizada','2025-04-15 02:13:17.625077',29),(225,'ACTUALIZACION',0,0,0,'Actualización datos','2025-04-15 02:13:20.228756',29),(226,'SALIDA',50,50,0,'Venta realizada','2025-04-15 02:16:39.526934',37),(227,'ACTUALIZACION',0,0,0,'Actualización datos','2025-04-15 02:16:43.070645',37),(228,'ENTRADA',50,0,50,'Ingreso de stock','2025-04-15 02:19:00.031805',29),(229,'SALIDA',49,50,1,'Venta realizada','2025-04-15 02:19:53.365754',29),(230,'SALIDA',49,50,1,'Venta realizada','2025-04-15 02:20:27.475481',32),(231,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-15 02:20:30.585479',32),(232,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-16 00:18:27.083637',29),(233,'ACTUALIZACION',0,10,10,'Actualización datos','2025-04-16 00:18:27.100119',30),(234,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-16 00:18:27.112949',32),(235,'ACTUALIZACION',0,0,0,'Actualización datos','2025-04-16 00:18:27.126714',37),(236,'ACTUALIZACION',0,20,20,'Actualización datos','2025-04-16 00:18:27.141035',56),(237,'SALIDA',1,1,0,'Venta realizada','2025-04-16 00:27:54.544706',29),(238,'ENTRADA',30,0,30,'Ingreso de stock','2025-04-16 00:29:49.846705',29),(239,'SALIDA',29,30,1,'Venta realizada','2025-04-16 00:30:04.949538',29),(240,'SALIDA',40,60,20,'Venta realizada','2025-04-16 00:30:37.762234',34),(241,'ACTUALIZACION',0,20,20,'Actualización datos','2025-04-16 00:30:40.324130',34),(242,'SALIDA',49,50,1,'Venta realizada','2025-04-16 00:34:00.170785',77),(243,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-16 00:34:02.982332',77),(244,'SALIDA',30,50,20,'Venta realizada','2025-04-16 00:45:56.755924',78),(245,'ACTUALIZACION',0,20,20,'Actualización datos','2025-04-16 00:45:59.591817',78),(246,'SALIDA',340,347,7,'Venta realizada','2025-04-16 01:24:16.779795',79),(247,'ACTUALIZACION',0,7,7,'Actualización datos','2025-04-16 01:24:20.944087',79),(248,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-17 15:23:24.032355',29),(249,'ACTUALIZACION',0,10,10,'Actualización datos','2025-04-17 15:23:24.066579',30),(250,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-17 15:23:24.085805',32),(251,'ACTUALIZACION',0,20,20,'Actualización datos','2025-04-17 15:23:24.100529',34),(252,'ACTUALIZACION',0,0,0,'Actualización datos','2025-04-17 15:23:24.117310',37),(253,'ACTUALIZACION',0,20,20,'Actualización datos','2025-04-17 15:23:24.131393',56),(254,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-17 15:23:24.145580',77),(255,'ACTUALIZACION',0,20,20,'Actualización datos','2025-04-17 15:23:24.160724',78),(256,'ACTUALIZACION',0,7,7,'Actualización datos','2025-04-17 15:23:24.169804',79),(257,'ENTRADA',29,1,30,'Ingreso de stock','2025-04-17 15:25:08.550929',29),(258,'ENTRADA',20,10,30,'Ingreso de stock','2025-04-17 15:25:13.078448',30),(259,'ENTRADA',29,1,30,'Ingreso de stock','2025-04-17 15:25:16.710722',32),(260,'ENTRADA',10,20,30,'Ingreso de stock','2025-04-17 15:25:25.244289',34),(261,'ENTRADA',30,0,30,'Ingreso de stock','2025-04-17 15:25:44.208740',37),(262,'ENTRADA',10,20,30,'Ingreso de stock','2025-04-17 15:30:46.847797',78),(263,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-17 17:28:44.579311',77),(264,'ACTUALIZACION',0,50,50,'Actualización datos','2025-04-17 17:28:52.216874',72),(265,'ENTRADA',29,1,30,'Ingreso de stock','2025-04-17 17:29:44.291739',77),(266,'ENTRADA',20,20,40,'Ingreso de stock','2025-04-17 17:29:55.540151',56),(267,'SALIDA',100,60,0,'Venta realizada','2025-04-21 18:39:12.767344',46),(268,'ENTRADA',100,0,100,'Ingreso de stock','2025-04-21 18:39:41.124152',46),(269,'ACTUALIZACION',0,7,7,'Actualización datos','2025-04-22 12:36:05.986459',79),(270,'ENTRADA',23,7,30,'Ingreso de stock','2025-04-22 12:36:27.229365',79),(271,'SALIDA',30,30,0,'Venta realizada','2025-04-22 12:37:17.713016',29),(272,'ACTUALIZACION',0,0,0,'Actualización datos','2025-04-22 12:37:21.333218',29),(273,'ENTRADA',6,0,6,'Ingreso de stock','2025-04-22 12:37:45.880034',29),(274,'SALIDA',12,6,0,'Venta realizada','2025-04-22 12:39:24.446581',29),(275,'ENTRADA',1,0,1,'Ingreso de stock','2025-04-22 12:39:49.113482',29),(276,'SALIDA',2,1,0,'Venta realizada','2025-04-22 12:39:59.688561',29),(277,'ENTRADA',1,0,1,'Ingreso de stock','2025-04-22 12:40:51.126668',29),(278,'SALIDA',3,1,0,'Venta realizada','2025-04-22 12:41:01.270798',29),(279,'SALIDA',10,30,20,'Venta realizada','2025-04-22 12:45:33.581901',30),(280,'SALIDA',1,20,19,'Venta realizada','2025-04-22 12:54:13.294954',30),(281,'SALIDA',1,19,18,'Venta realizada','2025-04-22 13:00:40.343223',30),(282,'ACTUALIZACION',0,18,18,'Actualización datos','2025-04-22 13:01:53.990860',30),(283,'SALIDA',1,18,17,'Venta realizada','2025-04-22 13:05:16.339159',30),(284,'SALIDA',30,50,20,'Venta realizada','2025-04-22 13:05:50.284801',31),(285,'ACTUALIZACION',0,20,20,'Actualización datos','2025-04-22 13:05:54.253427',31),(286,'ENTRADA',30,20,50,'Ingreso de stock','2025-04-22 13:08:49.478765',31),(287,'SALIDA',1,50,49,'Venta realizada','2025-04-22 13:38:05.415256',31),(288,'SALIDA',30,49,19,'Venta realizada','2025-04-22 13:38:35.414339',31),(289,'SALIDA',40,50,10,'Venta realizada','2025-04-22 13:39:52.352040',51),(290,'ACTUALIZACION',0,10,10,'Actualización datos','2025-04-22 13:39:55.822407',51),(291,'ACTUALIZACION',0,0,0,'Actualización datos','2025-04-22 18:43:52.044689',29),(292,'ENTRADA',30,0,30,'Ingreso de stock','2025-04-22 19:07:48.537622',29),(293,'ENTRADA',23,17,40,'Ingreso de stock','2025-04-22 19:07:55.963965',30),(294,'ENTRADA',21,19,40,'Ingreso de stock','2025-04-22 19:08:00.732559',31),(295,'ENTRADA',10,10,20,'Ingreso de stock','2025-04-22 19:08:08.824717',51),(296,'ENTRADA',20,20,40,'Ingreso de stock','2025-04-22 19:08:22.822461',51),(297,'SALIDA',29,30,1,'Venta realizada','2025-04-22 19:09:44.087526',29),(298,'SALIDA',1,1,0,'Venta realizada','2025-04-23 14:55:59.083288',29),(299,'ENTRADA',1,0,1,'Ingreso de stock','2025-04-23 14:56:17.668511',29),(300,'SALIDA',1,40,39,'Venta realizada','2025-04-23 15:04:39.857570',30),(301,'ENTRADA',1,39,40,'Ingreso de stock','2025-04-23 15:04:51.876371',30),(302,'SALIDA',1,1,0,'Venta realizada','2025-04-23 15:45:04.131908',29),(303,'ENTRADA',1,0,1,'Ingreso de stock','2025-04-23 15:45:20.470022',29),(304,'SALIDA',1,40,39,'Venta realizada','2025-04-23 15:45:47.540097',30),(305,'ENTRADA',1,39,40,'Ingreso de stock','2025-04-23 15:46:35.766522',30),(306,'SALIDA',1,40,39,'Venta realizada','2025-04-23 15:48:58.215040',31),(307,'ENTRADA',1,39,40,'Ingreso de stock','2025-04-23 15:49:19.827651',31),(308,'ACTUALIZACION',0,1,1,'Actualización datos','2025-04-25 18:21:01.956278',29),(309,'ENTRADA',29,1,30,'Ingreso de stock','2025-04-25 18:23:41.153369',29),(310,'SALIDA',30,30,0,'Venta realizada','2025-04-25 18:24:32.815488',29),(311,'SALIDA',40,40,0,'Venta realizada','2025-04-25 18:26:18.337405',30),(312,'SALIDA',30,40,10,'Venta realizada','2025-04-25 18:27:11.671590',31),(313,'SALIDA',20,29,9,'Venta realizada','2025-04-25 18:27:11.910364',33),(314,'SALIDA',20,30,10,'Venta realizada','2025-04-25 18:27:11.926599',32),(315,'SALIDA',1,10,9,'Venta realizada','2025-04-28 23:01:53.334690',31),(316,'SALIDA',1,10,9,'Venta realizada','2025-04-28 23:11:34.920264',32),(317,'ENTRADA',1,9,10,'Ingreso de stock','2025-04-28 23:11:56.267853',32),(318,'ENTRADA',1,9,10,'Ingreso de stock','2025-04-28 23:20:51.976015',31),(319,'SALIDA',1,10,9,'Venta realizada','2025-04-28 23:22:56.955800',31),(320,'ENTRADA',1,9,10,'Ingreso de stock','2025-04-28 23:23:15.288630',31),(321,'SALIDA',1,10,9,'Venta realizada','2025-04-28 23:28:22.427779',32),(322,'ENTRADA',1,9,10,'Ingreso de stock','2025-04-28 23:28:44.808420',32),(323,'SALIDA',1,50,49,'Venta realizada','2025-04-28 23:29:39.854519',55),(324,'ENTRADA',1,49,50,'Ingreso de stock','2025-04-28 23:29:59.145592',55),(325,'SALIDA',1,30,29,'Venta realizada','2025-05-01 13:48:37.608493',79),(326,'SALIDA',1,29,28,'Venta realizada','2025-05-01 14:35:30.514972',79),(327,'SALIDA',1,28,27,'Venta realizada','2025-05-01 16:16:18.771083',79),(328,'SALIDA',1,27,26,'Venta realizada','2025-05-01 16:52:15.795447',79),(329,'SALIDA',1,10,9,'Venta realizada','2025-05-01 21:13:56.178480',31),(330,'ENTRADA',1,26,27,'Ingreso de stock','2025-05-01 21:41:58.021512',79),(331,'SALIDA',1,9,8,'Venta realizada','2025-05-02 16:19:52.225661',31),(332,'SALIDA',1,8,7,'Venta realizada','2025-05-03 23:46:50.491208',31),(333,'SALIDA',1,50,49,'Venta realizada','2025-05-04 00:15:21.460502',59),(334,'SALIDA',1,49,48,'Venta realizada','2025-05-04 00:17:09.788677',59),(335,'SALIDA',1,9,8,'Venta realizada','2025-05-04 00:29:20.307642',33),(336,'ENTRADA',1,48,49,'Ingreso de stock','2025-05-04 00:48:02.658734',59),(337,'ENTRADA',59,0,59,'Ingreso de stock','2025-05-04 17:36:34.554026',29),(338,'ACTUALIZACION',1,59,60,'Actualización y stock','2025-05-04 20:00:13.083410',29),(339,'ACTUALIZACION',0,60,60,'Actualización datos','2025-05-04 20:02:17.694623',29),(340,'ACTUALIZACION',0,60,60,'Actualización datos','2025-05-04 20:02:28.485148',29),(343,'SALIDA',1,50,49,'Venta realizada','2025-05-05 20:39:09.862889',54),(344,'SALIDA',1,50,49,'Venta realizada','2025-05-05 20:39:18.629575',41),(345,'SALIDA',1,52,51,'Venta realizada','2025-05-05 20:39:28.166891',36),(346,'ACTUALIZACION',0,0,0,'Actualización datos','2025-05-06 01:56:52.461182',30),(347,'ACTUALIZACION',0,7,7,'Actualización datos','2025-05-06 01:56:52.500741',31),(348,'ACTUALIZACION',0,10,10,'Actualización datos','2025-05-06 01:56:52.538460',32),(349,'ACTUALIZACION',0,8,8,'Actualización datos','2025-05-06 01:56:52.581615',33),(350,'ENTRADA',1,60,61,'Ingreso de stock','2025-05-06 03:35:24.852738',29),(351,'ACTUALIZACION',0,0,0,'Actualización datos','2025-05-06 11:59:08.667698',30),(352,'ACTUALIZACION',0,7,7,'Actualización datos','2025-05-06 11:59:08.683900',31),(353,'ACTUALIZACION',0,10,10,'Actualización datos','2025-05-06 11:59:08.710066',32),(354,'ACTUALIZACION',0,8,8,'Actualización datos','2025-05-06 11:59:08.726039',33),(355,'SALIDA',1,61,60,'Venta realizada','2025-05-06 12:31:39.001327',29),(356,'SALIDA',1,60,59,'Venta realizada','2025-05-06 12:32:09.138049',29),(357,'SALIDA',1,59,58,'Venta realizada','2025-05-06 12:32:42.814558',29),(358,'ENTRADA',1,58,59,'Ingreso de stock','2025-05-06 12:33:08.534652',29),(359,'ENTRADA',40,40,80,'Ingreso de stock','2025-05-07 14:40:07.801827',51),(360,'ACTUALIZACION',0,0,0,'Actualización datos','2025-05-07 14:40:30.888448',30),(361,'ACTUALIZACION',0,7,7,'Actualización datos','2025-05-07 14:40:30.904562',31),(362,'ACTUALIZACION',0,10,10,'Actualización datos','2025-05-07 14:40:30.920001',32),(363,'ACTUALIZACION',0,8,8,'Actualización datos','2025-05-07 14:40:30.933761',33),(364,'ENTRADA',29,59,88,'Ingreso de stock','2025-05-07 15:04:07.583293',29);
/*!40000 ALTER TABLE `productos_movimientoproducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_producto`
--

DROP TABLE IF EXISTS `productos_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` longtext,
  `precio` decimal(10,2) NOT NULL,
  `stock` int unsigned NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `marca` longtext,
  `categoria_id` int NOT NULL,
  `codigo_qr` varchar(100) DEFAULT NULL,
  `costo` decimal(10,2) NOT NULL,
  `descuento` decimal(5,2) DEFAULT NULL,
  `suministrador_id` int NOT NULL,
  `ultima_alerta_stock` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `productos_producto_categoria_id_1fef506a_fk_productos` (`categoria_id`),
  KEY `productos_producto_suministrador_id_f2495bc0_fk_productos` (`suministrador_id`),
  CONSTRAINT `productos_producto_categoria_id_1fef506a_fk_productos` FOREIGN KEY (`categoria_id`) REFERENCES `productos_categoria` (`id_categoria`),
  CONSTRAINT `productos_producto_suministrador_id_f2495bc0_fk_productos` FOREIGN KEY (`suministrador_id`) REFERENCES `productos_suministradores` (`provedor_id`),
  CONSTRAINT `productos_producto_chk_1` CHECK ((`stock` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_producto`
--

LOCK TABLES `productos_producto` WRITE;
/*!40000 ALTER TABLE `productos_producto` DISABLE KEYS */;
INSERT INTO `productos_producto` VALUES (29,'Destornilladore','hola mundo',100.00,88,'productos_img/wallpaper.jpg',1,'2025-02-24 19:18:45.000000','2025-05-07 15:04:07.581476','Stanley',3,'qrcodes/producto_29_qr.png',10.00,NULL,1,'2025-04-22 18:43:52.029347'),(30,'Llave inglesaaa','fzxc',100.00,0,'productos_img/img3.png',1,'2025-02-24 19:18:45.000000','2025-05-07 14:40:30.881573','Surtek',9,'qrcodes/producto_30_qr.png',10.00,NULL,1,'2025-05-07 14:40:30.879449'),(31,'Sierra manual','Sierra de mano',120.00,7,'productos_img/img4_r2SdSJ5.png',1,'2025-02-24 19:18:45.000000','2025-05-07 14:40:30.897296','DeWalt',2,'qrcodes/producto_31_qr.png',10.00,NULL,1,'2025-05-07 14:40:30.879449'),(32,'Taladro eléctrico','Taladro eléctrico 500W',79.99,10,'productos_img/img4_1ozPp3g.png',1,'2025-02-24 19:18:45.000000','2025-05-07 14:40:30.910769','Bosch',2,'qrcodes/producto_32_qr.png',10.00,NULL,1,'2025-05-07 14:40:30.879449'),(33,'Clavos','Caja de clavos 1kg',5.99,8,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-05-07 14:40:30.928565','FierroMax',3,'qrcodes/producto_33_qr.png',10.00,NULL,1,'2025-05-07 14:40:30.879449'),(34,'Cinta métrica','Cinta métrica 5m',7.25,30,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-04-17 15:25:25.230698','Komelon',1,'qrcodes/producto_34_qr.png',10.00,NULL,1,'2025-04-17 15:23:24.010982'),(35,'Guantes de seguridad','Guantes de seguridad industrial',10.99,71,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-04-15 00:49:51.934236','3M',4,'qrcodes/producto_35_qr.png',10.00,NULL,1,NULL),(36,'Lentes de protección','Lentes de protección resistentes a impactos',9.50,51,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-05-05 20:39:28.165443','Honeywell',4,'qrcodes/producto_36_qr.png',10.00,NULL,1,NULL),(37,'Botas industriales','Botas de seguridad para construcción',49.99,30,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-04-17 15:25:44.195762','Caterpillar',4,'qrcodes/producto_37_qr.png',10.00,NULL,1,'2025-04-17 15:23:24.010982'),(38,'Sierra circular','Sierra circular 1400W',129.99,50,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-04-15 01:05:48.231836','Makita',2,'qrcodes/producto_38_qr.png',10.00,NULL,1,NULL),(39,'Escalera','Escalera de aluminio 3m',69.99,50,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-04-15 01:06:01.601757','Louisville',5,'qrcodes/producto_39_qr.png',10.00,NULL,1,NULL),(40,'Compresor de aire','Compresor de aire 50L',299.99,50,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-04-15 01:06:08.756162','Kobalt',6,'qrcodes/producto_40_qr.png',10.00,NULL,1,NULL),(41,'Generador','Generador portátil 2000W',499.99,49,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-05-05 20:39:18.619918','Honda',6,'qrcodes/producto_41_qr.png',10.00,NULL,1,NULL),(42,'Disco de corte','Disco de corte para metal',3.99,200,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-02-24 19:18:45.000000','Bosch',3,NULL,10.00,NULL,1,NULL),(43,'Soldadora','Soldadora inverter 200A',399.99,50,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-04-15 01:05:55.329815','Lincoln Electric',6,'qrcodes/producto_43_qr.png',10.00,NULL,1,NULL),(44,'Cemento','Cemento Portland 50kg',12.50,40,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-02-24 19:18:45.000000','Holcim',7,NULL,10.00,NULL,1,NULL),(45,'Pintura acrílica','Pintura acrílica blanca 1L',14.99,30,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-02-24 19:18:45.000000','Sherwin-Williams',8,NULL,10.00,NULL,1,NULL),(46,'Brocha','Brocha de 3 pulgadas para pintura',5.50,100,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-04-21 18:39:41.122302','Pintulux',8,'qrcodes/producto_46_qr.png',10.00,NULL,1,NULL),(47,'Rodillo','Rodillo para pintura',8.75,50,'productos_img/no_image.jpg',1,'2025-02-24 19:18:45.000000','2025-02-24 19:18:45.000000','Truper',8,NULL,10.00,NULL,1,NULL),(48,'RDSFCZX','fsdZCX',12.00,0,'productos_img/no_image.jpg',0,'2025-02-24 23:38:36.804609','2025-02-24 23:49:20.935721','sdzx',1,NULL,10.00,NULL,1,NULL),(50,'caja','caja',10.00,50,'productos_img/horario_rON0Cxf.jpg',1,'2025-03-03 23:48:33.801730','2025-04-15 01:06:22.497679','caja',2,'qrcodes/producto_50_qr_AjFt3dW.png',10.00,NULL,1,NULL),(51,'caja1','fxc',10.00,80,'productos_img/horario_AJxnd26.jpg',1,'2025-03-03 23:55:46.261608','2025-05-07 14:40:07.801827','caja1',1,'qrcodes/producto_51_qr_zmlVSfK.png',10.00,NULL,1,'2025-04-22 13:39:55.806087'),(52,'d','f',12.00,50,'productos_img/yo_sn7KGgF.jpeg',1,'2025-03-04 13:30:15.931905','2025-04-15 01:06:36.747193','fs',1,'qrcodes/producto_52_qr.png',10.00,NULL,1,NULL),(54,'dgf','efsd',12.00,49,'productos_img/no_image.jpg',1,'2025-03-04 13:38:07.780366','2025-05-05 20:39:09.855958','gesfd',3,'qrcodes/producto_54_qr.png',10.00,NULL,1,NULL),(55,'dsf','',12.00,50,'productos_img/no_image.jpg',1,'2025-03-04 13:47:37.508606','2025-04-28 23:29:59.140245','',3,'qrcodes/producto_55_qr.png',10.00,NULL,1,NULL),(56,'23','',12.00,40,'productos_img/no_image.jpg',1,'2025-03-04 13:52:50.455615','2025-04-17 17:29:55.535171','',1,'qrcodes/producto_56_qr.png',10.00,NULL,1,'2025-04-17 15:23:24.010982'),(57,'12','',12.00,50,'productos_img/no_image.jpg',1,'2025-03-04 13:53:12.093803','2025-04-15 01:07:15.677226','',1,'qrcodes/producto_57_qr.png',10.00,NULL,1,NULL),(58,'e','',1.00,50,'productos_img/no_image.jpg',1,'2025-03-04 14:01:08.083890','2025-04-15 01:07:51.148218','',1,'qrcodes/producto_58_qr.png',10.00,NULL,1,NULL),(59,'yoel','',12.00,49,'productos_img/no_image.jpg',1,'2025-03-05 14:55:40.419078','2025-05-04 00:48:02.653388','f',3,'qrcodes/producto_59_qr.png',10.00,NULL,1,NULL),(60,'angel','',12.00,50,'productos_img/no_image.jpg',1,'2025-03-05 14:57:46.117254','2025-04-15 01:07:55.877857','',6,'qrcodes/producto_60_qr.png',10.00,NULL,1,NULL),(61,'12','',12.00,50,'productos_img/no_image.jpg',1,'2025-03-05 14:59:49.403256','2025-04-15 01:07:25.710242','',1,'qrcodes/producto_61_qr.png',10.00,NULL,1,NULL),(62,'13','',12.00,50,'productos_img/no_image.jpg',1,'2025-03-05 15:00:58.487719','2025-04-15 01:07:20.786344','',1,'qrcodes/producto_62_qr.png',10.00,NULL,1,NULL),(63,'122','',12.00,155,'productos_img/no_image.jpg',1,'2025-03-05 15:08:54.418611','2025-04-15 01:07:41.792954','',9,'qrcodes/producto_63_qr.png',10.00,NULL,1,NULL),(64,'ew','',12.00,50,'productos_img/no_image.jpg',1,'2025-03-05 15:09:37.396634','2025-04-15 01:07:30.203506','',1,'qrcodes/producto_64_qr.png',10.00,NULL,1,NULL),(72,'3re','esrfcas',12.00,50,'productos_img/no_image.jpg',1,'2025-03-05 15:54:13.072923','2025-04-17 17:28:52.216874','',1,'qrcodes/producto_72_qr.png',10.00,NULL,1,NULL),(75,'e','',12.00,50,'productos_img/no_image.jpg',1,'2025-03-05 16:00:55.993883','2025-04-15 01:07:09.392257','',1,'qrcodes/producto_75_qr.png',10.00,NULL,1,NULL),(77,'re','etfcwsdferc',12.00,30,'productos_img/no_image.jpg',1,'2025-03-05 16:01:33.978476','2025-04-17 17:29:44.276813','',1,'qrcodes/producto_77_qr.png',10.00,0.00,1,'2025-04-17 15:23:24.010982'),(78,'sd','',12.00,30,'productos_img/no_image.jpg',1,'2025-03-05 17:42:36.294059','2025-04-17 15:30:46.841773','',6,'qrcodes/producto_78_qr.png',10.00,15.00,1,'2025-04-17 15:23:24.010982'),(79,'er','rs',34.00,27,'productos_img/yo.jpeg',1,'2025-03-21 09:05:54.601144','2025-05-01 21:41:58.021512','re',1,'qrcodes/producto_79_qr.png',10.00,10.00,1,'2025-04-22 12:36:05.958316'),(80,'dsafs','erasdfc',120.00,50,'productos_img/no_image.jpg',1,'2025-04-07 00:05:58.072775','2025-04-15 01:06:52.289017','sdfzxc',1,'qrcodes/producto_80_qr.png',10.00,NULL,3,NULL),(81,'angel2','dfg',120.00,100,'productos_img/no_image.jpg',1,'2025-04-07 00:06:46.685150','2025-04-12 02:31:37.877826','intel',1,'qrcodes/producto_81_qr.png',20.00,NULL,3,NULL),(82,'erfdsf','edsfd',120.00,34,'productos_img/no_image.jpg',1,'2025-04-07 00:54:03.446332','2025-04-07 00:54:03.498058','esf',1,'qrcodes/producto_82_qr.png',23.00,NULL,3,NULL),(83,'terf','ersdf',13.00,243,'productos_img/no_image.jpg',1,'2025-04-07 00:55:35.783701','2025-04-07 00:55:35.880269','retf',1,'qrcodes/producto_83_qr.png',1.00,NULL,3,NULL),(84,'fdcv','fgd',12.00,332,'productos_img/no_image.jpg',1,'2025-04-07 00:58:13.846619','2025-04-07 00:58:13.965343','fcv',9,'qrcodes/producto_84_qr.png',1.00,NULL,2,NULL),(85,'qfesdx','redfsc',123.00,123,'productos_img/no_image.jpg',1,'2025-04-07 01:01:28.523677','2025-04-07 01:01:28.632347','refsdc',3,'qrcodes/producto_85_qr.png',1.00,NULL,2,NULL),(86,'efdsgfc','ergsd',123.00,35,'productos_img/no_image.jpg',1,'2025-04-07 01:09:07.142837','2025-04-12 02:31:37.855206','ersdgxfc',9,'qrcodes/producto_86_qr.png',12.00,30.00,1,NULL);
/*!40000 ALTER TABLE `productos_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_suministradores`
--

DROP TABLE IF EXISTS `productos_suministradores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_suministradores` (
  `provedor_id` int NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `direccion` longtext,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`provedor_id`),
  UNIQUE KEY `nombre_proveedor` (`nombre_proveedor`),
  UNIQUE KEY `productos_suministradores_email_f721b9cd_uniq` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_suministradores`
--

LOCK TABLES `productos_suministradores` WRITE;
/*!40000 ALTER TABLE `productos_suministradores` DISABLE KEYS */;
INSERT INTO `productos_suministradores` VALUES (1,'rijo','8098098090','Greimi2@gmail.com','cualquier lugar','2025-03-28 00:55:02.885720','2025-03-28 00:55:02.885720'),(2,'miguel','8098098097','angelalexanderperezmartinez12@gmail.com','','2025-03-28 00:55:38.568960','2025-03-28 00:55:38.568960'),(3,'Ercilio','1234567890','angelalexanderperezmartinez39@gmail.com','','2025-03-28 00:56:36.071542','2025-03-28 00:56:36.071542');
/*!40000 ALTER TABLE `productos_suministradores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `returns_detalledevolucion`
--

DROP TABLE IF EXISTS `returns_detalledevolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `returns_detalledevolucion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cantidad` int unsigned NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `motivo` varchar(20) NOT NULL,
  `producto_id` int DEFAULT NULL,
  `devolucion_id` bigint NOT NULL,
  `inventario_repuesto` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `returns_detalledevol_producto_id_a548c087_fk_productos` (`producto_id`),
  KEY `returns_detalledevol_devolucion_id_5e186b68_fk_returns_d` (`devolucion_id`),
  CONSTRAINT `returns_detalledevol_devolucion_id_5e186b68_fk_returns_d` FOREIGN KEY (`devolucion_id`) REFERENCES `returns_devolucion` (`id`),
  CONSTRAINT `returns_detalledevol_producto_id_a548c087_fk_productos` FOREIGN KEY (`producto_id`) REFERENCES `productos_producto` (`id_producto`),
  CONSTRAINT `returns_detalledevolucion_chk_1` CHECK ((`cantidad` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `returns_detalledevolucion`
--

LOCK TABLES `returns_detalledevolucion` WRITE;
/*!40000 ALTER TABLE `returns_detalledevolucion` DISABLE KEYS */;
INSERT INTO `returns_detalledevolucion` VALUES (1,1,10.99,'',35,2,0),(2,1,10.99,'',35,3,0),(3,1,34.00,'',79,4,0),(4,1,120.00,'',31,5,1),(5,1,12.00,'',55,5,1),(6,2,12.00,'',60,5,1),(7,1,10.99,'',35,5,1),(8,1,123.00,'',86,5,1),(9,1,120.00,'',81,5,1),(10,2,12.00,'',60,5,1),(11,30,2.00,'',29,6,1),(12,1,120.00,'DANADO',31,7,1),(13,1,120.00,'',31,8,1),(14,1,120.00,'',31,9,1),(15,1,10.99,'',35,10,1),(16,1,120.00,'',31,11,1),(17,1,10.99,'',35,11,1),(18,1,120.00,'',31,12,1),(19,1,120.00,'',31,13,1),(20,1,2.00,'',29,14,1),(21,1,2.00,'',29,14,1),(22,1,120.00,'',31,14,1),(23,1,10.99,'',35,14,1),(24,1,9.50,'',36,14,1),(25,1,10.99,'',35,15,1),(26,1,120.00,'',31,16,1),(27,1,2.00,'',29,17,1),(30,1,120.00,'',31,20,1),(31,1,2.00,'',29,21,1),(32,1,2.00,'DEFECTUOSO',29,22,1),(33,1,2.00,'',29,23,1),(34,1,2.00,'',29,24,1),(35,1,2.00,'',29,26,1),(36,1,2.00,'',29,27,1),(37,1,120.00,'',31,28,1),(38,1,34.00,'',79,29,1),(39,1,10.99,'',35,29,1),(40,100,5.50,'',46,30,1),(41,30,120.00,'',31,31,1),(42,1,2.00,'',29,32,1),(43,1,100.00,'',30,33,1),(44,1,2.00,'DEFECTUOSO',29,34,1),(45,1,100.00,'DANADO',30,35,1),(46,1,120.00,'DEFECTUOSO',31,36,1),(47,1,79.99,'DEFECTUOSO',32,37,1),(48,1,120.00,'DEFECTUOSO',31,38,1),(49,1,120.00,'DANADO',31,39,1),(50,1,79.99,'OTRO',32,40,1),(51,1,12.00,'OTRO',55,41,1),(52,1,34.00,'OTRO',79,42,1),(53,1,12.00,'OTRO',59,43,1),(54,1,100.00,'OTRO',29,44,1),(55,40,10.00,'OTRO',51,45,1),(56,29,100.00,'OTRO',29,46,1);
/*!40000 ALTER TABLE `returns_detalledevolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `returns_devolucion`
--

DROP TABLE IF EXISTS `returns_devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `returns_devolucion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_devolucion` datetime(6) NOT NULL,
  `motivo_general` varchar(20) NOT NULL,
  `metodo_reembolso` varchar(20) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `impuesto` decimal(10,2) NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `total_devolver` decimal(10,2) NOT NULL,
  `comentarios` longtext,
  `factura_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `returns_devolucion_factura_id_c6e307f3_fk_ventas_factura_id` (`factura_id`),
  CONSTRAINT `returns_devolucion_factura_id_c6e307f3_fk_ventas_factura_id` FOREIGN KEY (`factura_id`) REFERENCES `ventas_factura` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `returns_devolucion`
--

LOCK TABLES `returns_devolucion` WRITE;
/*!40000 ALTER TABLE `returns_devolucion` DISABLE KEYS */;
INSERT INTO `returns_devolucion` VALUES (2,'2025-04-12 02:16:11.681673','OTRO','EFECTIVO',10.99,1.98,0.00,12.97,'rqews',26),(3,'2025-04-12 02:17:23.794411','OTRO','TRANSFERENCIA',10.99,1.98,0.00,12.97,'jj',26),(4,'2025-04-12 02:19:23.077771','OTRO','TRANSFERENCIA',34.00,5.51,3.40,36.11,'jb',31),(5,'2025-04-12 02:31:37.765886','OTRO','TRANSFERENCIA',421.99,75.96,0.00,497.95,'erdsxfzcwerfe',28),(6,'2025-04-12 02:35:06.093501','OTRO','EFECTIVO',60.00,10.80,0.00,70.80,'rdfcws',32),(7,'2025-04-13 23:40:00.082751','OTRO','TRANSFERENCIA',120.00,21.60,0.00,141.60,'',40),(8,'2025-04-14 01:26:10.377483','OTRO','EFECTIVO',120.00,21.60,0.00,141.60,'',42),(9,'2025-04-14 01:29:04.026818','OTRO','EFECTIVO',120.00,21.60,0.00,141.60,'',43),(10,'2025-04-14 01:31:10.709717','OTRO','TRANSFERENCIA',10.99,1.98,0.00,12.97,'',44),(11,'2025-04-14 01:32:41.508093','OTRO','EFECTIVO',130.99,23.58,0.00,154.57,'',45),(12,'2025-04-14 01:37:50.220592','OTRO','EFECTIVO',120.00,21.60,0.00,141.60,'',46),(13,'2025-04-14 01:41:21.821415','OTRO','TRANSFERENCIA',120.00,21.60,0.00,141.60,'',47),(14,'2025-04-14 01:43:18.628852','OTRO','TRANSFERENCIA',144.49,26.01,0.00,170.50,'',48),(15,'2025-04-14 01:49:47.434506','OTRO','EFECTIVO',10.99,1.98,0.00,12.97,'',49),(16,'2025-04-14 01:53:14.883637','OTRO','TRANSFERENCIA',120.00,21.60,0.00,141.60,'',50),(17,'2025-04-14 01:57:05.430750','OTRO','TRANSFERENCIA',2.00,0.36,0.00,2.36,'',51),(20,'2025-04-14 02:06:09.597063','OTRO','TRANSFERENCIA',120.00,21.60,0.00,141.60,'',53),(21,'2025-04-14 02:08:28.851684','OTRO','TRANSFERENCIA',2.00,0.36,0.00,2.36,'',54),(22,'2025-04-15 00:31:41.812987','OTRO','TRANSFERENCIA',2.00,0.36,0.00,2.36,'',55),(23,'2025-04-15 00:33:12.938488','OTRO','TRANSFERENCIA',2.00,0.36,0.00,2.36,'',56),(24,'2025-04-15 00:44:43.595803','OTRO','EFECTIVO',2.00,0.36,0.00,2.36,'',57),(26,'2025-04-15 00:46:26.469293','OTRO','TRANSFERENCIA',2.00,0.36,0.00,2.36,'',58),(27,'2025-04-15 00:47:19.388366','OTRO','TRANSFERENCIA',2.00,0.36,0.00,2.36,'',59),(28,'2025-04-15 00:48:53.841285','OTRO','TRANSFERENCIA',120.00,21.60,0.00,141.60,'',60),(29,'2025-04-15 00:49:51.908675','OTRO','TRANSFERENCIA',44.99,7.49,3.40,49.08,'',61),(30,'2025-04-21 18:39:41.111616','OTRO','TRANSFERENCIA',550.00,99.00,0.00,649.00,'',78),(31,'2025-04-22 13:08:49.469042','OTRO','TRANSFERENCIA',3600.00,648.00,0.00,4248.00,'',97),(32,'2025-04-23 14:56:17.662641','OTRO','TRANSFERENCIA',2.00,0.36,0.00,2.36,'',102),(33,'2025-04-23 15:04:51.869661','OTRO','TRANSFERENCIA',100.00,18.00,0.00,118.00,'',103),(34,'2025-04-23 15:45:20.461807','OTRO','EFECTIVO',2.00,0.36,0.00,2.36,'',104),(35,'2025-04-23 15:46:35.758193','OTRO','TRANSFERENCIA',100.00,18.00,0.00,118.00,'',105),(36,'2025-04-23 15:49:19.819996','OTRO','TRANSFERENCIA',120.00,21.60,0.00,141.60,'weda',106),(37,'2025-04-28 23:11:56.254637','OTRO','TRANSFERENCIA',79.99,14.40,0.00,94.39,'',111),(38,'2025-04-28 23:20:51.963420','OTRO','TRANSFERENCIA',120.00,21.60,0.00,141.60,'',110),(39,'2025-04-28 23:23:15.282125','OTRO','TRANSFERENCIA',120.00,21.60,0.00,141.60,'',112),(40,'2025-04-28 23:28:44.800725','OTRO','TRANSFERENCIA',79.99,14.40,0.00,94.39,'',113),(41,'2025-04-28 23:29:59.132299','defectuoso','TRANSFERENCIA',12.00,2.16,0.00,14.16,'',114),(42,'2025-05-01 21:41:58.000318','danado','EFECTIVO',30.60,4.96,3.06,32.50,'hlu',118),(43,'2025-05-04 00:48:02.642670','defectuoso','TRANSFERENCIA',12.00,2.16,0.00,14.16,'',123),(44,'2025-05-06 12:33:08.504073','defectuoso','TRANSFERENCIA',100.00,18.00,0.00,118.00,'',130),(45,'2025-05-07 14:40:07.781296','danado','EFECTIVO',400.00,72.00,0.00,472.00,'',100),(46,'2025-05-07 15:04:07.576306','defectuoso','TRANSFERENCIA',58.00,10.44,0.00,68.44,'',101);
/*!40000 ALTER TABLE `returns_devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser`
--

DROP TABLE IF EXISTS `users_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `profile_image` varchar(100) NOT NULL,
  `group_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `users_customuser_email_6445acef_uniq` (`email`),
  KEY `users_customuser_group_id_35aa4721_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_customuser_group_id_35aa4721_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser`
--

LOCK TABLES `users_customuser` WRITE;
/*!40000 ALTER TABLE `users_customuser` DISABLE KEYS */;
INSERT INTO `users_customuser` VALUES (1,'pbkdf2_sha256$870000$u4cr5t1WKTTu6PHd4L9KWW$925vzMiptQl8M89mSGHFRufuC54IjyGmNumqAs0WbZQ=','2025-05-06 11:54:29.284505',1,'angel2','','','angelalexanderperezmartinez47@gmail.com',1,1,'2025-02-06 21:35:53.997255','profile_pics/default_profile.png',NULL),(33,'pbkdf2_sha256$870000$oTJ8kE45oEYIweyjFYiOPQ$K8mp8ziR6RxCHXjoHT5CXh6lZOFGqzcu5aeXE1hg2ko=','2025-04-21 17:32:19.872245',0,'madiba','','','20230551@ipopsa.edu.do',0,1,'2025-02-09 23:45:27.533760','profile_pics/default_profile.png',NULL),(35,'pbkdf2_sha256$870000$7UdeGHSkmpVmZ4bb4LFALC$DPB2xU+Hfiv/u+tKbWrpT8bR298CTKrtTkvkPO/82g8=',NULL,0,'20230ed551','','','20230ed551@ipopsa.edu.do',0,1,'2025-02-25 23:46:14.416509','profile_pics/default_profile.png',NULL),(44,'pbkdf2_sha256$870000$AlSlky0b383cVxazGioeUy$7uROXWM2Vpkp4L0HzmzCC6CQ5Ahw8vuoBn1o0nr0XvU=','2025-05-04 21:27:44.683613',0,'angel21','','','angelalexanderperezmartinez39@gmail.com',1,1,'2025-03-31 14:24:11.416245','profile_pics/default_profile.png',NULL),(46,'pbkdf2_sha256$870000$5UTI7i7vipwoquosJ0EvfB$ma3dQHRp+mPhz9CTHDpRZosnGY6EzGP0hIt+/VHz8cQ=','2025-05-04 00:15:13.643993',0,'ryan','','','dawaryramirezmontero@gmail.com',0,1,'2025-04-01 01:59:59.527109','profile_pics/img4.png',NULL),(54,'pbkdf2_sha256$870000$PfbOPJxHRGLeXEdLY0OoCW$cHKpdPNjpD8KByXHembSfsmM/zaiXmi+vpBqytnKl2Y=','2025-05-05 23:24:36.994352',0,'angel33','','','healthyhub49@gmail.com',0,1,'2025-05-05 18:11:25.517826','profile_pics/qr_img_2.png',NULL);
/*!40000 ALTER TABLE `users_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_groups`
--

DROP TABLE IF EXISTS `users_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_groups_customuser_id_group_id_76b619e3_uniq` (`customuser_id`,`group_id`),
  KEY `users_customuser_groups_group_id_01390b14_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_customuser_gro_customuser_id_958147bf_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `users_customuser_groups_group_id_01390b14_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_groups`
--

LOCK TABLES `users_customuser_groups` WRITE;
/*!40000 ALTER TABLE `users_customuser_groups` DISABLE KEYS */;
INSERT INTO `users_customuser_groups` VALUES (19,35,6),(3,44,4),(6,46,6),(18,54,5);
/*!40000 ALTER TABLE `users_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_customuser_user_permissions`
--

DROP TABLE IF EXISTS `users_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_customuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customuser_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_customuser_user_pe_customuser_id_permission_7a7debf6_uniq` (`customuser_id`,`permission_id`),
  KEY `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_customuser_use_customuser_id_5771478b_fk_users_cus` FOREIGN KEY (`customuser_id`) REFERENCES `users_customuser` (`id`),
  CONSTRAINT `users_customuser_use_permission_id_baaa2f74_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_customuser_user_permissions`
--

LOCK TABLES `users_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_emailverificationtoken`
--

DROP TABLE IF EXISTS `users_emailverificationtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_emailverificationtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `new_email` varchar(254) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_emailverificationtoken_user_id_token_cb12f46a_uniq` (`user_id`,`token`),
  CONSTRAINT `users_emailverificat_user_id_d239ee38_fk_users_cus` FOREIGN KEY (`user_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_emailverificationtoken`
--

LOCK TABLES `users_emailverificationtoken` WRITE;
/*!40000 ALTER TABLE `users_emailverificationtoken` DISABLE KEYS */;
INSERT INTO `users_emailverificationtoken` VALUES (1,'c00154bbfe60458ea551a4d9c98d8035','20230547@ipopsa.edu.do','2025-04-03 21:28:52.318663',0,46),(2,'e26e77769e6a4b1e886c72ff910a27a0','20230547@ipopsa.edu.do','2025-04-03 21:30:51.563522',1,46),(3,'3654ba60a19943b296e4e688924851b8','dawaryramirezmontero@gmail.com','2025-04-03 21:41:08.441443',0,46),(4,'614eb5bd8d3648eb91ee24de268c289e','dawaryramirezmontero@gmail.com','2025-04-03 21:44:00.865633',1,46),(5,'3e3b5d11314f4f33b496ffb503257b63','20230551@ipopsa.edu.do','2025-04-03 21:46:15.921725',0,46),(6,'02c6486890a343e29ae89bdcea1b336f','healthyhub49@gmail.com','2025-05-05 21:04:35.256220',1,54),(7,'ca1e5244782149d2a542f7e32b08ed00','healthyhub49@gmail.com','2025-05-05 21:13:06.207875',1,54),(8,'afdcf40a339e49faa2f939c9a5b9002b','healthyhub49@gmail.com','2025-05-05 21:14:02.351996',1,54),(9,'cab0e5edaefe4944a76909ee21e385e7','healthyhub49@gmail.com','2025-05-05 21:14:49.900392',1,54),(10,'e339f71835134f3fa2b116a789416358','healthyhub49@gmail.com','2025-05-05 21:32:36.858480',1,54),(11,'a13b6c3c708b4bf4a8f2889b3f2e09bd','healthyhub49@gmail.com','2025-05-05 21:32:44.433951',1,54),(12,'09d5ea0a38eb45a4b6024c020a2a7d2e','lwmc1981@gmail.com','2025-05-05 21:38:46.820252',1,54),(13,'1876b4ee0509488091a6571b3c419fed','healthyhub49@gmail.com','2025-05-05 21:44:02.736825',1,54),(14,'46b15b8ae5e3492080a5e09b42490de0','angelalexanderperezmartinez12@gmail.com','2025-05-05 21:48:20.686015',1,54),(15,'947d81c43d2c483b920f45029893521e','angelalexanderperezmartinez12@gmail.com','2025-05-05 21:53:35.365112',1,54),(16,'8b6c4411319241309b45f4d3ba4449ff','healthyhub49@gmail.com','2025-05-05 21:59:25.784337',1,54),(17,'20a8d4acd81d481dac97c489d3a0598d','healthyhub49@gmail.com','2025-05-05 22:02:13.433375',1,54),(18,'9c9e733451cb4df2b4098c5f30a02512','angelalexanderperezmartinez12@gmail.com','2025-05-05 23:00:37.999446',1,54),(19,'642d03c11158414fac2bed765103a55c','healthyhub49@gmail.com','2025-05-05 23:08:49.521651',1,54),(20,'67f435ee2d384adba326f964c02466cd','angelalexanderperezmartinez12@gmail.com','2025-05-05 23:13:06.978964',1,54),(21,'bc61bf3fbcc94007830409550ac952f3','healthyhub49@gmail.com','2025-05-05 23:18:46.322729',1,54),(22,'4dbdf18c186c490ab89ddb8bf05e02d4','angelalexanderperezmartinez12@gmail.com','2025-05-05 23:23:57.260794',1,54),(23,'f30404f8ae1441d3ba8b83a1ffb39374','healthyhub49@gmail.com','2025-05-05 23:27:01.900630',1,54);
/*!40000 ALTER TABLE `users_emailverificationtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_detalleventa`
--

DROP TABLE IF EXISTS `ventas_detalleventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_detalleventa` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `cantidad` int unsigned NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `producto_id` int NOT NULL,
  `venta_id` int NOT NULL,
  `itbis` decimal(10,2) NOT NULL,
  `cantidad_descuento` decimal(10,2) NOT NULL,
  `descuento` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `ventas_detalleventa_producto_id_a820c807_fk_productos` (`producto_id`),
  KEY `ventas_detalleventa_venta_id_c370bcd7_fk_ventas_venta_id_venta` (`venta_id`),
  CONSTRAINT `ventas_detalleventa_producto_id_a820c807_fk_productos` FOREIGN KEY (`producto_id`) REFERENCES `productos_producto` (`id_producto`),
  CONSTRAINT `ventas_detalleventa_venta_id_c370bcd7_fk_ventas_venta_id_venta` FOREIGN KEY (`venta_id`) REFERENCES `ventas_venta` (`id_venta`),
  CONSTRAINT `ventas_detalleventa_chk_1` CHECK ((`cantidad` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=359 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_detalleventa`
--

LOCK TABLES `ventas_detalleventa` WRITE;
/*!40000 ALTER TABLE `ventas_detalleventa` DISABLE KEYS */;
INSERT INTO `ventas_detalleventa` VALUES (2,1,8.50,8.50,29,12,10.00,0.00,0),(3,1,8.50,8.50,29,13,10.00,0.00,0),(4,2,17.00,34.00,29,14,6.12,0.00,0),(5,1,12.99,12.99,30,14,2.34,0.00,0),(7,1,8.50,8.50,29,15,1.53,0.00,0),(8,10,59.90,599.00,33,15,107.82,0.00,0),(9,1,8.50,8.50,29,23,1.53,0.00,0),(10,1,8.50,8.50,29,23,1.53,0.00,0),(11,1,8.50,8.50,29,23,1.53,0.00,0),(12,1,8.50,8.50,29,23,1.53,0.00,0),(13,1,8.50,8.50,29,26,1.53,0.00,0),(14,1,8.50,8.50,29,27,1.53,0.00,0),(15,1,8.50,8.50,29,27,1.53,0.00,0),(16,2,17.00,34.00,29,28,6.12,0.00,0),(17,1,8.50,8.50,29,29,1.53,0.00,0),(20,1,8.50,8.50,29,30,1.53,0.00,0),(22,1,8.50,8.50,29,31,1.53,0.00,0),(24,1,8.50,8.50,29,32,1.53,0.00,0),(25,2,8.50,17.00,29,33,3.06,0.00,0),(26,1,8.50,8.50,29,33,1.53,0.00,0),(27,1,8.50,8.50,29,33,1.53,0.00,0),(28,1,8.50,8.50,29,43,1.53,0.00,0),(29,1,8.50,8.50,29,47,1.53,0.00,0),(30,1,8.50,8.50,29,51,1.53,0.00,0),(31,1,8.50,8.50,29,54,1.53,0.00,0),(34,1,8.50,8.50,29,57,1.53,0.00,0),(37,1,8.50,8.50,29,61,1.53,0.00,0),(46,1,8.50,8.50,29,75,1.53,0.00,0),(47,1,8.50,8.50,29,76,1.53,0.00,0),(48,1,8.50,8.50,29,77,1.53,0.00,0),(51,1,8.50,8.50,29,82,1.53,0.00,0),(55,1,30.60,30.60,79,88,5.51,0.00,0),(56,1,30.60,30.60,79,89,5.51,0.00,0),(57,1,34.00,34.00,79,90,6.12,0.00,0),(58,1,34.00,34.00,79,91,6.12,0.00,0),(59,1,30.60,30.60,79,92,5.51,0.00,0),(60,1,30.60,30.60,79,93,5.51,0.00,0),(61,1,30.60,30.60,79,94,5.51,0.00,0),(62,1,30.60,30.60,79,95,5.51,0.00,0),(63,2,17.00,34.00,79,96,6.12,0.00,0),(64,1,34.00,34.00,79,97,6.12,0.00,0),(65,1,34.00,34.00,79,98,6.12,0.00,0),(68,1,12.99,12.99,30,101,2.34,0.00,0),(69,2,6.50,12.99,30,102,2.34,0.00,0),(70,1,12.99,12.99,30,103,2.34,0.00,0),(71,2,6.50,12.99,30,104,2.34,0.00,0),(72,2,12.99,25.98,30,105,4.68,0.00,0),(73,1,34.00,34.00,79,106,6.12,0.00,0),(74,2,34.00,68.00,79,107,12.24,0.00,0),(75,1,12.99,12.99,30,108,2.34,0.00,0),(76,1,34.00,34.00,79,109,6.12,0.00,0),(77,1,8.50,8.50,29,110,1.53,0.00,0),(78,1,34.00,34.00,79,111,6.12,10.00,1),(79,1,30.60,30.60,79,112,5.51,0.00,0),(80,1,8.50,8.50,29,116,1.53,0.00,0),(81,1,30.60,30.60,79,117,5.51,10.00,1),(82,1,12.99,12.99,30,118,2.34,0.00,0),(83,1,12.99,12.99,30,119,2.34,0.00,0),(84,1,30.60,30.60,79,120,5.51,10.00,1),(85,1,34.00,34.00,79,128,6.12,10.00,1),(86,1,30.60,30.60,79,133,5.51,10.00,1),(87,1,30.60,30.60,79,137,5.51,10.00,1),(88,1,8.50,8.50,29,138,1.53,0.00,0),(89,1,12.99,12.99,30,139,2.34,0.00,0),(90,1,25.75,25.75,31,140,4.64,0.00,0),(91,1,25.75,25.75,31,141,4.64,0.00,0),(92,1,25.75,25.75,31,142,4.64,0.00,0),(93,1,25.75,25.75,31,143,4.64,0.00,0),(94,1,25.75,25.75,31,144,4.64,0.00,0),(95,1,25.75,25.75,31,145,4.64,0.00,0),(96,1,25.75,25.75,31,146,4.64,0.00,0),(97,1,25.75,25.75,31,147,4.64,0.00,0),(98,1,25.75,25.75,31,148,4.64,0.00,0),(99,1,25.75,25.75,31,149,4.64,0.00,0),(100,1,25.75,25.75,31,150,4.64,0.00,0),(101,1,25.75,25.75,31,151,4.64,0.00,0),(102,1,25.75,25.75,31,152,4.64,0.00,0),(103,1,25.75,25.75,31,153,4.64,0.00,0),(104,1,25.75,25.75,31,154,4.64,0.00,0),(105,1,25.75,25.75,31,155,4.64,0.00,0),(106,1,25.75,25.75,31,156,4.64,0.00,0),(107,1,25.75,25.75,31,157,4.64,0.00,0),(108,1,12.00,12.00,64,158,2.16,0.00,0),(109,1,12.00,12.00,64,159,2.16,0.00,0),(110,1,12.00,12.00,64,160,2.16,0.00,0),(111,1,12.00,12.00,64,161,2.16,0.00,0),(112,1,12.00,12.00,64,162,2.16,0.00,0),(113,1,12.00,12.00,64,163,2.16,0.00,0),(114,1,12.00,12.00,64,164,2.16,0.00,0),(115,1,12.00,12.00,64,165,2.16,0.00,0),(116,1,12.00,12.00,64,166,2.16,0.00,0),(117,1,8.50,8.50,29,167,1.53,0.00,0),(118,1,8.50,8.50,29,168,1.53,0.00,0),(119,1,8.50,8.50,29,169,1.53,0.00,0),(120,1,8.50,8.50,29,170,1.53,0.00,0),(121,1,8.50,8.50,29,171,1.53,0.00,0),(122,1,8.50,8.50,29,172,1.53,0.00,0),(123,1,8.50,8.50,29,173,1.53,0.00,0),(124,1,8.50,8.50,29,174,1.53,0.00,0),(125,1,8.50,8.50,29,175,1.53,0.00,0),(126,1,8.50,8.50,29,176,1.53,0.00,0),(128,1,5.99,5.99,33,178,1.08,0.00,0),(129,1,79.99,79.99,32,179,14.40,0.00,0),(130,1,12.99,12.99,30,180,2.34,0.00,0),(131,1,12.00,12.00,48,181,2.16,0.00,0),(132,1,299.99,299.99,40,182,54.00,0.00,0),(133,1,12.00,12.00,48,183,2.16,0.00,0),(134,1,8.50,8.50,29,184,1.53,0.00,0),(135,1,8.50,8.50,29,185,1.53,0.00,0),(136,1,8.50,8.50,29,186,1.53,0.00,0),(137,1,12.99,12.99,30,187,2.34,0.00,0),(138,1,8.50,8.50,29,188,1.53,0.00,0),(139,1,30.60,30.60,79,189,5.51,10.00,1),(140,1,30.60,30.60,79,190,5.51,10.00,1),(141,1,30.60,30.60,79,191,5.51,10.00,1),(142,1,129.99,129.99,38,192,23.40,0.00,0),(143,1,8.50,8.50,29,193,1.53,0.00,0),(144,1,8.50,8.50,29,194,1.53,0.00,0),(145,2,79.99,159.98,32,195,28.80,0.00,0),(146,1,30.60,30.60,79,196,5.51,10.00,1),(147,1,30.60,30.60,79,197,5.51,10.00,1),(148,1,30.60,30.60,79,198,5.51,10.00,1),(149,1,30.60,30.60,79,199,5.51,10.00,1),(150,1,30.60,30.60,79,200,5.51,10.00,1),(151,1,8.50,8.50,29,202,1.53,0.00,0),(152,1,30.60,30.60,79,203,5.51,10.00,1),(153,1,30.60,30.60,79,204,5.51,10.00,1),(154,1,30.60,30.60,79,205,5.51,10.00,1),(155,1,12.99,12.99,30,211,2.34,0.00,0),(156,1,12.99,12.99,30,212,2.34,0.00,0),(157,1,12.99,12.99,30,213,2.34,0.00,0),(158,1,12.99,12.99,30,214,2.34,0.00,0),(159,1,12.99,12.99,30,215,2.34,0.00,0),(160,1,12.99,12.99,30,216,2.34,0.00,0),(161,1,79.99,79.99,32,217,14.40,0.00,0),(162,1,34.00,34.00,79,218,6.12,10.00,1),(163,1,25.75,25.75,31,219,4.64,0.00,0),(164,1,9.50,9.50,36,219,1.71,0.00,0),(165,1,9.50,9.50,36,219,1.71,0.00,0),(166,1,9.50,9.50,36,219,1.71,0.00,0),(167,1,25.75,25.75,31,220,4.64,0.00,0),(168,1,25.75,25.75,31,220,4.64,0.00,0),(169,1,30.60,30.60,79,220,5.51,10.00,1),(170,4,25.75,103.00,31,221,18.54,0.00,0),(171,4,129.99,519.96,38,222,93.59,0.00,0),(172,3,499.99,1499.97,41,223,269.99,0.00,0),(173,2,79.99,159.98,32,224,28.80,0.00,0),(174,3,2.00,6.00,29,225,1.08,0.00,0),(178,1,34.00,34.00,79,229,6.12,10.00,1),(179,1,34.00,34.00,79,229,6.12,10.00,1),(180,1,12.00,12.00,54,230,2.16,0.00,0),(181,1,12.00,12.00,54,231,2.16,0.00,0),(182,1,12.00,12.00,55,232,2.16,0.00,0),(183,1,2.00,2.00,29,233,0.36,0.00,0),(184,1,100.00,100.00,30,234,18.00,0.00,0),(185,1,2.00,2.00,29,235,0.36,0.00,0),(186,1,100.00,100.00,30,236,18.00,0.00,0),(187,70,5.99,419.30,33,237,75.47,0.00,0),(188,100,79.99,7999.00,32,238,1439.82,0.00,0),(189,1,100.00,100.00,30,239,18.00,0.00,0),(190,1,25.75,25.75,31,240,4.64,0.00,0),(191,1,100.00,100.00,30,241,18.00,0.00,0),(192,3,100.00,300.00,30,242,54.00,0.00,0),(193,3,100.00,300.00,30,243,54.00,0.00,0),(194,1,100.00,100.00,30,244,18.00,0.00,0),(195,2,100.00,200.00,30,245,36.00,0.00,0),(196,40,100.00,4000.00,30,246,720.00,0.00,0),(197,4,100.00,400.00,30,247,72.00,0.00,0),(198,3,100.00,300.00,30,248,54.00,0.00,0),(199,2,100.00,200.00,30,249,36.00,0.00,0),(200,1,100.00,100.00,30,250,18.00,0.00,0),(201,1,100.00,100.00,30,251,18.00,0.00,0),(202,10,100.00,1000.00,30,252,180.00,0.00,0),(203,2,100.00,200.00,30,253,36.00,0.00,0),(204,40,100.00,4000.00,30,254,720.00,0.00,0),(205,1,2.00,2.00,29,255,0.36,0.00,0),(206,1,2.00,2.00,29,256,0.36,0.00,0),(207,1,2.00,2.00,29,257,0.36,0.00,0),(208,1,2.00,2.00,29,258,0.36,0.00,0),(209,1,2.00,2.00,29,259,0.36,0.00,0),(210,12,100.00,1200.00,30,260,216.00,0.00,0),(211,1,10.99,10.99,35,261,1.98,0.00,0),(212,60,100.00,6000.00,30,262,1080.00,0.00,0),(213,1,2.00,2.00,29,263,0.36,0.00,0),(214,1,2.00,2.00,29,264,0.36,0.00,0),(215,1,2.00,2.00,29,265,0.36,0.00,0),(216,1,2.00,2.00,29,266,0.36,0.00,0),(217,1,100.00,100.00,30,267,18.00,0.00,0),(218,1,2.00,2.00,29,268,0.36,0.00,0),(219,1,100.00,100.00,30,269,18.00,0.00,0),(220,1,100.00,100.00,30,270,18.00,0.00,0),(221,1,2.00,2.00,29,271,0.36,0.00,0),(222,1,2.00,2.00,29,272,0.36,0.00,0),(223,1,120.00,120.00,31,273,21.60,0.00,0),(224,1,120.00,120.00,31,273,21.60,0.00,0),(225,1,120.00,120.00,31,273,21.60,0.00,0),(226,3,2.00,6.00,29,273,1.08,0.00,0),(227,2,120.00,240.00,80,273,43.20,0.00,0),(228,1,12.00,12.00,60,273,2.16,0.00,0),(229,4,34.00,136.00,79,273,24.48,10.00,1),(230,1,100.00,100.00,30,274,18.00,0.00,0),(231,1,120.00,120.00,31,275,21.60,0.00,0),(232,1,120.00,120.00,31,276,21.60,0.00,0),(233,1,120.00,120.00,31,277,21.60,0.00,0),(234,1,120.00,120.00,31,278,21.60,0.00,0),(235,1,10.99,10.99,35,279,1.98,0.00,0),(236,1,120.00,120.00,31,280,21.60,0.00,0),(237,1,120.00,120.00,31,281,21.60,0.00,0),(238,1,120.00,120.00,31,282,21.60,0.00,0),(239,1,120.00,120.00,31,283,21.60,0.00,0),(240,1,120.00,120.00,31,284,21.60,0.00,0),(241,1,120.00,120.00,31,285,21.60,0.00,0),(242,1,10.99,10.99,35,286,1.98,0.00,0),(243,1,120.00,120.00,31,287,21.60,0.00,0),(244,1,120.00,120.00,31,288,21.60,0.00,0),(245,1,120.00,120.00,31,289,21.60,0.00,0),(246,1,10.99,10.99,35,290,1.98,0.00,0),(247,2,34.00,68.00,79,291,12.24,10.00,1),(248,1,120.00,120.00,31,292,21.60,0.00,0),(249,1,12.00,12.00,55,292,2.16,0.00,0),(250,1,12.00,12.00,60,292,2.16,0.00,0),(251,1,10.99,10.99,35,292,1.98,0.00,0),(252,1,123.00,123.00,86,292,22.14,0.00,0),(253,1,120.00,120.00,81,292,21.60,0.00,0),(254,2,12.00,24.00,60,292,4.32,0.00,0),(255,1,120.00,120.00,31,293,21.60,0.00,0),(256,1,120.00,120.00,31,294,21.60,0.00,0),(257,1,34.00,34.00,79,294,6.12,10.00,1),(258,1,34.00,34.00,79,295,6.12,10.00,1),(259,30,2.00,60.00,29,296,10.80,0.00,0),(260,1,34.00,34.00,79,297,6.12,10.00,1),(261,1,30.60,30.60,79,298,5.51,10.00,1),(262,1,34.00,34.00,79,299,6.12,10.00,1),(263,1,34.00,34.00,79,300,6.12,10.00,1),(264,1,120.00,120.00,31,301,21.60,0.00,0),(265,1,2.00,2.00,29,302,0.36,0.00,0),(266,1,30.60,30.60,79,303,5.51,10.00,1),(267,1,120.00,120.00,31,303,21.60,0.00,0),(268,1,30.60,30.60,79,304,5.51,10.00,1),(269,1,120.00,120.00,31,304,21.60,0.00,0),(270,1,34.00,34.00,79,305,6.12,10.00,1),(271,1,120.00,120.00,31,305,21.60,0.00,0),(272,1,120.00,120.00,31,306,21.60,0.00,0),(273,1,120.00,120.00,31,307,21.60,0.00,0),(274,1,10.99,10.99,35,308,1.98,0.00,0),(275,1,120.00,120.00,31,309,21.60,0.00,0),(276,1,10.99,10.99,35,309,1.98,0.00,0),(277,1,120.00,120.00,31,310,21.60,0.00,0),(278,1,120.00,120.00,31,311,21.60,0.00,0),(279,1,2.00,2.00,29,312,0.36,0.00,0),(280,1,2.00,2.00,29,312,0.36,0.00,0),(281,1,120.00,120.00,31,312,21.60,0.00,0),(282,1,10.99,10.99,35,312,1.98,0.00,0),(283,1,9.50,9.50,36,312,1.71,0.00,0),(284,1,10.99,10.99,35,313,1.98,0.00,0),(285,1,120.00,120.00,31,314,21.60,0.00,0),(286,1,2.00,2.00,29,315,0.36,0.00,0),(287,1,2.00,2.00,29,316,0.36,0.00,0),(288,1,120.00,120.00,31,317,21.60,0.00,0),(289,1,2.00,2.00,29,318,0.36,0.00,0),(290,1,2.00,2.00,29,319,0.36,0.00,0),(291,1,2.00,2.00,29,320,0.36,0.00,0),(292,1,2.00,2.00,29,321,0.36,0.00,0),(293,1,2.00,2.00,29,322,0.36,0.00,0),(294,1,2.00,2.00,29,323,0.36,0.00,0),(295,1,120.00,120.00,31,324,21.60,0.00,0),(296,1,34.00,34.00,79,325,6.12,10.00,1),(297,1,10.99,10.99,35,325,1.98,0.00,0),(298,10,2.00,20.00,29,326,3.60,0.00,0),(299,49,2.00,98.00,29,327,17.64,0.00,0),(300,30,120.00,3600.00,31,328,648.00,0.00,0),(301,1,2.00,2.00,29,329,0.36,0.00,0),(302,30,12.00,360.00,56,330,64.80,0.00,0),(303,40,100.00,4000.00,30,331,720.00,0.00,0),(304,50,2.00,100.00,29,332,18.00,0.00,0),(305,50,49.99,2499.50,37,333,449.91,0.00,0),(306,49,2.00,98.00,29,334,17.64,0.00,0),(307,49,79.99,3919.51,32,335,705.51,0.00,0),(308,1,2.00,2.00,29,336,0.36,0.00,0),(309,29,2.00,58.00,29,337,10.44,0.00,0),(310,40,7.25,290.00,34,338,52.20,0.00,0),(311,49,12.00,588.00,77,339,105.84,0.00,0),(312,30,12.00,360.00,78,340,64.80,15.00,1),(313,340,34.00,11560.00,79,341,2080.80,10.00,1),(314,100,5.50,550.00,46,342,99.00,0.00,0),(315,30,2.00,60.00,29,343,10.80,0.00,0),(316,12,2.00,24.00,29,344,4.32,0.00,0),(317,2,2.00,4.00,29,345,0.72,0.00,0),(318,3,2.00,6.00,29,346,1.08,0.00,0),(319,10,100.00,1000.00,30,349,180.00,0.00,0),(320,1,100.00,100.00,30,355,18.00,0.00,0),(321,1,100.00,100.00,30,358,18.00,0.00,0),(322,1,100.00,100.00,30,360,18.00,0.00,0),(323,30,120.00,3600.00,31,361,648.00,0.00,0),(324,1,120.00,120.00,31,362,21.60,0.00,0),(325,30,120.00,3600.00,31,363,648.00,0.00,0),(326,40,10.00,400.00,51,364,72.00,0.00,0),(327,29,2.00,58.00,29,365,10.44,0.00,0),(328,1,2.00,2.00,29,366,0.36,0.00,0),(329,1,100.00,100.00,30,367,18.00,0.00,0),(330,1,2.00,2.00,29,368,0.36,0.00,0),(331,1,100.00,100.00,30,369,18.00,0.00,0),(332,1,120.00,120.00,31,370,21.60,0.00,0),(333,30,2.00,60.00,29,371,10.80,0.00,0),(334,40,100.00,4000.00,30,372,720.00,0.00,0),(335,30,120.00,3600.00,31,373,648.00,0.00,0),(336,20,5.99,119.80,33,373,21.56,0.00,0),(337,20,79.99,1599.80,32,373,287.96,0.00,0),(338,1,120.00,120.00,31,374,21.60,0.00,0),(339,1,79.99,79.99,32,375,14.40,0.00,0),(340,1,120.00,120.00,31,376,21.60,0.00,0),(341,1,79.99,79.99,32,377,14.40,0.00,0),(342,1,12.00,12.00,55,378,2.16,0.00,0),(343,1,34.00,34.00,79,379,6.12,10.00,1),(344,1,30.60,30.60,79,380,5.51,10.00,1),(345,1,30.60,30.60,79,381,5.51,10.00,1),(346,1,30.60,30.60,79,382,5.51,10.00,1),(347,1,120.00,120.00,31,383,21.60,0.00,0),(348,1,120.00,120.00,31,384,21.60,0.00,0),(349,1,120.00,120.00,31,385,21.60,0.00,0),(350,1,12.00,12.00,59,386,2.16,0.00,0),(351,1,12.00,12.00,59,387,2.16,0.00,0),(352,1,5.99,5.99,33,388,1.08,0.00,0),(353,1,12.00,12.00,54,389,2.16,0.00,0),(354,1,499.99,499.99,41,390,90.00,0.00,0),(355,1,9.50,9.50,36,391,1.71,0.00,0),(356,1,100.00,100.00,29,392,18.00,0.00,0),(357,1,100.00,100.00,29,393,18.00,0.00,0),(358,1,100.00,100.00,29,394,18.00,0.00,0);
/*!40000 ALTER TABLE `ventas_detalleventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_factura`
--

DROP TABLE IF EXISTS `ventas_factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_factura` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_factura` varchar(20) NOT NULL,
  `fecha_emision` datetime(6) NOT NULL,
  `venta_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_factura` (`numero_factura`),
  UNIQUE KEY `venta_id` (`venta_id`),
  CONSTRAINT `ventas_factura_venta_id_63d49756_fk_ventas_venta_id_venta` FOREIGN KEY (`venta_id`) REFERENCES `ventas_venta` (`id_venta`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_factura`
--

LOCK TABLES `ventas_factura` WRITE;
/*!40000 ALTER TABLE `ventas_factura` DISABLE KEYS */;
INSERT INTO `ventas_factura` VALUES (1,'F-000265','2025-04-08 00:30:56.379600',265),(2,'F-000266','2025-04-08 00:35:54.725358',266),(3,'F-000267','2025-04-08 00:37:32.333803',267),(4,'F-000268','2025-04-08 00:38:33.429211',268),(5,'F-000269','2025-04-08 00:39:24.184830',269),(6,'F-000270','2025-04-08 00:40:13.990929',270),(7,'F-000271','2025-04-08 00:47:25.100158',271),(8,'F-000272','2025-04-08 00:47:54.814855',272),(9,'F-000273','2025-04-08 00:53:37.114071',273),(10,'F-000274','2025-04-08 00:57:32.251989',274),(11,'F-000275','2025-04-08 00:58:48.311346',275),(12,'F-000276','2025-04-08 00:59:19.208062',276),(13,'F-000277','2025-04-08 01:01:15.266441',277),(14,'F-000278','2025-04-08 01:02:29.290372',278),(15,'F-000279','2025-04-08 01:03:53.262557',279),(16,'F-000280','2025-04-08 01:04:28.836951',280),(17,'F-000281','2025-04-08 01:04:52.642947',281),(18,'F-000282','2025-04-08 14:39:21.013022',282),(19,'F-000283','2025-04-08 14:39:48.901753',283),(20,'F-000284','2025-04-09 00:47:55.665122',284),(21,'F-000285','2025-04-09 00:48:01.729967',285),(22,'F-000286','2025-04-09 00:49:10.493510',286),(23,'F-000287','2025-04-09 00:49:49.259378',287),(24,'EF-2025-000288','2025-04-09 00:59:09.014445',288),(25,'T2025-000289','2025-04-09 01:00:19.431318',289),(26,'TR2025-000290','2025-04-09 01:00:59.955825',290),(27,'EF2025-000291','2025-04-10 01:51:43.083313',291),(28,'EF2025-000292','2025-04-10 02:08:34.328741',292),(29,'EF2025-000293','2025-04-10 16:17:17.326929',293),(30,'EF2025-000294','2025-04-12 01:13:04.077158',294),(31,'EF2025-000295','2025-04-12 02:18:05.647423',295),(32,'EF2025-000296','2025-04-12 02:33:50.645429',296),(33,'EF2025-000297','2025-04-12 02:56:53.678704',297),(34,'TR2025-000298','2025-04-12 03:00:19.840426',298),(35,'EF2025-000299','2025-04-12 03:00:52.881370',299),(36,'EF2025-000300','2025-04-12 03:03:02.054662',300),(37,'EF2025-000301','2025-04-13 23:19:56.977255',301),(38,'EF2025-000302','2025-04-13 23:24:03.276117',302),(39,'T2025-000303','2025-04-13 23:35:51.769487',303),(40,'TR2025-000304','2025-04-13 23:36:25.879212',304),(41,'EF2025-000305','2025-04-13 23:36:38.192987',305),(42,'EF2025-000306','2025-04-13 23:46:50.321163',306),(43,'EF2025-000307','2025-04-14 01:28:47.789885',307),(44,'EF2025-000308','2025-04-14 01:30:54.315939',308),(45,'EF2025-000309','2025-04-14 01:32:25.845499',309),(46,'EF2025-000310','2025-04-14 01:37:32.692997',310),(47,'EF2025-000311','2025-04-14 01:41:05.897220',311),(48,'EF2025-000312','2025-04-14 01:42:52.476819',312),(49,'EF2025-000313','2025-04-14 01:49:31.787776',313),(50,'EF2025-000314','2025-04-14 01:53:01.697066',314),(51,'EF2025-000315','2025-04-14 01:56:49.221972',315),(52,'EF2025-000316','2025-04-14 02:03:53.436579',316),(53,'EF2025-000317','2025-04-14 02:05:20.116455',317),(54,'EF2025-000318','2025-04-14 02:08:09.572201',318),(55,'EF2025-000319','2025-04-15 00:31:22.720525',319),(56,'EF2025-000320','2025-04-15 00:32:58.684593',320),(57,'EF2025-000321','2025-04-15 00:44:04.381823',321),(58,'EF2025-000322','2025-04-15 00:46:13.116872',322),(59,'EF2025-000323','2025-04-15 00:47:08.291345',323),(60,'EF2025-000324','2025-04-15 00:48:39.262851',324),(61,'EF2025-000325','2025-04-15 00:49:32.319517',325),(62,'EF2025-000326','2025-04-15 01:13:01.742509',326),(63,'EF2025-000327','2025-04-15 01:39:42.574373',327),(64,'EF2025-000328','2025-04-15 01:45:29.599564',328),(65,'EF2025-000329','2025-04-15 01:46:16.966183',329),(66,'EF2025-000330','2025-04-15 02:07:17.640091',330),(67,'EF2025-000331','2025-04-15 02:12:45.707250',331),(68,'EF2025-000332','2025-04-15 02:13:17.603399',332),(69,'EF2025-000333','2025-04-15 02:16:39.494761',333),(70,'EF2025-000334','2025-04-15 02:19:53.344021',334),(71,'EF2025-000335','2025-04-15 02:20:27.455196',335),(72,'EF2025-000336','2025-04-16 00:27:54.524755',336),(73,'EF2025-000337','2025-04-16 00:30:04.929997',337),(74,'EF2025-000338','2025-04-16 00:30:37.666238',338),(75,'EF2025-000339','2025-04-16 00:34:00.138034',339),(76,'EF2025-000340','2025-04-16 00:45:56.735666',340),(77,'EF2025-000341','2025-04-16 01:24:16.747952',341),(78,'EF2025-000342','2025-04-21 18:39:12.627648',342),(79,'EF2025-000343','2025-04-22 12:37:17.665296',343),(80,'EF2025-000344','2025-04-22 12:39:24.446581',344),(81,'EF2025-000345','2025-04-22 12:39:59.678700',345),(82,'EF2025-000346','2025-04-22 12:41:01.250728',346),(83,'TR2025-000347','2025-04-22 12:43:52.238659',347),(84,'T2025-000348','2025-04-22 12:44:25.526248',348),(85,'T2025-000349','2025-04-22 12:45:33.559886',349),(86,'TR2025-000350','2025-04-22 12:46:57.826674',350),(87,'T2025-000351','2025-04-22 12:48:53.554690',351),(88,'EF2025-000352','2025-04-22 12:50:23.330801',352),(89,'EF2025-000353','2025-04-22 12:51:10.841210',353),(90,'EF2025-000354','2025-04-22 12:52:44.609631',354),(91,'T2025-000355','2025-04-22 12:54:13.276970',355),(92,'T2025-000356','2025-04-22 12:54:44.149337',356),(93,'T2025-000357','2025-04-22 12:55:05.650869',357),(94,'T2025-000358','2025-04-22 13:00:40.323280',358),(95,'T2025-000359','2025-04-22 13:01:06.666864',359),(96,'EF2025-000360','2025-04-22 13:05:16.329057',360),(97,'EF2025-000361','2025-04-22 13:05:50.273923',361),(98,'EF2025-000362','2025-04-22 13:38:05.392742',362),(99,'EF2025-000363','2025-04-22 13:38:35.382549',363),(100,'EF2025-000364','2025-04-22 13:39:52.336301',364),(101,'EF2025-000365','2025-04-22 19:09:44.047522',365),(102,'EF2025-000366','2025-04-23 14:55:59.047818',366),(103,'EF2025-000367','2025-04-23 15:04:39.839921',367),(104,'EF2025-000368','2025-04-23 15:45:04.101730',368),(105,'EF2025-000369','2025-04-23 15:45:47.524120',369),(106,'EF2025-000370','2025-04-23 15:48:58.194427',370),(107,'EF2025-000371','2025-04-25 18:24:32.768977',371),(108,'EF2025-000372','2025-04-25 18:26:18.309692',372),(109,'EF2025-000373','2025-04-25 18:27:11.640263',373),(110,'EF2025-000374','2025-04-28 23:01:53.291006',374),(111,'EF2025-000375','2025-04-28 23:11:34.899755',375),(112,'EF2025-000376','2025-04-28 23:22:56.938451',376),(113,'EF2025-000377','2025-04-28 23:28:22.410210',377),(114,'EF2025-000378','2025-04-28 23:29:39.829682',378),(115,'EF2025-000379','2025-05-01 13:48:37.578839',379),(116,'T2025-000380','2025-05-01 14:35:30.498570',380),(117,'T2025-000381','2025-05-01 16:16:18.754114',381),(118,'TR2025-000382','2025-05-01 16:52:15.770719',382),(119,'TR2025-000383','2025-05-01 21:13:56.095358',383),(120,'EF2025-000384','2025-05-02 16:19:52.184951',384),(121,'EF2025-000385','2025-05-03 23:46:50.450955',385),(122,'EF2025-000386','2025-05-04 00:15:21.436067',386),(123,'EF2025-000387','2025-05-04 00:17:09.765746',387),(124,'TR2025-000388','2025-05-04 00:29:20.278661',388),(125,'EF2025-000389','2025-05-05 20:39:09.811747',389),(126,'EF2025-000390','2025-05-05 20:39:18.610287',390),(127,'EF2025-000391','2025-05-05 20:39:28.155026',391),(128,'EF2025-000392','2025-05-06 12:31:38.982131',392),(129,'T2025-000393','2025-05-06 12:32:09.113350',393),(130,'TR2025-000394','2025-05-06 12:32:42.784213',394);
/*!40000 ALTER TABLE `ventas_factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_transferencia`
--

DROP TABLE IF EXISTS `ventas_transferencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_transferencia` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_referencia` varchar(20) NOT NULL,
  `banco_emisor` varchar(100) NOT NULL,
  `venta_id` int NOT NULL,
  `correo_cliente` varchar(254) NOT NULL,
  `nombre_cliente` varchar(255) NOT NULL,
  `telefono_cliente` varchar(15) NOT NULL,
  `tipo_cuenta` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `venta_id` (`venta_id`),
  CONSTRAINT `ventas_transferencia_venta_id_e7e1de80_fk_ventas_venta_id_venta` FOREIGN KEY (`venta_id`) REFERENCES `ventas_venta` (`id_venta`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_transferencia`
--

LOCK TABLES `ventas_transferencia` WRITE;
/*!40000 ALTER TABLE `ventas_transferencia` DISABLE KEYS */;
INSERT INTO `ventas_transferencia` VALUES (1,'f','f',17,'','','',''),(2,'f','f',18,'','','',''),(3,'eee','eee',19,'20230551@ipopsa.edu.do','angel','+1 333-333-3333',''),(4,'re','er',20,'angelalexanderperezmartinez12@gmail.com','fe','+1 222-222-2222',''),(5,'dfsdx','rfdc',21,'20230551@ipopsa.edu.do','sdf','+1 333-333-3333',''),(6,'ee','ee',22,'20230551@ipopsa.edu.do','fd','+1 333-333-3333',''),(7,'ewr','rea',24,'angelalexanderperezmartijez47@gmail.com','fsd','+1 222-222-2222',''),(8,'dz','dsfx',25,'angelalexanderperezmartinez39@gmail.com','rgsdf','+1 333-333-3333',''),(9,'v','bhd',34,'angelalexanderperezmartinez39@gmail.com','Lady Wendy Martinez Castillo','+1 555-555-5555',''),(10,'sedfsx','erd',35,'angelalexanderperezmartinez47@gmail.com','Lady Wendy Martinez Castillo','+1 000-000-0000','CORRIENTE'),(11,'d','d',41,'angelalexanderperezmartinez12@gmail.com','d','+1 444-444-4444','CORRIENTE'),(12,'dafsd','fd',65,'20230551@ipopsa.edu.do','fsd','+1 222-222-2222','CORRIENTE'),(13,'asf','as',66,'Greimi2@gmail.com','esd','+1 222-222-2222','CORRIENTE'),(14,'sd','d',67,'angelalexanderperezmartinez12@gmail.com','f','+1 555-555-5555','CORRIENTE'),(15,'c','b',69,'angelalexanderperezmartinez47@gmail.com','Lady Wendy Martinez Castillo','+1 888-888-8888','CORRIENTE'),(16,'ed','e',70,'Greimi2@gmail.com','vd','+1 333-333-3333','AHORROS'),(17,'ed','e',71,'Greimi2@gmail.com','vd','+1 333-333-3333','AHORROS'),(18,'r','r',72,'angelalexanderperezmartijez47@gmail.com','f','+1 444-444-4444','CORRIENTE'),(19,'r','r',73,'angelalexanderperezmartijez47@gmail.com','f','+1 444-444-4444','CORRIENTE'),(20,'r','r',74,'angelalexanderperezmartijez47@gmail.com','f','+1 444-444-4444','CORRIENTE'),(21,'d','s',75,'Greimi2@gmail.com','s','+1 444-444-4444','CORRIENTE'),(22,'d','s',76,'Greimi2@gmail.com','s','+1 444-444-4444','CORRIENTE'),(23,'d','s',77,'Greimi2@gmail.com','s','+1 444-444-4444','CORRIENTE'),(24,'gd','r',78,'angelalexanderperezmartinez47@gmail.com','d','+1 333-333-3333','AHORROS'),(25,'r','r',86,'angelalexanderperezmartinez39@gmail.com','f','+1 444-444-4444','CORRIENTE'),(26,'dgrs','gesfa',87,'angelalexanderperezmartinez12@gmail.com','ersa','+1 444-444-4444','CORRIENTE'),(27,'ffds','z',118,'Greimi2@gmail.com','ewsad','+1 333-333-3333','CORRIENTE'),(28,'fsdf','dfz',119,'Greimi2@gmail.com','reds','+1 333-333-3333','CORRIENTE'),(29,'fhg','dg',120,'Greimi2@gmail.com','xzfxcz','+1 444-444-4444','CORRIENTE'),(30,'sfads','sfds',135,'angelalexanderperezmartinez47@gmail.com','rgd','+1 444-444-4444','CORRIENTE'),(31,'sfads','sfds',136,'angelalexanderperezmartinez47@gmail.com','rgd','+1 444-444-4444','CORRIENTE'),(32,'sfads','sfds',137,'angelalexanderperezmartinez47@gmail.com','rgd','+1 444-444-4444','CORRIENTE'),(33,'rsfda','df',139,'angelalexanderperezmartijez47@gmail.com','erd','+1 444-444-4444','CORRIENTE'),(34,'fe','fs',187,'angelalexanderperezmartinez47@gmail.com','fds','+1 333-333-3333','CORRIENTE'),(35,'dfc','dsc',188,'dfzdx@gamil.com','fds','+1 333-333-3333','CORRIENTE'),(36,'44r23efcwdszaf','vdza',189,'4tof@gmail.com','er','+1 444-444-4444','CORRIENTE'),(37,'retfszgvs','fsdfsf',190,'rsgdzvx@fs.com','trads','+1 333-333-3333','CORRIENTE'),(38,'rgsfsdz','fdsz',191,'Greimi3@gmail.com','regdf','+1 443-334-4444','CORRIENTE'),(39,'dfsdxds','rfdc',192,'angelalexanderperezmartinez47@gmail.com','dv','+1 222-222-2222','CORRIENTE'),(40,'fveeeeeeeeeee','x',193,'angelalexanderperezmartinez47@gmail.com','ssd','+1 333-333-3333','AHORROS'),(41,'12345678ijh','ergsv',194,'angelalexanderperezmartinez47@gmail.com','dfgxv','+1 344-444-4444','CORRIENTE'),(42,'der4w422','dfxg',201,'angelalexanderperezmartinez47@gmail.com','resd','+1 444-444-4444','AHORROS'),(43,'der4w422','dfxg',202,'angelalexanderperezmartinez47@gmail.com','resd','+1 444-444-4444','AHORROS'),(44,'sfadser','er',220,'angelalexanderperezmartinez12@gmail.com','Lady Wendy Martinez Castillo','+1 211-111-1111','CORRIENTE'),(45,'d33333','rfdc',244,'Greimi2@gmail.com','Lady Wendy Martinez Castillo','+1 444-444-4444','CORRIENTE'),(46,'332wqr24wedrf','rfdc',284,'angelalexanderperezmartinez47@gmail.com','Lady Wendy Martinez Castillo','+1 222-222-2222','CORRIENTE'),(47,'332wqr24wedrf','rfdc',285,'angelalexanderperezmartinez47@gmail.com','Lady Wendy Martinez Castillo','+1 222-222-2222','CORRIENTE'),(48,'drfwdx','dszzf',286,'Greimi2@gmail.com','Lady Wendy Martinez Castillo','+1 332-233-3333','CORRIENTE'),(49,'eeeertf','er',290,'Greimi2@gmail.com','Lady Wendy Martinez Castillo','+1 222-222-2222','CORRIENTE'),(50,'esdfzcreqsdfw','tref',298,'rsdfwsdz@gmail.cmo','tersdrf','+1 333-333-3333','CORRIENTE'),(51,'erdtafcersdfweaf','4rerfwfs',304,'rewdr@gmail.com','Lady Wendy Martinez Castillo','+1 222-222-2222','AHORROS'),(52,'fsdvzdc sdzxc','33ewrazdca',347,'gra@gmail.com','rsdf','+1 222-222-2222','CORRIENTE'),(53,'rsdfzw','resdzfc',350,'fr@gmail.pcm','redsref','+1 333-333-3333','CORRIENTE'),(54,'123e452','BHD leon',382,'greimi@gmail.com','angel','+1 222-222-2222','CORRIENTE'),(55,'resdfreasD','resdard',383,'rdsfdzrf@gmail.com','rsd','+1 333-333-3333','AHORROS'),(56,'gtarGDZfveg','geardgvegv',388,'greimi@gmail.com','drfdtfv','+1 444-444-4444','CORRIENTE'),(57,'esdzflveszodfc','ersdzfklc;osf',394,'fre@gmail.com','Lady Wendy Martinez Castillo','+1 344-444-4444','CORRIENTE');
/*!40000 ALTER TABLE `ventas_transferencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_venta`
--

DROP TABLE IF EXISTS `ventas_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_venta` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `total` decimal(10,2) NOT NULL,
  `fecha` datetime(6) NOT NULL,
  `metodo_pago` varchar(20) NOT NULL,
  `empleado_id` bigint NOT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `ventas_venta_empleado_id_0a06890d_fk_users_customuser_id` (`empleado_id`),
  CONSTRAINT `ventas_venta_empleado_id_0a06890d_fk_users_customuser_id` FOREIGN KEY (`empleado_id`) REFERENCES `users_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=395 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_venta`
--

LOCK TABLES `ventas_venta` WRITE;
/*!40000 ALTER TABLE `ventas_venta` DISABLE KEYS */;
INSERT INTO `ventas_venta` VALUES (12,10.03,'2025-03-10 19:59:13.250844','EFECTIVO',1),(13,10.03,'2025-03-10 20:31:05.822706','EFECTIVO',1),(14,35.39,'2025-03-10 20:36:47.794824','EFECTIVO',1),(15,99.58,'2025-03-10 20:44:04.316504','EFECTIVO',1),(16,123.00,'2025-03-10 21:44:09.034154','TRANSFERENCIA',1),(17,123.00,'2025-03-10 21:44:47.743877','TRANSFERENCIA',1),(18,120.00,'2025-03-10 21:45:37.382409','TRANSFERENCIA',1),(19,20.00,'2025-03-10 22:57:43.123091','TRANSFERENCIA',1),(20,12.00,'2025-03-10 23:20:03.352427','TRANSFERENCIA',1),(21,12.00,'2025-03-10 23:41:03.498281','TRANSFERENCIA',1),(22,30.09,'2025-03-10 23:44:42.800743','TRANSFERENCIA',1),(23,40.12,'2025-03-11 11:52:38.400817','EFECTIVO',1),(24,56.60,'2025-03-11 11:53:40.662876','TRANSFERENCIA',1),(25,30.09,'2025-03-11 19:00:01.332116','TRANSFERENCIA',1),(26,10.03,'2025-03-11 19:01:30.734056','EFECTIVO',1),(27,20.06,'2025-03-11 19:02:57.962354','EFECTIVO',1),(28,20.06,'2025-03-11 19:04:22.810990','EFECTIVO',1),(29,28.90,'2025-03-11 19:10:24.858422','EFECTIVO',1),(30,28.90,'2025-03-11 19:17:37.861817','EFECTIVO',1),(31,28.90,'2025-03-11 19:24:42.352916','EFECTIVO',1),(32,47.77,'2025-03-12 14:40:45.844510','EFECTIVO',1),(33,40.12,'2025-03-12 14:50:40.396743','EFECTIVO',1),(34,28.90,'2025-03-12 14:55:44.286454','TRANSFERENCIA',1),(35,40.12,'2025-03-12 15:43:43.617236','TRANSFERENCIA',1),(36,50.00,'2025-03-14 15:50:35.780841','TARJETA',1),(37,50.00,'2025-03-14 15:50:35.804305','TARJETA',1),(38,500.00,'2025-03-14 15:53:27.391021','TARJETA',1),(41,20.06,'2025-03-17 15:14:09.541193','TRANSFERENCIA',1),(42,10.03,'2025-03-20 14:09:53.419348','TARJETA',1),(43,28.90,'2025-03-21 07:21:48.223346','EFECTIVO',1),(44,28.90,'2025-03-21 07:24:16.931572','EFECTIVO',1),(45,18.87,'2025-03-21 07:24:29.044874','EFECTIVO',1),(46,10.03,'2025-03-21 07:27:01.951009','EFECTIVO',1),(47,10.03,'2025-03-21 07:27:23.661429','EFECTIVO',1),(48,10.03,'2025-03-21 07:29:25.585923','EFECTIVO',1),(49,18.87,'2025-03-21 07:31:31.202544','EFECTIVO',1),(50,18.87,'2025-03-21 07:33:21.496535','EFECTIVO',1),(51,10.03,'2025-03-21 07:39:39.897701','EFECTIVO',1),(52,18.87,'2025-03-21 07:44:36.969979','EFECTIVO',1),(53,10.03,'2025-03-21 07:45:05.750461','EFECTIVO',1),(54,10.03,'2025-03-21 07:46:53.832103','EFECTIVO',1),(55,18.87,'2025-03-21 07:47:51.751333','EFECTIVO',1),(56,18.87,'2025-03-21 07:50:43.892386','EFECTIVO',1),(57,10.03,'2025-03-21 07:51:36.553618','EFECTIVO',1),(58,10.03,'2025-03-21 07:52:09.175770','EFECTIVO',1),(59,18.87,'2025-03-21 07:53:36.530209','EFECTIVO',1),(60,18.87,'2025-03-21 07:56:04.597945','EFECTIVO',1),(61,10.03,'2025-03-21 07:59:28.575671','EFECTIVO',1),(62,75.47,'2025-03-21 08:00:40.177179','EFECTIVO',1),(63,811.33,'2025-03-21 08:02:13.225694','EFECTIVO',1),(64,188.68,'2025-03-21 08:02:39.228156','EFECTIVO',1),(65,18.87,'2025-03-21 08:03:15.506325','TRANSFERENCIA',1),(66,18.87,'2025-03-21 08:07:52.300941','TRANSFERENCIA',1),(67,18.87,'2025-03-21 08:20:55.553964','TRANSFERENCIA',1),(68,18.87,'2025-03-21 08:34:17.065272','EFECTIVO',1),(69,10.03,'2025-03-21 08:34:53.759966','TRANSFERENCIA',1),(70,18.87,'2025-03-21 08:40:03.935512','TRANSFERENCIA',1),(71,18.87,'2025-03-21 08:45:29.604318','TRANSFERENCIA',1),(72,18.87,'2025-03-21 08:47:50.047105','TRANSFERENCIA',1),(73,18.87,'2025-03-21 08:52:18.136275','TRANSFERENCIA',1),(74,18.87,'2025-03-21 08:53:59.156846','TRANSFERENCIA',1),(75,10.03,'2025-03-21 08:55:16.453372','TRANSFERENCIA',1),(76,10.03,'2025-03-21 08:57:29.408597','TRANSFERENCIA',1),(77,10.03,'2025-03-21 09:00:20.079873','TRANSFERENCIA',1),(78,18.87,'2025-03-21 09:00:45.237483','TRANSFERENCIA',1),(79,113.21,'2025-03-21 09:01:34.923383','EFECTIVO',1),(80,80.24,'2025-03-21 09:08:19.545010','TARJETA',1),(81,10.03,'2025-03-21 09:41:34.996726','TARJETA',1),(82,10.03,'2025-03-21 09:43:51.196506','TARJETA',1),(83,377.36,'2025-03-21 09:48:35.092965','TARJETA',1),(84,18.87,'2025-03-21 09:49:13.229879','EFECTIVO',1),(85,18.87,'2025-03-21 09:49:33.547230','TARJETA',1),(86,18.87,'2025-03-21 09:49:59.260487','TRANSFERENCIA',1),(87,18.87,'2025-03-24 15:34:10.761842','TRANSFERENCIA',1),(88,36.11,'2025-03-25 18:21:38.916393','TARJETA',1),(89,36.11,'2025-03-25 18:33:26.922523','TARJETA',1),(90,40.12,'2025-03-25 18:43:49.003859','TARJETA',1),(91,36.11,'2025-03-25 19:01:08.596395','EFECTIVO',1),(92,36.11,'2025-03-25 19:09:37.528972','TARJETA',1),(93,36.11,'2025-03-25 19:33:04.410988','TARJETA',1),(94,36.11,'2025-03-25 19:36:14.707852','TARJETA',1),(95,36.11,'2025-03-25 19:38:01.021775','TARJETA',1),(96,72.22,'2025-03-26 00:38:39.142872','EFECTIVO',1),(97,36.11,'2025-03-26 00:39:58.947230','EFECTIVO',1),(98,36.11,'2025-03-26 00:41:40.958631','EFECTIVO',1),(99,18.87,'2025-03-26 00:42:06.182483','EFECTIVO',1),(100,18.87,'2025-03-26 00:42:10.402666','EFECTIVO',1),(101,15.33,'2025-03-26 00:42:48.781238','EFECTIVO',1),(102,30.66,'2025-03-26 00:43:48.451281','EFECTIVO',1),(103,15.33,'2025-03-26 00:46:38.674845','EFECTIVO',1),(104,30.66,'2025-03-26 00:47:23.112246','EFECTIVO',1),(105,30.66,'2025-03-26 00:48:01.880691','EFECTIVO',1),(106,36.11,'2025-03-26 00:48:29.209712','EFECTIVO',1),(107,72.22,'2025-03-26 00:48:42.893704','EFECTIVO',1),(108,15.33,'2025-03-26 00:54:41.086067','EFECTIVO',1),(109,36.11,'2025-03-26 00:55:10.848995','EFECTIVO',1),(110,10.03,'2025-03-26 00:57:49.812595','EFECTIVO',1),(111,36.11,'2025-03-26 00:58:15.416301','EFECTIVO',1),(112,36.11,'2025-03-26 01:14:40.146018','TARJETA',1),(113,12.97,'2025-03-26 01:25:42.806025','CASH',1),(114,10.03,'2025-03-26 01:27:33.336133','CASH',1),(115,10.03,'2025-03-26 01:29:08.308162','CASH',1),(116,10.03,'2025-03-26 01:31:10.261104','TARJETA',1),(117,36.11,'2025-03-26 01:31:46.917801','TARJETA',1),(118,15.33,'2025-03-26 01:35:37.012293','TRANSFERENCIA',1),(119,15.33,'2025-03-26 01:38:38.261045','TRANSFERENCIA',1),(120,36.11,'2025-03-26 01:40:20.412244','TRANSFERENCIA',1),(121,36.11,'2025-03-26 02:10:40.386442','CASH',1),(122,36.11,'2025-03-26 02:12:08.125940','CASH',1),(123,36.11,'2025-03-26 02:13:38.313129','CASH',1),(124,36.11,'2025-03-26 02:14:50.558907','CASH',1),(125,36.11,'2025-03-26 02:15:02.268930','CASH',1),(126,36.11,'2025-03-26 02:16:28.327102','CASH',1),(127,36.11,'2025-03-26 02:19:41.217693','CASH',1),(128,36.11,'2025-03-26 02:22:37.529760','CASH',1),(129,36.11,'2025-03-26 02:23:02.837682','TARJETA',1),(130,36.11,'2025-03-26 02:26:06.549681','TARJETA',1),(131,36.11,'2025-03-26 02:27:43.626795','TARJETA',1),(132,36.11,'2025-03-26 02:29:59.084005','TARJETA',1),(133,36.11,'2025-03-26 02:32:06.586744','TARJETA',1),(134,36.11,'2025-03-26 02:35:00.135174','TRANSFERENCIA',1),(135,36.11,'2025-03-26 02:37:46.026353','TRANSFERENCIA',1),(136,36.11,'2025-03-26 02:38:17.371597','TRANSFERENCIA',1),(137,36.11,'2025-03-26 02:38:50.004871','TRANSFERENCIA',1),(138,10.03,'2025-03-26 02:40:14.673293','CASH',1),(139,15.33,'2025-03-26 02:40:34.969481','TRANSFERENCIA',1),(140,30.38,'2025-03-26 02:46:45.436285','CASH',1),(141,30.38,'2025-03-26 02:46:48.721175','CASH',1),(142,30.38,'2025-03-26 02:46:49.483530','CASH',1),(143,30.38,'2025-03-26 02:46:49.627195','CASH',1),(144,30.38,'2025-03-26 02:46:49.851263','CASH',1),(145,30.38,'2025-03-26 02:46:54.076841','CASH',1),(146,30.38,'2025-03-26 02:47:01.176876','CASH',1),(147,30.38,'2025-03-26 02:47:01.407270','CASH',1),(148,30.38,'2025-03-26 02:47:01.603927','CASH',1),(149,30.38,'2025-03-26 02:47:01.782376','CASH',1),(150,30.38,'2025-03-26 02:47:01.950937','CASH',1),(151,30.38,'2025-03-26 02:47:02.126142','CASH',1),(152,30.38,'2025-03-26 02:47:02.307440','CASH',1),(153,30.38,'2025-03-26 02:47:02.672800','CASH',1),(154,30.38,'2025-03-26 02:47:02.899472','CASH',1),(155,30.38,'2025-03-26 02:47:03.523106','CASH',1),(156,30.38,'2025-03-26 02:47:03.742068','CASH',1),(157,30.38,'2025-03-26 02:47:10.839280','CASH',1),(158,14.16,'2025-03-26 02:47:51.219930','CASH',1),(159,14.16,'2025-03-26 02:47:51.854256','CASH',1),(160,14.16,'2025-03-26 02:47:52.046705','CASH',1),(161,14.16,'2025-03-26 02:47:52.224330','CASH',1),(162,14.16,'2025-03-26 02:47:52.393113','CASH',1),(163,14.16,'2025-03-26 02:47:52.582459','CASH',1),(164,14.16,'2025-03-26 02:47:52.904985','CASH',1),(165,14.16,'2025-03-26 02:48:24.882373','CASH',1),(166,14.16,'2025-03-26 02:48:25.644449','CASH',1),(167,10.03,'2025-03-26 02:48:35.127927','CASH',1),(168,10.03,'2025-03-26 02:48:35.911308','CASH',1),(169,10.03,'2025-03-26 02:48:36.098014','CASH',1),(170,10.03,'2025-03-26 02:48:36.257930','CASH',1),(171,10.03,'2025-03-26 02:48:36.553424','CASH',1),(172,10.03,'2025-03-26 02:48:36.731165','CASH',1),(173,10.03,'2025-03-26 02:48:36.888024','CASH',1),(174,10.03,'2025-03-26 02:48:37.037761','CASH',1),(175,10.03,'2025-03-26 02:48:37.187573','CASH',1),(176,10.03,'2025-03-26 02:48:37.497698','CASH',1),(177,18.87,'2025-03-26 02:48:59.779578','CASH',1),(178,7.07,'2025-03-26 02:49:24.930868','CASH',1),(179,94.39,'2025-03-26 02:50:49.188167','CASH',1),(180,15.33,'2025-03-26 02:51:28.978801','CASH',1),(181,14.16,'2025-03-26 02:53:02.446557','CASH',1),(182,353.99,'2025-03-26 02:54:06.122003','CASH',1),(183,14.16,'2025-03-26 02:55:23.346838','CASH',1),(184,10.03,'2025-03-26 02:55:54.310333','CASH',1),(185,10.03,'2025-03-26 02:58:25.439605','CASH',1),(186,10.03,'2025-03-26 03:02:36.287266','CASH',1),(187,15.33,'2025-03-26 03:05:08.202234','TRANSFERENCIA',1),(188,10.03,'2025-03-26 03:07:31.041058','TRANSFERENCIA',1),(189,36.11,'2025-03-26 16:25:46.691703','TRANSFERENCIA',1),(190,36.11,'2025-03-26 16:27:56.550369','TRANSFERENCIA',1),(191,36.11,'2025-03-26 16:29:23.505499','TRANSFERENCIA',1),(192,153.39,'2025-03-26 16:30:17.377744','TRANSFERENCIA',1),(193,10.03,'2025-03-26 16:31:55.830825','TRANSFERENCIA',1),(194,10.03,'2025-03-26 16:38:50.637078','TRANSFERENCIA',1),(195,188.78,'2025-03-26 16:41:38.012412','CASH',1),(196,36.11,'2025-03-26 17:00:18.882593','TARJETA',1),(197,36.11,'2025-03-26 17:02:19.096464','TARJETA',1),(198,36.11,'2025-03-26 17:07:22.919079','TARJETA',1),(199,36.11,'2025-03-26 17:08:40.227561','TARJETA',1),(200,36.11,'2025-03-26 17:13:44.565240','TARJETA',1),(201,18.87,'2025-03-26 17:17:14.965630','TRANSFERENCIA',1),(202,10.03,'2025-03-26 17:17:25.755700','TRANSFERENCIA',1),(203,36.11,'2025-03-26 17:17:54.114077','TARJETA',1),(204,36.11,'2025-03-26 17:23:23.108955','TARJETA',1),(205,36.11,'2025-03-26 17:26:15.896395','TARJETA',1),(206,10.03,'2025-03-26 17:27:16.773126','TARJETA',1),(207,10.03,'2025-03-26 17:27:39.601302','TARJETA',1),(208,10.03,'2025-03-26 17:28:06.099713','TARJETA',1),(209,10.03,'2025-03-26 17:28:58.338596','TARJETA',1),(210,10.03,'2025-03-26 17:31:02.299454','TARJETA',1),(211,15.33,'2025-03-26 17:31:22.011835','TARJETA',1),(212,15.33,'2025-03-26 17:36:24.484807','TARJETA',1),(213,15.33,'2025-03-26 17:36:45.189070','TARJETA',1),(214,15.33,'2025-03-26 17:37:17.679486','TARJETA',1),(215,15.33,'2025-03-26 17:39:12.369438','TARJETA',1),(216,15.33,'2025-03-26 17:39:13.631727','TARJETA',1),(217,94.39,'2025-03-26 17:40:20.077950','TARJETA',1),(218,36.11,'2025-03-26 19:23:36.846678','CASH',1),(219,64.02,'2025-03-26 19:32:10.087880','TARJETA',1),(220,96.88,'2025-03-26 19:51:44.489008','TRANSFERENCIA',1),(221,121.54,'2025-03-30 16:07:53.754402','CASH',1),(222,613.55,'2025-03-31 12:46:03.495089','CASH',1),(223,1769.96,'2025-03-31 12:46:43.871120','CASH',1),(224,188.78,'2025-03-31 12:49:30.949787','CASH',1),(225,7.08,'2025-03-31 12:50:09.925063','CASH',1),(229,72.22,'2025-04-03 16:33:13.014905','CASH',46),(230,14.16,'2025-04-03 19:04:33.798130','CASH',1),(231,14.16,'2025-04-03 19:04:46.006071','CASH',1),(232,14.16,'2025-04-03 19:06:01.940024','CASH',1),(233,2.36,'2025-04-03 19:07:44.607953','CASH',1),(234,118.00,'2025-04-04 14:39:10.794336','CASH',1),(235,2.36,'2025-04-04 14:42:02.130358','CASH',1),(236,118.00,'2025-04-04 14:42:12.536397','CASH',1),(237,494.77,'2025-04-04 16:08:17.004660','CASH',1),(238,9438.82,'2025-04-04 16:10:07.142714','CASH',1),(239,118.00,'2025-04-06 14:38:41.495378','CASH',1),(240,30.38,'2025-04-06 14:38:52.235867','CASH',1),(241,118.00,'2025-04-07 00:00:55.791627','CASH',1),(242,354.00,'2025-04-07 00:10:03.867648','CASH',1),(243,354.00,'2025-04-07 00:10:36.538182','CASH',1),(244,118.00,'2025-04-07 00:12:25.684397','TRANSFERENCIA',1),(245,236.00,'2025-04-07 00:15:48.374886','CASH',1),(246,4720.00,'2025-04-07 00:17:02.574446','CASH',1),(247,472.00,'2025-04-07 00:19:12.528298','CASH',1),(248,354.00,'2025-04-07 00:19:19.478778','CASH',1),(249,236.00,'2025-04-07 00:19:26.964744','CASH',1),(250,118.00,'2025-04-07 00:23:40.647724','CASH',1),(251,118.00,'2025-04-07 00:26:29.022391','CASH',1),(252,1180.00,'2025-04-07 00:28:22.153951','CASH',1),(253,236.00,'2025-04-07 00:32:08.599000','CASH',1),(254,4720.00,'2025-04-07 00:40:04.021003','CASH',1),(255,2.36,'2025-04-07 00:50:39.556746','CASH',1),(256,2.36,'2025-04-07 00:53:44.447470','CASH',1),(257,2.36,'2025-04-07 01:02:10.194760','CASH',1),(258,2.36,'2025-04-07 01:08:45.772985','CASH',1),(259,2.36,'2025-04-07 15:08:25.106522','CASH',1),(260,1416.00,'2025-04-07 15:09:12.276171','CASH',1),(261,12.97,'2025-04-07 15:09:21.324323','CASH',1),(262,7080.00,'2025-04-07 15:16:42.324906','CASH',1),(263,2.36,'2025-04-07 15:34:00.285772','TARJETA',1),(264,2.36,'2025-04-07 15:34:39.923295','TARJETA',1),(265,2.36,'2025-04-08 00:30:56.349467','CASH',1),(266,2.36,'2025-04-08 00:35:54.717724','CASH',1),(267,118.00,'2025-04-08 00:37:32.321373','CASH',1),(268,2.36,'2025-04-08 00:38:33.421825','CASH',1),(269,118.00,'2025-04-08 00:39:24.176796','CASH',1),(270,118.00,'2025-04-08 00:40:13.984048','CASH',1),(271,2.36,'2025-04-08 00:47:25.094445','CASH',1),(272,2.36,'2025-04-08 00:47:54.806729','CASH',1),(273,873.67,'2025-04-08 00:53:37.097534','CASH',1),(274,118.00,'2025-04-08 00:57:32.242127','CASH',1),(275,141.60,'2025-04-08 00:58:48.301458','CASH',1),(276,141.60,'2025-04-08 00:59:19.198431','CASH',1),(277,141.60,'2025-04-08 01:01:15.261031','CASH',1),(278,141.60,'2025-04-08 01:02:29.284128','CASH',1),(279,12.97,'2025-04-08 01:03:53.248117','CASH',1),(280,141.60,'2025-04-08 01:04:28.827009','CASH',1),(281,141.60,'2025-04-08 01:04:52.631812','CASH',1),(282,141.60,'2025-04-08 14:39:20.897081','CASH',1),(283,141.60,'2025-04-08 14:39:48.895679','CASH',1),(284,141.60,'2025-04-09 00:47:55.629674','TRANSFERENCIA',1),(285,141.60,'2025-04-09 00:48:01.722350','TRANSFERENCIA',1),(286,12.97,'2025-04-09 00:49:10.483209','TRANSFERENCIA',1),(287,141.60,'2025-04-09 00:49:49.254392','TARJETA',1),(288,141.60,'2025-04-09 00:59:08.999442','CASH',1),(289,141.60,'2025-04-09 01:00:19.405437','TARJETA',1),(290,12.97,'2025-04-09 01:00:59.952030','TRANSFERENCIA',1),(291,72.22,'2025-04-10 01:51:43.075357','CASH',46),(292,497.95,'2025-04-10 02:08:34.317297','CASH',46),(293,141.60,'2025-04-10 16:17:17.315125','CASH',46),(294,177.71,'2025-04-12 01:13:04.066267','CASH',1),(295,36.11,'2025-04-12 02:18:05.637473','CASH',1),(296,70.80,'2025-04-12 02:33:50.635414','CASH',1),(297,36.11,'2025-04-12 02:56:53.665004','CASH',1),(298,36.11,'2025-04-12 03:00:19.833579','TRANSFERENCIA',1),(299,36.11,'2025-04-12 03:00:52.867688','CASH',1),(300,36.11,'2025-04-12 03:03:02.054662','CASH',1),(301,141.60,'2025-04-13 23:19:56.929015','CASH',1),(302,2.36,'2025-04-13 23:24:03.263897','CASH',1),(303,177.71,'2025-04-13 23:35:51.762102','TARJETA',1),(304,177.71,'2025-04-13 23:36:25.871420','TRANSFERENCIA',1),(305,177.71,'2025-04-13 23:36:38.183230','CASH',1),(306,141.60,'2025-04-13 23:46:50.311571','CASH',1),(307,141.60,'2025-04-14 01:28:47.781191','CASH',1),(308,12.97,'2025-04-14 01:30:54.306863','CASH',1),(309,154.57,'2025-04-14 01:32:25.838708','CASH',1),(310,141.60,'2025-04-14 01:37:32.682429','CASH',1),(311,141.60,'2025-04-14 01:41:05.889659','CASH',1),(312,170.50,'2025-04-14 01:42:52.465358','CASH',1),(313,12.97,'2025-04-14 01:49:31.775744','CASH',1),(314,141.60,'2025-04-14 01:53:01.685370','CASH',1),(315,2.36,'2025-04-14 01:56:49.212710','CASH',1),(316,2.36,'2025-04-14 02:03:53.427819','CASH',1),(317,141.60,'2025-04-14 02:05:20.110776','CASH',1),(318,2.36,'2025-04-14 02:08:09.572201','CASH',1),(319,2.36,'2025-04-15 00:31:22.707904','CASH',1),(320,2.36,'2025-04-15 00:32:58.674855','CASH',1),(321,2.36,'2025-04-15 00:44:04.373361','CASH',1),(322,2.36,'2025-04-15 00:46:13.108189','CASH',1),(323,2.36,'2025-04-15 00:47:08.281065','CASH',1),(324,141.60,'2025-04-15 00:48:39.262851','CASH',1),(325,49.08,'2025-04-15 00:49:32.312261','CASH',1),(326,23.60,'2025-04-15 01:13:01.742509','CASH',1),(327,115.64,'2025-04-15 01:39:42.566992','CASH',1),(328,4248.00,'2025-04-15 01:45:29.599564','CASH',1),(329,2.36,'2025-04-15 01:46:16.956375','CASH',1),(330,424.80,'2025-04-15 02:07:17.632595','CASH',1),(331,4720.00,'2025-04-15 02:12:45.698540','CASH',1),(332,118.00,'2025-04-15 02:13:17.595075','CASH',1),(333,2949.41,'2025-04-15 02:16:39.479459','CASH',1),(334,115.64,'2025-04-15 02:19:53.338049','CASH',1),(335,4625.02,'2025-04-15 02:20:27.448490','CASH',1),(336,2.36,'2025-04-16 00:27:54.501094','CASH',1),(337,68.44,'2025-04-16 00:30:04.923188','CASH',1),(338,342.20,'2025-04-16 00:30:37.658252','CASH',1),(339,693.84,'2025-04-16 00:34:00.124974','CASH',1),(340,361.08,'2025-04-16 00:45:56.728790','CASH',1),(341,12276.72,'2025-04-16 01:24:16.734659','CASH',1),(342,649.00,'2025-04-21 18:39:12.619934','CASH',1),(343,70.80,'2025-04-22 12:37:17.657966','CASH',1),(344,28.32,'2025-04-22 12:39:24.440329','CASH',1),(345,4.72,'2025-04-22 12:39:59.669179','CASH',1),(346,7.08,'2025-04-22 12:41:01.245954','CASH',1),(347,4720.00,'2025-04-22 12:43:52.233172','TRANSFERENCIA',1),(348,4720.00,'2025-04-22 12:44:25.520248','TARJETA',1),(349,1180.00,'2025-04-22 12:45:33.551312','TARJETA',1),(350,5782.00,'2025-04-22 12:46:57.818953','TRANSFERENCIA',1),(351,5782.00,'2025-04-22 12:48:53.544152','TARJETA',1),(352,11800.00,'2025-04-22 12:50:23.319612','CASH',1),(353,11800.00,'2025-04-22 12:51:10.834097','CASH',1),(354,11800.00,'2025-04-22 12:52:44.601608','CASH',1),(355,118.00,'2025-04-22 12:54:13.269949','TARJETA',1),(356,118000.00,'2025-04-22 12:54:44.139751','TARJETA',1),(357,118000.00,'2025-04-22 12:55:05.643845','TARJETA',1),(358,118.00,'2025-04-22 13:00:40.316721','TARJETA',1),(359,11800.00,'2025-04-22 13:01:06.658861','TARJETA',1),(360,118.00,'2025-04-22 13:05:16.321656','CASH',1),(361,4248.00,'2025-04-22 13:05:50.265650','CASH',1),(362,141.60,'2025-04-22 13:38:05.381484','CASH',1),(363,4248.00,'2025-04-22 13:38:35.366549','CASH',1),(364,472.00,'2025-04-22 13:39:52.327909','CASH',1),(365,68.44,'2025-04-22 19:09:44.024404','CASH',1),(366,2.36,'2025-04-23 14:55:59.008126','CASH',1),(367,118.00,'2025-04-23 15:04:39.831860','CASH',1),(368,2.36,'2025-04-23 15:45:04.098510','CASH',1),(369,118.00,'2025-04-23 15:45:47.524120','CASH',1),(370,141.60,'2025-04-23 15:48:58.187581','CASH',1),(371,70.80,'2025-04-25 18:24:32.768977','CASH',1),(372,4720.00,'2025-04-25 18:26:18.302742','CASH',1),(373,6277.13,'2025-04-25 18:27:11.640263','CASH',1),(374,141.60,'2025-04-28 23:01:53.263419','CASH',1),(375,94.39,'2025-04-28 23:11:34.886988','CASH',1),(376,141.60,'2025-04-28 23:22:56.923874','CASH',1),(377,94.39,'2025-04-28 23:28:22.397603','CASH',1),(378,14.16,'2025-04-28 23:29:39.821797','CASH',1),(379,36.11,'2025-05-01 13:48:37.561444','CASH',46),(380,36.11,'2025-05-01 14:35:30.490291','TARJETA',46),(381,36.11,'2025-05-01 16:16:18.743620','TARJETA',46),(382,36.11,'2025-05-01 16:52:15.760125','TRANSFERENCIA',46),(383,141.60,'2025-05-01 21:13:56.054626','TRANSFERENCIA',46),(384,141.60,'2025-05-02 16:19:52.141135','CASH',1),(385,141.60,'2025-05-03 23:46:50.420937','CASH',1),(386,14.16,'2025-05-04 00:15:21.430619','CASH',46),(387,14.16,'2025-05-04 00:17:09.759309','CASH',1),(388,7.07,'2025-05-04 00:29:20.271834','TRANSFERENCIA',1),(389,14.16,'2025-05-05 20:39:09.798132','CASH',1),(390,589.99,'2025-05-05 20:39:18.607378','CASH',1),(391,11.21,'2025-05-05 20:39:28.147267','CASH',1),(392,118.00,'2025-05-06 12:31:38.972551','CASH',1),(393,118.00,'2025-05-06 12:32:09.105966','TARJETA',1),(394,118.00,'2025-05-06 12:32:42.774186','TRANSFERENCIA',1);
/*!40000 ALTER TABLE `ventas_venta` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-07 11:21:38
