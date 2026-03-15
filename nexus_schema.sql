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

-- Dump completed on 2026-03-15 16:41:17
