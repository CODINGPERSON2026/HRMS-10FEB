-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: hrms
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `assigned_det`
--

DROP TABLE IF EXISTS `assigned_det`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assigned_det` (
  `army_number` varchar(15) DEFAULT NULL,
  `det_id` int DEFAULT NULL,
  `assigned_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `det_removed_date` datetime DEFAULT NULL,
  `det_status` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assigned_det`
--

LOCK TABLES `assigned_det` WRITE;
/*!40000 ALTER TABLE `assigned_det` DISABLE KEYS */;
INSERT INTO `assigned_det` VALUES ('778G',1,'2025-11-25 06:37:53','2025-11-26 03:31:33',0),('99226WE',8,'2025-11-25 06:45:03','2025-12-16 06:56:48',0),('905CESR',4,'2025-11-26 02:35:04','2025-12-16 06:56:57',0),('9085CESR',2,'2025-11-26 03:10:02','2025-12-16 06:57:09',0),('778G',9,'2025-11-26 03:32:22',NULL,0),('9926WE',4,'2025-12-01 12:55:26','2025-12-02 14:14:41',0),('997CESR',4,'2025-12-01 12:58:30','2025-12-16 06:56:53',0),('905CESR',3,'2025-12-01 13:05:33','2025-12-16 06:56:57',0),('965CESR',4,'2025-12-01 15:21:47','2025-12-16 06:57:00',0),('775CESR',1,'2025-12-02 12:33:10','2025-12-16 06:57:04',0),('9085CESR',2,'2025-12-16 06:54:14','2025-12-16 06:57:09',0),('9085CESR',3,'2025-12-16 06:57:37',NULL,1),('984CESR',3,'2025-12-16 07:00:10',NULL,1);
/*!40000 ALTER TABLE `assigned_det` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assigned_personnel`
--

DROP TABLE IF EXISTS `assigned_personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assigned_personnel` (
  `army_number` varchar(15) NOT NULL,
  `det_id` int DEFAULT NULL,
  `assigned_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`army_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assigned_personnel`
--

LOCK TABLES `assigned_personnel` WRITE;
/*!40000 ALTER TABLE `assigned_personnel` DISABLE KEYS */;
INSERT INTO `assigned_personnel` VALUES ('1526',1,'2025-11-04 12:37:26');
/*!40000 ALTER TABLE `assigned_personnel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_members`
--

DROP TABLE IF EXISTS `board_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) DEFAULT NULL,
  `member_name` varchar(255) DEFAULT NULL,
  `army_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_members`
--

