CREATE DATABASE  IF NOT EXISTS `carrentaldb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `carrentaldb`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: carrentaldb
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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `BOOKING_ID` int NOT NULL AUTO_INCREMENT,
  `CUSTOMER_ID` int DEFAULT NULL,
  `VEHICLES_ID` int DEFAULT NULL,
  `BOOKINGDATE` date DEFAULT NULL,
  `STARTDATE` date DEFAULT NULL,
  `ENDDATE` date DEFAULT NULL,
  `TOTALAMOUNT` int DEFAULT NULL,
  PRIMARY KEY (`BOOKING_ID`),
  KEY `CUSTOMER_ID` (`CUSTOMER_ID`),
  KEY `VEHICLES_ID` (`VEHICLES_ID`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `customers` (`CUSTOMER_ID`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`VEHICLES_ID`) REFERENCES `vehicles` (`VEHICLES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (6,1,1,'2025-08-01','2025-08-02','2025-08-06',7200),(7,2,2,'2025-08-03','2025-08-04','2025-08-08',8000),(8,1,3,'2025-08-08','2025-08-08','2025-08-31',46000);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `BRANCH_ID` int NOT NULL AUTO_INCREMENT,
  `BRACHNAME` varchar(50) DEFAULT NULL,
  `LOCATION` varchar(50) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`BRANCH_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'Uttara Branch','Uttara, Dhaka','01700000001'),(2,'Dhanmondi Branch','Dhanmondi, Dhaka','01700000002'),(3,'Uttara Branch','Uttara, Dhaka','01700000001'),(4,'Dhanmondi Branch','Dhanmondi, Dhaka','01700000002');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CUSTOMER_ID` int NOT NULL AUTO_INCREMENT,
  `CUSTOMERNAME` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL,
  `DRIVER_LICENSE` varchar(50) DEFAULT NULL,
  `NATIONAL_ID` varchar(50) DEFAULT NULL,
  `PASSWORD_HASH` varchar(255) NOT NULL,
  PRIMARY KEY (`CUSTOMER_ID`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  UNIQUE KEY `PHONE` (`PHONE`),
  UNIQUE KEY `DRIVER_LICENSE` (`DRIVER_LICENSE`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'MD Anis Ahmed','mdanisahmed388@gmail.com','01988087533','D123456789\'','6024601731','scrypt:32768:8:1$fdYKKmmz193PMdQo$a9b326ec1d219e6c91367918f4b7a528f28ebe4cdd67f3f820776037f253ec94ace522226487505d845d0d0cf6c9d689673821f5de04ff188701825f451ae921'),(2,'Rahat','rahat123@gmail.com','01988888888','d1111111111111111','16102222222','scrypt:32768:8:1$BEZXjt4d6LEl1LVP$cc7762effe8ba4a84685073c1c974a849359a172c0a5a8698e71121279205ecc0878dda6ace65c111b82a195b70237d1d9915311aa5f0bcf35cba5166a55eb84'),(3,'Nahamu','nahamu1234@gmail.com','01988888887','d111222222','16102222222','scrypt:32768:8:1$UCQaTg2AvPLKB8kg$02447558d3d1c02dc186c8bcfd7e5cf01ed0a6a68e3bfc1bd8d06e15a9fce0bacc479306206cb4354486b5684ccbd9112354c76219bd47d43a13169abe6e3187'),(5,'akm','akm@gmail.com','01111111111111','D1234567100\'','0144444444','scrypt:32768:8:1$scJtBctpCqv5LTeQ$6e39cabc6a4dfa1ad56fe511a57ed3ac783ce854546a95bda4e2f39d09974c0a140f941b9a7a7bf674b54fa2c65ac9d911b92681864691798386af50afcd0336'),(6,'tarikul ','tarik@gmail.com','01877777777','D123456777\'','145987452664','scrypt:32768:8:1$sxRVHeseqPN16uek$195e984f4f274579acded2fe8f9c2222d029ebeb4766fb286c16b5da3c581a2ee5e3cd4438c37c28ac72182776d78e8ba1f4283abc5b41f360f7e06530429d78'),(7,'John Doe','john@example.com','0123456789','DL123456','NID123456','1'),(8,'Alice Karim','alice@gmail.com','01810000001','DL12345','NID12345','hashed_password_1'),(9,'Rafiul Islam','rafi@gmail.com','01810000002','DL54321','NID54321','hashed_password_2'),(10,'Tarikul islam ','tarik1@gmail.com','01900000000','D123455555\'','62014555845','scrypt:32768:8:1$eeQuKy5RAgpNCUMZ$fcadc9ef1310f188d705359e4e97606e4a3125d24be0802b5a5418e1dc631198113fc2b19b8fcea92a6a50ee4a38921ec93b4f70a5f4aad10f8d4af6858bfdc2'),(11,'BB','bb@gmail.com','01444444444','D123456789014\'','602460173444','scrypt:32768:8:1$PjhSIXVQL72MXAIi$42e342dd6b653f313d48ae0e2fd7b6dd7f7e08dee645c6f4c89a903bc2c70feb6b347c1c177e1350d731500c2040aa8417539bf693aba7c5d6bb46bd74412328');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `EMPLOYEE_ID` int NOT NULL AUTO_INCREMENT,
  `EMPLOYEE_NAME` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `PHONE` varchar(50) DEFAULT NULL,
  `HIREDATE` date DEFAULT NULL,
  `PASSWORD_HASH` varchar(255) NOT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  UNIQUE KEY `EMAIL` (`EMAIL`),
  UNIQUE KEY `PHONE` (`PHONE`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'MD Anis Ahmed','mdanisahmed389@gmail.com','01988087533','2025-08-08','scrypt:32768:8:1$SeZPZxp91IdVDrwc$8ee8b90cdd1c7227f3dc7e6b587b024dd0b779160f17d528c518d750b9638b1699d168e1d173c0201a2583925da9750ba82dea2d5401280a06d96436b762f22e'),(2,'rojoni ','rojoni123@gmail.com','01988887777','2025-08-07','scrypt:32768:8:1$dp529SNrAIeh0rDa$d29e12b1273a91815ae7569e1f50432b475a33be9afcf0bb0532c19eb802c25cd091706a2589d7ee9ea628debd651caf6fc5814832f68f81a98cabf0386621d4'),(3,'rojoni ','rojoni@gmail.com','01444444445','2025-08-08','scrypt:32768:8:1$hMtGerawVd2x8mhE$e61c14de80e12c6464aa0be87fbf710ba79d2dc8919552bc48b50bc1c5939bbcee281ffb5db7189a71fac3f0a789306011457db9bb643c88b7e8c923ae18a499'),(5,'aa','aa@gmail.com','01111111111','2025-08-08','scrypt:32768:8:1$uOjkxmGrCWgmZFiO$a0a8c6f9436bbabeedc1b5308fbd1fc7c5fe0395f2bf3d453de18b0aae24b53fc01d281739a08bef55cfa758d93121f6a4b5fa911f0a7783fd41d7c9f4164f57'),(7,'aaa','aaa@gmail.com','01222222222','2025-08-08','scrypt:32768:8:1$TNwRYwLr2iZMqPhf$7e384ba3c68fb5836dccd1a9228df49a7d567f5caef9322ea372bdcdafb2af8ac79ec052bf4be86836932616b9235cfd5bffabda702cae06d232629fd52999ee'),(8,'Mehedi Hasan','mehedi@gmail.com','01710000003','2023-06-01','hashed_password1'),(9,'Nusrat Jahan','nusrat@gmail.com','01710000004','2024-01-15','hashed_password2'),(10,'anis','anis@gmail.com','01888888888','2025-08-08','scrypt:32768:8:1$1brHAfaabfrPNaVH$dc39f36f56bb5dd42f51f22404a1741706758022b69e921092eac4fe888d8b6c27341cfa8aa8885ba139c07b147d62ba8c5a8ae8b101c1c5adbdf23bc0a8fc47');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedbacks` (
  `FEEDBACK_ID` int NOT NULL AUTO_INCREMENT,
  `CUSTOMER_ID` int DEFAULT NULL,
  `COMMENTS` text,
  `RATING` int DEFAULT NULL,
  `FEEDBACKDATE` date DEFAULT NULL,
  PRIMARY KEY (`FEEDBACK_ID`),
  KEY `CUSTOMER_ID` (`CUSTOMER_ID`),
  CONSTRAINT `feedbacks_ibfk_1` FOREIGN KEY (`CUSTOMER_ID`) REFERENCES `customers` (`CUSTOMER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedbacks`
--

LOCK TABLES `feedbacks` WRITE;
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
INSERT INTO `feedbacks` VALUES (1,1,'Great service and smooth booking!',5,'2025-08-07'),(2,2,'Car was clean and on time.',4,'2025-08-08');
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `PAYMENT_ID` int NOT NULL AUTO_INCREMENT,
  `BOOKING_ID` int DEFAULT NULL,
  `PAYMENTDATE` date DEFAULT NULL,
  `AMOUNTPAID` int DEFAULT NULL,
  `PAYMENTMETHOD` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PAYMENT_ID`),
  KEY `BOOKING_ID` (`BOOKING_ID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`BOOKING_ID`) REFERENCES `bookings` (`BOOKING_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `VEHICLES_ID` int NOT NULL AUTO_INCREMENT,
  `MODEL` varchar(50) DEFAULT NULL,
  `BRAND` varchar(50) DEFAULT NULL,
  `REGISTRATION` varchar(50) DEFAULT NULL,
  `RENTPERDAY` int DEFAULT NULL,
  `LASTSERVICEDATE` date DEFAULT NULL,
  PRIMARY KEY (`VEHICLES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES (1,'Corolla X','Toyota','DHA-1234',1800,'2025-07-15'),(2,'Corolla','Toyota','DHA-1111',1800,'2025-07-01'),(3,'Civic','Honda','DHA-2222',2000,'2025-07-03');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles_availability`
--

DROP TABLE IF EXISTS `vehicles_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles_availability` (
  `AVAILABILITY_ID` int NOT NULL AUTO_INCREMENT,
  `VEHICLES_ID` int DEFAULT NULL,
  `AVAILABLE_FROM` date DEFAULT NULL,
  `AVAILABLE_TO` date DEFAULT NULL,
  `STATUS` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AVAILABILITY_ID`),
  KEY `VEHICLES_ID` (`VEHICLES_ID`),
  CONSTRAINT `vehicles_availability_ibfk_1` FOREIGN KEY (`VEHICLES_ID`) REFERENCES `vehicles` (`VEHICLES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles_availability`
--

LOCK TABLES `vehicles_availability` WRITE;
/*!40000 ALTER TABLE `vehicles_availability` DISABLE KEYS */;
INSERT INTO `vehicles_availability` VALUES (1,1,'2025-08-01','2025-08-10','Available'),(2,2,'2025-08-05','2025-08-15','Available');
/*!40000 ALTER TABLE `vehicles_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiclesinventory`
--

DROP TABLE IF EXISTS `vehiclesinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiclesinventory` (
  `INVENTORY_ID` int NOT NULL AUTO_INCREMENT,
  `VEHICLES_ID` int DEFAULT NULL,
  `BRANCH_ID` int DEFAULT NULL,
  `QUANTITY` int DEFAULT NULL,
  PRIMARY KEY (`INVENTORY_ID`),
  KEY `VEHICLES_ID` (`VEHICLES_ID`),
  KEY `BRANCH_ID` (`BRANCH_ID`),
  CONSTRAINT `vehiclesinventory_ibfk_1` FOREIGN KEY (`VEHICLES_ID`) REFERENCES `vehicles` (`VEHICLES_ID`),
  CONSTRAINT `vehiclesinventory_ibfk_2` FOREIGN KEY (`BRANCH_ID`) REFERENCES `branches` (`BRANCH_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiclesinventory`
--

LOCK TABLES `vehiclesinventory` WRITE;
/*!40000 ALTER TABLE `vehiclesinventory` DISABLE KEYS */;
INSERT INTO `vehiclesinventory` VALUES (1,1,1,5),(2,2,2,3);
/*!40000 ALTER TABLE `vehiclesinventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehiclesmaintaintance`
--

DROP TABLE IF EXISTS `vehiclesmaintaintance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehiclesmaintaintance` (
  `MAINTAINTANCE_ID` int NOT NULL AUTO_INCREMENT,
  `VEHICLES_ID` int DEFAULT NULL,
  `COST` int DEFAULT NULL,
  `MAINTAINTANCEDATE` date DEFAULT NULL,
  PRIMARY KEY (`MAINTAINTANCE_ID`),
  KEY `VEHICLES_ID` (`VEHICLES_ID`),
  CONSTRAINT `vehiclesmaintaintance_ibfk_1` FOREIGN KEY (`VEHICLES_ID`) REFERENCES `vehicles` (`VEHICLES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiclesmaintaintance`
--

LOCK TABLES `vehiclesmaintaintance` WRITE;
/*!40000 ALTER TABLE `vehiclesmaintaintance` DISABLE KEYS */;
INSERT INTO `vehiclesmaintaintance` VALUES (1,1,1500,'2025-07-15'),(2,2,2000,'2025-07-20');
/*!40000 ALTER TABLE `vehiclesmaintaintance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'carrentaldb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-09  5:58:08
