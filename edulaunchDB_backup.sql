-- MySQL dump 10.13  Distrib 9.7.1, for Win64 (x86_64)
--
-- Host: localhost    Database: edulaunchDB
-- ------------------------------------------------------
-- Server version	9.7.1

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '70160a8b-85a7-11f1-98a6-6c0b5e172f0a:1-1019';

--
-- Table structure for table `assessment`
--

DROP TABLE IF EXISTS `assessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assessment` (
  `assessmentID` int NOT NULL AUTO_INCREMENT,
  `carProgrammeID` int NOT NULL,
  `assessmentTitle` varchar(65) NOT NULL,
  `assessmentType` varchar(65) NOT NULL,
  PRIMARY KEY (`assessmentID`),
  KEY `fk_assessment_programmeID` (`carProgrammeID`),
  CONSTRAINT `fk_assessment_programmeID` FOREIGN KEY (`carProgrammeID`) REFERENCES `career_programme` (`carProgrammeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment`
--

LOCK TABLES `assessment` WRITE;
/*!40000 ALTER TABLE `assessment` DISABLE KEYS */;
INSERT INTO `assessment` VALUES (1,1,'LinkedIn Workshop','Practical Workshop Tasks'),(2,1,'Marketing','Quiz'),(3,4,'CV Writing','Creative Writing Exam'),(4,4,'Peer-To-Peer CV Review','CV Review'),(5,4,'CV Writing Best Practices','Quiz'),(6,3,'CV Design Best Practices','Quiz'),(7,5,'Mock Interview','Practical'),(8,5,'Higher Order Mock Interview','Practical'),(9,2,'Career Pathway Mapping','Practical Task');
/*!40000 ALTER TABLE `assessment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assessment_result`
--

DROP TABLE IF EXISTS `assessment_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assessment_result` (
  `assessmentResultID` int NOT NULL AUTO_INCREMENT,
  `studentID` int NOT NULL,
  `assessmentID` int NOT NULL,
  `assMarksObtained` decimal(8,2) NOT NULL,
  `carReadinessScoreGained` decimal(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`assessmentResultID`),
  UNIQUE KEY `uq_student_assessment` (`studentID`,`assessmentID`),
  KEY `fk_result_programmeID` (`assessmentID`),
  CONSTRAINT `fk_result_programmeID` FOREIGN KEY (`assessmentID`) REFERENCES `assessment` (`assessmentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_studentID` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assessment_result_chk_1` CHECK ((`assMarksObtained` between 0 and 100)),
  CONSTRAINT `assessment_result_chk_2` CHECK ((`carReadinessScoreGained` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assessment_result`
--

LOCK TABLES `assessment_result` WRITE;
/*!40000 ALTER TABLE `assessment_result` DISABLE KEYS */;
INSERT INTO `assessment_result` VALUES (1,1,3,92.00,36.00),(2,1,4,88.50,36.00),(3,1,5,81.00,32.00),(4,5,4,65.00,26.00),(5,5,5,89.00,36.00),(6,5,6,95.00,38.00),(7,3,1,94.00,38.00),(8,3,2,58.00,24.00),(9,8,1,42.00,16.00),(10,4,9,68.00,28.00);
/*!40000 ALTER TABLE `assessment_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `career_advisor`
--

DROP TABLE IF EXISTS `career_advisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `career_advisor` (
  `carAdvisorID` int NOT NULL AUTO_INCREMENT,
  `carAdvisorName` varchar(32) NOT NULL,
  `carAdvisorSurname` varchar(32) NOT NULL,
  `carAdvisorEmail` varchar(65) NOT NULL,
  `carAdvisorSpecialisation` varchar(65) NOT NULL,
  PRIMARY KEY (`carAdvisorID`),
  UNIQUE KEY `carAdvisorEmail` (`carAdvisorEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `career_advisor`
--

LOCK TABLES `career_advisor` WRITE;
/*!40000 ALTER TABLE `career_advisor` DISABLE KEYS */;
INSERT INTO `career_advisor` VALUES (1,'Chantel','Mororo','Chantel.Mororo@EDULAUNCH.COM','Interview Preparation'),(2,'Lesego','Rangoaga-Masha','Lesego.Rangoaga-Masha@EDULAUNCH.COM','Career Guidance'),(3,'Palesa','Matlala','Palesa.Matlala@EDULAUNCH.COM','CV Support'),(4,'Jeremiah','Williams','Jeremiah.Williams@EDULAUNCH.COM','Entreprenuership Guidance');
/*!40000 ALTER TABLE `career_advisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `career_programme`
--

DROP TABLE IF EXISTS `career_programme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `career_programme` (
  `carProgrammeID` int NOT NULL AUTO_INCREMENT,
  `carAdvisorID` int NOT NULL,
  `carProgrammeTitle` varchar(65) NOT NULL,
  `carProgrammeCategory` varchar(65) NOT NULL,
  `carProgrammeLevel` enum('Foundation','Intermediate','Advanced') NOT NULL,
  `carProgrammeCapacityLimit` int NOT NULL,
  PRIMARY KEY (`carProgrammeID`),
  KEY `fk_programme_advisorID` (`carAdvisorID`),
  KEY `idx_CareerProgramme_Title_Category` (`carProgrammeTitle`,`carProgrammeCategory`),
  CONSTRAINT `fk_programme_advisorID` FOREIGN KEY (`carAdvisorID`) REFERENCES `career_advisor` (`carAdvisorID`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `career_programme_chk_1` CHECK ((`carProgrammeCapacityLimit` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `career_programme`
--

LOCK TABLES `career_programme` WRITE;
/*!40000 ALTER TABLE `career_programme` DISABLE KEYS */;
INSERT INTO `career_programme` VALUES (1,4,'Personal Branding Concepts','Entreprenuership Guidance','Advanced',4),(2,2,'Career Guidance Foundations','Career Guidance','Foundation',16),(3,3,'CV Design Concepts','CV Support','Foundation',8),(4,3,'CV Writing','CV Support','Intermediate',12),(5,1,'Interview Practice','Interview Preparation','Advanced',8);
/*!40000 ALTER TABLE `career_programme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `career_resource`
--

DROP TABLE IF EXISTS `career_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `career_resource` (
  `carResourceID` int NOT NULL AUTO_INCREMENT,
  `carResourceTitle` varchar(65) NOT NULL,
  `carResourceType` varchar(65) NOT NULL,
  `carResourceSize_mb` decimal(8,2) NOT NULL,
  `carResourceNumDownloads` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`carResourceID`),
  CONSTRAINT `career_resource_chk_1` CHECK ((`carResourceSize_mb` >= 0)),
  CONSTRAINT `career_resource_chk_2` CHECK ((`carResourceNumDownloads` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `career_resource`
--

LOCK TABLES `career_resource` WRITE;
/*!40000 ALTER TABLE `career_resource` DISABLE KEYS */;
INSERT INTO `career_resource` VALUES (1,'Professional CV Templates','CV Template',5.40,23),(2,'Marketing Student Guide','PDF Guide',25.67,17),(3,'Personal Branding Concepts','Slides',4.34,2),(4,'CV Design Foundations','Slides',12.46,19),(5,'How to Write a CV Series','Videos',232.16,10),(6,'How to Prepare for an Interview','Video',50.76,26),(7,'Workplace Readiness Guide','PDF Guide',13.33,8),(8,'Career Guidance Workbook','Career Planning',4.65,12),(9,'English Dictionary','PDF',10.78,14);
/*!40000 ALTER TABLE `career_resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `error_event_log`
--

DROP TABLE IF EXISTS `error_event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `error_event_log` (
  `errEventLogID` int NOT NULL AUTO_INCREMENT,
  `studentID` int DEFAULT NULL,
  `errEventCategory` varchar(232) NOT NULL,
  `errEventMessage` varchar(232) DEFAULT NULL,
  `errEventTimestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`errEventLogID`),
  KEY `fk_error_studentID` (`studentID`),
  CONSTRAINT `fk_error_studentID` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `error_event_log`
--

LOCK TABLES `error_event_log` WRITE;
/*!40000 ALTER TABLE `error_event_log` DISABLE KEYS */;
INSERT INTO `error_event_log` VALUES (1,NULL,'Programme Enrolment','The programme is full','2026-02-15 11:46:00'),(2,5,'Assessment Submission','Submission failed, The only acceptable formats are PDF, DOCX and TEXT','2026-04-17 09:38:00'),(3,2,'Login Failure','Your Access has expired','2026-05-01 09:04:00'),(4,NULL,'Login Failure','Please enter a valid student number','2026-06-16 13:59:00'),(5,3,'Resource Storage','Your storage is full','2026-07-25 18:23:00'),(6,9,'Resource Storage','Failed to add career resource: How to Write a CV Series, EDUL4664 does not enough storage to download this resource.','2026-08-23 01:22:14'),(7,12,'Resource Storage','Failed to add career resource: How to Write a CV Series student does not enough storage to download this resource.','2026-08-23 01:24:18');
/*!40000 ALTER TABLE `error_event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_activity`
--

DROP TABLE IF EXISTS `learning_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning_activity` (
  `lrngActivityID` int NOT NULL AUTO_INCREMENT,
  `carProgrammeID` int NOT NULL,
  `lrngActivityTitle` varchar(65) NOT NULL,
  PRIMARY KEY (`lrngActivityID`),
  KEY `fk_activity_programmeID` (`carProgrammeID`),
  CONSTRAINT `fk_activity_programmeID` FOREIGN KEY (`carProgrammeID`) REFERENCES `career_programme` (`carProgrammeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_activity`
--

LOCK TABLES `learning_activity` WRITE;
/*!40000 ALTER TABLE `learning_activity` DISABLE KEYS */;
INSERT INTO `learning_activity` VALUES (1,1,'LinkedIn for Personal Branding'),(2,1,'Professional Networking Events'),(3,2,'Possible Career Pathways'),(4,5,'Interview Practice'),(5,5,'Interview Practice Feedback'),(6,4,'Professional CV Writing'),(7,4,'Drafting your Bio'),(8,4,'Compiling Work Experience or Education'),(9,3,'Working with CV Templates');
/*!40000 ALTER TABLE `learning_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_activity_progress`
--

DROP TABLE IF EXISTS `learning_activity_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning_activity_progress` (
  `lrngActivityProgressID` int NOT NULL AUTO_INCREMENT,
  `lrngActivityID` int NOT NULL,
  `studentID` int NOT NULL,
  `lrngActCompletionStatus` enum('Not Started','In Progress','Completed') NOT NULL DEFAULT 'Not Started',
  `lrngActProgressPercentage` tinyint unsigned NOT NULL DEFAULT '0',
  `carReadinessPointsEarned` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`lrngActivityProgressID`),
  UNIQUE KEY `uq_student_learning_activity` (`studentID`,`lrngActivityID`),
  KEY `fk_lrngActivityID` (`lrngActivityID`),
  CONSTRAINT `fk_lrngActivityID` FOREIGN KEY (`lrngActivityID`) REFERENCES `learning_activity` (`lrngActivityID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_progress_studentID` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `learning_activity_progress_chk_1` CHECK ((`lrngActProgressPercentage` between 0 and 100)),
  CONSTRAINT `learning_activity_progress_chk_2` CHECK ((`carReadinessPointsEarned` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_activity_progress`
--

LOCK TABLES `learning_activity_progress` WRITE;
/*!40000 ALTER TABLE `learning_activity_progress` DISABLE KEYS */;
INSERT INTO `learning_activity_progress` VALUES (1,1,3,'Completed',100,20),(2,2,3,'In Progress',40,8),(3,1,8,'In Progress',20,4),(4,2,8,'Not Started',0,0),(5,4,1,'In Progress',0,0),(6,5,1,'Not Started',0,0),(7,6,1,'Completed',100,20),(8,7,1,'Completed',100,20),(9,8,1,'In Progress',80,16),(10,6,5,'In Progress',40,8),(11,7,5,'Completed',100,20),(12,8,5,'Completed',100,20),(13,9,5,'Completed',100,20),(14,3,4,'In Progress',60,12);
/*!40000 ALTER TABLE `learning_activity_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programme_enrolment`
--

DROP TABLE IF EXISTS `programme_enrolment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programme_enrolment` (
  `prgmEnrolmentID` int NOT NULL AUTO_INCREMENT,
  `studentID` int NOT NULL,
  `carProgrammeID` int NOT NULL,
  `prgmEnrolmentDate` date NOT NULL DEFAULT (curdate()),
  PRIMARY KEY (`prgmEnrolmentID`),
  UNIQUE KEY `uq_student_career_programme` (`studentID`,`carProgrammeID`),
  KEY `fk_enrolment_programmeID` (`carProgrammeID`),
  KEY `idx_Student_ProgrammeEnrolment` (`studentID`,`carProgrammeID`),
  CONSTRAINT `fk_enrolment_programmeID` FOREIGN KEY (`carProgrammeID`) REFERENCES `career_programme` (`carProgrammeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_enrolment_studendID` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programme_enrolment`
--

LOCK TABLES `programme_enrolment` WRITE;
/*!40000 ALTER TABLE `programme_enrolment` DISABLE KEYS */;
INSERT INTO `programme_enrolment` VALUES (1,1,5,'2026-02-14'),(2,1,4,'2026-03-01'),(3,5,4,'2026-01-20'),(4,5,3,'2026-02-10'),(5,3,1,'2026-03-15'),(6,8,1,'2026-04-05'),(7,4,2,'2026-03-22');
/*!40000 ALTER TABLE `programme_enrolment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `studentID` int NOT NULL AUTO_INCREMENT,
  `stuNumber` varchar(8) NOT NULL,
  `stuAccountPassword` varchar(12) NOT NULL,
  `stuName` varchar(32) NOT NULL,
  `stuSurname` varchar(32) NOT NULL,
  `stuAccountStatus` enum('Active','Blocked') NOT NULL DEFAULT 'Active',
  `stuAccessExpDate` date NOT NULL,
  `stuStorageLimit_mb` decimal(8,2) NOT NULL DEFAULT '500.00',
  PRIMARY KEY (`studentID`),
  UNIQUE KEY `stuNumber` (`stuNumber`),
  UNIQUE KEY `stuAccountPassword` (`stuAccountPassword`),
  KEY `idx_Student_AccountStatus_AccessExpDate` (`stuAccountStatus`,`stuAccessExpDate`),
  CONSTRAINT `student_chk_1` CHECK ((`stuStorageLimit_mb` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'EDUL5678','hashpass1682','Emma','Pillay','Active','2026-11-04',500.00),(2,'EDUL8946','hashpass8761','Tashreeq','Valentine','Blocked','2026-04-30',300.00),(3,'EDUL4098','hashpass3236','Kaymore','Masha','Active','2026-09-30',500.00),(4,'EDUL7295','hashpass2658','Ishmael','Richards','Active','2027-03-30',500.00),(5,'EDUL6823','hashpass6581','Jacob','Kwete','Active','2026-12-31',300.00),(6,'EDUL2316','hashpass8959','Lionell','Chiko','Blocked','2026-06-30',100.00),(7,'EDUL4656','hashpass0462','Marlene','April','Blocked','2026-06-30',400.00),(8,'EDUL6512','hashpass1237','Carla','Miller','Active','2027-02-28',400.00),(9,'EDUL4664','hashpass7622','Lebo','Motampane','Active','2026-10-28',200.00),(10,'EDUL4696','hashpass3296','Mildah','Masha','Blocked','2025-02-28',100.00),(11,'EDUL1296','hashpass6521','Jonathan','Wheatley','Blocked','2026-04-29',100.00),(12,'EDUL9632','hashpass4608','Jayden','Mills','Active','2026-11-30',100.00);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_BFI_AutoBlock_Student` BEFORE INSERT ON `student` FOR EACH ROW BEGIN 
    IF NEW.stuAccessExpDate < CURRENT_DATE() THEN
        SET new.stuAccountStatus = 'Blocked';
    END IF;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_BFU_Autoblock_Student` BEFORE UPDATE ON `student` FOR EACH ROW BEGIN
    IF NEW.stuAccessExpDate < CURRENT_DATE() THEN
        SET NEW.stuAccountStatus = 'Blocked';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `student_resource`
--

DROP TABLE IF EXISTS `student_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_resource` (
  `stuResourceID` int NOT NULL AUTO_INCREMENT,
  `carResourceID` int NOT NULL,
  `studentID` int NOT NULL,
  PRIMARY KEY (`stuResourceID`),
  UNIQUE KEY `uq_student_resource` (`studentID`,`carResourceID`),
  KEY `fk_carResourceID` (`carResourceID`),
  CONSTRAINT `fk_carResourceID` FOREIGN KEY (`carResourceID`) REFERENCES `career_resource` (`carResourceID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_resource_studentID` FOREIGN KEY (`studentID`) REFERENCES `student` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_resource`
--

LOCK TABLES `student_resource` WRITE;
/*!40000 ALTER TABLE `student_resource` DISABLE KEYS */;
INSERT INTO `student_resource` VALUES (5,5,1),(4,6,1),(10,9,2),(8,2,3),(9,8,4),(1,1,5),(2,4,5),(3,5,5),(6,2,8),(7,3,8),(11,5,12);
/*!40000 ALTER TABLE `student_resource` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_AFI_LogError_StudentResource` AFTER INSERT ON `student_resource` FOR EACH ROW BEGIN
    DECLARE v_stuStorageLimit_mb DECIMAL(8, 2); 
    DECLARE v_stuUsedStorage_mb DECIMAL(8, 2);
    DECLARE v_newCarResourceSize_mb DECIMAL(8, 2);
    DECLARE v_carResourceTitle VARCHAR(32);

    SELECT stuStorageLimit_mb INTO v_stuStorageLimit_mb
    FROM student WHERE studentID = NEW.studentID;

    SELECT COALESCE(SUM(cr.carResourceSize_mb), 0) INTO v_stuUsedStorage_mb
    FROM student_resource AS sr
    JOIN career_resource AS cr ON sr.carResourceID = cr.carResourceID
    WHERE sr.studentID = NEW.studentID;

    SELECT carResourceSize_mb, carResourceTitle
    INTO v_newCarResourceSize_mb, v_carResourceTitle
    FROM career_resource
    WHERE carResourceID = NEW.carResourceID;

    -- logging error if the student does not have enough storage left to add the career resource
    IF (v_newCarResourceSize_mb + v_stuUsedStorage_mb) > v_stuStorageLimit_mb THEN   
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (NEW.studentID, 'Resource Storage', 
                CONCAT('Failed to add career resource: ', v_carResourceTitle, 
                ' student does not enough storage to download this resource.'));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `vwblockedstudents`
--

DROP TABLE IF EXISTS `vwblockedstudents`;
/*!50001 DROP VIEW IF EXISTS `vwblockedstudents`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwblockedstudents` AS SELECT 
 1 AS `studentID`,
 1 AS `stuNumber`,
 1 AS `StudentName`,
 1 AS `stuAccountStatus`,
 1 AS `stuAccessExpDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwmostdownloadedresources`
--

DROP TABLE IF EXISTS `vwmostdownloadedresources`;
/*!50001 DROP VIEW IF EXISTS `vwmostdownloadedresources`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwmostdownloadedresources` AS SELECT 
 1 AS `carResourceID`,
 1 AS `carResourceTitle`,
 1 AS `carResourceType`,
 1 AS `carResourceSize_mb`,
 1 AS `DownloadCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwpopularcareerprogrammes`
--

DROP TABLE IF EXISTS `vwpopularcareerprogrammes`;
/*!50001 DROP VIEW IF EXISTS `vwpopularcareerprogrammes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwpopularcareerprogrammes` AS SELECT 
 1 AS `carProgrammeID`,
 1 AS `carProgrammeTitle`,
 1 AS `carProgrammeCategory`,
 1 AS `carProgrammeLevel`,
 1 AS `carProgrammeCapacityLimit`,
 1 AS `EnrolmentCount`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vwtopcareerreadystudents`
--

DROP TABLE IF EXISTS `vwtopcareerreadystudents`;
/*!50001 DROP VIEW IF EXISTS `vwtopcareerreadystudents`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vwtopcareerreadystudents` AS SELECT 
 1 AS `studentID`,
 1 AS `stuNumber`,
 1 AS `StudentName`,
 1 AS `TotalCarReadinessScore`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'edulaunchDB'
--

--
-- Dumping routines for database 'edulaunchDB'
--
/*!50003 DROP PROCEDURE IF EXISTS `spAddCareerResource` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spAddCareerResource`(
    IN p_studentNumber VARCHAR(8),
    IN p_careerResourceID INT,
    OUT p_message VARCHAR(160)
)
BEGIN
    DECLARE v_stuStorageLimit_mb DECIMAL(8, 2); 
    DECLARE v_stuUsedStorage_mb DECIMAL(8, 2);
    DECLARE v_studentID INT;
    DECLARE v_newCarResourceSize_mb DECIMAL(8, 2);
    DECLARE v_carResourceTitle VARCHAR(32);

    SELECT stuStorageLimit_mb, studentID
    INTO v_stuStorageLimit_mb, v_studentID
    FROM student WHERE stuNumber = p_studentNumber;

    SELECT COALESCE(SUM(cr.carResourceSize_mb), 0) INTO v_stuUsedStorage_mb
    FROM student_resource AS sr
    JOIN career_resource AS cr ON sr.carResourceID = cr.carResourceID
    WHERE sr.studentID = v_studentID;

    SELECT carResourceSize_mb, carResourceTitle
    INTO v_newCarResourceSize_mb, v_carResourceTitle
    FROM career_resource
    WHERE carResourceID = p_careerResourceID;

    -- checking if the student has enough storage left to add the career resource
    IF (v_newCarResourceSize_mb + v_stuUsedStorage_mb) > v_stuStorageLimit_mb THEN   
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (v_studentID, 'Resource Storage', 
                CONCAT('Failed to add career resource: ', v_carResourceTitle, 
                ', ', p_studentNumber, ' does not enough storage to download this resource.'));

        SET p_message = CONCAT('Failed to Add career resource: ', v_carResourceTitle, 
                        ', ', p_studentNumber, ' does not enough storage to download this resource.');

    -- downloading the career resource into the student's storage
    ELSE 
        INSERT INTO student_resource (studentID, carResourceID)
        VALUES (v_studentID, p_careerResourceID);

        SET p_message = CONCAT('The career resource: ', v_carResourceTitle,
                                ', has been added successfully into ', p_studentNumber, '''s career resource storage');

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spEnrolStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spEnrolStudent`(
    IN p_studentNumber VARCHAR(8),
    IN p_careerProgrammeID INT,
    OUT p_message VARCHAR (160)
)
BEGIN 
    -- declaring my variables
    DECLARE v_prgmCapacityLimit INT; -- programme capacity limit
    DECLARE v_currentlyEnrolled INT; -- currently enrolled students
    DECLARE v_accountStatus VARCHAR(8); -- student account status
    DECLARE v_alreadyEnrolled INT; -- checks if student is enrolled already
    DECLARE v_studentID INT; -- student's student number
    DECLARE v_carProgrammeTitle VARCHAR(32);

    SELECT carProgrammeCapacityLimit, carProgrammeTitle
    INTO v_prgmCapacityLimit, v_carProgrammeTitle
    FROM career_programme WHERE carProgrammeID = p_careerProgrammeID;

    SELECT COUNT(*) INTO v_currentlyEnrolled
    FROM programme_enrolment WHERE carProgrammeID = p_careerProgrammeID;

    SELECT stuAccountStatus, studentID
    INTO v_accountStatus, v_studentID
    FROM student WHERE stuNumber = p_studentNumber;    

    SELECT COUNT(*) INTO v_alreadyEnrolled
    FROM programme_enrolment WHERE studentID = v_studentID AND carProgrammeID = p_careerProgrammeID;

    -- checking if the student number of programme ID entered exists
    IF v_StudentID IS NULL OR v_prgmCapacityLimit IS NULL THEN
        SET p_message = CONCAT('Enrolling ', p_studentNumber, ' failed, the career programme: ',
                         v_carProgrammeTitle, ', or student number: ', p_studentNumber, ' does not exist.');
    
    -- checking if the programme is not full
    ELSEIF v_currentlyEnrolled >= v_prgmCapacityLimit THEN
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (v_studentID, 'Enrolment Failure', 
                CONCAT('Enrolling ', p_studentNumber, ' failed, the career programme: ',
                         v_carProgrammeTitle, ', is full.'));

        SET p_message = CONCAT('Enrolling ', p_studentNumber, ' failed, the career programme: ', 
                                v_carProgrammeTitle, ', is full.');
    
    -- checking if the student is not enrolled already
    ELSEIF v_alreadyEnrolled > 0 THEN
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (v_studentID, 'Enrolment Failure', 
                CONCAT('Enrolling ', p_studentNumber,' failed, ', p_studentNumber, 
                ' is already enrolled in the career programme.'));
        SET p_message = CONCAT('Enrolling ', p_studentNumber, ' failed, ', p_studentNumber, 
                        ' is already enrolled in the career programme: ', v_carProgrammeTitle);

    -- checking if the student's account is active
    ELSEIF v_accountStatus != 'Active' THEN
        INSERT INTO error_event_log (studentID, errEventCategory, errEventMessage)
        VALUES (v_studentID, 'Enrolment Failure', CONCAT('Enrolling ', p_studentNumber, ' failed, ', 
                    p_studentNumber,'''s account status is not active.'));

        SET p_message = CONCAT('Enrolling ', p_studentNumber, ' failed, ', 
                                p_studentNumber,'''s account status is not active.');

    -- enrolling the student into the career programme
    ELSE
        INSERT INTO programme_enrolment (studentID, carProgrammeID)
        VALUES (v_studentID, p_careerProgrammeID);

        SET p_message = CONCAT(p_studentNumber, ' has been enrolled successfully into career programme: ', 
                        v_carProgrammeTitle);

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spRegisterStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRegisterStudent`(
    IN p_studentNumber VARCHAR(8),
    IN p_studentPassword VARCHAR(12),
    IN p_studentName VARCHAR(32),
    IN p_studentSurname VARCHAR(32),
    IN p_studentAcessExpDate DATE,
    IN p_studentStorageLimit_mb DECIMAL(8, 2),
    OUT p_message VARCHAR (160)
)
BEGIN 
    DECLARE v_existingStuNumber INT DEFAULT 0;
    DECLARE v_existingStuPassword INT DEFAULT 0;

    SELECT COUNT(*) INTO v_existingStuNumber 
    FROM student WHERE stuNumber = p_studentNumber;

    SELECT COUNT(*) INTO v_existingStuPassword
    FROM student WHERE stuAccountPassword = p_studentPassword;

    -- checking if student already exists
    IF v_existingStuNumber > 0 THEN
        INSERT INTO error_event_log (errEventCategory, errEventMessage)
        VALUES ('Registration Failure', 
            CONCAT('Failed to register student, the student number ', 
            p_studentNumber, ' already exists in the system.'));

        SET p_Message = CONCAT('Failed to register student, the student number  ', 
                        p_studentNumber, ' already exists in the system.');

    -- checking if student's password holder already exists
    ELSEIF v_existingStuPassword > 0 THEN
        INSERT INTO error_event_log (errEventCategory, errEventMessage)
        VALUES ('Registration Failure', 
            CONCAT('Failed to register student, the password place holder ', 
            p_studentPassword, ' already exists in the system.'));

        SET p_Message = CONCAT('Failed to register student, the password place holder ', 
                        p_studentPassword, ' already exists in the system.');

    -- registering the student into student table
    ELSE 
        INSERT INTO student (stuNumber, stuAccountPassword, stuName, stuSurname, 
                            stuAccessExpDate, stuStorageLimit_mb)
        VALUES (p_studentNumber, p_studentPassword, p_studentName, 
                p_studentSurname, p_studentAcessExpDate, p_studentStorageLimit_mb);
        SET p_message = CONCAT(p_studentNumber, ', has been Registered Successfully.');

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spRenewAccess` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spRenewAccess`(
    IN p_studentNumber VARCHAR(8),
    IN p_numDaysToAdd INT,
    OUT p_message VARCHAR(160)
)
BEGIN
    DECLARE v_studentID INT;
    
    SELECT studentID INTO v_studentID
    FROM student WHERE stuNumber = p_studentNumber;

    -- checking if student exists
    IF v_studentID IS NULL THEN
        SET p_message = CONCAT('Renewing Access Failed, the student number: ', 
                            p_studentNumber, ', does not exist.');

    -- checking if the number of days to add is positive
    ELSEIF p_numDaysToAdd <= 0 THEN
        SET p_message = 'Renewing Access Failed, number of days to add needs to be higher than 0.';

    -- renewing the student's access
    ELSE
        UPDATE student
        SET stuAccessExpDate = DATE_ADD(GREATEST(stuAccessExpDate, CURDATE()),
                                         INTERVAL p_numDaysToAdd DAY),
            stuAccountStatus = 'Active'
        WHERE studentID = v_studentID;
        SET p_message = CONCAT(p_studentnumber, '''s Edulaunch access has been renewed for ',
                             p_numDaysToAdd, ' days.');

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spSendAccessNotice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `spSendAccessNotice`(
    IN p_studentNumber VARCHAR(8)
)
BEGIN
    SELECT 
        p_studentNumber AS StudentNumber,
        CONCAT(stuName, ' ', stuSurname) AS StudentName,
        stuAccessExpDate AS AccessExpDate,
        DATEDIFF(stuAccessExpDate, CURRENT_DATE()) AS RemainingDays,
        CASE
            WHEN stuAccountStatus = 'Blocked'
                THEN CONCAT(stuName, ' ', stuSurname, '''s Edulaunch access has expired ',
                        DATEDIFF(stuAccessExpDate, CURRENT_DATE()), ' days ago.')
            WHEN DATEDIFF(stuAccessExpDate, CURRENT_DATE()) <= 30
                THEN CONCAT(stuName, ' ', stuSurname, '''s Edulaunch access is expiring in ', 
                        DATEDIFF(stuAccessExpDate, CURRENT_DATE()), ' days.')
            ELSE 
                CONCAT (stuName, ' ', stuSurname, ' has ', DATEDIFF(stuAccessExpDate, CURRENT_DATE()),
                         ' days of Edulaunch access remaining.')
        END AS AccessNoticeMessage
    FROM student
    WHERE (p_studentNumber IS NULL OR stuNumber = p_studentNumber)
    ORDER BY RemainingDays ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vwblockedstudents`
--

/*!50001 DROP VIEW IF EXISTS `vwblockedstudents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwblockedstudents` AS select `s`.`studentID` AS `studentID`,`s`.`stuNumber` AS `stuNumber`,concat(`s`.`stuName`,' ',`s`.`stuSurname`) AS `StudentName`,`s`.`stuAccountStatus` AS `stuAccountStatus`,`s`.`stuAccessExpDate` AS `stuAccessExpDate` from `student` `s` where ((`s`.`stuAccountStatus` = 'Blocked') and (`s`.`stuAccessExpDate` < curdate())) order by `s`.`stuAccessExpDate` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwmostdownloadedresources`
--

/*!50001 DROP VIEW IF EXISTS `vwmostdownloadedresources`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwmostdownloadedresources` AS select `cr`.`carResourceID` AS `carResourceID`,`cr`.`carResourceTitle` AS `carResourceTitle`,`cr`.`carResourceType` AS `carResourceType`,`cr`.`carResourceSize_mb` AS `carResourceSize_mb`,`cr`.`carResourceNumDownloads` AS `DownloadCount` from `career_resource` `cr` order by `DownloadCount` desc limit 20 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwpopularcareerprogrammes`
--

/*!50001 DROP VIEW IF EXISTS `vwpopularcareerprogrammes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwpopularcareerprogrammes` AS select `cp`.`carProgrammeID` AS `carProgrammeID`,`cp`.`carProgrammeTitle` AS `carProgrammeTitle`,`cp`.`carProgrammeCategory` AS `carProgrammeCategory`,`cp`.`carProgrammeLevel` AS `carProgrammeLevel`,`cp`.`carProgrammeCapacityLimit` AS `carProgrammeCapacityLimit`,coalesce(count(`pe`.`prgmEnrolmentID`),0) AS `EnrolmentCount` from (`career_programme` `cp` left join `programme_enrolment` `pe` on((`cp`.`carProgrammeID` = `pe`.`carProgrammeID`))) group by `cp`.`carProgrammeID`,`cp`.`carProgrammeTitle`,`cp`.`carProgrammeCategory`,`cp`.`carProgrammeLevel`,`cp`.`carProgrammeCapacityLimit` order by `EnrolmentCount` desc limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vwtopcareerreadystudents`
--

/*!50001 DROP VIEW IF EXISTS `vwtopcareerreadystudents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vwtopcareerreadystudents` AS select `s`.`studentID` AS `studentID`,`s`.`stuNumber` AS `stuNumber`,concat(`s`.`stuName`,' ',`s`.`stuSurname`) AS `StudentName`,(coalesce(`ar`.`TotalAssessmentScore`,0) + coalesce(`lap`.`TotalActivityPoints`,0)) AS `TotalCarReadinessScore` from ((`student` `s` left join (select `assessment_result`.`studentID` AS `studentID`,sum(`assessment_result`.`carReadinessScoreGained`) AS `TotalAssessmentScore` from `assessment_result` group by `assessment_result`.`studentID`) `ar` on((`s`.`studentID` = `ar`.`studentID`))) left join (select `learning_activity_progress`.`studentID` AS `studentID`,sum(`learning_activity_progress`.`carReadinessPointsEarned`) AS `TotalActivityPoints` from `learning_activity_progress` group by `learning_activity_progress`.`studentID`) `lap` on((`s`.`studentID` = `lap`.`studentID`))) order by `TotalCarReadinessScore` desc limit 20 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-23  1:33:54