LOCK TABLES `board_members` WRITE;
/*!40000 ALTER TABLE `board_members` DISABLE KEYS */;
INSERT INTO `board_members` VALUES (1,'73837','Pankaj','12111');
/*!40000 ALTER TABLE `board_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boards`
--

DROP TABLE IF EXISTS `boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `authority` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `presiding_officer` varchar(255) DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boards`
--

LOCK TABLES `boards` WRITE;
/*!40000 ALTER TABLE `boards` DISABLE KEYS */;
INSERT INTO `boards` VALUES (2,'73837','2026-01-09','TEMP','TEMP2','VIVEK','2026-01-22','JADSF LASJDF JASDF ASDFJSDFJ ASDFJDL ');
/*!40000 ALTER TABLE `boards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `children`
--

DROP TABLE IF EXISTS `children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `children` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `class` varchar(100) DEFAULT NULL,
  `part_ii_order` varchar(100) DEFAULT NULL,
  `uid_no` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_children` (`personnel_id`),
  CONSTRAINT `children_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `children`
--

LOCK TABLES `children` WRITE;
/*!40000 ALTER TABLE `children` DISABLE KEYS */;
INSERT INTO `children` VALUES (1,1,'778G',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(2,2,'156WE',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(3,3,'1526WE',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(4,4,'9926WE',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(5,5,'99226WE',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(6,6,'966WE',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(7,7,'87CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(8,8,'997CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(9,10,'965CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(10,12,'905CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(11,13,'9085CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(12,14,'25CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(13,15,'165CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(14,16,'775CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(15,17,'984CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(16,18,'994CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(17,19,'99999CESR',1,'Alice Doe','2015-08-10','Class 5','P-II/2015/004','111111111111'),(18,25,'123456',1,'Alice Doe','2015-05-01','5th','CP2','CUID1234');
/*!40000 ALTER TABLE `children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `institute` varchar(255) DEFAULT NULL,
  `grading` varchar(100) DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_courses` (`personnel_id`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,1,'778G',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(2,2,'156WE',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(3,3,'1526WE',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(4,4,'9926WE',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(5,5,'99226WE',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(6,6,'966WE',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(7,7,'87CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(8,8,'997CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(9,10,'965CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(10,12,'905CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(11,13,'9085CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(12,14,'25CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(13,15,'165CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(14,16,'775CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(15,17,'984CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(16,18,'994CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(17,19,'99999CESR',1,'Basic Leadership Course','2011-01-01','2011-03-01','OTA Bangalore','A','Passed with distinction'),(18,25,'123456',1,'Tactical Course','2016-01-01','2016-06-01','Army Academy','A','Excellent'),(19,26,'14951234A',1,'Basic Recruit Training','2023-06-15','2023-12-14','Regimental Centre','A','Passed out as Best Recruit'),(20,27,'14952345B',1,'Basic Training','2024-01-20','2024-07-19','Corps Training Centre','B','');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_events`
--

DROP TABLE IF EXISTS `daily_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_date` date DEFAULT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `venue` varchar(255) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_events`
--

LOCK TABLES `daily_events` WRITE;
/*!40000 ALTER TABLE `daily_events` DISABLE KEYS */;
INSERT INTO `daily_events` VALUES (1,'2025-12-01','XYZCSDVS','DSVDS','2025-12-01 06:04:19'),(2,'2025-12-03','abc','test','2025-12-01 06:33:03'),(3,'2026-01-07','CELEBRATION','PT','2026-01-05 09:57:01'),(4,'2026-01-05','DANCING','PT','2026-01-05 10:08:56'),(5,'2026-01-05','CELEBRATION','PT GROUND','2026-01-05 10:11:49'),(6,'2026-01-06','CELEBRATION','PT GROUND','2026-01-06 07:27:29'),(7,'2026-01-09','abc','Convention Center','2026-01-08 18:43:57');
/*!40000 ALTER TABLE `daily_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_accounts`
--

DROP TABLE IF EXISTS `department_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_holder` varchar(100) NOT NULL,
  `current_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_holder` (`account_holder`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_accounts`
--

LOCK TABLES `department_accounts` WRITE;
/*!40000 ALTER TABLE `department_accounts` DISABLE KEYS */;
INSERT INTO `department_accounts` VALUES (6,'IT',5000.00,'ACTIVE','2026-01-07 07:20:45','2026-01-07 07:27:45'),(7,'SWSG',9910100.00,'ACTIVE','2026-01-07 07:21:16','2026-01-13 10:44:41'),(8,'ATG',10.00,'ACTIVE','2026-01-07 09:12:43','2026-01-07 09:13:37'),(9,'IT HW',80000.00,'ACTIVE','2026-01-07 09:41:39','2026-01-07 09:44:45'),(10,'abc',222222.00,'ACTIVE','2026-01-11 07:36:33','2026-01-11 07:36:33');
/*!40000 ALTER TABLE `department_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_transactions`
--

DROP TABLE IF EXISTS `department_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `department_account_id` int NOT NULL,
  `transaction_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `old_balance` decimal(15,2) NOT NULL,
  `credit_amount` decimal(15,2) DEFAULT '0.00',
  `debit_amount` decimal(15,2) DEFAULT '0.00',
  `new_balance` decimal(15,2) NOT NULL,
  `transaction_type` enum('CREDIT','DEBIT') NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `department_account_id` (`department_account_id`),
  CONSTRAINT `department_transactions_ibfk_1` FOREIGN KEY (`department_account_id`) REFERENCES `department_accounts` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_transactions`
--

LOCK TABLES `department_transactions` WRITE;
/*!40000 ALTER TABLE `department_transactions` DISABLE KEYS */;
INSERT INTO `department_transactions` VALUES (1,6,'2026-01-07 12:51:50',2000.00,2000.00,0.00,4000.00,'CREDIT','Payment','2026-01-07 07:21:50'),(2,7,'2026-01-07 12:56:16',0.00,10100.00,0.00,10100.00,'CREDIT','','2026-01-07 07:26:16'),(3,6,'2026-01-07 12:57:21',4000.00,4000.00,0.00,8000.00,'CREDIT','Payment','2026-01-07 07:27:21'),(4,6,'2026-01-07 12:57:45',8000.00,0.00,3000.00,5000.00,'CREDIT','','2026-01-07 07:27:45'),(5,8,'2026-01-07 14:43:11',0.00,90.00,0.00,90.00,'CREDIT','payment ','2026-01-07 09:13:11'),(6,8,'2026-01-07 14:43:37',90.00,0.00,80.00,10.00,'CREDIT','','2026-01-07 09:13:37'),(7,9,'2026-01-07 15:12:36',50000.00,50000.00,0.00,100000.00,'CREDIT','','2026-01-07 09:42:36'),(8,9,'2026-01-07 15:14:45',100000.00,0.00,20000.00,80000.00,'CREDIT','to purchase laptop','2026-01-07 09:44:45'),(9,7,'2026-01-08 19:48:47',10100.00,10000000.00,0.00,10010100.00,'CREDIT','abc','2026-01-08 14:18:47'),(10,7,'2026-01-13 16:14:41',10010100.00,0.00,100000.00,9910100.00,'CREDIT','trg lab','2026-01-13 10:44:41');
/*!40000 ALTER TABLE `department_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailed_courses`
--

DROP TABLE IF EXISTS `detailed_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detailed_courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_detailed_courses` (`personnel_id`),
  CONSTRAINT `detailed_courses_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailed_courses`
--

LOCK TABLES `detailed_courses` WRITE;
/*!40000 ALTER TABLE `detailed_courses` DISABLE KEYS */;
INSERT INTO `detailed_courses` VALUES (1,1,'778G',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(2,2,'156WE',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(3,3,'1526WE',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(4,4,'9926WE',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(5,5,'99226WE',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(6,6,'966WE',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(7,7,'87CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(8,8,'997CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(9,10,'965CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(10,12,'905CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(11,13,'9085CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(12,14,'25CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(13,15,'165CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(14,16,'775CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(15,17,'984CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(16,18,'994CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(17,19,'99999CESR',1,'Advanced Infantry Course','2016-01-01','2016-03-01','Detailed due to injury'),(18,25,'123456',1,'Special Ops Training','2018-01-01','2018-06-01','Outstanding');
/*!40000 ALTER TABLE `detailed_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dets`
--

DROP TABLE IF EXISTS `dets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dets` (
  `det_id` int NOT NULL AUTO_INCREMENT,
  `det_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`det_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dets`
--

LOCK TABLES `dets` WRITE;
/*!40000 ALTER TABLE `dets` DISABLE KEYS */;
INSERT INTO `dets` VALUES (1,'Alpha Detachment'),(2,'Bravo Detachment'),(3,'Charlie Detachment'),(4,'Delta Detachment'),(5,'Echo Detachment'),(6,'Foxtrot Detachment'),(7,'Golf Detachment'),(8,'Hotel Detachment'),(9,'India Detachment'),(10,'Juliet Detachment');
/*!40000 ALTER TABLE `dets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `family_members`
--

DROP TABLE IF EXISTS `family_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `relation` varchar(100) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `uid_no` varchar(50) DEFAULT NULL,
  `part_ii_order` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_family` (`personnel_id`),
  CONSTRAINT `family_members_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `family_members`
--

LOCK TABLES `family_members` WRITE;
/*!40000 ALTER TABLE `family_members` DISABLE KEYS */;
INSERT INTO `family_members` VALUES (1,1,'778G','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(2,2,'156WE','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(3,3,'1526WE','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(4,4,'9926WE','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(5,5,'99226WE','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(6,6,'966WE','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(7,7,'87CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(8,8,'997CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(9,10,'965CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(10,12,'905CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(11,13,'9085CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(12,14,'25CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(13,15,'165CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(14,16,'775CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(15,17,'984CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(16,18,'994CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(17,19,'99999CESR','Spouse','Jane Doe','1987-04-15','987654321098','P-II/2012/003'),(18,25,'123456','Father','Robert Doe','1965-05-01','UID1234','FP2'),(19,26,'14951234A','Father','Shri Ram Singh','1975-08-20','987654321098','Part-II/2023/48'),(20,26,'14951234A','Mother','Smt. Sunita Devi','1978-03-15','876543210987','Part-II/2023/49'),(21,27,'14952345B','Father','Shri Ram Yadav','1972-05-10','123456789012','Part-II/2024/115');
/*!40000 ALTER TABLE `family_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ideal_weights`
--

DROP TABLE IF EXISTS `ideal_weights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ideal_weights` (
  `id` int NOT NULL AUTO_INCREMENT,
  `height_cm` int NOT NULL,
  `age_range` varchar(20) NOT NULL,
  `ideal_weight_kg` decimal(5,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ideal_weights`
--

LOCK TABLES `ideal_weights` WRITE;
/*!40000 ALTER TABLE `ideal_weights` DISABLE KEYS */;
INSERT INTO `ideal_weights` VALUES (2,156,'18-22',49.00,'2025-09-22 10:02:56'),(3,156,'23-27',51.00,'2025-09-22 10:02:56'),(4,156,'28-32',52.50,'2025-09-22 10:02:56'),(5,156,'33-37',53.50,'2025-09-22 10:02:56'),(6,156,'38-42',54.00,'2025-09-22 10:02:56'),(7,156,'43-47',54.50,'2025-09-22 10:02:56'),(8,156,'48-70',55.00,'2025-09-22 10:02:56'),(10,158,'18-22',50.00,'2025-09-22 10:02:56'),(11,158,'23-27',52.00,'2025-09-22 10:02:56'),(12,158,'28-32',54.00,'2025-09-22 10:02:56'),(13,158,'33-37',55.00,'2025-09-22 10:02:56'),(14,158,'38-42',55.50,'2025-09-22 10:02:56'),(15,158,'43-47',56.00,'2025-09-22 10:02:56'),(16,158,'48-70',56.50,'2025-09-22 10:02:56'),(18,160,'18-22',51.00,'2025-09-22 10:02:56'),(19,160,'23-27',53.00,'2025-09-22 10:02:56'),(20,160,'28-32',55.00,'2025-09-22 10:02:56'),(21,160,'33-37',56.00,'2025-09-22 10:02:56'),(22,160,'38-42',56.50,'2025-09-22 10:02:56'),(23,160,'43-47',57.00,'2025-09-22 10:02:56'),(24,160,'48-70',57.50,'2025-09-22 10:02:56'),(26,162,'18-22',52.50,'2025-09-22 10:02:56'),(27,162,'23-27',54.50,'2025-09-22 10:02:56'),(28,162,'28-32',56.00,'2025-09-22 10:02:56'),(29,162,'33-37',57.50,'2025-09-22 10:02:56'),(30,162,'38-42',58.00,'2025-09-22 10:02:56'),(31,162,'43-47',58.50,'2025-09-22 10:02:56'),(32,162,'48-70',59.00,'2025-09-22 10:02:56'),(34,164,'18-22',53.50,'2025-09-22 10:02:56'),(35,164,'23-27',55.50,'2025-09-22 10:02:56'),(36,164,'28-32',57.50,'2025-09-22 10:02:56'),(37,164,'33-37',59.00,'2025-09-22 10:02:56'),(38,164,'38-42',59.50,'2025-09-22 10:02:56'),(39,164,'43-47',60.00,'2025-09-22 10:02:56'),(40,164,'48-70',60.50,'2025-09-22 10:02:56'),(42,166,'18-22',55.00,'2025-09-22 10:02:56'),(43,166,'23-27',57.00,'2025-09-22 10:02:56'),(44,166,'28-32',59.00,'2025-09-22 10:02:56'),(45,166,'33-37',60.50,'2025-09-22 10:02:56'),(46,166,'38-42',61.00,'2025-09-22 10:02:56'),(47,166,'43-47',61.50,'2025-09-22 10:02:56'),(48,166,'48-70',62.00,'2025-09-22 10:02:56'),(50,168,'18-22',56.50,'2025-09-22 10:02:56'),(51,168,'23-27',58.50,'2025-09-22 10:02:56'),(52,168,'28-32',60.50,'2025-09-22 10:02:56'),(53,168,'33-37',62.00,'2025-09-22 10:02:56'),(54,168,'38-42',63.00,'2025-09-22 10:02:56'),(55,168,'43-47',63.50,'2025-09-22 10:02:56'),(56,168,'48-70',64.00,'2025-09-22 10:02:56'),(58,170,'18-22',58.00,'2025-09-22 10:02:56'),(59,170,'23-27',60.00,'2025-09-22 10:02:56'),(60,170,'28-32',62.00,'2025-09-22 10:02:56'),(61,170,'33-37',64.00,'2025-09-22 10:02:56'),(62,170,'38-42',64.50,'2025-09-22 10:02:56'),(63,170,'43-47',65.00,'2025-09-22 10:02:56'),(64,170,'48-70',65.50,'2025-09-22 10:02:56'),(66,172,'18-22',60.00,'2025-09-22 10:02:56'),(67,172,'23-27',61.50,'2025-09-22 10:02:56'),(68,172,'28-32',63.50,'2025-09-22 10:02:56'),(69,172,'33-37',65.50,'2025-09-22 10:02:56'),(70,172,'38-42',66.00,'2025-09-22 10:02:56'),(71,172,'43-47',66.50,'2025-09-22 10:02:56'),(72,172,'48-70',67.50,'2025-09-22 10:02:56'),(74,174,'18-22',61.00,'2025-09-22 10:02:56'),(75,174,'23-27',63.50,'2025-09-22 10:02:56'),(76,174,'28-32',65.50,'2025-09-22 10:02:56'),(77,174,'33-37',67.50,'2025-09-22 10:02:56'),(78,174,'38-42',68.00,'2025-09-22 10:02:56'),(79,174,'43-47',68.50,'2025-09-22 10:02:56'),(80,174,'48-70',69.00,'2025-09-22 10:02:56'),(82,176,'18-22',62.50,'2025-09-22 10:02:56'),(83,176,'23-27',65.00,'2025-09-22 10:02:56'),(84,176,'28-32',67.00,'2025-09-22 10:02:56'),(85,176,'33-37',69.00,'2025-09-22 10:02:56'),(86,176,'38-42',69.50,'2025-09-22 10:02:56'),(87,176,'43-47',70.00,'2025-09-22 10:02:56'),(88,176,'48-70',71.00,'2025-09-22 10:02:56'),(90,178,'18-22',64.00,'2025-09-22 10:02:56'),(91,178,'23-27',66.50,'2025-09-22 10:02:56'),(92,178,'28-32',68.50,'2025-09-22 10:02:56'),(93,178,'33-37',70.50,'2025-09-22 10:02:56'),(94,178,'38-42',71.50,'2025-09-22 10:02:56'),(95,178,'43-47',72.00,'2025-09-22 10:02:56'),(96,178,'48-70',72.50,'2025-09-22 10:02:56'),(98,180,'18-22',65.50,'2025-09-22 10:02:56'),(99,180,'23-27',68.00,'2025-09-22 10:02:56'),(100,180,'28-32',70.50,'2025-09-22 10:02:56'),(101,180,'33-37',72.50,'2025-09-22 10:02:56'),(102,180,'38-42',73.00,'2025-09-22 10:02:56'),(103,180,'43-47',74.00,'2025-09-22 10:02:56'),(104,180,'48-70',74.50,'2025-09-22 10:02:56'),(106,182,'18-22',67.50,'2025-09-22 10:02:56'),(107,182,'23-27',69.50,'2025-09-22 10:02:56'),(108,182,'28-32',72.00,'2025-09-22 10:02:56'),(109,182,'33-37',74.00,'2025-09-22 10:02:56'),(110,182,'38-42',75.00,'2025-09-22 10:02:56'),(111,182,'43-47',75.50,'2025-09-22 10:02:56'),(112,182,'48-70',76.50,'2025-09-22 10:02:56'),(114,184,'18-22',70.00,'2025-09-22 10:02:56'),(115,184,'23-27',71.50,'2025-09-22 10:02:56'),(116,184,'28-32',74.00,'2025-09-22 10:02:56'),(117,184,'33-37',76.00,'2025-09-22 10:02:56'),(118,184,'38-42',76.50,'2025-09-22 10:02:56'),(119,184,'43-47',77.50,'2025-09-22 10:02:56'),(120,184,'48-70',78.00,'2025-09-22 10:02:56'),(122,186,'18-22',70.50,'2025-09-22 10:02:56'),(123,186,'23-27',73.00,'2025-09-22 10:02:56'),(124,186,'28-32',75.50,'2025-09-22 10:02:56'),(125,186,'33-37',78.00,'2025-09-22 10:02:56'),(126,186,'38-42',78.50,'2025-09-22 10:02:56'),(127,186,'43-47',79.00,'2025-09-22 10:02:56'),(128,186,'48-70',80.00,'2025-09-22 10:02:56'),(130,188,'18-22',72.00,'2025-09-22 10:02:56'),(131,188,'23-27',75.00,'2025-09-22 10:02:56'),(132,188,'28-32',77.60,'2025-09-22 10:02:56'),(133,188,'33-37',79.50,'2025-09-22 10:02:56'),(134,188,'38-42',80.00,'2025-09-22 10:02:56'),(135,188,'43-47',81.00,'2025-09-22 10:02:56'),(136,188,'48-70',82.00,'2025-09-22 10:02:56'),(138,190,'18-22',73.50,'2025-09-22 10:02:56'),(139,190,'23-27',76.00,'2025-09-22 10:02:56'),(140,190,'28-32',78.50,'2025-09-22 10:02:56'),(141,190,'33-37',80.50,'2025-09-22 10:02:56'),(142,190,'38-42',81.00,'2025-09-22 10:02:56'),(143,190,'43-47',82.00,'2025-09-22 10:02:56'),(144,190,'48-70',83.00,'2025-09-22 10:02:56');
/*!40000 ALTER TABLE `ideal_weights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_details`
--

DROP TABLE IF EXISTS `leave_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leave_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `year` varchar(10) DEFAULT NULL,
  `al_days` int DEFAULT NULL,
  `cl_days` int DEFAULT NULL,
  `aal_days` int DEFAULT NULL,
  `total_days` int DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_leave` (`personnel_id`),
  CONSTRAINT `leave_details_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_details`
--

LOCK TABLES `leave_details` WRITE;
/*!40000 ALTER TABLE `leave_details` DISABLE KEYS */;
INSERT INTO `leave_details` VALUES (1,1,'778G',1,'2024',20,10,5,35,'Utilized for family'),(2,2,'156WE',1,'2024',20,10,5,35,'Utilized for family'),(3,3,'1526WE',1,'2024',20,10,5,35,'Utilized for family'),(4,4,'9926WE',1,'2024',20,10,5,35,'Utilized for family'),(5,5,'99226WE',1,'2024',20,10,5,35,'Utilized for family'),(6,6,'966WE',1,'2024',20,10,5,35,'Utilized for family'),(7,7,'87CESR',1,'2024',20,10,5,35,'Utilized for family'),(8,8,'997CESR',1,'2024',20,10,5,35,'Utilized for family'),(9,10,'965CESR',1,'2024',20,10,5,35,'Utilized for family'),(10,12,'905CESR',1,'2024',20,10,5,35,'Utilized for family'),(11,13,'9085CESR',1,'2024',20,10,5,35,'Utilized for family'),(12,14,'25CESR',1,'2024',20,10,5,35,'Utilized for family'),(13,15,'165CESR',1,'2024',20,10,5,35,'Utilized for family'),(14,16,'775CESR',1,'2024',20,10,5,35,'Utilized for family'),(15,17,'984CESR',1,'2024',20,10,5,35,'Utilized for family'),(16,18,'994CESR',1,'2024',20,10,5,35,'Utilized for family'),(17,19,'99999CESR',1,'2024',20,10,5,35,'Utilized for family'),(18,25,'123456',1,'2023',10,5,2,17,'Regular'),(19,26,'14951234A',1,'2024',30,10,0,40,''),(20,26,'14951234A',2,'2025',30,8,0,38,'');
/*!40000 ALTER TABLE `leave_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_history`
--

DROP TABLE IF EXISTS `leave_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leave_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `leave_request_id` int NOT NULL,
  `army_number` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `leave_type` varchar(50) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `total_days` int NOT NULL,
  `recommended_by` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Recommended by SEC NCO',
  `remarks` text,
  `recommended_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `reject_reason` text,
  `company` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_history`
--

LOCK TABLES `leave_history` WRITE;
/*!40000 ALTER TABLE `leave_history` DISABLE KEYS */;
INSERT INTO `leave_history` VALUES (1,1,'156WE','Srivastav','AL','2026-01-16','2026-01-31',16,'ARUN SHARMA','Rejected at SEC NCO','Leave rejected','2026-01-15 05:54:35','Im rejjecting your leave because too many are on leave','1 company'),(2,1,'156WE','Srivastav','AL','2026-01-16','2026-01-31',16,'Kohli','Rejected at SEC JCO','Leave rejected','2026-01-15 06:19:50','not possible yet','1 company'),(3,1,'156WE','Srivastav','AL','2026-01-16','2026-01-31',16,'SEC JCO','Pending at OC','i need leave for sisters marriag\n','2026-01-15 06:20:09',NULL,NULL),(4,1,'156WE','Srivastav','AL','2026-01-16','2026-01-31',16,'RAHUL SINGH','Rejected at OC','Leave rejected','2026-01-15 06:21:17','the request cannot be approved','1 company'),(5,1,'156WE','Srivastav','AL','2026-01-16','2026-01-31',16,'RAHUL SINGH','Rejected at OC','Leave rejected','2026-01-15 06:21:52','the request cannot be approved','1 company'),(6,1,'156WE','Srivastav','AL','2026-01-16','2026-01-31',16,'CO','Approved','i need leave for sisters marriag\n','2026-01-15 07:37:53',NULL,NULL),(7,2,'905CESR','Hardik','AL','2026-01-16','2026-01-31',17,'ROHIT YADAV','Rejected at SEC NCO','Leave rejected','2026-01-15 07:55:46','NOT POSSIBLE','2 company');
/*!40000 ALTER TABLE `leave_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_status_info`
--

DROP TABLE IF EXISTS `leave_status_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leave_status_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `army_number` varchar(50) NOT NULL,
  `name` varchar(45) NOT NULL,
  `leave_type` varchar(50) NOT NULL,
  `leave_days` int NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `request_sent_to` varchar(150) DEFAULT NULL,
  `request_status` varchar(50) DEFAULT 'Pending',
  `recommend_date` datetime DEFAULT NULL,
  `rejected_date` datetime DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `leave_reason` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reject_reason` text,
  `company` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_status_info`
--

LOCK TABLES `leave_status_info` WRITE;
/*!40000 ALTER TABLE `leave_status_info` DISABLE KEYS */;
INSERT INTO `leave_status_info` VALUES (1,'156WE','Srivastav','AL',16,'2026-01-16','2026-01-31','Approved','Approved','2026-01-15 13:07:53',NULL,'AL for 16 day(s)','i need leave for sisters marriag\n','2026-01-15 11:22:21','2026-01-15 13:07:53','the request cannot be approved','1 company'),(2,'905CESR','Hardik','AL',17,'2026-01-16','2026-01-31','SEC NCO','Rejected at SEC NCO',NULL,'2026-01-15 13:25:46','AL for 17 day(s)','i need leave for 10 days','2026-01-15 13:23:20','2026-01-15 13:25:46','NOT POSSIBLE','2 company');
/*!40000 ALTER TABLE `leave_status_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `loan_type` varchar(255) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `bank_details` varchar(255) DEFAULT NULL,
  `emi_per_month` decimal(15,2) DEFAULT NULL,
  `pending` decimal(15,2) DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_loans` (`personnel_id`),
  CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loans`
--

LOCK TABLES `loans` WRITE;
/*!40000 ALTER TABLE `loans` DISABLE KEYS */;
INSERT INTO `loans` VALUES (1,1,'778G',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(2,2,'156WE',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(3,3,'1526WE',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(4,4,'9926WE',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(5,5,'99226WE',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(6,6,'966WE',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(7,7,'87CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(8,8,'997CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(9,10,'965CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(10,12,'905CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(11,13,'9085CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(12,14,'25CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(13,15,'165CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(14,16,'775CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(15,17,'984CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(16,18,'994CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(17,19,'99999CESR',1,'Home Loan',5000000.00,'SBI',25000.00,3000000.00,'Repaying on time'),(18,25,'123456',1,'Car Loan',50000.00,'State Bank',2000.00,10000.00,'Good repayment'),(19,27,'14952345B',1,'Two Wheeler Loan',80000.00,'HDFC Bank',3000.00,50000.00,'Ongoing');
/*!40000 ALTER TABLE `loans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marital_discord_cases`
--

DROP TABLE IF EXISTS `marital_discord_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marital_discord_cases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `case_no` varchar(100) DEFAULT NULL,
  `amount_to_pay` decimal(15,2) DEFAULT NULL,
  `sanction_letter_no` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_discord` (`personnel_id`),
  CONSTRAINT `marital_discord_cases_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marital_discord_cases`
--

LOCK TABLES `marital_discord_cases` WRITE;
/*!40000 ALTER TABLE `marital_discord_cases` DISABLE KEYS */;
INSERT INTO `marital_discord_cases` VALUES (1,1,'778G',1,'MD-001',10000.00,'SL/2023/001'),(2,2,'156WE',1,'MD-001',10000.00,'SL/2023/001'),(3,3,'1526WE',1,'MD-001',10000.00,'SL/2023/001'),(4,4,'9926WE',1,'MD-001',10000.00,'SL/2023/001'),(5,5,'99226WE',1,'MD-001',10000.00,'SL/2023/001'),(6,6,'966WE',1,'MD-001',10000.00,'SL/2023/001'),(7,7,'87CESR',1,'MD-001',10000.00,'SL/2023/001'),(8,8,'997CESR',1,'MD-001',10000.00,'SL/2023/001'),(9,10,'965CESR',1,'MD-001',10000.00,'SL/2023/001'),(10,12,'905CESR',1,'MD-001',10000.00,'SL/2023/001'),(11,13,'9085CESR',1,'MD-001',10000.00,'SL/2023/001'),(12,14,'25CESR',1,'MD-001',10000.00,'SL/2023/001'),(13,15,'165CESR',1,'MD-001',10000.00,'SL/2023/001'),(14,16,'775CESR',1,'MD-001',10000.00,'SL/2023/001'),(15,17,'984CESR',1,'MD-001',10000.00,'SL/2023/001'),(16,18,'994CESR',1,'MD-001',10000.00,'SL/2023/001'),(17,19,'99999CESR',1,'MD-001',10000.00,'SL/2023/001'),(18,25,'123456',1,'DC123',5000.00,'Sanction123');
/*!40000 ALTER TABLE `marital_discord_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_phones`
--

DROP TABLE IF EXISTS `mobile_phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobile_phones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `service_provider` varchar(100) DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_mobiles` (`personnel_id`),
  CONSTRAINT `mobile_phones_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_phones`
--

LOCK TABLES `mobile_phones` WRITE;
/*!40000 ALTER TABLE `mobile_phones` DISABLE KEYS */;
INSERT INTO `mobile_phones` VALUES (1,1,'778G',1,'Personal','9876543210','Airtel','Active'),(2,2,'156WE',1,'Personal','9876543210','Airtel','Active'),(3,3,'1526WE',1,'Personal','9876543210','Airtel','Active'),(4,4,'9926WE',1,'Personal','9876543210','Airtel','Active'),(5,5,'99226WE',1,'Personal','9876543210','Airtel','Active'),(6,6,'966WE',1,'Personal','9876543210','Airtel','Active'),(7,7,'87CESR',1,'Personal','9876543210','Airtel','Active'),(8,8,'997CESR',1,'Personal','9876543210','Airtel','Active'),(9,10,'965CESR',1,'Personal','9876543210','Airtel','Active'),(10,12,'905CESR',1,'Personal','9876543210','Airtel','Active'),(11,13,'9085CESR',1,'Personal','9876543210','Airtel','Active'),(12,14,'25CESR',1,'Personal','9876543210','Airtel','Active'),(13,15,'165CESR',1,'Personal','9876543210','Airtel','Active'),(14,16,'775CESR',1,'Personal','9876543210','Airtel','Active'),(15,17,'984CESR',1,'Personal','9876543210','Airtel','Active'),(16,18,'994CESR',1,'Personal','9876543210','Airtel','Active'),(17,19,'99999CESR',1,'Personal','9876543210','Airtel','Active'),(18,25,'123456',1,'Personal','9876543210','ProviderX','Primary'),(19,26,'14951234A',1,'Personal','9876543210','Airtel','Primary contact'),(20,26,'14951234A',2,'Family','8765432109','Jio','Father\'s number'),(21,27,'14952345B',1,'Personal','9876543210','Jio','');
/*!40000 ALTER TABLE `mobile_phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monthly_medical_status`
--

DROP TABLE IF EXISTS `monthly_medical_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monthly_medical_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `year` int NOT NULL,
  `month` tinyint NOT NULL,
  `unit` varchar(50) NOT NULL,
  `unfit_count` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_year_month_unit` (`year`,`month`,`unit`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monthly_medical_status`
--

LOCK TABLES `monthly_medical_status` WRITE;
/*!40000 ALTER TABLE `monthly_medical_status` DISABLE KEYS */;
INSERT INTO `monthly_medical_status` VALUES (1,2025,12,'All',5,'2025-11-11 23:19:39'),(2,2025,12,'1 Company',1,'2025-11-11 23:19:39'),(3,2025,12,'2 Company',2,'2025-11-11 23:19:39'),(4,2025,12,'3 Company',0,'2025-11-11 23:19:39'),(5,2025,12,'4 Company',2,'2025-12-15 23:19:39'),(6,2025,11,'All',6,'2025-11-09 23:00:00'),(7,2025,11,'1 Company',2,'2025-11-09 23:00:00'),(8,2025,11,'2 Company',1,'2025-11-09 23:00:00'),(9,2025,11,'3 Company',1,'2025-11-09 23:00:00'),(10,2025,11,'4 Company',2,'2025-11-09 23:00:00'),(11,2025,10,'All',8,'2025-10-11 23:30:00'),(12,2025,10,'1 Company',2,'2025-10-11 23:30:00'),(13,2025,10,'2 Company',2,'2025-10-11 23:30:00'),(14,2025,10,'3 Company',1,'2025-10-11 23:30:00'),(15,2025,10,'4 Company',3,'2025-10-11 23:30:00'),(16,2025,9,'All',7,'2025-09-15 00:40:00'),(17,2025,9,'1 Company',1,'2025-09-15 00:40:00'),(18,2025,9,'2 Company',2,'2025-09-15 00:40:00'),(19,2025,9,'3 Company',2,'2025-09-15 00:40:00'),(20,2025,9,'4 Company',2,'2025-09-15 00:40:00'),(21,2026,1,'All',5,'2025-12-31 19:03:45'),(22,2026,1,'1 Company',1,'2025-12-31 19:03:45'),(23,2026,1,'2 Company',2,'2025-12-31 19:03:45'),(24,2026,1,'3 Company',0,'2025-12-31 19:03:45'),(25,2026,1,'4 Company',2,'2025-12-31 19:03:45');
/*!40000 ALTER TABLE `monthly_medical_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parade_state_daily`
--

DROP TABLE IF EXISTS `parade_state_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parade_state_daily` (
  `id` int NOT NULL AUTO_INCREMENT,
  `report_date` date NOT NULL,
  `company` varchar(100) NOT NULL,
  `offr_auth` int DEFAULT '0',
  `offr_hs` int DEFAULT '0',
  `offr_posted_str` int DEFAULT '0',
  `offr_lve` int DEFAULT '0',
  `offr_course` int DEFAULT '0',
  `offr_det` int DEFAULT '0',
  `offr_mh` int DEFAULT '0',
  `offr_sick_lve` int DEFAULT '0',
  `offr_ex` int DEFAULT '0',
  `offr_td` int DEFAULT '0',
  `offr_att` int DEFAULT '0',
  `offr_awl_osl_jc` int DEFAULT '0',
  `offr_trout_det` int DEFAULT '0',
  `offr_present_det` int DEFAULT '0',
  `offr_present_unit` int DEFAULT '0',
  `offr_dues_in` int DEFAULT '0',
  `offr_dues_out` int DEFAULT '0',
  `jco_auth` int DEFAULT '0',
  `jco_hs` int DEFAULT '0',
  `jco_posted_str` int DEFAULT '0',
  `jco_lve` int DEFAULT '0',
  `jco_course` int DEFAULT '0',
  `jco_det` int DEFAULT '0',
  `jco_mh` int DEFAULT '0',
  `jco_sick_lve` int DEFAULT '0',
  `jco_ex` int DEFAULT '0',
  `jco_td` int DEFAULT '0',
  `jco_att` int DEFAULT '0',
  `jco_awl_osl_jc` int DEFAULT '0',
  `jco_trout_det` int DEFAULT '0',
  `jco_present_det` int DEFAULT '0',
  `jco_present_unit` int DEFAULT '0',
  `jco_dues_in` int DEFAULT '0',
  `jco_dues_out` int DEFAULT '0',
  `jcoEre_auth` int DEFAULT '0',
  `jcoEre_hs` int DEFAULT '0',
  `jcoEre_posted_str` int DEFAULT '0',
  `jcoEre_lve` int DEFAULT '0',
  `jcoEre_course` int DEFAULT '0',
  `jcoEre_det` int DEFAULT '0',
  `jcoEre_mh` int DEFAULT '0',
  `jcoEre_sick_lve` int DEFAULT '0',
  `jcoEre_ex` int DEFAULT '0',
  `jcoEre_td` int DEFAULT '0',
  `jcoEre_att` int DEFAULT '0',
  `jcoEre_awl_osl_jc` int DEFAULT '0',
  `jcoEre_trout_det` int DEFAULT '0',
  `jcoEre_present_det` int DEFAULT '0',
  `jcoEre_present_unit` int DEFAULT '0',
  `jcoEre_dues_in` int DEFAULT '0',
  `jcoEre_dues_out` int DEFAULT '0',
  `or_auth` int DEFAULT '0',
  `or_hs` int DEFAULT '0',
  `or_posted_str` int DEFAULT '0',
  `or_lve` int DEFAULT '0',
  `or_course` int DEFAULT '0',
  `or_det` int DEFAULT '0',
  `or_mh` int DEFAULT '0',
  `or_sick_lve` int DEFAULT '0',
  `or_ex` int DEFAULT '0',
  `or_td` int DEFAULT '0',
  `or_att` int DEFAULT '0',
  `or_awl_osl_jc` int DEFAULT '0',
  `or_trout_det` int DEFAULT '0',
  `or_present_det` int DEFAULT '0',
  `or_present_unit` int DEFAULT '0',
  `or_dues_in` int DEFAULT '0',
  `or_dues_out` int DEFAULT '0',
  `orEre_auth` int DEFAULT '0',
  `orEre_hs` int DEFAULT '0',
  `orEre_posted_str` int DEFAULT '0',
  `orEre_lve` int DEFAULT '0',
  `orEre_course` int DEFAULT '0',
  `orEre_det` int DEFAULT '0',
  `orEre_mh` int DEFAULT '0',
  `orEre_sick_lve` int DEFAULT '0',
  `orEre_ex` int DEFAULT '0',
  `orEre_td` int DEFAULT '0',
  `orEre_att` int DEFAULT '0',
  `orEre_awl_osl_jc` int DEFAULT '0',
  `orEre_trout_det` int DEFAULT '0',
  `orEre_present_det` int DEFAULT '0',
  `orEre_present_unit` int DEFAULT '0',
  `orEre_dues_in` int DEFAULT '0',
  `orEre_dues_out` int DEFAULT '0',
  `firstTotal_auth` int DEFAULT '0',
  `firstTotal_hs` int DEFAULT '0',
  `firstTotal_posted_str` int DEFAULT '0',
  `firstTotal_lve` int DEFAULT '0',
  `firstTotal_course` int DEFAULT '0',
  `firstTotal_det` int DEFAULT '0',
  `firstTotal_mh` int DEFAULT '0',
  `firstTotal_sick_lve` int DEFAULT '0',
  `firstTotal_ex` int DEFAULT '0',
  `firstTotal_td` int DEFAULT '0',
  `firstTotal_att` int DEFAULT '0',
  `firstTotal_awl_osl_jc` int DEFAULT '0',
  `firstTotal_trout_det` int DEFAULT '0',
  `firstTotal_present_det` int DEFAULT '0',
  `firstTotal_present_unit` int DEFAULT '0',
  `firstTotal_dues_in` int DEFAULT '0',
  `firstTotal_dues_out` int DEFAULT '0',
  `oaOr_auth` int DEFAULT '0',
  `oaOr_hs` int DEFAULT '0',
  `oaOr_posted_str` int DEFAULT '0',
  `oaOr_lve` int DEFAULT '0',
  `oaOr_course` int DEFAULT '0',
  `oaOr_det` int DEFAULT '0',
  `oaOr_mh` int DEFAULT '0',
  `oaOr_sick_lve` int DEFAULT '0',
  `oaOr_ex` int DEFAULT '0',
  `oaOr_td` int DEFAULT '0',
  `oaOr_att` int DEFAULT '0',
  `oaOr_awl_osl_jc` int DEFAULT '0',
  `oaOr_trout_det` int DEFAULT '0',
  `oaOr_present_det` int DEFAULT '0',
  `oaOr_present_unit` int DEFAULT '0',
  `oaOr_dues_in` int DEFAULT '0',
  `oaOr_dues_out` int DEFAULT '0',
  `attSummary_auth` int DEFAULT '0',
  `attSummary_hs` int DEFAULT '0',
  `attSummary_posted_str` int DEFAULT '0',
  `attSummary_lve` int DEFAULT '0',
  `attSummary_course` int DEFAULT '0',
  `attSummary_det` int DEFAULT '0',
  `attSummary_mh` int DEFAULT '0',
  `attSummary_sick_lve` int DEFAULT '0',
  `attSummary_ex` int DEFAULT '0',
  `attSummary_td` int DEFAULT '0',
  `attSummary_att` int DEFAULT '0',
  `attSummary_awl_osl_jc` int DEFAULT '0',
  `attSummary_trout_det` int DEFAULT '0',
  `attSummary_present_det` int DEFAULT '0',
  `attSummary_present_unit` int DEFAULT '0',
  `attSummary_dues_in` int DEFAULT '0',
  `attSummary_dues_out` int DEFAULT '0',
  `attOffr_auth` int DEFAULT '0',
  `attOffr_hs` int DEFAULT '0',
  `attOffr_posted_str` int DEFAULT '0',
  `attOffr_lve` int DEFAULT '0',
  `attOffr_course` int DEFAULT '0',
  `attOffr_det` int DEFAULT '0',
  `attOffr_mh` int DEFAULT '0',
  `attOffr_sick_lve` int DEFAULT '0',
  `attOffr_ex` int DEFAULT '0',
  `attOffr_td` int DEFAULT '0',
  `attOffr_att` int DEFAULT '0',
  `attOffr_awl_osl_jc` int DEFAULT '0',
  `attOffr_trout_det` int DEFAULT '0',
  `attOffr_present_det` int DEFAULT '0',
  `attOffr_present_unit` int DEFAULT '0',
  `attOffr_dues_in` int DEFAULT '0',
  `attOffr_dues_out` int DEFAULT '0',
  `attJco_auth` int DEFAULT '0',
  `attJco_hs` int DEFAULT '0',
  `attJco_posted_str` int DEFAULT '0',
  `attJco_lve` int DEFAULT '0',
  `attJco_course` int DEFAULT '0',
  `attJco_det` int DEFAULT '0',
  `attJco_mh` int DEFAULT '0',
  `attJco_sick_lve` int DEFAULT '0',
  `attJco_ex` int DEFAULT '0',
  `attJco_td` int DEFAULT '0',
  `attJco_att` int DEFAULT '0',
  `attJco_awl_osl_jc` int DEFAULT '0',
  `attJco_trout_det` int DEFAULT '0',
  `attJco_present_det` int DEFAULT '0',
  `attJco_present_unit` int DEFAULT '0',
  `attJco_dues_in` int DEFAULT '0',
  `attJco_dues_out` int DEFAULT '0',
  `attOr_auth` int DEFAULT '0',
  `attOr_hs` int DEFAULT '0',
  `attOr_posted_str` int DEFAULT '0',
  `attOr_lve` int DEFAULT '0',
  `attOr_course` int DEFAULT '0',
  `attOr_det` int DEFAULT '0',
  `attOr_mh` int DEFAULT '0',
  `attOr_sick_lve` int DEFAULT '0',
  `attOr_ex` int DEFAULT '0',
  `attOr_td` int DEFAULT '0',
  `attOr_att` int DEFAULT '0',
  `attOr_awl_osl_jc` int DEFAULT '0',
  `attOr_trout_det` int DEFAULT '0',
  `attOr_present_det` int DEFAULT '0',
  `attOr_present_unit` int DEFAULT '0',
  `attOr_dues_in` int DEFAULT '0',
  `attOr_dues_out` int DEFAULT '0',
  `secondTotal_auth` int DEFAULT '0',
  `secondTotal_hs` int DEFAULT '0',
  `secondTotal_posted_str` int DEFAULT '0',
  `secondTotal_lve` int DEFAULT '0',
  `secondTotal_course` int DEFAULT '0',
  `secondTotal_det` int DEFAULT '0',
  `secondTotal_mh` int DEFAULT '0',
  `secondTotal_sick_lve` int DEFAULT '0',
  `secondTotal_ex` int DEFAULT '0',
  `secondTotal_td` int DEFAULT '0',
  `secondTotal_att` int DEFAULT '0',
  `secondTotal_awl_osl_jc` int DEFAULT '0',
  `secondTotal_trout_det` int DEFAULT '0',
  `secondTotal_present_det` int DEFAULT '0',
  `secondTotal_present_unit` int DEFAULT '0',
  `secondTotal_dues_in` int DEFAULT '0',
  `secondTotal_dues_out` int DEFAULT '0',
  `grandTotal_auth` int DEFAULT '0',
  `grandTotal_hs` int DEFAULT '0',
  `grandTotal_posted_str` int DEFAULT '0',
  `grandTotal_lve` int DEFAULT '0',
  `grandTotal_course` int DEFAULT '0',
  `grandTotal_det` int DEFAULT '0',
  `grandTotal_mh` int DEFAULT '0',
  `grandTotal_sick_lve` int DEFAULT '0',
  `grandTotal_ex` int DEFAULT '0',
  `grandTotal_td` int DEFAULT '0',
  `grandTotal_att` int DEFAULT '0',
  `grandTotal_awl_osl_jc` int DEFAULT '0',
  `grandTotal_trout_det` int DEFAULT '0',
  `grandTotal_present_det` int DEFAULT '0',
  `grandTotal_present_unit` int DEFAULT '0',
  `grandTotal_dues_in` int DEFAULT '0',
  `grandTotal_dues_out` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_company_date` (`company`,`report_date`),
  KEY `idx_company` (`company`),
  KEY `idx_date` (`report_date`),
  KEY `idx_company_date` (`company`,`report_date`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parade_state_daily`
--

LOCK TABLES `parade_state_daily` WRITE;
/*!40000 ALTER TABLE `parade_state_daily` DISABLE KEYS */;
INSERT INTO `parade_state_daily` VALUES (1,'2026-01-14','1 company',171,5,48,3,2,2,2,1,1,1,1,1,36,2,12,1,4,108,1,70,1,3,2,2,2,4,1,3,4,50,2,20,4,7,39,3,17,2,2,1,1,1,1,1,2,1,6,1,11,4,7,36,7,22,3,1,1,1,1,1,1,1,5,8,1,14,2,8,40,3,21,1,1,1,1,2,3,1,1,4,7,1,14,1,5,394,19,178,10,9,7,7,7,10,5,8,15,107,7,71,12,31,62,7,25,1,1,1,1,1,1,1,1,1,17,1,8,1,1,89,5,23,1,2,2,2,2,2,2,1,2,9,2,14,2,2,49,2,13,1,1,1,1,1,1,1,1,1,5,1,8,2,3,50,2,20,1,1,1,1,1,1,2,1,1,11,1,9,5,10,56,2,33,2,1,1,1,2,3,1,1,1,21,1,12,4,7,306,18,114,6,6,6,6,7,8,7,5,6,63,6,51,14,23,700,37,292,16,15,13,13,14,18,12,13,21,170,13,122,26,54,'2026-01-07 06:43:40','2026-01-15 09:58:11'),(6,'2026-01-06','1 company',64,13,57,3,2,8,2,2,2,1,1,1,43,8,14,3,2,41,15,21,2,1,1,1,1,3,2,1,2,8,1,13,4,4,13,4,11,1,1,2,1,1,1,1,1,1,3,2,8,4,1,84,21,30,1,1,2,2,3,4,3,2,1,13,2,17,4,7,73,2,92,4,2,1,5,4,2,2,5,2,66,1,26,6,7,275,55,211,11,7,14,11,11,12,9,10,7,133,14,78,21,21,77,12,61,4,2,7,5,1,1,1,1,3,43,7,18,11,12,97,8,53,4,2,6,1,1,3,2,1,1,38,6,15,4,4,123,11,53,1,4,6,3,2,2,3,1,1,36,6,17,11,10,140,1,79,4,1,8,1,11,2,1,3,1,55,8,24,11,2,142,31,71,10,1,10,6,3,1,1,1,6,42,10,29,14,25,579,63,317,23,10,37,16,18,9,8,7,12,214,37,103,51,53,854,118,528,34,17,51,27,29,21,17,17,19,347,51,181,72,74,'2026-01-07 07:49:14','2026-01-07 08:47:47'),(10,'2026-01-07','1 company',116,7,62,1,1,4,2,2,1,3,1,1,50,4,12,1,4,70,1,48,4,2,1,1,4,4,2,1,3,27,1,21,6,6,94,2,70,2,1,1,1,1,1,1,4,3,56,1,14,4,5,141,18,64,1,1,1,1,1,1,1,3,2,53,1,11,13,13,192,29,79,3,5,2,2,2,2,5,4,8,48,2,31,16,25,613,57,323,11,10,9,7,10,9,12,13,17,234,9,89,40,53,63,9,24,3,1,2,3,1,1,1,3,3,8,2,16,5,4,11,3,35,1,1,1,1,1,1,1,1,1,27,1,8,9,13,51,8,20,2,2,1,1,1,1,3,1,2,7,1,13,6,5,87,13,38,1,1,1,1,3,1,1,1,1,28,1,10,3,2,150,13,99,1,2,1,2,1,1,3,1,4,84,1,15,8,13,362,46,216,8,7,6,8,7,5,9,7,11,62,6,154,31,37,975,103,539,19,17,15,15,17,14,21,20,28,296,15,243,71,90,'2026-01-07 08:52:48','2026-01-12 18:30:00'),(16,'2026-01-11','1 company',37,3,22,1,2,3,3,2,1,1,1,2,13,3,9,5,4,46,12,32,1,3,2,1,2,1,1,1,1,11,2,21,5,3,66,5,22,1,2,3,2,1,1,1,1,1,10,3,12,12,11,39,3,27,1,1,1,1,1,1,1,1,1,8,1,19,1,11,105,14,44,1,1,2,1,1,1,2,1,1,9,2,35,6,11,293,37,147,5,9,11,8,7,5,6,5,6,51,0,96,29,40,52,7,13,2,1,1,1,1,1,1,1,1,9,1,4,8,8,84,7,28,1,1,1,1,1,1,1,1,1,8,1,20,4,9,69,10,20,1,2,3,1,1,1,2,1,1,10,3,10,1,1,86,1,31,1,1,1,2,1,3,1,1,1,11,1,20,3,11,61,7,32,1,1,1,1,2,1,1,1,2,10,1,22,1,1,352,32,124,6,6,7,6,6,7,6,5,6,48,0,76,17,30,645,69,271,11,15,18,14,13,12,12,10,12,99,0,172,46,70,'2026-01-08 05:34:07','2026-01-11 10:29:40'),(17,'2026-01-11','2 Company',37,2,17,2,2,1,1,1,1,1,1,1,10,1,7,3,4,44,1,32,1,1,1,2,1,1,1,1,1,9,1,23,9,12,64,1,34,1,1,1,1,1,1,1,2,1,9,1,25,1,1,100,21,55,1,1,1,1,2,2,2,1,1,11,1,44,11,10,145,12,56,2,1,4,1,2,1,1,2,3,13,4,43,14,16,390,37,194,7,6,8,6,7,6,6,7,7,52,0,142,38,43,55,10,26,1,2,1,1,1,1,1,1,1,9,1,17,11,10,148,18,44,1,1,2,1,1,1,2,3,1,11,2,33,11,22,188,14,56,1,2,3,1,5,1,2,1,1,14,3,42,11,8,122,24,86,1,1,1,1,1,1,1,1,1,8,1,78,11,1,111,14,42,1,2,1,2,15,1,1,1,1,24,1,18,11,11,624,80,254,5,8,8,6,23,5,7,7,5,66,0,188,55,52,1014,117,448,12,14,16,12,30,11,13,14,12,118,0,330,93,95,'2026-01-08 07:03:30','2026-01-11 10:30:22'),(18,'2026-01-11','3 Company',100,2,14,1,1,1,1,1,1,1,1,1,8,1,6,4,9,45,5,23,1,1,1,0,1,1,1,1,1,7,1,16,11,7,88,14,25,1,2,1,4,1,1,1,1,1,12,1,13,6,2,58,14,22,2,1,2,1,1,1,1,1,1,9,2,13,11,8,98,24,45,1,1,2,11,1,1,1,1,1,18,2,27,1,11,389,59,129,6,6,7,17,5,5,5,5,5,54,0,75,33,37,88,14,25,1,1,1,1,1,1,1,1,1,8,1,17,11,8,44,8,14,1,1,1,1,1,1,1,1,1,8,1,6,12,1,42,1,29,1,1,3,1,1,1,1,1,1,8,3,21,1,1,45,4,12,1,1,1,1,1,1,1,1,1,8,1,4,11,1,54,14,24,1,1,2,1,1,1,1,1,1,8,2,16,9,21,273,41,104,5,5,8,5,5,5,5,5,5,40,0,64,44,32,662,100,233,11,11,15,22,10,10,10,10,10,94,0,139,77,69,'2026-01-08 07:12:52','2026-01-11 10:30:25'),(20,'2026-01-11','4 Company',55,11,22,1,1,1,1,1,1,1,1,1,8,1,14,11,1,111,22,24,1,1,1,1,1,1,1,1,1,8,1,16,1,20,25,2,11,1,1,1,1,1,1,1,1,1,8,1,3,11,11,88,24,34,1,1,1,1,1,1,1,1,1,8,1,26,1,1,88,20,18,1,1,1,1,1,1,1,1,1,8,1,10,11,1,367,79,109,5,5,5,5,5,5,5,5,5,40,0,69,35,34,88,24,12,1,1,1,1,1,1,1,1,1,8,1,4,11,14,154,21,24,1,1,1,1,1,1,1,1,1,8,1,16,1,1,88,11,22,1,1,1,1,1,1,1,1,1,8,1,14,11,1,45,12,24,1,1,1,1,1,1,1,1,1,8,1,16,1,5,58,1,22,1,1,1,1,1,11,1,1,1,18,1,4,11,24,433,69,104,5,5,5,5,5,15,5,5,5,50,0,54,35,45,800,148,213,10,10,10,10,10,20,10,10,10,90,0,123,70,79,'2026-01-08 07:37:46','2026-01-11 10:30:28'),(21,'2026-01-10','1 company',44,14,15,1,1,3,1,1,1,1,1,1,8,3,7,11,1,88,14,25,1,1,1,0,1,1,1,1,1,7,1,18,1,5,94,14,36,1,2,1,2,1,1,1,1,1,10,1,26,1,5,25,1,20,1,1,1,1,1,1,1,1,1,8,1,12,1,1,125,14,28,1,1,1,1,1,1,1,1,1,8,1,20,1,1,376,57,124,5,6,7,5,5,5,5,5,5,41,7,83,15,13,66,12,27,1,1,5,1,1,1,1,1,1,8,5,19,5,4,48,14,26,1,1,1,1,1,0,1,1,1,7,1,19,1,1,55,14,28,1,1,2,1,1,1,1,1,1,8,2,20,11,1,88,1,34,1,1,1,1,1,1,1,1,1,8,1,26,11,1,108,14,28,1,1,1,0,1,1,1,0,1,6,1,22,1,1,365,55,143,5,5,10,4,5,4,5,4,5,37,10,106,29,8,741,112,267,10,11,17,9,10,9,10,9,10,78,17,189,44,21,'2026-01-10 17:07:15','2026-01-10 17:20:08');
/*!40000 ALTER TABLE `parade_state_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel`
--

DROP TABLE IF EXISTS `personnel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personnel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `army_number` varchar(100) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL,
  `trade` varchar(100) DEFAULT NULL,
  `date_of_enrollment` date NOT NULL,
  `date_of_birth` date NOT NULL,
  `date_of_tos` date DEFAULT NULL,
  `date_of_tors` date DEFAULT NULL,
  `blood_group` varchar(10) DEFAULT NULL,
  `religion` varchar(100) DEFAULT NULL,
  `food_preference` varchar(50) DEFAULT NULL,
  `drinker` varchar(10) DEFAULT NULL,
  `civ_qualifications` text,
  `decoration_awards` text,
  `lacking_qualifications` text,
  `willing_promotions` varchar(10) DEFAULT NULL,
  `i_card_no` varchar(100) DEFAULT NULL,
  `i_card_date` date DEFAULT NULL,
  `i_card_issued_by` varchar(255) DEFAULT NULL,
  `bpet_grading` varchar(50) DEFAULT NULL,
  `ppt_grading` varchar(50) DEFAULT NULL,
  `bpet_date` date DEFAULT NULL,
  `clothing_card` varchar(10) DEFAULT NULL,
  `pan_card_no` varchar(50) DEFAULT NULL,
  `pan_part_ii` varchar(100) DEFAULT NULL,
  `aadhar_card_no` varchar(20) DEFAULT NULL,
  `aadhar_part_ii` varchar(100) DEFAULT NULL,
  `joint_account_no` varchar(100) DEFAULT NULL,
  `joint_account_bank` varchar(255) DEFAULT NULL,
  `joint_account_ifsc` varchar(20) DEFAULT NULL,
  `home_house_no` varchar(255) DEFAULT NULL,
  `home_village` varchar(255) DEFAULT NULL,
  `home_phone` varchar(50) DEFAULT NULL,
  `home_to` varchar(255) DEFAULT NULL,
  `home_po` varchar(255) DEFAULT NULL,
  `home_ps` varchar(255) DEFAULT NULL,
  `home_teh` varchar(255) DEFAULT NULL,
  `home_nrs` varchar(255) DEFAULT NULL,
  `home_nmh` varchar(255) DEFAULT NULL,
  `home_district` varchar(255) DEFAULT NULL,
  `home_state` varchar(255) DEFAULT NULL,
  `border_area` varchar(50) DEFAULT NULL,
  `distance_from_ib` decimal(10,2) DEFAULT NULL,
  `height` decimal(10,2) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `chest` decimal(10,2) DEFAULT NULL,
  `identification_marks` varchar(255) DEFAULT NULL,
  `court_cases` text,
  `loan` varchar(50) DEFAULT NULL,
  `total_leaves_encashed` int DEFAULT NULL,
  `participation_activities` text,
  `present_family_location` text,
  `prior_station` varchar(50) DEFAULT NULL,
  `prior_station_date` date DEFAULT NULL,
  `worked_it` varchar(50) DEFAULT NULL,
  `worked_unit_tenure` varchar(255) DEFAULT NULL,
  `med_cat` varchar(50) DEFAULT NULL,
  `last_recat_bd_date` date DEFAULT NULL,
  `last_recat_bd_at` varchar(255) DEFAULT NULL,
  `next_recat_due` date DEFAULT NULL,
  `medical_problem` text,
  `restrictions` text,
  `computer_knowledge` varchar(50) DEFAULT NULL,
  `it_literature` varchar(50) DEFAULT NULL,
  `kin_name` varchar(255) DEFAULT NULL,
  `kin_relation` varchar(100) DEFAULT NULL,
  `kin_marriage_date` date DEFAULT NULL,
  `kin_account_no` varchar(100) DEFAULT NULL,
  `kin_bank` varchar(255) DEFAULT NULL,
  `kin_ifsc` varchar(20) DEFAULT NULL,
  `kin_part_ii` varchar(100) DEFAULT NULL,
  `vehicle_reg_no` varchar(100) DEFAULT NULL,
  `vehicle_model` varchar(255) DEFAULT NULL,
  `vehicle_purchase_date` date DEFAULT NULL,
  `vehicle_agif` varchar(50) DEFAULT NULL,
  `driving_license_no` varchar(100) DEFAULT NULL,
  `license_issue_date` date DEFAULT NULL,
  `license_expiry_date` date DEFAULT NULL,
  `disability_child` varchar(50) DEFAULT NULL,
  `marital_discord` varchar(50) DEFAULT NULL,
  `counselling` text,
  `folder_prepared_on` date DEFAULT NULL,
  `folder_checked_by` varchar(255) DEFAULT NULL,
  `bring_family` varchar(50) DEFAULT NULL,
  `domestic_issues` text,
  `other_requests` text,
  `family_medical_issues` text,
  `quality_points` text,
  `strengths` text,
  `weaknesses` text,
  `detailed_course` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `company` varchar(100) DEFAULT NULL,
  `onleave_status` tinyint(1) DEFAULT '0',
  `detachment_status` tinyint(1) DEFAULT '0',
  `posting_status` tinyint(1) DEFAULT '0',
  `personnel_status` varchar(110) DEFAULT NULL,
  `personnel_remarks` varchar(100) DEFAULT NULL,
  `td_status` tinyint(1) DEFAULT '0',
  `interview_status` tinyint(1) DEFAULT '0',
  `batch` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `army_number` (`army_number`),
  KEY `idx_personnel_army_number` (`army_number`),
  KEY `idx_personnel_name` (`name`),
  KEY `idx_personnel_rank` (`rank`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personnel`
--

LOCK TABLES `personnel` WRITE;
/*!40000 ALTER TABLE `personnel` DISABLE KEYS */;
INSERT INTO `personnel` VALUES (1,'ABC','778G','JCO','Infantry','2010-05-15','1985-03-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-23 07:27:16','2026-01-14 08:13:29','1 Company',0,0,0,NULL,NULL,NULL,0,NULL),(2,'Srivastav','156WE','Agniveer','Infantry','2010-05-15','2002-03-20','2015-01-10','2020-06-01','O+','Muslim','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 05:56:59','2026-01-14 08:07:29','1 Company',0,0,0,NULL,NULL,NULL,0,NULL),(3,'Vivek','1526WE','JCO','Infantry','2010-05-15','2001-03-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 05:57:55','2026-01-15 05:49:34','2 Company',0,0,0,NULL,NULL,NULL,0,NULL),(4,'Gugar','9926WE','JCO','Infantry','2010-05-15','1994-03-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 05:58:25','2026-01-14 10:31:35','4 Company',0,0,1,'det','5',1,0,NULL),(5,'Abishek','99226WE','JCO','Infantry','2010-05-15','1960-03-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:00:05','2026-01-14 07:43:37','3 Company',0,0,1,NULL,NULL,NULL,0,NULL),(6,'Raju','966WE','JCO','Infantry','2010-05-15','1986-09-20','2015-01-10','2020-06-01','O+','Muslim','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:03:59','2026-01-14 07:18:55','3 Company',0,0,1,NULL,NULL,NULL,0,NULL),(7,'Rohit','87CESR','Agniveer','Infantry','2010-05-15','1989-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:04:31','2026-01-15 08:35:55','3 Company',0,0,0,NULL,NULL,NULL,0,NULL),(8,'Prateeq','997CESR','JCO','Infantry','2010-05-15','1967-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:05:21','2026-01-14 07:18:55','3 Company',0,0,0,NULL,NULL,NULL,0,NULL),(10,'Rahul','965CESR','Signal Man','Infantry','2010-05-15','1987-09-20','2015-01-10','2020-06-01','O+','Hindu','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:06:06','2026-01-14 07:18:55','2 Company',0,0,0,NULL,NULL,NULL,0,NULL),(12,'Hardik','905CESR','Signal Man','Infantry','2010-05-15','1997-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:06:35','2026-01-15 05:49:34','2 Company',0,0,1,NULL,NULL,1,0,NULL),(13,'Kurnal','9085CESR','Signal Man','Infantry','2010-05-15','1989-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:07:05','2026-01-14 07:18:55','2 Company',0,1,0,NULL,NULL,NULL,0,NULL),(14,'Gill','25CESR','OC','Infantry','2010-05-15','1987-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:07:40','2026-01-14 07:18:55','2 Company',0,0,0,NULL,NULL,NULL,0,NULL),(15,'Raju','165CESR','OC','Infantry','2010-05-15','1987-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:08:03','2026-01-14 08:07:29','1 Company',0,0,0,NULL,NULL,NULL,0,NULL),(16,'ABC','775CESR','Subedar','Infantry','2010-05-15','1999-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:18:15','2026-01-14 08:07:29','1 Company',0,0,1,NULL,NULL,NULL,0,NULL),(17,'ABC','984CESR','Subedar','Infantry','2010-05-15','1979-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:18:42','2025-12-16 01:30:10','1 Company',0,1,0,NULL,NULL,NULL,0,NULL),(18,'Aijaz','994CESR','JCO','Infantry','2010-05-15','1990-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 06:19:13','2025-12-16 01:31:08','1 Company',0,0,1,NULL,NULL,NULL,0,NULL),(19,'Aijaz','99999CESR','Subedar','Infantry','2010-05-15','1990-09-20','2015-01-10','2020-06-01','O+','Christian','Non-Vegetarian','No','BSc Computer Science','Gallantry Award 2018','Advanced Leadership Course','Yes','IC-45678','2020-01-01','Unit HQ','A','B+','2025-09-01','Yes','ABCDE1234F','P-II/2020/001','123456789012','P-II/2021/002','1234567890','State Bank of India','SBIN0001234','House 5, Lane 2','Greenville','+91-9876543210','Central Tehsil','Greenville PO','Greenville PS','Green Tehsil','NRS-001','NMH-002','Green District','Greenland','Yes',5.50,175.50,75.00,85.00,'Scar on left arm','None','Yes',30,'Sports and Drama','Delhi','Yes','2024-01-01','No','N/A','Yes','2024-06-15','Military Hospital','2026-06-15','Mild Asthma','No heavy lifting','Excellent','Good','Jane Doe','Spouse','2012-07-20','0987654321','HDFC Bank','HDFC0005678','P-II/2012/003','DL01AB1234','Toyota Innova','2020-03-10','Yes','DL-56789','2020-01-01','2030-01-01','No','No','Attended in 2023','2025-10-01','Sgt. Smith','Yes','None','Transfer to hometown','None','Improve mess facilities, gym upgrade, family quarters','Leadership, teamwork, discipline','Public speaking','No','2025-10-27 09:44:27','2025-11-25 01:47:34','4 Company',0,0,0,NULL,NULL,NULL,0,NULL),(20,'John Doe','AN10001','JCO','Infantry','2010-06-15','1985-03-12','2010-06-15','2015-06-15','O+','Christian','Non-Veg','No','MBA','Medal of Honor','None','Yes','IC1001','2010-07-01','HQ Alpha','A','B','2011-06-01','Yes','PAN12345','PartII1','AADHAR12345','PartIIA1','AC123','Bank A','IFSC001','12','Village A','1234567890','To City','PO1','PS1','Teh1','NRS1','NMH1','District1','State1','No',25.50,180.50,75.00,95.00,'Scar on right hand','None','No',10,'Football','City1','Yes','2012-05-01','Yes','Unit A','A','2018-06-01','HQ Bravo','2023-06-01','None','None','Advanced','Intermediate','Jane Doe','Spouse','2010-08-15','AC987','Bank B','IFSC002','PartIIB1','MH123','Honda Civic','2015-01-20','Yes','DL12345','2015-01-01','2025-01-01','No','No','None','2015-06-10','Officer X','Yes','None','None','None','Excellent','Leadership','Time management','Yes','2025-12-02 07:47:16','2025-12-02 07:51:50','1 Company',0,0,0,'Active','Fit for service',0,0,NULL),(21,'Alice Smith','AN10002','Lieutenant','Signals','2012-04-10','1988-07-23','2012-04-10','2017-04-10','A+','Hindu','Veg','No','B.Tech','Service Medal','None','Yes','IC1002','2012-05-01','HQ Beta','B','A','2013-04-10','No','PAN12346','PartII2','AADHAR12346','PartIIA2','AC124','Bank B','IFSC002','34','Village B','0987654321','To Town','PO2','PS2','Teh2','NRS2','NMH2','District2','State2','Yes',15.00,165.00,60.00,88.00,'Mole on left cheek','None','No',8,'Cricket','City2','No','2013-05-01','No','Unit B','B','2019-07-01','HQ Gamma','2024-07-01','Asthma','No running','Intermediate','Basic','Bob Smith','Father','1980-02-12','AC988','Bank C','IFSC003','PartIIB2','MH124','Toyota Corolla','2016-02-15','No','DL12346','2016-02-01','2026-02-01','No','No','Counselling done','2016-04-10','Officer Y','No','None','Special request','None','Good','Problem solving','Patience','Yes','2025-12-02 07:47:16','2025-12-02 07:47:16','2 Company',0,0,0,'Active','Fit for service',0,0,NULL),(22,'Robert Johnson','AN10003','Major','Artillery','2008-01-20','1980-11-02','2008-01-20','2013-01-20','B+','Muslim','Non-Veg','Yes','PhD','Gallantry Medal','None','Yes','IC1003','2008-02-10','HQ Charlie','A','B','2009-01-20','Yes','PAN12347','PartII3','AADHAR12347','PartIIA3','AC125','Bank C','IFSC003','56','Village C','1122334455','To City','PO3','PS3','Teh3','NRS3','NMH3','District3','State3','No',30.00,170.00,68.00,92.00,'Tattoo on arm','None','Yes',12,'Basketball','City3','Yes','2010-01-15','Yes','Unit C','B','2017-03-01','HQ Delta','2023-03-01','None','None','Advanced','Advanced','Alice Johnson','Mother','1982-09-20','AC989','Bank D','IFSC004','PartIIB3','MH125','Ford Fiesta','2014-05-10','Yes','DL12347','2014-05-01','2024-05-01','No','No','None','2014-06-20','Officer Z','Yes','None','None','None','Excellent','Strategic thinking','Delegation','No','2025-12-02 07:47:16','2025-12-16 01:31:53','3 Company',0,0,1,'Active','Fit for service',0,0,NULL),(23,'Emma Williams','AN10004','Captain','Signals','2011-09-12','1987-05-14','2011-09-12','2016-09-12','O-','Hindu','Veg','No','MCA','Service Medal','None','Yes','IC1004','2011-10-01','HQ Delta','B','C','2012-09-12','Yes','PAN12348','PartII4','AADHAR12348','PartIIA4','AC126','Bank D','IFSC004','78','Village D','2233445566','To City','PO4','PS4','Teh4','NRS4','NMH4','District4','State4','No',20.00,172.00,70.00,90.00,'Scar on forehead','None','No',9,'Tennis','City4','No','2012-08-01','Yes','Unit D','A','2018-05-01','HQ Echo','2023-05-01','None','No heavy lifting','Intermediate','Intermediate','William Williams','Father','1985-03-10','AC990','Bank E','IFSC005','PartIIB4','MH126','Hyundai Elantra','2017-07-20','Yes','DL12348','2017-07-01','2027-07-01','No','No','None','2017-08-10','Officer A','Yes','None','None','None','Good','Communication','Teamwork','Yes','2025-12-02 07:47:16','2025-12-02 07:47:16','4 Company',0,0,0,'Active','Fit for service',0,0,NULL),(24,'Michael Brown','AN10005','Lieutenant','Infantry','2013-03-11','1990-12-20','2013-03-11','2018-03-11','AB+','Sikh','Non-Veg','No','B.Sc','Medal of Valor','None','Yes','IC1005','2013-04-01','HQ Echo','C','A','2014-03-11','No','PAN12349','PartII5','AADHAR12349','PartIIA5','AC127','Bank E','IFSC005','90','Village E','3344556677','To Town','PO5','PS5','Teh5','NRS5','NMH5','District5','State5','Yes',18.50,168.00,65.00,89.00,'Birthmark on arm','None','No',7,'Volleyball','City5','Yes','2015-02-01','No','Unit E','B','2020-04-01','HQ Foxtrot','2024-04-01','Diabetes','No sugar diet','Basic','Basic','Sarah Brown','Spouse','2012-06-15','AC991','Bank F','IFSC006','PartIIB5','MH127','Kia Sportage','2018-03-10','No','DL12349','2018-03-01','2028-03-01','No','No','None','2018-05-10','Officer B','No','None','None','None','Good','Planning','Problem solving','No','2025-12-02 07:47:16','2025-12-02 07:47:16','1 Company',0,0,0,'Active','Fit for service',0,0,NULL),(25,'John Doe','123456','Captain','Infantry','2015-06-01','1990-05-15','2016-01-01','2020-12-31','O+','Christianity','Vegetarian','No','Bachelor in Science','Medal of Honor','Advanced Tactics','Yes','IC123456','2016-06-01','Admin Office','A','B','2023-01-01','CC123','PAN123456','P2','AADHAR1234','AP2','JA123456','State Bank','SBIN0001234','12B','VillageName','0123456789','LocalTO','PO123','PS123','TehsilName','NRS123','NMH123','DistrictName','StateName','None',10.50,175.50,70.20,95.00,'Mole on right cheek','None','Loan',5,'Sports and Volunteering','CityName','Station ABC','2019-12-01','Yes','2 years','A','2022-06-01','Unit HQ','2025-06-01','None','None','Basic','Intermediate','Jane Doe','Spouse','2014-05-01','KA123456','State Bank','SBIN0005678','KP2','ABC1234','Toyota Corolla','2018-05-01','Yes','DL123456','2015-06-01','2025-06-01','None','None','Completed','2023-01-01','Admin Officer','Yes','None','None','None','Leadership, Teamwork','Discipline, Planning','Impatience','Advanced Combat Training','2025-12-11 09:32:16','2025-12-11 09:32:16','1 Company',0,0,0,NULL,NULL,0,0,NULL),(26,'Rajesh Kumar Singh','14951234A','Agniveer','Operator Radio','2023-06-15','2003-04-12','2024-01-10',NULL,'O+','Hindu','Vegetarian','No','12th Pass (Science), Diploma in Computer Applications','Best Recruit Award',NULL,'Yes','IC-123456','2023-07-01','Unit Adjutant','A','Excellent','2025-03-20','Yes','ABCDE1234F','Part-II/2023/45','123456789012','Part-II/2023/46','123456789012','State Bank of India','SBIN0001234','H.No. 45, Near Temple','Rampur','9876543210','Tehsil Office Rampur','Post Office Rampur','PS Rampur','Tehsil Rampur','Nearest Railway Station - Moradabad','Nearest Military Hospital - Bareilly','Rampur','Uttar Pradesh','No',NULL,172.50,68.50,86.00,'Mole on left cheek',NULL,'No',15,'Unit football team member','Family staying in native village','No',NULL,'No',NULL,'No',NULL,NULL,NULL,NULL,NULL,'Excellent','Excellent','Smt. Sunita Devi','Mother',NULL,'987654321098','Punjab National Bank','PUNB0123456','Part-II/2023/47',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'No','No','Counselling done on 10 Jan 2025 by RT JCO - No issues','2026-01-15','Capt Rahul Sharma','No',NULL,NULL,NULL,'1. Improve sports facilities\n2. Better internet connectivity\n3. Regular health camps\n4. Yoga sessions\n5. Skill development courses','Disciplined, physically fit, quick learner, team player','Sometimes over-enthusiastic, working on patience','No','2026-01-15 09:07:30','2026-01-15 09:07:30','1 Company',0,0,0,NULL,NULL,0,0,'Batch 1'),(27,'Amit Yadav','14952345B','Agniveer','Technician','2024-01-20','2004-09-18',NULL,NULL,'B+','Hindu','Non-Vegetarian','No','10th Pass, ITI in Electrician',NULL,'Driving License','Yes','IC-789012','2024-02-05','Adjutant','B','Good','2025-08-10','Yes','FGHIJ5678K','Part-II/2024/112','987654321098','Part-II/2024/113','345678901234','HDFC Bank','HDFC0001234','Village House No. 123','Kheri Kalan','+91-9876543210','Faridabad','Kheri PO','PS Faridabad','Ballabgarh','Faridabad Railway Station','MH Ambala','Faridabad','Haryana','No',NULL,170.00,65.00,84.00,'Scar on right forearm',NULL,'Yes',0,'Volleyball team','Family in village','No',NULL,'No',NULL,'No',NULL,NULL,NULL,NULL,NULL,'Poor','Poor','Smt. Rekha Yadav','Mother',NULL,'567890123456','SBI','SBIN0005678','Part-II/2024/114',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'No','No',NULL,'2026-01-10','Maj Vikram Singh','Yes',NULL,'Request for computer training',NULL,'1. More sports events\n2. Better mess food variety\n3. Night study room\n4. Library upgrade\n5. Gym equipment','Hardworking, punctual, good in technical work','Needs improvement in communication','No','2026-01-15 09:10:10','2026-01-15 09:10:10','3 Company',0,0,0,NULL,NULL,0,0,'Batch 2'),(28,'Vikram Singh Rathore','14951111X','Agniveer','Clerk','2023-07-01','2003-11-25','2024-02-15',NULL,'A+','Hindu','Vegetarian','No','B.Com (Pursuing)','Best in Clerical Duties',NULL,'Yes','IC-456789','2023-08-01','Unit HQ','C','Average','2025-06-20','Yes','KLMNO9012P','Part-II/2023/201','456789123012','Part-II/2023/202','901234567890','Punjab National Bank','PUNB0456789','Rajput Mohalla','Bikaner','8765432109','Bikaner','Bikaner HO','Kotwali PS','Bikaner','Bikaner Junction','MH Jodhpur','Bikaner','Rajasthan','Yes',45.00,175.00,72.00,88.00,'Tattoo on right arm',NULL,'No',20,NULL,'MD Accn required','Yes','2024-02-15','Yes','NFS Section - 6 months','Yes','2025-05-10','MH Jodhpur','2026-05-10','Lower back pain (L4-L5 disc issue)','Avoid heavy physical exertion','Excellent','Excellent','Smt. Kamla Devi','Mother',NULL,NULL,NULL,NULL,NULL,'RJ07AB1234','Hero Splendor','2024-10-01','Yes','RJ0720230001234','2023-12-01','2043-12-01','No','No','Regular counselling done','2026-01-12','Capt Ajay Singh','Yes',NULL,NULL,'Father has hypertension','1. Better medical facilities\n2. Faster internet\n3. More clerical training\n4. Family welfare programs\n5. Canteen improvement','Excellent in admin work, computer proficient','Physical fitness needs improvement','No','2026-01-15 09:10:29','2026-01-15 09:10:29','2 Company',0,0,0,NULL,NULL,0,0,'Batch 1'),(29,'Rahul Sharma','14953456C','Agniveer','General Duty','2024-12-01','2005-03-05',NULL,NULL,'O-','Hindu','Vegetarian','No','12th Pass',NULL,NULL,'Yes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'345678901234',NULL,NULL,NULL,NULL,'House No. 56','Dehradun','7654321098','Dehradun','Dehradun Cantt','Cantt PS','Dehradun','Dehradun','MH Dehradun','Dehradun','Uttarakhand','No',NULL,168.00,62.00,82.00,NULL,NULL,'No',0,NULL,NULL,'No',NULL,'No',NULL,'No',NULL,NULL,NULL,NULL,NULL,'Poor','Poor','Shri Anil Sharma','Father',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'No','No',NULL,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,NULL,'No','2026-01-15 09:10:45','2026-01-15 09:10:45','4 Company',0,0,0,NULL,NULL,0,0,'Batch 2');
/*!40000 ALTER TABLE `personnel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personnel_sports`
--

DROP TABLE IF EXISTS `personnel_sports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personnel_sports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(50) NOT NULL,
  `sport_type` varchar(50) NOT NULL,
  `sport_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personnel_sports`
--

LOCK TABLES `personnel_sports` WRITE;
/*!40000 ALTER TABLE `personnel_sports` DISABLE KEYS */;
INSERT INTO `personnel_sports` VALUES (1,1,'ARMY001','Football','Football','2025-11-28 15:08:37'),(2,1,'ARMY001','Cricket','Cricket','2025-11-28 15:08:37'),(3,2,'ARMY002','Basketball','Basketball','2025-11-28 15:08:37'),(4,2,'ARMY002','Other','Table Tennis','2025-11-28 15:08:37'),(5,3,'ARMY003','Athletics','Athletics','2025-11-28 15:08:37'),(6,3,'ARMY003','Other','Badminton','2025-11-28 15:08:37'),(7,4,'ARMY004','Swimming','Swimming','2025-11-28 15:08:37'),(8,5,'ARMY005','Other','Volleyball','2025-11-28 15:08:37'),(9,5,'ARMY005','Other','Hockey','2025-11-28 15:08:37'),(10,11,'ARMY001545','Football','Football','2025-11-28 15:09:27'),(11,26,'14951234A','Football','Football','2026-01-15 09:07:30'),(12,26,'14951234A','Volleyball','Volleyball','2026-01-15 09:07:30'),(13,26,'14951234A','Other','Cricket','2026-01-15 09:07:30'),(14,26,'14951234A','Other','Athletics','2026-01-15 09:07:30'),(15,27,'14952345B','Volleyball','Volleyball','2026-01-15 09:10:10'),(16,27,'14952345B','Handball','Handball','2026-01-15 09:10:10'),(17,27,'14952345B','Other','Kabaddi','2026-01-15 09:10:10'),(18,27,'14952345B','Other','Boxing','2026-01-15 09:10:10'),(19,28,'14951111X','Basketball','Basketball','2026-01-15 09:10:29'),(20,28,'14951111X','Other','Chess','2026-01-15 09:10:29'),(21,28,'14951111X','Other','Carrom','2026-01-15 09:10:29');
/*!40000 ALTER TABLE `personnel_sports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posting_details_table`
--

DROP TABLE IF EXISTS `posting_details_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posting_details_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `army_number` varchar(15) NOT NULL,
  `action_type` varchar(10) NOT NULL,
  `posting_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `army_number` (`army_number`),
  CONSTRAINT `posting_details_table_ibfk_1` FOREIGN KEY (`army_number`) REFERENCES `personnel` (`army_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posting_details_table`
--

LOCK TABLES `posting_details_table` WRITE;
/*!40000 ALTER TABLE `posting_details_table` DISABLE KEYS */;
INSERT INTO `posting_details_table` VALUES (1,'966WE','P2','2025-11-26 03:12:21'),(2,'9926WE','1','2025-12-01 12:26:04'),(3,'905CESR','P3','2025-12-01 13:06:08'),(4,'99226WE','P1','2025-12-01 15:22:55'),(5,'994CESR','P3','2025-12-16 07:01:08'),(6,'AN10003','P3','2025-12-16 07:01:53');
/*!40000 ALTER TABLE `posting_details_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_heads`
--

DROP TABLE IF EXISTS `project_heads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_heads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `head_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `head_name` (`head_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_heads`
--

LOCK TABLES `project_heads` WRITE;
/*!40000 ALTER TABLE `project_heads` DISABLE KEYS */;
INSERT INTO `project_heads` VALUES (1,'PTPT','2026-01-07 07:46:01'),(3,'IT','2026-01-07 07:50:40'),(4,'TT&IE','2026-01-07 10:43:58');
/*!40000 ALTER TABLE `project_heads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `project_id` int NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) NOT NULL,
  `current_stage` varchar(255) DEFAULT NULL,
  `project_cost` decimal(10,2) DEFAULT NULL,
  `project_items` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `project_description` text,
  `created_on` datetime DEFAULT CURRENT_TIMESTAMP,
  `head` varchar(100) NOT NULL,
  `company` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'COMPUTER LAB','PPP',8900.00,'\"Laptops\"',767,'WE ARE RECIEVED ','2026-01-07 13:23:09','IT','Admin'),(2,'Test','PPP',4500000.00,'\"ABC, XYZ\"',8,'abc','2026-01-08 00:40:13','PTPT','1 company');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `punishments`
--

DROP TABLE IF EXISTS `punishments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `punishments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `punishment_date` date DEFAULT NULL,
  `punishment` varchar(255) DEFAULT NULL,
  `aa_sec` varchar(100) DEFAULT NULL,
  `remarks` text,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_punishments` (`personnel_id`),
  CONSTRAINT `punishments_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `punishments`
--

LOCK TABLES `punishments` WRITE;
/*!40000 ALTER TABLE `punishments` DISABLE KEYS */;
INSERT INTO `punishments` VALUES (1,1,'778G',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(2,2,'156WE',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(3,3,'1526WE',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(4,4,'9926WE',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(5,5,'99226WE',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(6,6,'966WE',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(7,7,'87CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(8,8,'997CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(9,10,'965CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(10,12,'905CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(11,13,'9085CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(12,14,'25CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(13,15,'165CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(14,16,'775CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(15,17,'984CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(16,18,'994CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(17,19,'99999CESR',1,'2018-02-10','Red Ink','Section 39','Minor infraction'),(18,25,'123456',1,'2017-05-01','Warning','AA-1','Minor offense'),(19,27,'14952345B',1,'2025-03-15','Black','39(a)','Late reporting');
/*!40000 ALTER TABLE `punishments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roll_call_points`
--

DROP TABLE IF EXISTS `roll_call_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roll_call_points` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(20) NOT NULL,
  `point_title` varchar(100) NOT NULL,
  `point_description` text NOT NULL,
  `army_number` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roll_call_points`
--

LOCK TABLES `roll_call_points` WRITE;
/*!40000 ALTER TABLE `roll_call_points` DISABLE KEYS */;
INSERT INTO `roll_call_points` VALUES (1,'OR_REQUEST','Medical Assistance','I NEED MEDICAL ASSISTANCE','778G','2026-01-10 08:35:19','PENDING'),(2,'OR_REQUEST','Equipment Requirement','i dont have Equipments','156WE','2026-01-10 09:09:40','APPROVED'),(3,'SM_SUGGESTION','Training Improvement','focus on traing. avoide MT accidents ,',NULL,'2026-01-10 10:38:53','SUGGESTED');
/*!40000 ALTER TABLE `roll_call_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `liquor_sale` int NOT NULL,
  `grocery_sale` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'2025-01-01',18000,12000),(2,'2025-01-02',17500,11800),(3,'2025-01-03',22000,13500),(4,'2025-01-04',24500,14200),(5,'2025-01-05',21000,12800),(6,'2025-01-06',16500,11000),(7,'2025-01-07',17000,11500),(8,'2025-01-08',22500,13000),(9,'2025-01-09',24000,14500),(10,'2025-01-10',26000,15000),(11,'2025-01-11',19500,12200),(12,'2025-01-12',20500,12500),(13,'2025-01-13',23000,13800),(14,'2025-01-14',25000,14000),(15,'2025-01-15',27000,15500),(16,'2025-01-16',17500,11800),(17,'2025-01-17',18500,12300),(18,'2025-01-18',23500,13700),(19,'2025-01-19',25500,14900),(20,'2025-01-20',26500,15200),(21,'2025-01-21',19000,12100),(22,'2025-01-22',20000,12600),(23,'2025-01-23',24000,13500),(24,'2025-01-24',26000,14800),(25,'2025-01-25',27500,15800),(26,'2025-01-26',18500,12000),(27,'2025-01-27',19500,12500),(28,'2025-01-28',24500,14000),(29,'2025-01-29',26500,15000),(30,'2025-01-30',28000,16000);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensitive_marking`
--

DROP TABLE IF EXISTS `sensitive_marking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensitive_marking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `army_number` varchar(100) DEFAULT NULL,
  `reason` text,
  `marked_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensitive_marking`
--

LOCK TABLES `sensitive_marking` WRITE;
/*!40000 ALTER TABLE `sensitive_marking` DISABLE KEYS */;
INSERT INTO `sensitive_marking` VALUES (17,'1526WE','INDICPILINE','2026-01-05 15:21:09'),(18,'9926WE','This person is not hygienic','2026-01-06 12:56:06'),(19,'778G','online gamming','2026-01-07 14:53:03'),(20,'AN10005','mentally disorder','2026-01-08 19:59:38');
/*!40000 ALTER TABLE `sensitive_marking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_items`
--

DROP TABLE IF EXISTS `store_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `store_id` int DEFAULT NULL,
  `qlp_no` varchar(50) DEFAULT NULL,
  `slp_no` varchar(50) DEFAULT NULL,
  `nomenclature` varchar(200) DEFAULT NULL,
  `au` varchar(20) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `store_id` (`store_id`),
  CONSTRAINT `store_items_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_items`
--

LOCK TABLES `store_items` WRITE;
/*!40000 ALTER TABLE `store_items` DISABLE KEYS */;
INSERT INTO `store_items` VALUES (3,7,NULL,NULL,'XYZ','nos',10);
/*!40000 ALTER TABLE `store_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  `store_name` varchar(100) NOT NULL,
  `place` varchar(100) DEFAULT NULL,
  `incharge_name` varchar(100) DEFAULT NULL,
  `total_items` int DEFAULT '0',
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES (7,'ST1','Dighi',NULL,0);
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_name` varchar(200) NOT NULL,
  `description` text,
  `priority` varchar(10) DEFAULT 'medium',
  `assigned_to` varchar(255) DEFAULT NULL,
  `assigned_by` varchar(255) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `task_status` varchar(40) DEFAULT 'Pending',
  `remarks` varchar(100) DEFAULT 'No Remarks',
  `range_status` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `tasks_chk_1` CHECK ((`priority` in (_utf8mb4'low',_utf8mb4'medium',_utf8mb4'high',_utf8mb4'urgent')))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (9,'Prepare Monthly Report','Compile all financial data for the monthly performance report and submit it to management.\nCompile all financial data for the monthly performance report and submit it to management.\nCompile all financial data for the monthly performance report and submit it to management.','Low','Prateeq','CO','2025-12-21','2025-12-03 09:21:07','Pending','No Remarks',0),(10,'Update Inventory Records','Update the stock database with the latest incoming and outgoing items for accuracy.\nUpdate the stock database with the latest incoming and outgoing items for accuracy.\nUpdate the stock database with the latest incoming and outgoing items for accuracy.\nUpdate the stock database with the latest incoming and outgoing items for accuracy.\n','Medium','Gugar','CO','2025-12-31','2025-12-03 09:21:48','Pending','No Remarks',0),(11,'Conduct Team Meeting','Organize and conduct a team meeting to discuss project milestones and deadlines.\r\nOrganize and conduct a team meeting to discuss project milestones and deadlines.\r\n','High','Abishek','CO','2026-01-01','2025-12-03 09:22:27','Pending','No Remarks',0),(13,'Wash all vehicles','This involves thoroughly cleaning both the exterior and interior of all vehicles, removing dirt, dust, and grime, and ensuring they are tidy and presentable. The process helps maintain a polished appearance, keeps the vehicles hygienic, and ensures they remain in good condition for daily use.','High','Prateeq','CO','2025-12-12','2025-12-10 09:05:58','Pending','No Remarks',0),(14,'Conduct Team Meeting','test data','High','','CO','2025-12-23','2025-12-23 08:31:47','Pending','No Remarks',0),(15,'Christmas Celebration','celebration','High','Gugar','CO','2025-12-25','2025-12-23 20:27:23','Pending','No Remarks',0),(16,'or mess completion report','al work report pendind and give with phtotos','High','Gugar','CO','2026-01-14','2026-01-14 08:41:11','Pending','No Remarks',0),(17,'VISIT','VISIT IS REQUIRED','Low','99999CESR','CO','2026-01-31','2026-01-14 09:07:41','In Progress','Work in progress',31),(18,'TRAINNG','night traing eqpt test every night trainning','Medium','99999CESR','CO','2026-01-14','2026-01-14 09:38:33','Completed','ALL TESTED',100);
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `td_table`
--

DROP TABLE IF EXISTS `td_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `td_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `army_number` varchar(50) NOT NULL,
  `remarks` text,
  `td_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `company` varchar(50) DEFAULT NULL,
  `authority` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `td_table`
--

LOCK TABLES `td_table` WRITE;
/*!40000 ALTER TABLE `td_table` DISABLE KEYS */;
INSERT INTO `td_table` VALUES (7,'905CESR','temporary detached for 10 days','2025-12-01 08:56:16',NULL,NULL,NULL),(8,'9926WE','temporary detached for 10 days','2025-12-01 08:56:47',NULL,NULL,NULL);
/*!40000 ALTER TABLE `td_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units_served`
--

DROP TABLE IF EXISTS `units_served`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units_served` (
  `id` int NOT NULL AUTO_INCREMENT,
  `personnel_id` int NOT NULL,
  `army_number` varchar(100) NOT NULL,
  `sr_no` int DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `duty_performed` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_army_number` (`army_number`),
  KEY `idx_personnel_id_units` (`personnel_id`),
  CONSTRAINT `units_served_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units_served`
--

LOCK TABLES `units_served` WRITE;
/*!40000 ALTER TABLE `units_served` DISABLE KEYS */;
INSERT INTO `units_served` VALUES (1,1,'778G',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(2,2,'156WE',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(3,3,'1526WE',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(4,4,'9926WE',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(5,5,'99226WE',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(6,6,'966WE',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(7,7,'87CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(8,8,'997CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(9,10,'965CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(10,12,'905CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(11,13,'9085CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(12,14,'25CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(13,15,'165CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(14,16,'775CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(15,17,'984CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(16,18,'994CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(17,19,'99999CESR',1,'1st Battalion','2010-05-15','2015-05-15','Platoon Commander'),(18,25,'123456',1,'Unit Alpha','2016-07-01','2018-07-01','Training'),(19,26,'14951234A',1,'Training Battalion','2023-06-15','2023-12-14','Recruit Training'),(20,26,'14951234A',2,'1 Signal Regiment','2024-01-01',NULL,'Radio Operator'),(21,27,'14952345B',1,'Current Unit','2024-08-01',NULL,'Technician Duty');
/*!40000 ALTER TABLE `units_served` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `company` varchar(50) DEFAULT '1 company',
  `army_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'RAVI KUMAR','ravi@gmail.com','ravi@123','CO','2025-11-19 06:28:38','Admin',NULL),(2,'RAHUL SINGH','rahul.oc@gmail.com','rahul@123','OC','2025-11-19 06:42:10','1 company',NULL),(3,'SACHIN SHARMA','sachin.adj@gmail.com','sachin@123','ADJUTANT','2025-11-19 06:45:22','1 company',NULL),(4,'MANOJ SINGH','manoj.jco@gmail.com','manoj@123','JCO','2025-11-18 04:52:55','1 company',NULL),(5,'AKHILESH VERMA','akhil.jco@gmail.com','akhil@123','JCO','2025-11-18 06:15:33','1 company',NULL),(6,'SUNIL KUMAR','sunil.or@gmail.com','sunil@123','OR','2025-11-17 03:48:20','1 company',NULL),(7,'VIJAY KUMAR','vijay.or@gmail.com','vijay@123','OR','2025-11-17 09:10:11','1 company',NULL),(8,'ARUN SHARMA','arun.clerk@gmail.com','arun@123','SEC NCO','2025-11-16 03:20:45','1 company',NULL),(9,'ROHIT YADAV','rohit.clerk@gmail.com','rohit@123','SEC NCO','2025-11-16 05:42:30','2 Company',NULL),(10,'ADMIN USER','admin@gmail.com','admin@123','ADJUTANT','2025-11-15 07:55:00','1 company',NULL),(11,'col_singh','co@unit.army','@123','OC','2025-12-16 01:40:20','2 Company',NULL),(12,'maj_khan','oc_alpha@unit.army','@123','ADJUTANT','2025-12-16 01:40:20','2 Company',NULL),(13,'clerk_ram','clerk@unit.army','@123','CLERK','2025-12-16 01:40:20','3 Company',NULL),(14,'subedar_yadav','subedar@unit.army','@123','SUBEDAR','2025-12-16 01:40:20','3 Company',NULL),(15,'naib_subedar_ali','naib@unit.army','@123','NAIB_SUBEDAR','2025-12-16 01:40:20','4 Company',NULL),(16,'MS DHONI','dhoni_sec_jco@1coy','123','SEC JCO','2025-12-30 06:46:54','2 company',NULL),(17,'Yuvraj','yuvraj@2coy','123','SEC JCO','2025-12-30 06:47:20','2 company',NULL),(18,'Kohli','kohli@1coy','123','SEC JCO','2025-12-30 06:47:41','1 company',NULL),(19,'unit_2ic','2ic@123','123','2IC','2025-12-31 06:48:12','Admin',NULL),(20,'OSECNCO','osecnco@gmail.com','osecnco123','O CENTRE NCO','2026-01-10 06:00:29','Center',NULL),(21,'Subedar_Ram','subedar.ram@army.local','123','KUNBA TASK','2026-01-14 05:50:39','1 company','984CESR'),(22,'Subedar_Mohan','subedar.mohan@army.local','123','KUNBA TASK','2026-01-14 05:50:39','2 company',NULL),(23,'NaibSubedar_Singh','naib.singh@army.local','123','KUNBA TASK','2026-01-14 05:50:39','3 company',NULL),(24,'NaibSubedar_Kumar','naib.kumar@army.local','123','KUNBA TASK','2026-01-14 05:50:39','4 company','99999CESR'),(25,'AMIT SINGH','1coyonco@gmail.com','1coyonco@123','ONCO','2026-01-12 07:27:53','1 company',NULL),(26,'SANJAY DAS','2coyonco@gmail.com','2coyonco@123','ONCO','2026-01-12 07:27:53','2 company',NULL),(27,'ROHIT KUMAR','3coyonco@gmail.com','3coyonco@123','ONCO','2026-01-12 07:27:53','3 company',NULL),(28,'PREM SINGH','4coyonco@gmail.com','4coyonco@123','ONCO','2026-01-12 07:27:53','4 company',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_detail`
--

DROP TABLE IF EXISTS `vehicle_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_detail` (
  `vehicle_no` varchar(20) NOT NULL,
  `type` varchar(30) DEFAULT NULL,
  `class` varchar(10) DEFAULT NULL,
  `detailment` varchar(100) DEFAULT NULL,
  `dist_travelled` int DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `bullet_proof` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`vehicle_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_detail`
--

LOCK TABLES `vehicle_detail` WRITE;
/*!40000 ALTER TABLE `vehicle_detail` DISABLE KEYS */;
INSERT INTO `vehicle_detail` VALUES ('JK152398','Truck','II','UNIT DUTY',10000,1,'Y'),('JK157503','Scorpio','II','CSO Duty',12000,1,'Y'),('MH12YZ2022','Scorpio','V','CSO Duty',5000,1,'N'),('MH14SK2300','Truck','II','Unit duty',10000,1,'Y');
/*!40000 ALTER TABLE `vehicle_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weight_info`
--

DROP TABLE IF EXISTS `weight_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weight_info` (
  `troop_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `army_number` varchar(50) DEFAULT NULL,
  `actual_weight` float DEFAULT NULL,
  `age` int DEFAULT NULL,
  `height` float DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `status_type` varchar(10) NOT NULL DEFAULT 'safe',
  `category_type` varchar(10) DEFAULT NULL,
  `restrictions` text,
  PRIMARY KEY (`troop_id`),
  UNIQUE KEY `army_number` (`army_number`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weight_info`
--

LOCK TABLES `weight_info` WRITE;
/*!40000 ALTER TABLE `weight_info` DISABLE KEYS */;
INSERT INTO `weight_info` VALUES (1,'john snow','AGNIVEER','12121',56,56,156,'3 Company','category','permanent','cannot run'),(2,'John Doe','Captain','JD12345',75.5,30,175,'2 Company','shape',NULL,NULL),(3,'Yawar','Havaldar','121132229',67,34,170,'3 Company','category','permanent','cannot drive'),(4,'Ubaid lone','JCO','0234032048',56,40,179,'2 Company','category','permanent','CANNOT WAIT PROPERLY'),(5,'G NARESH','JCO','023403204890',67,56,178,'4 Company','shape',NULL,NULL),(6,'GANESH','JCO','34809',67,56,167,'4 Company','category','permanent','THIS CANNOT READ'),(7,'tiku sharma','JCO','12',56,45,165,'2 Company','shape',NULL,NULL),(8,'zaheer','MAJOR','453343',67,56,170,'4 Company','shape',NULL,NULL),(9,'h r','JCO','15732589',173,32,176,'4 Company','shape',NULL,NULL),(10,'MANISH BAJPAI','JCO','48943948',67,45,180,'1 Company','shape',NULL,NULL),(11,'MURALI DHARAN','AGNIVEER','3438094830984',56,34,180,'4 Company','shape',NULL,NULL),(12,'STEVE SMITH','MAJOR','32943284',60,45,180,'1 Company','category','temporary','injury'),(13,'John Doe','Captain','123456',70.2,35,175.5,'1 Company','shape',NULL,'None'),(14,'Rajesh Kumar Singh','Agniveer','14951234A',68.5,22,172.5,'1 Company','shape',NULL,NULL),(15,'Amit Yadav','Agniveer','14952345B',65,21,170,'3 Company','shape',NULL,NULL),(16,'Vikram Singh Rathore','Agniveer','14951111X',72,22,175,'2 Company','category','temporary','Avoid heavy physical exertion'),(17,'Rahul Sharma','Agniveer','14953456C',62,20,168,'4 Company','shape',NULL,NULL);
/*!40000 ALTER TABLE `weight_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-15 15:47:29
