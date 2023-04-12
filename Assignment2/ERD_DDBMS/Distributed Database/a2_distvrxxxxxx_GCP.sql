-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: xx.xxx.xxx.xxx    Database: a2_distvrxxxxxx
-- ------------------------------------------------------
-- Server version	8.0.26-google

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '33b0480c-5186-11ed-adb3-42010a800005:1-2868';

--
-- Table structure for table `equipments`
--

DROP TABLE IF EXISTS `equipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipments` (
  `equipID` int NOT NULL AUTO_INCREMENT,
  `equipName` varchar(45) DEFAULT NULL,
  `availableQty` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`equipID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipments`
--

LOCK TABLES `equipments` WRITE;
/*!40000 ALTER TABLE `equipments` DISABLE KEYS */;
INSERT INTO `equipments` VALUES (1,'camp',23,3.5),(2,'RV 5people',15,56),(3,'RV 10people',6,56),(4,'twin camp',37,7.21);
/*!40000 ALTER TABLE `equipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventapplication`
--

DROP TABLE IF EXISTS `eventapplication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventapplication` (
  `appID` int NOT NULL AUTO_INCREMENT,
  `eventName` varchar(45) DEFAULT NULL,
  `eventHost` varchar(45) DEFAULT NULL,
  `count` varchar(45) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `appStatus` varchar(45) DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `parkID` int DEFAULT NULL,
  PRIMARY KEY (`appID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventapplication`
--

LOCK TABLES `eventapplication` WRITE;
/*!40000 ALTER TABLE `eventapplication` DISABLE KEYS */;
INSERT INTO `eventapplication` VALUES (1,'Anjunadeep Ben Bohmer Live','viraj','150','2022-09-27','2022-09-27 17:30:00','approved',1,2),(2,'Deephouse Rave','viraj','14','2022-06-15','2022-06-15 23:59:00','approved',1,4),(3,'Goa Psy Party','viraj','60','2022-10-05','2022-10-05 04:30:00','approved',1,1);
/*!40000 ALTER TABLE `eventapplication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reservationID` int NOT NULL AUTO_INCREMENT,
  `reservationName` varchar(45) DEFAULT NULL,
  `arr_date` date DEFAULT NULL,
  `dep_date` date DEFAULT NULL,
  `countOfPax` int DEFAULT NULL,
  `reservType` varchar(45) DEFAULT NULL,
  `equipID` int DEFAULT NULL,
  `totalAmt` double DEFAULT NULL,
  `parkID` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  PRIMARY KEY (`reservationID`),
  KEY `FK1_RES_EQUIP_idx` (`equipID`),
  CONSTRAINT `FK1_RES_EQUIP` FOREIGN KEY (`equipID`) REFERENCES `equipments` (`equipID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (1,'robert','2022-07-12','2022-07-14',2,'online',1,3.5,2,3),(2,'jay','2022-08-15','2022-08-17',1,'phone',2,56,1,1),(3,'utsav','2022-09-01','2022-09-15',2,'online',4,7.21,4,2);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-27 15:27:50
