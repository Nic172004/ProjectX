-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: projectx
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `id_admin` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `ctn` varchar(45) NOT NULL,
  PRIMARY KEY (`id_admin`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Mark','Balilahon','mark@gmail.com','Nic','123','09556591234'),(2,'System','Administrator','admin@example.com','admin','123','');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `attendance_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `class_id` int NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'Present',
  `date_marked` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `marked_by` int DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  KEY `idx_student_class` (`student_id`,`class_id`),
  KEY `idx_date` (`date_marked`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES (1,1,1,'Present','2025-05-19 01:49:59',1);
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `class_id` int NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) NOT NULL,
  `class_code` varchar(45) NOT NULL,
  `description` text,
  `capacity` int DEFAULT '30',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `room` varchar(45) DEFAULT NULL,
  `schedule` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`class_id`),
  UNIQUE KEY `class_code` (`class_code`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES (1,'Programming 2','121','Ahshhs',30,'2025-05-19 01:39:58','2025-05-19 01:39:58','Netlab1','MF 9-10AM');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_ass`
--

DROP TABLE IF EXISTS `class_ass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_ass` (
  `classID_ass` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `class_name` varchar(100) NOT NULL,
  `class_code` varchar(45) NOT NULL,
  `description` text,
  `instructor_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`classID_ass`),
  UNIQUE KEY `class_code` (`class_code`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_ass`
--

LOCK TABLES `class_ass` WRITE;
/*!40000 ALTER TABLE `class_ass` DISABLE KEYS */;
INSERT INTO `class_ass` VALUES (1,1,'Programming 2','121','Ahshhs',1,'2025-05-19 01:44:45','2025-05-19 01:44:45');
/*!40000 ALTER TABLE `class_ass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment` (
  `enrollment_id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `lecturer_id` int DEFAULT NULL,
  `class_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`enrollment_id`),
  KEY `idx_student` (`student_id`),
  KEY `idx_class` (`class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES (1,1,1,1,'2025-05-21 16:28:33','2025-05-21 16:28:33');
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturers`
--

DROP TABLE IF EXISTS `lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturers` (
  `lecturer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `specialization` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `qualification` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`lecturer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturers`
--

LOCK TABLES `lecturers` WRITE;
/*!40000 ALTER TABLE `lecturers` DISABLE KEYS */;
INSERT INTO `lecturers` VALUES (1,'Terry ','terry@gmail.com','09556591234','Programming ','FACET','Jshs','2025-05-21 16:26:56','2025-05-21 16:26:56',NULL,NULL);
/*!40000 ALTER TABLE `lecturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `action_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `action_type` enum('login','logout','login_failed') NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  `details` text,
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,'Nic','2025-05-19 01:38:56','login','success','admin login'),(2,'Nic','2025-05-19 01:39:58','','success','{\"class_id\":1,\"class_name\":\"Programming 2\",\"class_code\":\"121\",\"room\":\"Netlab1\",\"schedule\":\"MF 9-10AM\"}'),(3,'Nic','2025-05-19 01:42:02','','success','{\"lecturer_id\":1,\"name\":\"Terry Watz\",\"email\":\"terry@gmail.com\"}'),(4,'Nic','2025-05-19 01:43:41','','success','{\"lecturer_id\":2,\"name\":\"Melbourne \",\"email\":\"Mhel@gmail.com\"}'),(5,'Nic','2025-05-19 01:46:22','logout','success',NULL),(6,'terry@gmail.com','2025-05-19 01:47:02','login','success','lecturer login'),(7,'terry@gmail.com','2025-05-19 01:49:06','logout','success',NULL),(8,'Nic','2025-05-19 01:49:23','login','success','student login'),(9,'terry@gmail.com','2025-05-19 01:50:28','login','success','lecturer login'),(10,'terry@gmail.com','2025-05-19 01:51:10','logout','success',NULL),(11,'Nic','2025-05-19 01:51:17','login','success','student login'),(12,'Nic','2025-05-19 01:51:42','login','success','admin login'),(13,'Nic','2025-05-21 16:26:21','login','success','admin login'),(14,'Nic','2025-05-21 16:26:56','','success','{\"lecturer_id\":1,\"name\":\"Terry \",\"email\":\"terry@gmail.com\"}');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qr_codes`
--

DROP TABLE IF EXISTS `qr_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qr_codes` (
  `qr_id` int NOT NULL AUTO_INCREMENT,
  `class_id` int NOT NULL,
  `lecturer_id` int NOT NULL,
  `qr_data` text NOT NULL,
  `generated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NOT NULL,
  `is_expired` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`qr_id`),
  KEY `lecturer_id` (`lecturer_id`),
  KEY `idx_class_lecturer` (`class_id`,`lecturer_id`),
  KEY `idx_expiration` (`expires_at`,`is_expired`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qr_codes`
--

LOCK TABLES `qr_codes` WRITE;
/*!40000 ALTER TABLE `qr_codes` DISABLE KEYS */;
INSERT INTO `qr_codes` VALUES (1,1,1,'{\"id\":1,\"name\":\"Programming 2\",\"code\":\"121\",\"lecturerId\":1,\"generated\":\"2025-05-19 09:48:37\",\"expires\":\"2025-05-19 10:48:37\"}','2025-05-19 01:48:36','2025-05-19 02:48:37',1),(2,1,1,'{\"id\":1,\"name\":\"Programming 2\",\"code\":\"121\",\"lecturerId\":1,\"generated\":\"2025-05-19 09:48:37\",\"expires\":\"2025-05-19 10:48:37\"}','2025-05-21 15:46:35','2025-05-19 02:48:37',1);
/*!40000 ALTER TABLE `qr_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id_student` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `studentID` varchar(45) NOT NULL,
  `ctn` varchar(45) NOT NULL,
  PRIMARY KEY (`id_student`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Mark Nicholas','Bailahon','marknicholas.bailahon@dorsu.edu.ph','Nic','1234','2022-2662','09556591234'),(2,'Clandet','Lemosnero','clan@gmail.com','Clan','4321','0000-0000','1234567890'),(3,'Sitti','Martin','sitti@gmail.com','sitti','123','1234-4321','09876543211'),(4,'Mhelbourne','Laurente','mhel@gmail.com','mhel','123','1221-2112','0987654321'),(5,'Kyle','Alonzo','kyle@gmail.com','kyle','23','3333-3333','0321456987'),(6,'Anna','Lopez','anna.lopez@mail.com','anna123','pass1','2022-1001','09123456780'),(7,'Brian','Dela Cruz','brian.dc@mail.com','briandc','brian@432','2022-1002','09123456781'),(8,'Carla','Santos','carla.s@mail.com','carlasan','carl@1','2022-1003','09123456782'),(9,'Daniel','Ramos','dan.ramos@mail.com','danr','ramos123','2022-1004','09123456783'),(10,'Ella','Gomez','ella.gomez@mail.com','ellag','ella@pass','2022-1005','09123456784'),(11,'Frank','Torres','frank.torres@mail.com','frankt','pass@frank','2022-1006','09123456785'),(12,'Grace','Lim','grace.lim@mail.com','gracel','glim123','2022-1007','09123456786'),(13,'Harry','Yu','harry.yu@mail.com','harryu','yu456','2022-1008','09123456787'),(14,'Isabel','Reyes','isabel.reyes@mail.com','isarey','isa@321','2022-1009','09123456788'),(15,'Jack','Nguyen','jack.nguyen@mail.com','jackn','jn123','2022-1010','09123456789'),(16,'Kyla','Diaz','kyla.diaz@mail.com','kylad','kd123','2022-1011','09123456790'),(17,'Leo','Tan','leo.tan@mail.com','leotan','tan2023','2022-1012','09123456791'),(18,'Mia','Villanueva','mia.vill@mail.com','miav','miamia','2022-1013','09123456792'),(19,'Nathan','Flores','nathan.flores@mail.com','natef','nat123','2022-1014','09123456793'),(20,'Olivia','Cruz','olivia.cruz@mail.com','oliviac','olive456','2022-1015','09123456794'),(21,'Paul','Zhang','paul.zhang@mail.com','paulz','zhang321','2022-1016','09123456795'),(22,'Queenie','Mendoza','queenie.men@mail.com','queenm','qm1234','2022-1017','09123456796'),(23,'Ryan','Lo','ryan.lo@mail.com','rylo','ryanlo','2022-1018','09123456797'),(24,'Samantha','Go','sam.go@mail.com','samgo','samantha','2022-1019','09123456798'),(25,'Thomas','Bautista','thomas.b@mail.com','thomb','tb123','2022-1020','09123456799'),(26,'Ursula','Quinto','ursula.q@mail.com','ursq','uqpass','2022-1021','09123456800'),(27,'Victor','Chan','victor.chan@mail.com','vicc','vchan','2022-1022','09123456801'),(28,'Wendy','Tan','wendy.tan@mail.com','wentan','wtanpass','2022-1023','09123456802'),(29,'Xander','Reyes','xander.reyes@mail.com','xandre','xandpass','2022-1024','09123456803'),(30,'Yana','Lee','yana.lee@mail.com','yanal','lee@pass','2022-1025','09123456804'),(31,'Zach','Ocampo','zach.ocampo@mail.com','zacho','zach123','2022-1026','09123456805');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-22  0:50:50
