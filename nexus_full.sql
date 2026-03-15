-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: nexus
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `operation` enum('INSERT','UPDATE','DELETE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_id` int DEFAULT NULL,
  `old_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `changed_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed_at` datetime(3) DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
INSERT INTO `audit_log` VALUES (1,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"West Bengal\", \"district\": \"Kolkata\", \"threat_level\": \"low\", \"threat_score\": 33.00}','sp_compute_threat_scores','2026-03-15 15:45:53.063'),(2,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"Assam\", \"district\": \"Kamrup\", \"threat_level\": \"low\", \"threat_score\": 6.50}','sp_compute_threat_scores','2026-03-15 15:45:53.072'),(3,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"Bihar\", \"district\": \"East Champaran\", \"threat_level\": \"low\", \"threat_score\": 10.50}','sp_compute_threat_scores','2026-03-15 15:45:53.076'),(4,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"Maharashtra\", \"district\": \"Pune\", \"threat_level\": \"low\", \"threat_score\": 6.50}','sp_compute_threat_scores','2026-03-15 15:45:53.080'),(5,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"Delhi\", \"district\": \"East Delhi\", \"threat_level\": \"low\", \"threat_score\": 19.50}','sp_compute_threat_scores','2026-03-15 15:45:53.082'),(6,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"Tripura\", \"district\": \"West Tripura\", \"threat_level\": \"low\", \"threat_score\": 13.00}','sp_compute_threat_scores','2026-03-15 15:45:53.085'),(7,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"Maharashtra\", \"district\": \"Mumbai\", \"threat_level\": \"low\", \"threat_score\": 15.50}','sp_compute_threat_scores','2026-03-15 15:45:53.089'),(8,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"West Bengal\", \"district\": \"Darjeeling\", \"threat_level\": \"low\", \"threat_score\": 10.50}','sp_compute_threat_scores','2026-03-15 15:45:53.092'),(9,'district_threat_scores','UPDATE',NULL,NULL,'{\"state\": \"Telangana\", \"district\": \"Hyderabad\", \"threat_level\": \"low\", \"threat_score\": 7.00}','sp_compute_threat_scores','2026-03-15 15:45:53.094'),(10,'incidents','INSERT',13,NULL,'{\"title\": \"Child labour racket busted Murshidabad\", \"status\": \"reported\", \"severity\": 4, \"incident_type\": \"forced_labour\", \"victims_count\": 3}','system','2026-03-15 15:48:34.431'),(11,'incidents','INSERT',13,NULL,'{\"type\": \"forced_labour\", \"title\": \"Child labour racket busted Murshidabad\", \"source\": \"West Bengal Police\", \"victims\": 3, \"severity\": 4}','sp_report_incident','2026-03-15 15:48:34.438');
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_persons`
--

DROP TABLE IF EXISTS `case_persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_persons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `case_id` int NOT NULL,
  `person_id` int NOT NULL,
  `role` enum('victim','suspect','witness','informant','accused') COLLATE utf8mb4_unicode_ci NOT NULL,
  `added_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `case_id` (`case_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `case_persons_ibfk_1` FOREIGN KEY (`case_id`) REFERENCES `cases` (`case_id`),
  CONSTRAINT `case_persons_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `persons` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_persons`
--

LOCK TABLES `case_persons` WRITE;
/*!40000 ALTER TABLE `case_persons` DISABLE KEYS */;
INSERT INTO `case_persons` VALUES (1,1,1,'victim','2026-03-15 15:32:45',NULL),(2,1,6,'suspect','2026-03-15 15:32:45',NULL),(3,1,7,'accused','2026-03-15 15:32:45',NULL),(4,2,3,'victim','2026-03-15 15:32:45',NULL),(5,2,4,'victim','2026-03-15 15:32:45',NULL),(6,2,9,'suspect','2026-03-15 15:32:45',NULL),(7,2,6,'suspect','2026-03-15 15:32:45',NULL),(8,2,14,'witness','2026-03-15 15:32:45',NULL),(9,3,2,'victim','2026-03-15 15:32:45',NULL),(10,3,8,'suspect','2026-03-15 15:32:45',NULL),(11,3,7,'suspect','2026-03-15 15:32:45',NULL),(12,4,5,'victim','2026-03-15 15:32:45',NULL),(13,4,13,'suspect','2026-03-15 15:32:45',NULL),(14,5,9,'suspect','2026-03-15 15:32:45',NULL),(15,5,11,'suspect','2026-03-15 15:32:45',NULL),(16,5,15,'witness','2026-03-15 15:32:45',NULL),(17,6,12,'suspect','2026-03-15 15:32:45',NULL),(18,6,8,'suspect','2026-03-15 15:32:45',NULL);
/*!40000 ALTER TABLE `case_persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases`
--

DROP TABLE IF EXISTS `cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cases` (
  `case_id` int NOT NULL AUTO_INCREMENT,
  `case_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opened_at` date NOT NULL,
  `closed_at` date DEFAULT NULL,
  `status` enum('open','closed','cold','referred','dismissed') COLLATE utf8mb4_unicode_ci DEFAULT 'open',
  `lead_agency` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` tinyint DEFAULT '3',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`case_id`),
  UNIQUE KEY `case_number` (`case_number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases`
--

LOCK TABLES `cases` WRITE;
/*!40000 ALTER TABLE `cases` DISABLE KEYS */;
INSERT INTO `cases` VALUES (1,'WB/2023/TRF/001','Operation Sealdah Rescue','2023-03-12','2023-06-30','closed','CBI','Kolkata','West Bengal',1,NULL,'2026-03-15 15:32:35','2026-03-15 15:32:35'),(2,'BR/2023/TRF/002','Raxaul Border Network','2023-07-04',NULL,'open','NIA','East Champaran','Bihar',1,NULL,'2026-03-15 15:32:35','2026-03-15 15:32:35'),(3,'MH/2023/TRF/003','Mumbai Exploitation Ring','2023-08-22',NULL,'open','Mumbai Police','Mumbai','Maharashtra',1,NULL,'2026-03-15 15:32:35','2026-03-15 15:32:35'),(4,'AS/2023/TRF/004','Guwahati Recruitment Fraud','2023-09-10',NULL,'open','Assam Police','Kamrup','Assam',2,NULL,'2026-03-15 15:32:35','2026-03-15 15:32:35'),(5,'TR/2024/TRF/005','Agartala Border Smuggling','2024-01-19',NULL,'open','BSF','West Tripura','Tripura',1,NULL,'2026-03-15 15:32:35','2026-03-15 15:32:35'),(6,'DL/2023/TRF/006','Delhi Forced Marriage Network','2023-12-01',NULL,'open','Delhi Police','East Delhi','Delhi',2,NULL,'2026-03-15 15:32:35','2026-03-15 15:32:35');
/*!40000 ALTER TABLE `cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connections`
--

DROP TABLE IF EXISTS `connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connections` (
  `connection_id` int NOT NULL AUTO_INCREMENT,
  `person_a` int NOT NULL,
  `person_b` int NOT NULL,
  `relationship` enum('recruiter_victim','handler_victim','financier_recruiter','kingpin_handler','associate','unknown') COLLATE utf8mb4_unicode_ci NOT NULL,
  `strength` tinyint DEFAULT '1',
  `confirmed` tinyint(1) DEFAULT '0',
  `first_seen` date DEFAULT NULL,
  `last_seen` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`connection_id`),
  KEY `idx_connections_person_a` (`person_a`,`relationship`),
  KEY `idx_connections_person_b` (`person_b`,`relationship`),
  CONSTRAINT `connections_ibfk_1` FOREIGN KEY (`person_a`) REFERENCES `persons` (`person_id`),
  CONSTRAINT `connections_ibfk_2` FOREIGN KEY (`person_b`) REFERENCES `persons` (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connections`
--

LOCK TABLES `connections` WRITE;
/*!40000 ALTER TABLE `connections` DISABLE KEYS */;
INSERT INTO `connections` VALUES (1,12,9,'kingpin_handler',5,1,'2022-01-10','2024-04-01',NULL,'2026-03-15 15:31:58'),(2,9,7,'kingpin_handler',4,1,'2022-03-15','2024-03-20',NULL,'2026-03-15 15:31:58'),(3,7,6,'handler_victim',4,1,'2022-06-01','2023-07-04',NULL,'2026-03-15 15:31:58'),(4,9,11,'handler_victim',3,1,'2023-01-05','2024-01-19',NULL,'2026-03-15 15:31:58'),(5,12,13,'financier_recruiter',5,1,'2021-11-20','2024-02-10',NULL,'2026-03-15 15:31:58'),(6,13,10,'recruiter_victim',3,0,'2023-08-01','2023-09-10',NULL,'2026-03-15 15:31:58'),(7,11,6,'associate',2,0,'2023-02-14','2023-11-14',NULL,'2026-03-15 15:31:58'),(8,7,8,'associate',3,1,'2022-09-30','2023-08-22',NULL,'2026-03-15 15:31:58'),(9,12,8,'financier_recruiter',5,1,'2021-08-15','2024-04-10',NULL,'2026-03-15 15:31:58'),(10,8,6,'handler_victim',4,1,'2022-12-01','2023-05-18',NULL,'2026-03-15 15:31:58');
/*!40000 ALTER TABLE `connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district_threat_scores`
--

DROP TABLE IF EXISTS `district_threat_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district_threat_scores` (
  `score_id` int NOT NULL AUTO_INCREMENT,
  `district` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `incident_count` int DEFAULT '0',
  `victim_count` int DEFAULT '0',
  `suspect_count` int DEFAULT '0',
  `threat_score` decimal(6,2) DEFAULT '0.00',
  `threat_level` enum('low','moderate','high','critical') COLLATE utf8mb4_unicode_ci DEFAULT 'low',
  `last_computed` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`score_id`),
  KEY `idx_threat_district` (`state`,`district`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district_threat_scores`
--

LOCK TABLES `district_threat_scores` WRITE;
/*!40000 ALTER TABLE `district_threat_scores` DISABLE KEYS */;
INSERT INTO `district_threat_scores` VALUES (1,'Kolkata','West Bengal',22.572600,88.363900,19,48,25,97.50,'critical','2026-03-15 15:48:34','2026-03-15 15:33:01','2026-03-15 15:48:34'),(2,'East Champaran','Bihar',26.983900,84.932500,14,38,17,82.00,'critical','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(3,'Mumbai','Maharashtra',19.076000,72.877400,12,28,19,74.50,'high','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(4,'Kamrup','Assam',26.144600,91.736200,9,21,11,61.00,'high','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(5,'West Tripura','Tripura',23.831400,91.286200,11,29,14,71.00,'high','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(6,'East Delhi','Delhi',28.660800,77.308400,8,18,12,58.50,'moderate','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(7,'Darjeeling','West Bengal',26.717200,88.425300,10,24,13,67.00,'high','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(8,'Hyderabad','Telangana',17.385000,78.486700,7,15,9,52.00,'moderate','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(9,'Pune','Maharashtra',18.520400,73.856700,5,11,7,41.00,'moderate','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(10,'Murshidabad','West Bengal',24.176000,88.269000,13,35,16,79.00,'critical','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(11,'North 24 Parganas','West Bengal',22.860000,88.530000,15,40,20,83.00,'critical','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(12,'Jhargram','West Bengal',22.453600,86.983800,8,19,10,56.00,'moderate','2026-03-15 15:33:01','2026-03-15 15:33:01','2026-03-15 15:33:01'),(13,'Kolkata','West Bengal',NULL,NULL,4,14,11,43.00,'moderate','2026-03-15 15:48:34','2026-03-15 15:45:53','2026-03-15 15:48:34'),(14,'Kamrup','Assam',NULL,NULL,1,2,1,6.50,'low','2026-03-15 15:45:53','2026-03-15 15:45:53','2026-03-15 15:45:53'),(15,'East Champaran','Bihar',NULL,NULL,1,4,2,10.50,'low','2026-03-15 15:45:53','2026-03-15 15:45:53','2026-03-15 15:45:53'),(16,'Pune','Maharashtra',NULL,NULL,1,2,1,6.50,'low','2026-03-15 15:45:53','2026-03-15 15:45:53','2026-03-15 15:45:53'),(17,'East Delhi','Delhi',NULL,NULL,2,7,4,19.50,'low','2026-03-15 15:45:53','2026-03-15 15:45:53','2026-03-15 15:45:53'),(18,'West Tripura','Tripura',NULL,NULL,1,5,3,13.00,'low','2026-03-15 15:45:53','2026-03-15 15:45:53','2026-03-15 15:45:53'),(19,'Mumbai','Maharashtra',NULL,NULL,1,6,4,15.50,'low','2026-03-15 15:45:53','2026-03-15 15:45:53','2026-03-15 15:45:53'),(20,'Darjeeling','West Bengal',NULL,NULL,1,4,2,10.50,'low','2026-03-15 15:45:53','2026-03-15 15:45:53','2026-03-15 15:45:53'),(21,'Hyderabad','Telangana',NULL,NULL,1,1,3,7.00,'low','2026-03-15 15:45:53','2026-03-15 15:45:53','2026-03-15 15:45:53');
/*!40000 ALTER TABLE `district_threat_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evidence`
--

DROP TABLE IF EXISTS `evidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evidence` (
  `evidence_id` int NOT NULL AUTO_INCREMENT,
  `incident_id` int NOT NULL,
  `evidence_type` enum('document','photo','video','testimony','financial_record','physical','digital','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `collected_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `collected_at` datetime DEFAULT NULL,
  `storage_ref` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `chain_intact` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`evidence_id`),
  KEY `incident_id` (`incident_id`),
  CONSTRAINT `evidence_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incidents` (`incident_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evidence`
--

LOCK TABLES `evidence` WRITE;
/*!40000 ALTER TABLE `evidence` DISABLE KEYS */;
INSERT INTO `evidence` VALUES (1,1,'testimony','Victim statement recorded at Sealdah GRP','GRP Officer Banerjee','2023-03-12 14:00:00',NULL,1,1,'2026-03-15 15:32:53'),(2,1,'photo','CCTV footage from Sealdah platform 7','CBI Team','2023-03-13 10:00:00',NULL,1,1,'2026-03-15 15:32:53'),(3,3,'financial_record','Hawala transaction record Raxaul','NIA Agent Verma','2023-07-05 09:00:00',NULL,1,1,'2026-03-15 15:32:53'),(4,3,'document','Fake identity documents seized at border','BSF Unit 4','2023-07-04 16:00:00',NULL,1,1,'2026-03-15 15:32:53'),(5,4,'digital','WhatsApp chat logs extracted from suspect phone','Mumbai Cyber Cell','2023-08-24 11:00:00',NULL,1,1,'2026-03-15 15:32:53'),(6,6,'physical','Medical equipment seized from suspect premises','Hyderabad Police','2023-10-06 08:00:00',NULL,0,1,'2026-03-15 15:32:53'),(7,7,'testimony','Child witness statement Siliguri shelter','CHILDLINE Worker','2023-11-15 10:00:00',NULL,1,1,'2026-03-15 15:32:53'),(8,9,'document','Forged travel documents seized Agartala','BSF Tripura','2024-01-20 09:00:00',NULL,1,1,'2026-03-15 15:32:53');
/*!40000 ALTER TABLE `evidence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidents`
--

DROP TABLE IF EXISTS `incidents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidents` (
  `incident_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `incident_date` date NOT NULL,
  `location_id` int DEFAULT NULL,
  `incident_type` enum('recruitment','transportation','exploitation','sale','forced_labour','sexual_exploitation','organ_trafficking','unknown') COLLATE utf8mb4_unicode_ci NOT NULL,
  `severity` tinyint DEFAULT '1',
  `victims_count` tinyint unsigned DEFAULT '0',
  `suspects_count` tinyint unsigned DEFAULT '0',
  `status` enum('reported','investigating','solved','cold_case') COLLATE utf8mb4_unicode_ci DEFAULT 'reported',
  `source` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`incident_id`),
  KEY `location_id` (`location_id`),
  KEY `idx_incidents_date` (`incident_date`,`severity`),
  CONSTRAINT `incidents_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidents`
--

LOCK TABLES `incidents` WRITE;
/*!40000 ALTER TABLE `incidents` DISABLE KEYS */;
INSERT INTO `incidents` VALUES (1,'Minor girls rescued from Sealdah station','2023-03-12',1,'transportation',5,3,2,'solved','NCRB 2023',NULL,'2026-03-15 15:31:49'),(2,'Forced labour racket busted in Kolkata','2023-05-18',2,'forced_labour',4,5,3,'investigating','Police FIR',NULL,'2026-03-15 15:31:49'),(3,'Cross border trafficking via Raxaul','2023-07-04',4,'transportation',5,4,2,'investigating','NCRB 2023',NULL,'2026-03-15 15:31:49'),(4,'Sexual exploitation network Mumbai','2023-08-22',8,'sexual_exploitation',5,6,4,'investigating','NGO Report',NULL,'2026-03-15 15:31:49'),(5,'Recruitment fraud Guwahati','2023-09-10',3,'recruitment',3,2,1,'reported','Police FIR',NULL,'2026-03-15 15:31:49'),(6,'Organ trafficking attempt Hyderabad','2023-10-05',10,'organ_trafficking',5,1,3,'investigating','NCRB 2023',NULL,'2026-03-15 15:31:49'),(7,'Child trafficking Siliguri junction','2023-11-14',9,'transportation',5,4,2,'solved','NGO Report',NULL,'2026-03-15 15:31:49'),(8,'Forced marriage racket Delhi','2023-12-01',6,'recruitment',4,3,2,'investigating','Police FIR',NULL,'2026-03-15 15:31:49'),(9,'Agartala border smuggling ring','2024-01-19',7,'transportation',5,5,3,'investigating','NCRB 2024',NULL,'2026-03-15 15:31:49'),(10,'Fake job offer scam Pune','2024-02-28',5,'recruitment',3,2,1,'reported','NGO Report',NULL,'2026-03-15 15:31:49'),(11,'Minor trafficking West Bengal network','2024-03-15',1,'transportation',5,3,4,'investigating','NCRB 2024',NULL,'2026-03-15 15:31:49'),(12,'Domestic servitude racket Delhi','2024-04-10',6,'forced_labour',4,4,2,'investigating','Police FIR',NULL,'2026-03-15 15:31:49'),(13,'Child labour racket busted Murshidabad','2026-03-15',1,'forced_labour',4,3,2,'reported','West Bengal Police',NULL,'2026-03-15 15:48:34');
/*!40000 ALTER TABLE `incidents` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_incidents_insert` AFTER INSERT ON `incidents` FOR EACH ROW BEGIN
  INSERT INTO audit_log (
    table_name, operation, record_id,
    old_data, new_data, changed_by, changed_at
  ) VALUES (
    'incidents', 'INSERT', NEW.incident_id,
    NULL,
    JSON_OBJECT(
      'title',          NEW.title,
      'incident_type',  NEW.incident_type,
      'severity',       NEW.severity,
      'victims_count',  NEW.victims_count,
      'status',         NEW.status
    ),
    'system',
    NOW(3)
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `investigators`
--

DROP TABLE IF EXISTS `investigators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investigators` (
  `investigator_id` int NOT NULL AUTO_INCREMENT,
  `badge_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rank` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `agency` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_level` tinyint DEFAULT '1',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`investigator_id`),
  UNIQUE KEY `badge_number` (`badge_number`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investigators`
--

LOCK TABLES `investigators` WRITE;
/*!40000 ALTER TABLE `investigators` DISABLE KEYS */;
INSERT INTO `investigators` VALUES (1,'CBI/2019/0412','Vikram Malhotra','Deputy SP','CBI','West Bengal','v.malhotra@cbi.gov.in',5,1,'2026-03-15 15:33:09'),(2,'NIA/2020/0231','Preethi Nair','Inspector','NIA','Bihar','p.nair@nia.gov.in',4,1,'2026-03-15 15:33:09'),(3,'MH/2018/1102','Arjun Desai','ACP','Mumbai Police','Maharashtra','a.desai@mumbaipolice.gov.in',3,1,'2026-03-15 15:33:09'),(4,'AS/2021/0567','Ranjit Borah','SI','Assam Police','Assam','r.borah@assampolice.gov.in',2,1,'2026-03-15 15:33:09'),(5,'BSF/2017/0891','Kavitha Reddy','Commandant','BSF','Tripura','k.reddy@bsf.gov.in',4,1,'2026-03-15 15:33:09');
/*!40000 ALTER TABLE `investigators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('safehouse','border_crossing','pickup_point','drop_point','transit_hub','unknown') COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `threat_level` tinyint DEFAULT '1',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Sealdah Railway Station','transit_hub','Sealdah, Kolkata','Kolkata','West Bengal',22.565300,88.370100,5,1,'2026-03-15 15:30:42'),(2,'Sonagachi Area','safehouse','Shyambazar, Kolkata','Kolkata','West Bengal',22.598100,88.374200,5,1,'2026-03-15 15:30:42'),(3,'Guwahati Bus Terminal','transit_hub','Paltan Bazaar, Guwahati','Kamrup','Assam',26.184100,91.751500,4,1,'2026-03-15 15:30:42'),(4,'Raxaul Border Crossing','border_crossing','Raxaul, East Champaran','East Champaran','Bihar',26.983900,84.932500,5,1,'2026-03-15 15:30:42'),(5,'Pune Station Road','pickup_point','Station Road, Pune','Pune','Maharashtra',18.528400,73.874600,3,1,'2026-03-15 15:30:42'),(6,'Delhi Anand Vihar ISBT','transit_hub','Anand Vihar, Delhi','East Delhi','Delhi',28.646500,77.316200,4,1,'2026-03-15 15:30:42'),(7,'Agartala Border Zone','border_crossing','Akhaura Road, Agartala','West Tripura','Tripura',23.831400,91.286200,5,1,'2026-03-15 15:30:42'),(8,'Mumbai Dadar Station','transit_hub','Dadar West, Mumbai','Mumbai','Maharashtra',19.018200,72.841800,3,1,'2026-03-15 15:30:42'),(9,'Siliguri Tenzing Norgay Bus Terminal','transit_hub','Hill Cart Road, Siliguri','Darjeeling','West Bengal',26.717200,88.425300,4,1,'2026-03-15 15:30:42'),(10,'Hyderabad Secunderabad Station','transit_hub','Secunderabad, Hyderabad','Hyderabad','Telangana',17.434400,78.500300,3,1,'2026-03-15 15:30:42');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movements`
--

DROP TABLE IF EXISTS `movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movements` (
  `movement_id` int NOT NULL AUTO_INCREMENT,
  `person_id` int NOT NULL,
  `location_id` int NOT NULL,
  `arrived_at` datetime NOT NULL,
  `departed_at` datetime DEFAULT NULL,
  `transport_mode` enum('foot','vehicle','train','flight','boat','unknown') COLLATE utf8mb4_unicode_ci DEFAULT 'unknown',
  `flagged` tinyint(1) DEFAULT '0',
  `flagged_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recorded_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`movement_id`),
  KEY `location_id` (`location_id`),
  KEY `idx_movements_person_time` (`person_id`,`arrived_at`),
  CONSTRAINT `movements_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`person_id`),
  CONSTRAINT `movements_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movements`
--

LOCK TABLES `movements` WRITE;
/*!40000 ALTER TABLE `movements` DISABLE KEYS */;
INSERT INTO `movements` VALUES (1,9,4,'2023-07-03 08:00:00','2023-07-03 10:30:00','vehicle',0,NULL,NULL,'2026-03-15 15:32:06'),(2,9,1,'2023-07-03 14:00:00','2023-07-03 16:00:00','train',0,NULL,NULL,'2026-03-15 15:32:06'),(3,9,9,'2023-07-03 20:00:00','2023-07-04 06:00:00','vehicle',1,NULL,NULL,'2026-03-15 15:32:06'),(4,7,2,'2023-05-17 09:00:00','2023-05-17 11:00:00','foot',0,NULL,NULL,'2026-03-15 15:32:06'),(5,7,8,'2023-08-21 10:00:00','2023-08-21 14:00:00','vehicle',0,NULL,NULL,'2026-03-15 15:32:06'),(6,7,1,'2023-08-21 18:00:00','2023-08-21 20:00:00','train',1,NULL,NULL,'2026-03-15 15:32:06'),(7,12,6,'2023-12-01 07:00:00','2023-12-01 09:00:00','flight',0,NULL,NULL,'2026-03-15 15:32:06'),(8,12,7,'2024-01-18 10:00:00','2024-01-18 13:00:00','vehicle',0,NULL,NULL,'2026-03-15 15:32:06'),(9,12,1,'2024-01-18 20:00:00','2024-01-19 02:00:00','train',1,NULL,NULL,'2026-03-15 15:32:06'),(10,6,4,'2023-07-03 09:00:00','2023-07-03 11:00:00','vehicle',0,NULL,NULL,'2026-03-15 15:32:06'),(11,6,1,'2023-07-03 15:00:00','2023-07-03 17:00:00','train',0,NULL,NULL,'2026-03-15 15:32:06'),(12,8,8,'2023-08-22 08:00:00','2023-08-22 12:00:00','vehicle',0,NULL,NULL,'2026-03-15 15:32:06'),(13,11,9,'2023-11-13 06:00:00','2023-11-13 10:00:00','vehicle',0,NULL,NULL,'2026-03-15 15:32:06'),(14,11,7,'2023-11-13 16:00:00','2023-11-13 20:00:00','vehicle',1,NULL,NULL,'2026-03-15 15:32:06'),(15,13,3,'2023-09-09 08:00:00','2023-09-09 11:00:00','vehicle',0,NULL,NULL,'2026-03-15 15:32:06');
/*!40000 ALTER TABLE `movements` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_movements_flag` AFTER INSERT ON `movements` FOR EACH ROW BEGIN
  DECLARE location_count INT;

  SELECT COUNT(*) INTO location_count
  FROM movements
  WHERE person_id  = NEW.person_id
    AND arrived_at >= NEW.arrived_at - INTERVAL 6 HOUR
    AND arrived_at <= NEW.arrived_at;

  IF location_count >= 3 THEN
    UPDATE movements
    SET    flagged        = 1,
           flagged_reason = 'Auto: 3+ locations within 6 hours'
    WHERE  movement_id    = NEW.movement_id;

    INSERT INTO audit_log (
      table_name, operation, record_id,
      old_data, new_data, changed_by, changed_at
    ) VALUES (
      'movements', 'INSERT', NEW.movement_id,
      NULL,
      JSON_OBJECT(
        'person_id',   NEW.person_id,
        'location_id', NEW.location_id,
        'arrived_at',  NEW.arrived_at,
        'flagged',     1,
        'reason',      'Auto: 3+ locations within 6 hours'
      ),
      'system_trigger',
      NOW(3)
    );
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `persons`
--

DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persons` (
  `person_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` tinyint unsigned DEFAULT NULL,
  `gender` enum('male','female','unknown') COLLATE utf8mb4_unicode_ci DEFAULT 'unknown',
  `nationality` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT 'Indian',
  `role` enum('victim','suspect','witness','unknown') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('active','rescued','arrested','missing','deceased') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `risk_score` decimal(5,2) DEFAULT '0.00',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`person_id`),
  KEY `idx_persons_role` (`role`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persons`
--

LOCK TABLES `persons` WRITE;
/*!40000 ALTER TABLE `persons` DISABLE KEYS */;
INSERT INTO `persons` VALUES (1,'Priya Sharma',17,'female','Indian','victim','rescued',0.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(2,'Sunita Devi',19,'female','Indian','victim','rescued',0.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(3,'Rina Begum',16,'female','Indian','victim','missing',0.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(4,'Kamla Oraon',15,'female','Indian','victim','missing',0.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(5,'Anita Murmu',18,'female','Indian','victim','rescued',0.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(6,'Raju Mandal',34,'male','Indian','suspect','active',72.50,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(7,'Karim Sheikh',41,'male','Indian','suspect','active',88.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(8,'Deepak Yadav',38,'male','Indian','suspect','arrested',91.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(9,'Salim Khan',45,'male','Indian','suspect','active',95.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(10,'Meena Devi',36,'female','Indian','suspect','active',67.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(11,'Bablu Das',29,'male','Indian','suspect','active',78.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(12,'Rohit Tiwari',52,'male','Indian','suspect','active',96.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(13,'Fatima Khatun',22,'female','Bangladeshi','suspect','active',74.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(14,'James Marak',33,'male','Indian','witness','active',0.00,'2026-03-15 15:31:07','2026-03-15 15:31:07'),(15,'Sundar Singh',27,'male','Indian','witness','active',0.00,'2026-03-15 15:31:07','2026-03-15 15:31:07');
/*!40000 ALTER TABLE `persons` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_persons_insert` AFTER INSERT ON `persons` FOR EACH ROW BEGIN
  INSERT INTO audit_log (
    table_name, operation, record_id,
    old_data, new_data, changed_by, changed_at
  ) VALUES (
    'persons', 'INSERT', NEW.person_id,
    NULL,
    JSON_OBJECT(
      'full_name', NEW.full_name,
      'role',      NEW.role,
      'status',    NEW.status,
      'risk_score',NEW.risk_score
    ),
    'system',
    NOW(3)
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_persons_update` AFTER UPDATE ON `persons` FOR EACH ROW BEGIN
  INSERT INTO audit_log (
    table_name, operation, record_id,
    old_data, new_data, changed_by, changed_at
  ) VALUES (
    'persons', 'UPDATE', NEW.person_id,
    JSON_OBJECT(
      'full_name', OLD.full_name,
      'role',      OLD.role,
      'status',    OLD.status,
      'risk_score',OLD.risk_score
    ),
    JSON_OBJECT(
      'full_name', NEW.full_name,
      'role',      NEW.role,
      'status',    NEW.status,
      'risk_score',NEW.risk_score
    ),
    'system',
    NOW(3)
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'INR',
  `method` enum('cash','hawala','upi','crypto','bank_transfer','unknown') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_date` datetime NOT NULL,
  `location_id` int DEFAULT NULL,
  `suspected` tinyint(1) DEFAULT '1',
  `verified` tinyint(1) DEFAULT '0',
  `reference_no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `location_id` (`location_id`),
  KEY `idx_transactions_sender` (`sender_id`,`transaction_date`),
  KEY `idx_transactions_receiver` (`receiver_id`,`transaction_date`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `persons` (`person_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `persons` (`person_id`),
  CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `locations` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,12,9,150000.00,'INR','hawala','2023-07-01 10:00:00',4,1,1,NULL,NULL,'2026-03-15 15:32:22'),(2,12,8,200000.00,'INR','hawala','2023-08-20 09:00:00',8,1,1,NULL,NULL,'2026-03-15 15:32:22'),(3,9,7,75000.00,'INR','cash','2023-07-02 11:00:00',4,1,0,NULL,NULL,'2026-03-15 15:32:22'),(4,9,11,90000.00,'INR','upi','2024-01-17 14:00:00',7,1,0,NULL,NULL,'2026-03-15 15:32:22'),(5,12,13,120000.00,'INR','hawala','2023-09-08 08:00:00',3,1,1,NULL,NULL,'2026-03-15 15:32:22'),(6,13,10,30000.00,'INR','cash','2023-09-09 09:00:00',3,1,0,NULL,NULL,'2026-03-15 15:32:22'),(7,8,6,45000.00,'INR','cash','2023-05-16 10:00:00',2,1,0,NULL,NULL,'2026-03-15 15:32:22'),(8,7,6,25000.00,'INR','cash','2023-07-03 08:30:00',4,1,0,NULL,NULL,'2026-03-15 15:32:22'),(9,12,9,180000.00,'INR','crypto','2024-01-15 16:00:00',NULL,1,0,NULL,NULL,'2026-03-15 15:32:22'),(10,9,7,60000.00,'INR','hawala','2024-03-10 11:00:00',1,1,1,NULL,NULL,'2026-03-15 15:32:22');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_transactions_insert` AFTER INSERT ON `transactions` FOR EACH ROW BEGIN
  INSERT INTO audit_log (
    table_name, operation, record_id,
    old_data, new_data, changed_by, changed_at
  ) VALUES (
    'transactions', 'INSERT', NEW.transaction_id,
    NULL,
    JSON_OBJECT(
      'sender_id',   NEW.sender_id,
      'receiver_id', NEW.receiver_id,
      'amount',      NEW.amount,
      'method',      NEW.method,
      'suspected',   NEW.suspected
    ),
    'system',
    NOW(3)
  );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vw_active_suspects`
--

DROP TABLE IF EXISTS `vw_active_suspects`;
/*!50001 DROP VIEW IF EXISTS `vw_active_suspects`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_active_suspects` AS SELECT 
 1 AS `person_id`,
 1 AS `full_name`,
 1 AS `age`,
 1 AS `gender`,
 1 AS `nationality`,
 1 AS `risk_score`,
 1 AS `cases_involved`,
 1 AS `known_connections`,
 1 AS `transactions_flagged`,
 1 AS `last_seen`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_financial_trail`
--

DROP TABLE IF EXISTS `vw_financial_trail`;
/*!50001 DROP VIEW IF EXISTS `vw_financial_trail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_financial_trail` AS SELECT 
 1 AS `sender_name`,
 1 AS `receiver_name`,
 1 AS `method`,
 1 AS `amount`,
 1 AS `currency`,
 1 AS `transaction_date`,
 1 AS `verified`,
 1 AS `transaction_district`,
 1 AS `transaction_state`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_high_threat_districts`
--

DROP TABLE IF EXISTS `vw_high_threat_districts`;
/*!50001 DROP VIEW IF EXISTS `vw_high_threat_districts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_high_threat_districts` AS SELECT 
 1 AS `district`,
 1 AS `state`,
 1 AS `latitude`,
 1 AS `longitude`,
 1 AS `incident_count`,
 1 AS `victim_count`,
 1 AS `threat_score`,
 1 AS `threat_level`,
 1 AS `last_computed`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_active_suspects`
--

/*!50001 DROP VIEW IF EXISTS `vw_active_suspects`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_active_suspects` AS select `p`.`person_id` AS `person_id`,`p`.`full_name` AS `full_name`,`p`.`age` AS `age`,`p`.`gender` AS `gender`,`p`.`nationality` AS `nationality`,`p`.`risk_score` AS `risk_score`,count(distinct `c`.`case_id`) AS `cases_involved`,count(distinct `co`.`connection_id`) AS `known_connections`,count(distinct `t`.`transaction_id`) AS `transactions_flagged`,max(`m`.`arrived_at`) AS `last_seen` from (((((`persons` `p` left join `case_persons` `cp` on((`cp`.`person_id` = `p`.`person_id`))) left join `cases` `c` on((`c`.`case_id` = `cp`.`case_id`))) left join `connections` `co` on((`co`.`person_a` = `p`.`person_id`))) left join `transactions` `t` on((`t`.`sender_id` = `p`.`person_id`))) left join `movements` `m` on((`m`.`person_id` = `p`.`person_id`))) where ((`p`.`role` = 'suspect') and (`p`.`status` = 'active')) group by `p`.`person_id`,`p`.`full_name`,`p`.`age`,`p`.`gender`,`p`.`nationality`,`p`.`risk_score` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_financial_trail`
--

/*!50001 DROP VIEW IF EXISTS `vw_financial_trail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_financial_trail` AS select `p`.`full_name` AS `sender_name`,`p2`.`full_name` AS `receiver_name`,`t`.`method` AS `method`,`t`.`amount` AS `amount`,`t`.`currency` AS `currency`,`t`.`transaction_date` AS `transaction_date`,`t`.`verified` AS `verified`,`l`.`district` AS `transaction_district`,`l`.`state` AS `transaction_state` from (((`transactions` `t` join `persons` `p` on((`p`.`person_id` = `t`.`sender_id`))) join `persons` `p2` on((`p2`.`person_id` = `t`.`receiver_id`))) left join `locations` `l` on((`l`.`location_id` = `t`.`location_id`))) where (`t`.`suspected` = 1) order by `t`.`transaction_date` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_high_threat_districts`
--

/*!50001 DROP VIEW IF EXISTS `vw_high_threat_districts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_high_threat_districts` AS select `district_threat_scores`.`district` AS `district`,`district_threat_scores`.`state` AS `state`,`district_threat_scores`.`latitude` AS `latitude`,`district_threat_scores`.`longitude` AS `longitude`,`district_threat_scores`.`incident_count` AS `incident_count`,`district_threat_scores`.`victim_count` AS `victim_count`,`district_threat_scores`.`threat_score` AS `threat_score`,`district_threat_scores`.`threat_level` AS `threat_level`,`district_threat_scores`.`last_computed` AS `last_computed` from `district_threat_scores` where (`district_threat_scores`.`threat_level` in ('high','critical')) order by `district_threat_scores`.`threat_score` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-15 16:41:42
