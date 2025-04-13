-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: cruise
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cruise_id` int DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cruise_id` (`cruise_id`),
  CONSTRAINT `activities_ibfk_1` FOREIGN KEY (`cruise_id`) REFERENCES `cruises` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_registrations`
--

DROP TABLE IF EXISTS `activity_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_registrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `passenger_id` int DEFAULT NULL,
  `activity_id` int DEFAULT NULL,
  `registration_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `passenger_id` (`passenger_id`),
  KEY `activity_id` (`activity_id`),
  CONSTRAINT `activity_registrations_ibfk_1` FOREIGN KEY (`passenger_id`) REFERENCES `passengers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `activity_registrations_ibfk_2` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_registrations`
--

LOCK TABLES `activity_registrations` WRITE;
/*!40000 ALTER TABLE `activity_registrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardingpass`
--

DROP TABLE IF EXISTS `boardingpass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boardingpass` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_passenger_id` int DEFAULT NULL,
  `qr_code` varchar(255) NOT NULL,
  `scanned` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qr_code` (`qr_code`),
  KEY `booking_passenger_id` (`booking_passenger_id`),
  CONSTRAINT `boardingpass_ibfk_1` FOREIGN KEY (`booking_passenger_id`) REFERENCES `booking_passengers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardingpass`
--

LOCK TABLES `boardingpass` WRITE;
/*!40000 ALTER TABLE `boardingpass` DISABLE KEYS */;
INSERT INTO `boardingpass` VALUES (7,7,'pay_QII1iRKQbtwTSe$1',0,'2025-04-12 21:11:13'),(8,8,'pay_QII4H9J5h1ED9u$1',0,'2025-04-12 21:13:38'),(9,9,'pay_QIIAOTCZMXyBiA$1',0,'2025-04-12 21:19:25'),(10,10,'pay_QIIDQAoGpvGHiw$1',0,'2025-04-12 21:22:17'),(11,11,'pay_QIIIQcmLhplIc0$1',0,'2025-04-12 21:27:02'),(12,12,'pay_QIINdtDV4tzSml$1',0,'2025-04-12 21:31:58'),(13,13,'pay_QIIi8V2Js6XrF9$1',0,'2025-04-12 21:51:22'),(14,14,'pay_QIIm77EgThRNqW$1',0,'2025-04-12 21:55:08'),(15,15,'pay_QIIqNPUQLu2S99$1',0,'2025-04-12 21:59:10'),(16,16,'pay_QIIwrvgb9S86ee$1',0,'2025-04-12 22:05:19'),(17,17,'pay_QIJ0jMLQkUt43Z$2',0,'2025-04-12 22:08:58'),(18,18,'pay_QIU28L2QpSyDgA$1',0,'2025-04-13 08:55:56'),(19,19,'pay_QIU8WbizMKelVw$1',0,'2025-04-13 09:01:59'),(20,20,'pay_QIUBwz30Tco2Wl$3',0,'2025-04-13 09:05:14');
/*!40000 ALTER TABLE `boardingpass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_passengers`
--

DROP TABLE IF EXISTS `booking_passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_passengers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `passenger_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `passenger_id` (`passenger_id`),
  CONSTRAINT `booking_passengers_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `booking_passengers_ibfk_2` FOREIGN KEY (`passenger_id`) REFERENCES `passengers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_passengers`
--

