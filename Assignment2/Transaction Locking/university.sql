-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: uni
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `alumni`
--

DROP TABLE IF EXISTS `alumni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumni` (
  `alumni_id` int NOT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `program_id` varchar(45) DEFAULT NULL,
  `passout_batch` varchar(4) DEFAULT NULL,
  `UNIVERSITY_uni_name` varchar(45) NOT NULL,
  PRIMARY KEY (`alumni_id`,`UNIVERSITY_uni_name`),
  UNIQUE KEY `alumni_id_UNIQUE` (`alumni_id`),
  KEY `fk_Alumni_UNIVERSITY1_idx` (`UNIVERSITY_uni_name`),
  CONSTRAINT `fk_Alumni_UNIVERSITY1` FOREIGN KEY (`UNIVERSITY_uni_name`) REFERENCES `university` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni`
--

LOCK TABLES `alumni` WRITE;
/*!40000 ALTER TABLE `alumni` DISABLE KEYS */;
/*!40000 ALTER TABLE `alumni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application` (
  `application_Id` int NOT NULL,
  `application_status` varchar(45) DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  PRIMARY KEY (`application_Id`),
  KEY `fk_app_stud_idx` (`student_id`),
  CONSTRAINT `fk_app_stud` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `athletics_center`
--

DROP TABLE IF EXISTS `athletics_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `athletics_center` (
  `name` int NOT NULL,
  `facility_time` datetime DEFAULT NULL,
  `UNIVERSITY_uni_name` varchar(45) NOT NULL,
  PRIMARY KEY (`name`,`UNIVERSITY_uni_name`),
  KEY `fk_ATHLETICS_CENTER_UNIVERSITY1_idx` (`UNIVERSITY_uni_name`),
  CONSTRAINT `fk_ATHLETICS_CENTER_UNIVERSITY1` FOREIGN KEY (`UNIVERSITY_uni_name`) REFERENCES `university` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `athletics_center`
--

LOCK TABLES `athletics_center` WRITE;
/*!40000 ALTER TABLE `athletics_center` DISABLE KEYS */;
/*!40000 ALTER TABLE `athletics_center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `author_id` int NOT NULL,
  `author_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (501,'HC Verma'),(502,'Jayesh Mamtora'),(503,'RD Sharma');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `book_Id` int NOT NULL,
  `book_name` varchar(45) DEFAULT NULL,
  `book_price` decimal(10,0) DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  PRIMARY KEY (`book_Id`),
  KEY `fk_book_auth_idx` (`author_id`),
  CONSTRAINT `fk_book_auth` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (101,'Concepts of Physics',5,501),(102,'Concepts of Maths',6,503),(103,'Concepts of Chemistry',13,502),(104,'Adv Physics',17,501);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookborrowed`
--

DROP TABLE IF EXISTS `bookborrowed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookborrowed` (
  `book_Id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `library_id` int DEFAULT NULL,
  KEY `fk2_bookBorr_Lib_idx` (`library_id`),
  KEY `fk3_bookBorr_Stud_idx` (`student_id`),
  KEY `fk1_bookBorr_Book` (`book_Id`),
  CONSTRAINT `fk1_bookBorr_Book` FOREIGN KEY (`book_Id`) REFERENCES `book` (`book_Id`),
  CONSTRAINT `fk2_bookBorr_Lib` FOREIGN KEY (`library_id`) REFERENCES `library` (`library_id`),
  CONSTRAINT `fk3_bookBorr_Stud` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookborrowed`
--

LOCK TABLES `bookborrowed` WRITE;
/*!40000 ALTER TABLE `bookborrowed` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookborrowed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookstore`
--

DROP TABLE IF EXISTS `bookstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookstore` (
  `building_id` int NOT NULL,
  `building_type` varchar(45) NOT NULL DEFAULT 'Bookstore',
  `book_name` varchar(45) DEFAULT NULL,
  `book_amount` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`building_id`,`building_type`),
  CONSTRAINT `fk1_book_build` FOREIGN KEY (`building_id`, `building_type`) REFERENCES `building` (`building_id`, `building_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookstore`
--

LOCK TABLES `bookstore` WRITE;
/*!40000 ALTER TABLE `bookstore` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookstore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `building` (
  `building_id` int NOT NULL,
  `building_name` varchar(45) DEFAULT NULL,
  `building_addr` varchar(45) DEFAULT NULL,
  `building_type` varchar(45) NOT NULL,
  `UNIVERSITY_uni_name` varchar(45) NOT NULL,
  PRIMARY KEY (`building_id`,`building_type`,`UNIVERSITY_uni_name`),
  UNIQUE KEY `building_id_UNIQUE` (`building_id`),
  KEY `fk_Building_UNIVERSITY1_idx` (`UNIVERSITY_uni_name`),
  CONSTRAINT `fk_Building_UNIVERSITY1` FOREIGN KEY (`UNIVERSITY_uni_name`) REFERENCES `university` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campuses`
--

DROP TABLE IF EXISTS `campuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campuses` (
  `campus_name` varchar(45) NOT NULL,
  `campus_addr` varchar(45) DEFAULT NULL,
  `campus_map` geometry DEFAULT NULL,
  `UNIVERSITY_uni_name` varchar(45) NOT NULL,
  PRIMARY KEY (`campus_name`,`UNIVERSITY_uni_name`),
  UNIQUE KEY `campus_name_UNIQUE` (`campus_name`),
  KEY `fk_Campuses_UNIVERSITY1_idx` (`UNIVERSITY_uni_name`),
  CONSTRAINT `fk_Campuses_UNIVERSITY1` FOREIGN KEY (`UNIVERSITY_uni_name`) REFERENCES `university` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campuses`
--

LOCK TABLES `campuses` WRITE;
/*!40000 ALTER TABLE `campuses` DISABLE KEYS */;
INSERT INTO `campuses` VALUES ('Studley','Halifax',_binary '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','Dalhousie University');
/*!40000 ALTER TABLE `campuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classroom` (
  `class_Id` int NOT NULL,
  `classroom_name` varchar(45) DEFAULT NULL,
  `classroom_addr` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`class_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES (143,'Tupper Theater','CHEB'),(144,'Auditorium','Goldberg'),(145,'KC ROWE','1020');
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communities` (
  `comm_name` varchar(45) NOT NULL,
  `events` varchar(45) DEFAULT NULL,
  `UNIVERSITY_uni_name` varchar(45) NOT NULL,
  PRIMARY KEY (`comm_name`,`UNIVERSITY_uni_name`),
  UNIQUE KEY `comm_name_UNIQUE` (`comm_name`),
  KEY `fk_Communities_UNIVERSITY1_idx` (`UNIVERSITY_uni_name`),
  CONSTRAINT `fk_Communities_UNIVERSITY1` FOREIGN KEY (`UNIVERSITY_uni_name`) REFERENCES `university` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int NOT NULL,
  `course_name` varchar(45) DEFAULT NULL,
  `course_credits` varchar(45) DEFAULT NULL,
  `Program_Department_dept_id` int DEFAULT NULL,
  `student_Id` int NOT NULL,
  `FACULTY_faculty_id` int DEFAULT NULL,
  `class_Id` int DEFAULT NULL,
  `lab_id` int DEFAULT NULL,
  PRIMARY KEY (`course_id`,`student_Id`),
  KEY `fk_Course_Program1_idx` (`Program_Department_dept_id`),
  KEY `fk_course_student_idx` (`student_Id`),
  KEY `fk_Course_FACULTY1_idx` (`FACULTY_faculty_id`),
  KEY `fk_Course_Classroom1_idx` (`class_Id`),
  KEY `fk_Course_Laboratory1_idx` (`lab_id`),
  CONSTRAINT `fk_Course_Classroom1` FOREIGN KEY (`class_Id`) REFERENCES `classroom` (`class_Id`),
  CONSTRAINT `fk_Course_FACULTY1` FOREIGN KEY (`FACULTY_faculty_id`) REFERENCES `faculty` (`faculty_id`),
  CONSTRAINT `fk_Course_Laboratory1` FOREIGN KEY (`lab_id`) REFERENCES `laboratory` (`lab_id`),
  CONSTRAINT `fk_Course_Program1` FOREIGN KEY (`Program_Department_dept_id`) REFERENCES `program` (`Department_dept_id`),
  CONSTRAINT `fk_course_student` FOREIGN KEY (`student_Id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (5308,'ASDC','3',21,924759,103,144,154),(5408,'DWBA','3',21,924759,102,144,154);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dalcard`
--

DROP TABLE IF EXISTS `dalcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dalcard` (
  `idDalCard` int NOT NULL,
  `Upass_Start_Date` date DEFAULT NULL,
  `Upass_End_Date` date DEFAULT NULL,
  `card_balance` double DEFAULT NULL,
  `card_transaction` varchar(45) DEFAULT NULL,
  `trans_amount` double DEFAULT NULL,
  `Student_student_id` int NOT NULL,
  PRIMARY KEY (`idDalCard`,`Student_student_id`),
  KEY `fk_DalCard_Student1_idx` (`Student_student_id`),
  CONSTRAINT `fk_DalCard_Student1` FOREIGN KEY (`Student_student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dalcard`
--

LOCK TABLES `dalcard` WRITE;
/*!40000 ALTER TABLE `dalcard` DISABLE KEYS */;
INSERT INTO `dalcard` VALUES (924759,'2022-08-01','2023-04-01',500,'Book Purchase',9,924759);
/*!40000 ALTER TABLE `dalcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dean`
--

DROP TABLE IF EXISTS `dean`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dean` (
  `faculty_id` int DEFAULT NULL,
  `faculty_type` varchar(45) DEFAULT NULL,
  `office_address` varchar(45) DEFAULT 'Dean',
  KEY `fk1_dean_faculty` (`faculty_id`),
  CONSTRAINT `fk1_dean_faculty` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dean`
--

LOCK TABLES `dean` WRITE;
/*!40000 ALTER TABLE `dean` DISABLE KEYS */;
/*!40000 ALTER TABLE `dean` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dept_id` int NOT NULL,
  `dept_name` varchar(45) DEFAULT NULL,
  `dept_head` int DEFAULT NULL,
  `UNIVERSITY_uni_name` varchar(45) NOT NULL,
  PRIMARY KEY (`dept_id`,`UNIVERSITY_uni_name`),
  UNIQUE KEY `idDepartment_UNIQUE` (`dept_id`),
  KEY `fk_Department_UNIVERSITY_idx` (`UNIVERSITY_uni_name`),
  KEY `fk_Depart_Faculty_idx` (`dept_head`),
  CONSTRAINT `fk_Depart_Faculty` FOREIGN KEY (`dept_head`) REFERENCES `faculty` (`faculty_id`),
  CONSTRAINT `fk_Department_UNIVERSITY` FOREIGN KEY (`UNIVERSITY_uni_name`) REFERENCES `university` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (21,'Faculty of Computer Science',101,'Dalhousie University');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examination`
--

DROP TABLE IF EXISTS `examination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examination` (
  `exam_id` int NOT NULL,
  `exam_date` datetime DEFAULT NULL,
  `Course_course_id` int NOT NULL,
  PRIMARY KEY (`exam_id`,`Course_course_id`),
  KEY `fk_Examination_Course1_idx` (`Course_course_id`),
  CONSTRAINT `fk_Examination_Course1` FOREIGN KEY (`Course_course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examination`
--

LOCK TABLES `examination` WRITE;
/*!40000 ALTER TABLE `examination` DISABLE KEYS */;
/*!40000 ALTER TABLE `examination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `faculty_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `experience` decimal(4,2) DEFAULT NULL,
  `faculty_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES (101,'A Chaplin',23.50,'Dean'),(102,'Saurabh Dey',5.50,'Instructor'),(103,'Robert Hawkey',9.80,'Instructor');
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foodbank`
--

DROP TABLE IF EXISTS `foodbank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foodbank` (
  `building_id` int NOT NULL,
  `building_type` varchar(45) NOT NULL DEFAULT 'foodbank',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`building_id`,`building_type`),
  CONSTRAINT `fk1_food_build` FOREIGN KEY (`building_id`, `building_type`) REFERENCES `building` (`building_id`, `building_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foodbank`
--

LOCK TABLES `foodbank` WRITE;
/*!40000 ALTER TABLE `foodbank` DISABLE KEYS */;
/*!40000 ALTER TABLE `foodbank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housing`
--

DROP TABLE IF EXISTS `housing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housing` (
  `hostel_id` int NOT NULL,
  `hostel_name` varchar(45) DEFAULT NULL,
  `room_number` int DEFAULT NULL,
  `room_status` varchar(45) DEFAULT NULL,
  `Campuses_campus_name` varchar(45) NOT NULL,
  PRIMARY KEY (`hostel_id`,`Campuses_campus_name`),
  KEY `fk_Housing_Campuses1_idx` (`Campuses_campus_name`),
  CONSTRAINT `fk_Housing_Campuses1` FOREIGN KEY (`Campuses_campus_name`) REFERENCES `campuses` (`campus_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housing`
--

LOCK TABLES `housing` WRITE;
/*!40000 ALTER TABLE `housing` DISABLE KEYS */;
/*!40000 ALTER TABLE `housing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor` (
  `faculty_id` int NOT NULL,
  `faculty_type` varchar(45) NOT NULL DEFAULT 'I',
  `office_hours` date DEFAULT NULL,
  PRIMARY KEY (`faculty_id`,`faculty_type`),
  CONSTRAINT `fk1_inst_facu` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance`
--

DROP TABLE IF EXISTS `insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insurance` (
  `insurance_name` varchar(45) NOT NULL,
  `insured_amount` decimal(10,0) DEFAULT NULL,
  `Student_student_id` int NOT NULL,
  PRIMARY KEY (`insurance_name`,`Student_student_id`),
  KEY `fk_Insurance_Student1_idx` (`Student_student_id`),
  CONSTRAINT `fk_Insurance_Student1` FOREIGN KEY (`Student_student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance`
--

LOCK TABLES `insurance` WRITE;
/*!40000 ALTER TABLE `insurance` DISABLE KEYS */;
/*!40000 ALTER TABLE `insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `international_center`
--

DROP TABLE IF EXISTS `international_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `international_center` (
  `intl_events` varchar(45) NOT NULL,
  `Communities_comm_name` varchar(45) NOT NULL,
  PRIMARY KEY (`intl_events`,`Communities_comm_name`),
  KEY `fk_International_Center_Communities1_idx` (`Communities_comm_name`),
  CONSTRAINT `fk_International_Center_Communities1` FOREIGN KEY (`Communities_comm_name`) REFERENCES `communities` (`comm_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `international_center`
--

LOCK TABLES `international_center` WRITE;
/*!40000 ALTER TABLE `international_center` DISABLE KEYS */;
/*!40000 ALTER TABLE `international_center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratory`
--

DROP TABLE IF EXISTS `laboratory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratory` (
  `lab_name` varchar(45) DEFAULT NULL,
  `lab_addr` varchar(45) DEFAULT NULL,
  `lab_id` int NOT NULL,
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory`
--

LOCK TABLES `laboratory` WRITE;
/*!40000 ALTER TABLE `laboratory` DISABLE KEYS */;
INSERT INTO `laboratory` VALUES ('Data Science Laboratory','Goldberg',154),('AI Laboratory','Goldberg',313);
/*!40000 ALTER TABLE `laboratory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library`
--

DROP TABLE IF EXISTS `library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library` (
  `library_id` int NOT NULL,
  `library_name` varchar(45) DEFAULT NULL,
  `Campuses_campus_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`library_id`),
  UNIQUE KEY `library_id_UNIQUE` (`library_id`),
  KEY `fk_Library_Campuses1_idx` (`Campuses_campus_name`),
  CONSTRAINT `fk_Library_Campuses1` FOREIGN KEY (`Campuses_campus_name`) REFERENCES `campuses` (`campus_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library`
--

LOCK TABLES `library` WRITE;
/*!40000 ALTER TABLE `library` DISABLE KEYS */;
INSERT INTO `library` VALUES (1,'Killam Memorial','Studley'),(2,'Kellog','Studley'),(3,'Keith','Studley');
/*!40000 ALTER TABLE `library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office`
--

DROP TABLE IF EXISTS `office`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `office` (
  `building_id` int NOT NULL,
  `building_type` varchar(45) NOT NULL,
  `office_addr` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`building_id`,`building_type`),
  CONSTRAINT `fk1_off_build` FOREIGN KEY (`building_id`, `building_type`) REFERENCES `building` (`building_id`, `building_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office`
--

LOCK TABLES `office` WRITE;
/*!40000 ALTER TABLE `office` DISABLE KEYS */;
/*!40000 ALTER TABLE `office` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor` (
  `fauclty_id` int NOT NULL,
  `faculty_type` varchar(45) NOT NULL DEFAULT 'Professor',
  `office_hours` datetime DEFAULT NULL,
  PRIMARY KEY (`fauclty_id`,`faculty_type`),
  CONSTRAINT `fk1_prof_faculty` FOREIGN KEY (`fauclty_id`) REFERENCES `faculty` (`faculty_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `program` (
  `prog_id` varchar(45) NOT NULL,
  `prog_name` varchar(45) DEFAULT NULL,
  `prog_head` varchar(45) DEFAULT NULL,
  `Department_dept_id` int DEFAULT NULL,
  `Department_UNIVERSITY_uni_name` varchar(45) DEFAULT NULL,
  `TutionFees_tutionFees` decimal(16,8) DEFAULT NULL,
  PRIMARY KEY (`prog_id`),
  KEY `fk_Program_Department1_idx` (`Department_dept_id`,`Department_UNIVERSITY_uni_name`),
  KEY `fk_Program_TutionFees1_idx` (`TutionFees_tutionFees`),
  CONSTRAINT `fk_Program_Department1` FOREIGN KEY (`Department_dept_id`, `Department_UNIVERSITY_uni_name`) REFERENCES `department` (`dept_id`, `UNIVERSITY_uni_name`),
  CONSTRAINT `fk_Program_TutionFees1` FOREIGN KEY (`TutionFees_tutionFees`) REFERENCES `tutionfees` (`tutionFees`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `program`
--

LOCK TABLES `program` WRITE;
/*!40000 ALTER TABLE `program` DISABLE KEYS */;
INSERT INTO `program` VALUES ('1331','MACS','Michael',21,'Dalhousie University',40000.45000000);
/*!40000 ALTER TABLE `program` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `schedule_id` int NOT NULL,
  `schedule_info` varchar(45) DEFAULT NULL,
  `Course_course_id` int DEFAULT NULL,
  `Course_Program_Department_dept_id` int DEFAULT NULL,
  PRIMARY KEY (`schedule_id`),
  UNIQUE KEY `schedule_id_UNIQUE` (`schedule_id`),
  KEY `fk_Schedule_Course1_idx` (`Course_course_id`),
  CONSTRAINT `fk1_Schedule_Course` FOREIGN KEY (`Course_course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scholarship`
--

DROP TABLE IF EXISTS `scholarship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scholarship` (
  `schol_id` int NOT NULL,
  `schol_name` varchar(45) DEFAULT NULL,
  `schol_amount` varchar(45) DEFAULT NULL,
  `Student_student_id` int NOT NULL,
  `UNIVERSITY_uni_name` varchar(45) NOT NULL,
  PRIMARY KEY (`schol_id`,`Student_student_id`,`UNIVERSITY_uni_name`),
  KEY `fk_SCHOLARSHIP_Student1_idx` (`Student_student_id`),
  KEY `fk_SCHOLARSHIP_UNIVERSITY1_idx` (`UNIVERSITY_uni_name`),
  CONSTRAINT `fk_SCHOLARSHIP_Student1` FOREIGN KEY (`Student_student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `fk_SCHOLARSHIP_UNIVERSITY1` FOREIGN KEY (`UNIVERSITY_uni_name`) REFERENCES `university` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scholarship`
--

LOCK TABLES `scholarship` WRITE;
/*!40000 ALTER TABLE `scholarship` DISABLE KEYS */;
/*!40000 ALTER TABLE `scholarship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL,
  `student_name` varchar(45) DEFAULT NULL,
  `student_DOB` date DEFAULT NULL,
  `UNIVERSITY_uni_name` varchar(45) NOT NULL,
  PRIMARY KEY (`student_id`,`UNIVERSITY_uni_name`),
  UNIQUE KEY `student_id_UNIQUE` (`student_id`),
  KEY `fk_Student_UNIVERSITY1_idx` (`UNIVERSITY_uni_name`),
  CONSTRAINT `fk_Student_UNIVERSITY1` FOREIGN KEY (`UNIVERSITY_uni_name`) REFERENCES `university` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (924759,'Viraj','1996-10-29','Dalhousie University'),(924760,'Adam','1998-10-23','Dalhousie University');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentgrades`
--

DROP TABLE IF EXISTS `studentgrades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentgrades` (
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  `grades` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`student_id`,`course_id`),
  KEY `fk2-grade_course_idx` (`course_id`),
  CONSTRAINT `fk1_grade_stud` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `fk2-grade_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentgrades`
--

LOCK TABLES `studentgrades` WRITE;
/*!40000 ALTER TABLE `studentgrades` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentgrades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutionfees`
--

DROP TABLE IF EXISTS `tutionfees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutionfees` (
  `tutionFees` decimal(16,8) NOT NULL,
  PRIMARY KEY (`tutionFees`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutionfees`
--

LOCK TABLES `tutionfees` WRITE;
/*!40000 ALTER TABLE `tutionfees` DISABLE KEYS */;
INSERT INTO `tutionfees` VALUES (40000.45000000);
/*!40000 ALTER TABLE `tutionfees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university`
--

DROP TABLE IF EXISTS `university`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `university` (
  `uni_name` varchar(45) NOT NULL,
  `uni_addr` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`uni_name`),
  UNIQUE KEY `university_name_UNIQUE` (`uni_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university`
--

LOCK TABLES `university` WRITE;
/*!40000 ALTER TABLE `university` DISABLE KEYS */;
INSERT INTO `university` VALUES ('Dalhousie University','Halifax,Nova Scotia,Canada');
/*!40000 ALTER TABLE `university` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-27 16:21:06