LOCK TABLES `booking_passengers` WRITE;
/*!40000 ALTER TABLE `booking_passengers` DISABLE KEYS */;
INSERT INTO `booking_passengers` VALUES (7,7,1),(8,8,1),(9,9,1),(10,10,1),(11,11,1),(12,12,1),(13,13,1),(14,14,1),(15,15,1),(16,16,1),(17,17,2),(18,18,1),(19,19,1),(20,20,3);
/*!40000 ALTER TABLE `booking_passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_reference` varchar(255) NOT NULL,
  `cruise_id` int DEFAULT NULL,
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `booking_reference` (`booking_reference`),
  KEY `cruise_id` (`cruise_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`cruise_id`) REFERENCES `cruises` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_chk_1` CHECK ((`status` in (_utf8mb4'Confirmed',_utf8mb4'Cancelled',_utf8mb4'Pending')))
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (7,'BOOK-pay_QII1iRKQbtwTSe',1,'2025-04-12 21:11:13','Confirmed',89.00),(8,'BOOK-pay_QII4H9J5h1ED9u',2,'2025-04-12 21:13:38','Confirmed',1000.00),(9,'BOOK-pay_QIIAOTCZMXyBiA',2,'2025-04-12 21:19:25','Confirmed',1000.00),(10,'BOOK-pay_QIIDQAoGpvGHiw',1,'2025-04-12 21:22:17','Confirmed',89.00),(11,'BOOK-pay_QIIIQcmLhplIc0',2,'2025-04-12 21:27:02','Confirmed',1000.00),(12,'BOOK-pay_QIINdtDV4tzSml',2,'2025-04-12 21:31:58','Confirmed',1000.00),(13,'BOOK-pay_QIIi8V2Js6XrF9',2,'2025-04-12 21:51:22','Confirmed',1000.00),(14,'BOOK-pay_QIIm77EgThRNqW',2,'2025-04-12 21:55:08','Confirmed',1000.00),(15,'BOOK-pay_QIIqNPUQLu2S99',2,'2025-04-12 21:59:10','Confirmed',1000.00),(16,'BOOK-pay_QIIwrvgb9S86ee',1,'2025-04-12 22:05:19','Confirmed',89.00),(17,'BOOK-pay_QIJ0jMLQkUt43Z',1,'2025-04-12 22:08:58','Confirmed',89.00),(18,'BOOK-pay_QIU28L2QpSyDgA',1,'2025-04-13 08:55:56','Confirmed',89.00),(19,'BOOK-pay_QIU8WbizMKelVw',2,'2025-04-13 09:01:59','Confirmed',1000.00),(20,'BOOK-pay_QIUBwz30Tco2Wl',1,'2025-04-13 09:05:14','Confirmed',89.00);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cruises`
--

DROP TABLE IF EXISTS `cruises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cruises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ship_name` varchar(100) NOT NULL,
  `route` varchar(255) NOT NULL,
  `departure_date` date NOT NULL,
  `duration_days` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `cruises_chk_1` CHECK ((`status` in (_utf8mb4'Scheduled',_utf8mb4'Ongoing',_utf8mb4'Completed')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cruises`
--

LOCK TABLES `cruises` WRITE;
/*!40000 ALTER TABLE `cruises` DISABLE KEYS */;
INSERT INTO `cruises` VALUES (1,'kjbk','kjk','2025-03-29',89,89.00,'Scheduled'),(2,'bhu','america','2025-03-29',34,1000.00,'Ongoing');
/*!40000 ALTER TABLE `cruises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passengers`
--

DROP TABLE IF EXISTS `passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passengers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `passport_number` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `passport_number` (`passport_number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passengers`
--

LOCK TABLES `passengers` WRITE;
/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
INSERT INTO `passengers` VALUES (1,'Bhuvan','Tinani','bhuvantinani1000@outlook.com','8849411336','India','V234516','2025-04-11 17:00:01'),(2,'Bhuvan','K','bhuvantinani@gmail.com','1234567890','Switzerland','BWMIE','2025-04-12 22:08:25'),(3,'Bhuvan','Tinani','bhuvantinani1000@gmail.com','9924089520','Singapore','dsfjnwkjd','2025-04-13 09:04:39');
/*!40000 ALTER TABLE `passengers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payments_chk_1` CHECK ((`payment_method` in (_utf8mb4'Credit Card',_utf8mb4'Debit Card',_utf8mb4'Net Banking',_utf8mb4'UPI'))),
  CONSTRAINT `payments_chk_2` CHECK ((`status` in (_utf8mb4'Completed',_utf8mb4'Pending',_utf8mb4'Failed')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'Staff',
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (4,'abc','cba','Second Officer','01234567890','abc@mail.com','abc'),(5,'a','aa','Captain','01234567890','a@mail.com','a'),(6,'b','b','First Officer','01234567890','b@mail.com','b'),(7,'John','Smith','Captain','1234567890','john.smith@cruise.com','pass123'),(8,'David','Brown','Captain','1234567891','david.brown@cruise.com','pass123'),(9,'Michael','Johnson','Captain','1234567892','michael.johnson@cruise.com','pass123'),(10,'Alice','Davis','First Officer','1234567893','alice.davis@cruise.com','pass123'),(11,'Robert','Wilson','First Officer','1234567894','robert.wilson@cruise.com','pass123'),(12,'Emma','Moore','First Officer','1234567895','emma.moore@cruise.com','pass123'),(13,'Sophia','Taylor','Second Officer','1234567896','sophia.taylor@cruise.com','pass123'),(14,'James','Anderson','Second Officer','1234567897','james.anderson@cruise.com','pass123'),(15,'Olivia','Thomas','Second Officer','1234567898','olivia.thomas@cruise.com','pass123'),(16,'Ethan','Martin','Chief Engineer','1234567899','ethan.martin@cruise.com','pass123'),(17,'Liam','Harris','Chief Engineer','1234567800','liam.harris@cruise.com','pass123'),(18,'Charlotte','Thompson','Chief Engineer','1234567801','charlotte.thompson@cruise.com','pass123'),(19,'Benjamin','Garcia','Assistant Engineer','1234567802','benjamin.garcia@cruise.com','pass123'),(20,'Mia','Martinez','Assistant Engineer','1234567803','mia.martinez@cruise.com','pass123'),(21,'Lucas','Robinson','Assistant Engineer','1234567804','lucas.robinson@cruise.com','pass123'),(22,'Ella','Clark','Housekeeping','1234567805','ella.clark@cruise.com','pass123'),(23,'William','Rodriguez','Housekeeping','1234567806','william.rodriguez@cruise.com','pass123'),(24,'Ava','Lewis','Housekeeping','1234567807','ava.lewis@cruise.com','pass123'),(25,'Henry','Walker','Cleaner','1234567808','henry.walker@cruise.com','pass123'),(26,'Isabella','Hall','Cleaner','1234567809','isabella.hall@cruise.com','pass123'),(27,'Alexander','Allen','Cleaner','1234567810','alexander.allen@cruise.com','pass123'),(28,'Daniel','Young','Chef','1234567811','daniel.young@cruise.com','pass123'),(29,'Harper','King','Chef','1234567812','harper.king@cruise.com','pass123'),(30,'Sebastian','Wright','Chef','1234567813','sebastian.wright@cruise.com','pass123'),(31,'Jack','Lopez','Waiter','1234567814','jack.lopez@cruise.com','pass123'),(32,'Amelia','Scott','Waiter','1234567815','amelia.scott@cruise.com','pass123'),(33,'Elijah','Green','Waiter','1234567816','elijah.green@cruise.com','pass123'),(34,'Grayson','Adams','Receptionist','1234567817','grayson.adams@cruise.com','pass123'),(35,'Scarlett','Baker','Receptionist','1234567818','scarlett.baker@cruise.com','pass123'),(36,'Gabriel','Gonzalez','Receptionist','1234567819','gabriel.gonzalez@cruise.com','pass123'),(37,'Mateo','Nelson','Security Officer','1234567820','mateo.nelson@cruise.com','pass123'),(38,'Lily','Carter','Security Officer','1234567821','lily.carter@cruise.com','pass123'),(39,'Levi','Mitchell','Security Officer','1234567822','levi.mitchell@cruise.com','pass123'),(40,'Victoria','Perez','Bartender','1234567823','victoria.perez@cruise.com','pass123'),(41,'Dylan','Roberts','Bartender','1234567824','dylan.roberts@cruise.com','pass123'),(42,'Zoey','Turner','Bartender','1234567825','zoey.turner@cruise.com','pass123'),(43,'Nathan','Phillips','Entertainment Manager','1234567826','nathan.phillips@cruise.com','pass123'),(44,'Sofia','Campbell','Entertainment Manager','1234567827','sofia.campbell@cruise.com','pass123'),(45,'Eli','Parker','Entertainment Manager','1234567828','eli.parker@cruise.com','pass123'),(46,'Chloe','Evans','Medical Staff','1234567829','chloe.evans@cruise.com','pass123'),(47,'Luke','Edwards','Medical Staff','1234567830','luke.edwards@cruise.com','pass123'),(48,'Zoe','Collins','Medical Staff','1234567831','zoe.collins@cruise.com','pass123'),(49,'Ryan','Stewart','Crew Member','1234567832','ryan.stewart@cruise.com','pass123'),(50,'Mila','Sanchez','Crew Member','1234567833','mila.sanchez@cruise.com','pass123'),(51,'Evan','Morris','Crew Member','1234567834','evan.morris@cruise.com','pass123');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff_assignment`
--

DROP TABLE IF EXISTS `staff_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff_assignment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `staff_id` int DEFAULT NULL,
  `cruise_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `cruise_id` (`cruise_id`),
  CONSTRAINT `staff_assignment_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_assignment_ibfk_2` FOREIGN KEY (`cruise_id`) REFERENCES `cruises` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff_assignment`
--

LOCK TABLES `staff_assignment` WRITE;
/*!40000 ALTER TABLE `staff_assignment` DISABLE KEYS */;
INSERT INTO `staff_assignment` VALUES (37,5,1),(38,6,1),(39,4,1),(40,16,1),(41,19,1),(42,22,1),(43,27,1),(44,29,1),(45,32,1),(46,34,1),(47,38,1),(48,40,1),(49,44,1),(50,46,1),(51,49,1);
/*!40000 ALTER TABLE `staff_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) DEFAULT NULL,
  `payment_id` varchar(255) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `receipt` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `cruise_id` int DEFAULT NULL,
  `passenger_id` int DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `paid_time` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `FK_cruise_idx` (`cruise_id`),
  KEY `FK_passenger_idx` (`passenger_id`),
  CONSTRAINT `FK_cruise` FOREIGN KEY (`cruise_id`) REFERENCES `cruises` (`id`),
  CONSTRAINT `FK_passenger` FOREIGN KEY (`passenger_id`) REFERENCES `passengers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (15,'order_QII1WsrkWJw48v','pay_QII1iRKQbtwTSe','8900','order_rcptid_11','paid',1,1,'2025-04-13','02:40:46','2025-04-13 02:41:13'),(16,'order_QII46G6gW86iCa','pay_QII4H9J5h1ED9u','100000','order_rcptid_11','paid',2,1,'2025-04-13','02:43:12','2025-04-13 02:43:38'),(17,'order_QIIACAYe8a5ypa','pay_QIIAOTCZMXyBiA','100000','order_rcptid_11','paid',2,1,'2025-04-13','02:48:59','2025-04-13 02:49:25'),(18,'order_QIIDEGOJZNus2Z','pay_QIIDQAoGpvGHiw','8900','order_rcptid_11','paid',1,1,'2025-04-13','02:51:51','2025-04-13 02:52:17'),(19,'order_QIIIEi0j3XdreX','pay_QIIIQcmLhplIc0','100000','order_rcptid_11','paid',2,1,'2025-04-13','02:56:35','2025-04-13 02:57:02'),(20,'order_QIINS1WLEzwokD','pay_QIINdtDV4tzSml','100000','order_rcptid_11','paid',2,1,'2025-04-13','03:01:31','2025-04-13 03:01:58'),(21,'order_QIIhv9FoDfX0Ja','pay_QIIi8V2Js6XrF9','100000','order_rcptid_11','paid',2,1,'2025-04-13','03:20:53','2025-04-13 03:21:22'),(22,'order_QIIlt9Zcb0Ohzy','pay_QIIm77EgThRNqW','100000','order_rcptid_11','paid',2,1,'2025-04-13','03:24:40','2025-04-13 03:25:08'),(23,'order_QIIqC0H58EyoSB','pay_QIIqNPUQLu2S99','100000','order_rcptid_11','paid',2,1,'2025-04-13','03:28:44','2025-04-13 03:29:10'),(24,'order_QIIweUdHF8562V','pay_QIIwrvgb9S86ee','8900','order_rcptid_11','paid',1,1,'2025-04-13','03:34:51','2025-04-13 03:35:19'),(25,'order_QIJ0WOo6hSpb6G','pay_QIJ0jMLQkUt43Z','8900','order_rcptid_11','paid',1,2,'2025-04-13','03:38:31','2025-04-13 03:38:58'),(26,'order_QIU1rKgmoWL0Cv','pay_QIU28L2QpSyDgA','8900','order_rcptid_11','paid',1,1,'2025-04-13','14:25:23','2025-04-13 14:25:56'),(27,'order_QIU8DA3Nj0Jh6e','pay_QIU8WbizMKelVw','100000','order_rcptid_11','paid',2,1,'2025-04-13','14:31:25','2025-04-13 14:31:59'),(28,'order_QIUBhbIOkoUoiQ','pay_QIUBwz30Tco2Wl','8900','order_rcptid_11','paid',1,3,'2025-04-13','14:34:44','2025-04-13 14:35:14');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','Staff','Passenger') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@mail.com','admin','Admin','2025-03-14 16:08:03'),(2,'bhuvantinani1000@outlook.com','123','Passenger','2025-03-15 12:59:25'),(7,'mail@qw.com','erty','Passenger','2025-03-15 13:08:09'),(8,'as@mail.com','as1','Passenger','2025-03-23 16:48:09'),(9,'bhuvantinani@gmail.com','123','Passenger','2025-04-12 22:07:48'),(10,'bhuvantinani1000@gmail.com','123','Passenger','2025-04-13 09:03:52');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-13 22:22:47
