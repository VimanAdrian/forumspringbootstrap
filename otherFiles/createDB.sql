-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: forum
-- ------------------------------------------------------
-- Server version	5.7.18-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */;
/*!40103 SET TIME_ZONE = '+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */;

--
-- Table structure for table `activation_tokens`
--

DROP TABLE IF EXISTS `activation_tokens`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activation_tokens` (
  `userID`       INT(11)     NOT NULL,
  `token`        VARCHAR(30) NOT NULL,
  `creationDate` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token`),
  KEY `activation_tokens_users_userID_fk` (`userID`),
  CONSTRAINT `activation_tokens_users_userID_fk` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activation_tokens`
--

LOCK TABLES `activation_tokens` WRITE;
/*!40000 ALTER TABLE `activation_tokens`
  DISABLE KEYS */;
/*!40000 ALTER TABLE `activation_tokens`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `categoryId` INT(11)     NOT NULL AUTO_INCREMENT,
  `title`      VARCHAR(50)          DEFAULT NULL,
  `url`        VARCHAR(50) NOT NULL,
  PRIMARY KEY (`categoryId`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 11
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories`
  DISABLE KEYS */;
INSERT INTO `categories`
VALUES (1, 'java', 'java'), (2, 'c#', 'c%23'), (3, 'c++', 'c%2B%2B'), (4, 'python', 'pytho'), (5, 'ruby', 'ruby'),
  (6, 'lisp', 'lisp'), (7, 'hibernate', 'hibernate'), (8, 'spring', 'spring'), (9, 'cc#', 'cc%23'), (10, '', '');
/*!40000 ALTER TABLE `categories`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_tokens`
--

DROP TABLE IF EXISTS `password_tokens`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_tokens` (
  `userID`       INT(11)              DEFAULT NULL,
  `token`        VARCHAR(30) NOT NULL,
  `creationDate` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token`),
  KEY `password_tokens_users_userID_fk` (`userID`),
  CONSTRAINT `password_tokens_users_userID_fk` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_tokens`
--

LOCK TABLES `password_tokens` WRITE;
/*!40000 ALTER TABLE `password_tokens`
  DISABLE KEYS */;
INSERT INTO `password_tokens` VALUES (51, 'CVD3hoUc7oTuj4OmbQIhr1IKI8WQeI', '2017-08-11 07:04:14'),
  (11, 'VRo6rzhrKqKFyYXMhIWP4ub85jlmhA', '2017-08-17 12:19:05');
/*!40000 ALTER TABLE `password_tokens`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persistent_logins`
--

DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persistent_logins` (
  `username`  VARCHAR(64) NOT NULL,
  `series`    VARCHAR(64) NOT NULL,
  `token`     VARCHAR(64) NOT NULL,
  `last_used` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persistent_logins`
--

LOCK TABLES `persistent_logins` WRITE;
/*!40000 ALTER TABLE `persistent_logins`
  DISABLE KEYS */;
INSERT INTO `persistent_logins`
VALUES ('a.viman', 'OLl85zbv625LKpdI1HGRpA==', 'EMvDLZDscyB4+u4OQoOmsA==', '2017-08-17 13:03:19');
/*!40000 ALTER TABLE `persistent_logins`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `postID`       INT(11)       NOT NULL AUTO_INCREMENT,
  `userID`       INT(11)       NOT NULL,
  `title`        VARCHAR(500)  NOT NULL,
  `content`      VARCHAR(5000) NOT NULL,
  `creationDate` TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `views`        INT(11)                DEFAULT '0',
  `score`        INT(11)                DEFAULT '0',
  `active`       TINYINT(1)             DEFAULT '1',
  PRIMARY KEY (`postID`),
  KEY `userID` (`userID`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 144
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts`
  DISABLE KEYS */;
INSERT INTO `posts` VALUES (4, 1, 'How can i compile java?',
                            'I am new to java and i want to make a game like minecraft to make millions of dollars but i don\'t know how to compile it. If anyone can help me write me some code and compile it i\'m sure you cand do it in a few hours and i will credit you in my game and you will get a lot of exposure. Thanks. ',
                            '2017-08-01 06:20:19', 185, 15, 0),
  (9, 1, 'Test title', 'Test question because i want to ask a good question.', '2017-08-01 06:24:48', 41, 0, 0),
  (10, 1, 'dasdasd', 'sadasd', '2017-07-31 12:21:51', 4, 0, 0),
  (11, 1, 'This is a title', 'This is some content', '2017-07-31 12:21:29', 281, 3, 1),
  (12, 11, 'asdasdasdasd', 'dsasdasdasdasdasdasdasdasd', '2017-07-31 12:22:18', 15, 0, 1),
  (13, 1, 'what song is this?', 'it goes like this: dum dum dum BLE BLE BRUM BRUM BLE dum dum ', '2017-07-31 12:31:00', 5, 0, 0),
  (14, 1, 'sadasdasd', 'asdasdasdasdasdasda', '2017-07-31 14:20:02', 1, 0, 1),
  (15, 1, 'test question', 'hello world', '2017-07-31 14:30:24', 6, 0, 1),
  (16, 1, 'java', 'das', '2017-08-01 09:56:06', 8, 1, 1),
  (17, 11, 'java jasad', 'dasd', '2017-08-01 09:56:06', 6, 1, 1),
  (18, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 2, 0, 1),
  (19, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 3, 1, 1),
  (20, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 4, 0, 1),
  (21, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 4, 0, 1),
  (22, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (23, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (24, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 2, 0, 1),
  (25, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (26, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (27, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 5, 0, 1),
  (28, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 8, 0, 1),
  (29, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 3, 0, 1),
  (30, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (31, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (32, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (33, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (34, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (35, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 33, 0, 1),
  (36, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (37, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (38, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (39, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (40, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (41, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (42, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (43, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (44, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (45, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (46, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (47, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (48, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (49, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (50, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (51, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (52, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (53, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 0, 0, 1),
  (54, 1, 'i like turtles', 'do you? ', '2017-08-01 12:14:39', 2, 0, 1),
  (55, 1, 'hello you', 'i like you', '2017-08-01 12:49:10', 3, 0, 1),
  (56, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (57, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (58, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (59, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 2, 0, 1),
  (60, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (61, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (62, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (63, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (64, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (65, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (66, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (67, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (68, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (69, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (70, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (71, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 2, 0, 1),
  (72, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (73, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (74, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (75, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (76, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (77, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 3, 0, 1),
  (78, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (79, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (80, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (81, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (82, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (83, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 5, 0, 1),
  (84, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (85, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (86, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (87, 1, 'sdaada java', 'asdasd', '2017-08-01 09:56:06', 1, 0, 1),
  (88, 1, 'test for tags', 'this is a test', '2017-08-02 07:25:52', 1, 0, 1),
  (89, 1, 'test pentru categorii', 'acesta este un test pentru a vedea daca merge categoriile', '2017-08-02 09:03:00', 0, 0, 1),
  (90, 1, 'alt test pentru categorii', 'ce zice si titlu', '2017-08-02 09:04:33', 1, 0, 1),
  (91, 1, 'alt test', '^^^', '2017-08-02 09:06:53', 2, 0, 1),
  (92, 1, 'hello categories', 'the categories work :D\r\n', '2017-08-02 09:09:52', 1, 0, 1),
  (93, 1, 'sadasdas', 'dasdasdas', '2017-08-02 11:10:30', 2, 0, 1),
  (94, 1, 'test pt taguri', 'da', '2017-08-03 09:04:33', 1, 0, 1),
  (95, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:25:45', 1, 0, 1),
  (96, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:25:49', 1, 0, 1),
  (97, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:25:50', 1, 0, 1),
  (98, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:25:52', 1, 0, 1),
  (99, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:25:55', 1, 0, 1),
  (100, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:25:56', 1, 0, 1),
  (101, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:25:58', 1, 0, 1),
  (102, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:04', 1, 0, 1),
  (103, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:05', 1, 0, 1),
  (104, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:06', 1, 0, 1),
  (105, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:07', 1, 0, 1),
  (106, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:07', 1, 0, 1),
  (107, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:08', 1, 0, 1),
  (108, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:09', 1, 0, 1),
  (109, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:09', 1, 0, 1),
  (110, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:10', 1, 0, 1),
  (111, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:11', 1, 0, 1),
  (112, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:11', 1, 0, 1),
  (113, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:12', 1, 0, 1),
  (114, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:12', 1, 0, 1),
  (115, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:13', 1, 0, 1),
  (116, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:14', 1, 0, 1),
  (117, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:14', 1, 0, 1),
  (118, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:15', 1, 0, 1),
  (119, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:16', 1, 0, 1),
  (120, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:17', 1, 0, 1),
  (121, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:17', 1, 0, 1),
  (122, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:18', 1, 0, 1),
  (123, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:19', 2, 0, 1),
  (124, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:19', 1, 0, 1),
  (125, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:20', 1, 0, 1),
  (126, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:21', 1, 0, 1),
  (127, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:21', 1, 0, 1),
  (128, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:22', 1, 0, 1),
  (129, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:23', 1, 0, 1),
  (130, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:23', 1, 0, 1),
  (131, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:24', 1, 0, 1),
  (132, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:24', 1, 0, 1),
  (133, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:25', 1, 0, 1),
  (134, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:25', 1, 0, 1),
  (135, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:26', 1, 0, 1),
  (136, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:26', 1, 0, 1),
  (137, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:26', 1, 0, 1),
  (138, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:27', 1, 0, 1),
  (139, 1, 'test for pagination', 'test for pagination', '2017-08-07 12:26:27', 1, 0, 1),
  (140, 1, 'c plus plus', 'plus plus', '2017-08-08 07:28:34', 1, 0, 1),
  (141, 1, 'cc sharp', 'cc sharp', '2017-08-08 07:42:58', 1, 0, 1),
  (142, 52, 'asdasda', 'dasdasdas', '2017-08-17 08:09:39', 1, 0, 1);
/*!40000 ALTER TABLE `posts`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_categories`
--

DROP TABLE IF EXISTS `posts_categories`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts_categories` (
  `posts_categoriesId` INT(11) NOT NULL AUTO_INCREMENT,
  `postId`             INT(11) NOT NULL,
  `categoryId`         INT(11) NOT NULL,
  PRIMARY KEY (`posts_categoriesId`),
  UNIQUE KEY `postId` (`postId`, `categoryId`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `posts_categories_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `posts` (`postID`),
  CONSTRAINT `posts_categories_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 96
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_categories`
--

LOCK TABLES `posts_categories` WRITE;
/*!40000 ALTER TABLE `posts_categories`
  DISABLE KEYS */;
INSERT INTO `posts_categories`
VALUES (3, 4, 1), (28, 68, 1), (45, 69, 1), (44, 70, 1), (43, 71, 1), (42, 72, 1), (41, 73, 1), (40, 74, 1),
  (39, 75, 1), (38, 76, 1), (37, 77, 1), (36, 78, 1), (35, 79, 1), (34, 80, 1), (33, 81, 1), (31, 82, 1), (32, 83, 1),
  (30, 84, 1), (29, 85, 1), (27, 86, 1), (26, 87, 1), (25, 88, 1), (24, 89, 1), (23, 90, 1), (5, 91, 1), (8, 91, 2),
  (6, 91, 4), (7, 91, 5), (9, 92, 1), (10, 92, 2), (11, 92, 4), (12, 92, 6), (13, 93, 1), (14, 94, 1), (15, 94, 7),
  (46, 95, 8), (47, 96, 8), (48, 97, 8), (49, 98, 8), (50, 99, 8), (51, 100, 8), (52, 101, 8), (53, 102, 8),
  (54, 103, 8), (55, 104, 8), (56, 105, 8), (57, 106, 8), (58, 107, 8), (59, 108, 8), (60, 109, 8), (61, 110, 8),
  (62, 111, 8), (63, 112, 8), (64, 113, 8), (65, 114, 8), (66, 115, 8), (67, 116, 8), (68, 117, 8), (69, 118, 8),
  (70, 119, 8), (71, 120, 8), (72, 121, 8), (73, 122, 8), (74, 123, 8), (75, 124, 8), (76, 125, 8), (77, 126, 8),
  (78, 127, 8), (79, 128, 8), (80, 129, 8), (81, 130, 8), (82, 131, 8), (83, 132, 8), (84, 133, 8), (85, 134, 8),
  (86, 135, 8), (87, 136, 8), (88, 137, 8), (89, 138, 8), (90, 139, 8), (91, 140, 3), (92, 141, 9), (93, 142, 10);
/*!40000 ALTER TABLE `posts_categories`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replies`
--

DROP TABLE IF EXISTS `replies`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `replies` (
  `replyId`      INT(11)   NOT NULL AUTO_INCREMENT,
  `postID`       INT(11)            DEFAULT NULL,
  `userID`       INT(11)            DEFAULT NULL,
  `content`      VARCHAR(5000)      DEFAULT NULL,
  `creationDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `score`        INT(11)            DEFAULT '0',
  `bestAnswer`   TINYINT(1)         DEFAULT '0',
  `enabled`      TINYINT(1)         DEFAULT '1',
  PRIMARY KEY (`replyId`),
  KEY `postID` (`postID`),
  KEY `userID` (`userID`),
  CONSTRAINT `replies_ibfk_1` FOREIGN KEY (`postID`) REFERENCES `posts` (`postID`),
  CONSTRAINT `replies_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 39
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replies`
--

LOCK TABLES `replies` WRITE;
/*!40000 ALTER TABLE `replies`
  DISABLE KEYS */;
INSERT INTO `replies` VALUES (1, 4, 1, 'dasdasdada', '2017-07-31 14:27:47', 0, 1, 1),
  (2, 15, 1, 'dasliudaisoldjka', '2017-07-31 14:30:31', 1, 0, 1),
  (3, 4, 1, 'test answer', '2017-08-01 06:16:43', 0, 0, 1),
  (4, 9, 1, 'hello friend. you are very good question i like because i have the same problem. have you found solution could you provide answer to me as wel? thank you ', '2017-08-01 06:21:20', 0, 0, 1),
  (5, 83, 1, 'nice', '2017-08-01 13:10:17', 0, 0, 1), (6, 83, 1, 'nice', '2017-08-01 13:10:17', 0, 0, 1),
  (7, 83, 1, 'nice', '2017-08-01 13:10:17', 0, 0, 1), (8, 27, 1, 'dasdas', '2017-08-01 13:13:44', 0, 0, 1),
  (9, 24, 1, 'sdasdasdasd', '2017-08-01 13:15:07', 0, 0, 1), (10, 20, 1, 'dasdasda', '2017-08-01 13:16:29', 0, 0, 1),
  (11, 20, 1, 'asdasd', '2017-08-01 13:25:38', 1, 0, 1), (12, 27, 1, 'dasdasda', '2017-08-01 13:28:48', 0, 0, 1),
  (13, 4, 1, 'i will help you if you promise to say i helped you and promise to send me more clients when you are rich :)\r\n', '2017-08-02 07:11:35', 0, 0, 1),
  (14, 16, 1, 'yes', '2017-08-02 10:05:55', 1, 0, 1), (15, 29, 1, 'dasdasdasd', '2017-08-02 11:10:14', 0, 0, 1),
  (16, 11, 1, 'yes\r\n', '2017-08-07 12:53:08', 17, 1, 1), (17, 4, 1, 'aaa', '2017-08-08 06:24:15', 0, 0, 1),
  (18, 4, 1, '111', '2017-08-08 06:27:19', 0, 0, 1), (19, 4, 1, '1111', '2017-08-08 06:27:24', 0, 0, 1),
  (20, 4, 1, '111', '2017-08-08 06:27:31', 0, 0, 1), (21, 4, 1, '111', '2017-08-08 06:27:33', 0, 0, 1),
  (22, 4, 1, '1111', '2017-08-08 06:27:34', 0, 0, 1), (23, 4, 1, '1111', '2017-08-08 06:27:35', 0, 0, 1),
  (24, 4, 1, '1111', '2017-08-08 06:27:37', 0, 0, 1), (25, 4, 1, '1111', '2017-08-08 06:27:38', 0, 0, 1),
  (26, 4, 1, '1111', '2017-08-08 06:27:40', 0, 0, 1), (27, 4, 1, '11111', '2017-08-08 06:27:41', 0, 0, 1),
  (28, 4, 1, '111', '2017-08-08 06:28:27', 0, 0, 1), (29, 4, 1, '111', '2017-08-08 06:28:28', 0, 0, 1),
  (30, 4, 1, '111', '2017-08-08 06:28:30', 0, 0, 1), (31, 4, 1, '111', '2017-08-08 06:28:32', 0, 0, 1),
  (32, 4, 1, '111', '2017-08-08 06:28:33', 0, 0, 1), (33, 4, 1, '111', '2017-08-08 06:28:39', 0, 0, 1),
  (34, 4, 1, '111', '2017-08-08 06:28:49', 0, 0, 1), (35, 12, 1, 'hello cow', '2017-08-08 10:25:06', 0, 0, 1),
  (36, 11, 1, 'no', '2017-08-10 10:56:28', 1, 0, 1), (37, 11, 1,
                                                      'abledas\r\ndasdasd\r\nasdasd\r\nasdasd\r\nasdasdasdasd\r\ndasasd\r\nasda\r\nsdas\r\ndasd\r\nas\r\ndas\r\nd',
                                                      '2017-08-10 11:15:49', 0, 0, 1);
/*!40000 ALTER TABLE `replies`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userID`       INT(11)     NOT NULL AUTO_INCREMENT,
  `username`     VARCHAR(50) NOT NULL,
  `password`     VARCHAR(60) NOT NULL,
  `firstName`    VARCHAR(50)          DEFAULT NULL,
  `lastName`     VARCHAR(50)          DEFAULT NULL,
  `email`        VARCHAR(50) NOT NULL,
  `dateOfBirth`  DATE                 DEFAULT NULL,
  `gender`       VARCHAR(50)          DEFAULT NULL,
  `role`         VARCHAR(50) NOT NULL DEFAULT 'ROLE_USER',
  `creationDate` TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled`      TINYINT(4)  NOT NULL DEFAULT '0',
  `profileImage` VARCHAR(50) NOT NULL DEFAULT '/profileImage/generic.png',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 55
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users`
  DISABLE KEYS */;
INSERT INTO `users` VALUES
  (0, 'unauthenticated', '$2a$10$8bSTUIRcQfayE08jZbRzKewCQnvvrYCuZ8VPIVkyPeVkNgQsMnr9C', ' ', ' ',
      'unauthenticated@yahoo.com', '2017-08-01', ' ', 'ROLE_USER', '2017-08-17 08:14:15', 0,
   '/profileImage/generic.png'),
  (1, 'a.viman', '$2a$10$bj1Ed3vdL/ieh9QyrkrZBePLes2RF5Tzs2a4wg4bZ0wzoBcMxHpGa', 'Viman', 'Adrian', 'a.viman@yahoo.net', '1996-09-21', 'male', 'ROLE_ADMIN', '2017-07-31 10:09:21', 1, 'http://i.imgur.com/zoRG8uC.png'),
  (2, 'viorelv', '$2a$10$Y.S9G3p3V2iPRTgPQ.sCfeLfqirt5EWwh3z7nEnBJbzpNnktr9yyy', 'Adrian', 'Viman', 'vimanadrian@yahoo.com', '2017-07-19', 'male', 'ROLE_USER', '2017-07-31 08:07:55', 1, '/profileImage/generic.png'),
  (3, 'adi', '$2a$10$4NSD1JfBnyGopT6TmsfX.uIHqoW.BNt1WlmYFXU8BfHbaBbZQilce', 'Adi', 'Viorel', 'adi@viorel.com', '2017-07-20', 'male', 'ROLE_USER', '2017-07-31 12:18:33', 1, '/profileImage/generic.png'),
  (11, 'colda', '$2a$10$iFL2CHFTygbvcQOJ2Glw9u1CjvwpWxipv4v5EH1kY5z6YcfJ//IvW', 'dasdasd', 'Andrei', 'andrei@yahoo.com', '1970-01-01', 'male', 'ROLE_USER', '2017-07-31 08:09:09', 1, '/profileImage/20170817152118iLiCbuOUPC.png'),
  (12, 'viorel', '$2a$10$LFg2ESXE/n9nEUyt43g/b.vUHocaBOdS7zwf1R/JFX.ASmInqoBFG', 'Primu', 'Ultimu', 'viorel@email.com', '1982-05-10', 'male', 'ROLE_USER', '2017-07-31 09:49:01', 1, '/profileImage/generic.png'),
  (13, 'username', '$2a$10$m.GcmzhkidCfCcnkuUMp5OEtOOXEO2bTfrrbRj8gdvsheLgtOEDrW', 'ciudat', 'foarte', 'foarte@ciudat.com', '2017-08-17', 'female', 'ROLE_USER', '2017-08-03 12:46:08', 1, '/profileImage/generic.png'),
  (14, 'stefii', '$2a$10$LCOzSIBAjwZ4m.bTK.YQye4.4FtXtMYxGyOVSFFl9fJL6LTYSgsiK', 'Stefania', 'Lucaci', 'stefii@yahoo.com', '1996-10-23', 'female', 'ROLE_USER', '2017-08-04 05:39:55', 1, '/profileImage/20170807084233vdkoWRZ5jE.png'),
  (15, 'cristian', '$2a$10$naUfihcag3ZRHd8GopPAE.pZHZRkx7R8snjtQBJq706EMXrpbKRci', 'lucica', 'cristi', 'yahoo@cristi.lucica', '2017-08-24', 'male', 'ROLE_USER', '2017-08-04 06:50:57', 1, '/profileImage/generic.png'),
  (16, 'user1', '$2a$10$jobwnspSDZaMQnhfCU4hauQSMoFYqM9zL/K02XguQsy5wT6eC0p3G', 'first', 'last', 'first@last.com', '2017-08-16', 'male', 'ROLE_USER', '2017-08-04 06:52:14', 1, '/profileImage/generic.png'),
  (17, 'user2', '$2a$10$3DQVQpK/WKjUhz2Q5tw4buChmtD7bptGG/9J9IptVJNhXo3iHb28O', 'first', 'last', 'first2@last.com', '2017-08-16', 'male', 'ROLE_USER', '2017-08-04 06:52:14', 1, '/profileImage/generic.png'),
  (18, 'username1', '$2a$10$ULsOAHXBx1irZrOAC7Znn.abPB/81kiSAy99oSqWm.IPhltuZSG8W', 'asd', 'asdad', 'email@1.com', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:54:43', 0, '/profileImage/generic.png'),
  (19, 'username2', '$2a$10$YpY4AwV.UybU2bMtDMFhbOwdPbdiHYZYorRLpzG69HvwEAihXP2NW', '', '', 'email@2.com', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:54:57', 0, '/profileImage/generic.png'),
  (20, 'username3', '$2a$10$GETI571pyR4MAHnHhOi7x.nkLeYNZzPNpHPvTRD2rdjeUYVcCVZLS', '', '', 'email@3.com', '1970-01-01', 'male', 'ROLE_ADMIN', '2017-08-04 06:55:08', 0, '/profileImage/generic.png'),
  (21, 'username4', '$2a$10$PNOCz4J8wn5VMPcbWgyhxuagNi1svWYocgjIsRoKfMbdaFv9bBBV.', '', '', '4@4.4', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:55:23', 0, '/profileImage/generic.png'),
  (22, 'username5', '$2a$10$bbM4.BapLTBt/EfmqYMmQ.H4e..D0iDUf/l3L8CVGcOcR2FYvNNo.', '', '', '5@5.5', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:55:34', 0, '/profileImage/generic.png'),
  (23, 'username6', '$2a$10$fzYkV/Ntq.tDnygLG5B3TuhoA7nhx3wpT0jgxu.mFAkeAS3w5vdIS', '', '', '6@6.com', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:55:44', 0, '/profileImage/generic.png'),
  (24, 'username7', '$2a$10$1vkht74TmHTkK6P8VWBikOrKotClCprBwRfH1KseAPWEWd80tursC', '', '', '7@7.7', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:55:51', 0, '/profileImage/generic.png'),
  (25, '8', '$2a$10$DaV8X.Uy1LfWgVD5HbNPvuoig.sZEXKkUk7ksuSbLyWaFWdbsRQKK', '', '', '8@8.8', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:56:00', 0, '/profileImage/generic.png'),
  (26, '9', '$2a$10$vFbbjss7NvZv3BKLX8Z0vemtm.Opzxd5Akj/eWxB5UBzKNxSx/5Uu', '', '', '9@9.2', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:56:26', 0, '/profileImage/generic.png'),
  (27, '10', '$2a$10$64nxyhUuMp41aC3eUXwnsu8S8zf1IodWzG3LuQK5a8E/IFw6kUvQG', '', '', '10@10.10', '1970-01-01', 'male', 'ROLE_USER', '2017-08-04 06:56:38', 0, '/profileImage/generic.png'),
  (28, '11', '$2a$10$1Wkq9VdDc89P5dCODVjmu.HlZPZSUSD/Fqx1oRz/CeB59KokygrDu', '', '', '11@11.11', '1970-01-01', 'male',
       'ROLE_USER', '2017-08-04 06:56:48', 0, '/profileImage/generic.png'),
  (29, 'dasda', '$2a$10$Q3FeYKfNTNX7rvIqcVniHuBS6SEB8l465hn/TGI2F6AHmKkXv3tSq', '', '', 'das@das.casda', '1970-01-01',
       'male', 'ROLE_USER', '2017-08-04 06:57:15', 0, '/profileImage/generic.png'),
  (30, 'adriana', '$2a$10$/ZwlxH91u0DBJRAf81Sg5.TeyWDact7CpbkW.bcZDqw6J5FusOMz6', '', '', 'adriana@yahoo.com',
       '1996-07-15', 'female', 'ROLE_USER', '2017-08-07 05:43:33', 1, '/profileImage/20170807084400pmkuxDxJEv.png'),
  (31, 'bcrypt', '$2a$10$Q1LF97/zASz//1KoFwBCA.BPgQxQgjbqNEJo2zW5g88PPXLF3gPh2', '', '', 'bcrypt@security.com',
       '1970-01-01', 'male', 'ROLE_USER', '2017-08-08 08:17:08', 1, '/profileImage/generic.png'),
  (51, 'vimanadrian', '$2a$10$hJ2zcDrLv/dOn7GGE.tyGuq2FGDuMbG1ber1xGENT1CDdG1G2u8uG', '', '', 'a.viman@yahoo.ro',
       '1970-01-01', 'male', 'ROLE_USER', '2017-08-09 11:04:45', 1, '/profileImage/generic.png'),
  (52, 'TestUsername', '$2a$10$8bSTUIRcQfayE08jZbRzKewCQnvvrYCuZ8VPIVkyPeVkNgQsMnr9C', '', '', 'a.viman@yahoo.co.uk',
       '1970-01-01', 'male', 'ROLE_USER', '2017-08-17 07:53:12', 1, '/profileImage/20170817110107STskq51Vhp.png'),
  (54, 'testusername1', '$2a$10$W.VKwluKuLGQ/yGDCjPG5../HzMXYb4wlCvsfBDZbnjoBobychR.S', '', '', 'a.viman@yahoo.com',
       '1970-01-01', 'male', 'ROLE_USER', '2017-08-17 12:15:42', 1, '/profileImage/generic.png');
/*!40000 ALTER TABLE `users`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes_users_posts`
--

DROP TABLE IF EXISTS `votes_users_posts`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes_users_posts` (
  `userID`   INT(11) NOT NULL,
  `postID`   INT(11) NOT NULL,
  `voteType` INT(11) DEFAULT NULL,
  PRIMARY KEY (`userID`, `postID`),
  KEY `votes_users_posts_posts_postID_fk` (`postID`),
  CONSTRAINT `votes_users_posts_posts_postID_fk` FOREIGN KEY (`postID`) REFERENCES `posts` (`postID`),
  CONSTRAINT `votes_users_posts_users_userID_fk` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes_users_posts`
--

LOCK TABLES `votes_users_posts` WRITE;
/*!40000 ALTER TABLE `votes_users_posts`
  DISABLE KEYS */;
INSERT INTO `votes_users_posts`
VALUES (1, 11, -1), (1, 17, -1), (1, 19, 1), (1, 21, 1), (1, 28, -1), (11, 16, 1), (51, 11, 1);
/*!40000 ALTER TABLE `votes_users_posts`
  ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes_users_replies`
--

DROP TABLE IF EXISTS `votes_users_replies`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes_users_replies` (
  `userID`   INT(11) NOT NULL,
  `replyID`  INT(11) NOT NULL,
  `voteType` INT(11) DEFAULT NULL,
  PRIMARY KEY (`userID`, `replyID`),
  KEY `votes_users_replies_replies_replyId_fk` (`replyID`),
  CONSTRAINT `votes_users_replies_replies_replyId_fk` FOREIGN KEY (`replyID`) REFERENCES `replies` (`replyId`),
  CONSTRAINT `votes_users_replies_users_userID_fk` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes_users_replies`
--

LOCK TABLES `votes_users_replies` WRITE;
/*!40000 ALTER TABLE `votes_users_replies`
  DISABLE KEYS */;
INSERT INTO `votes_users_replies` VALUES (1, 2, 1), (1, 16, 1), (1, 36, 1), (11, 14, 1);
/*!40000 ALTER TABLE `votes_users_replies`
  ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2017-08-17 16:46:33
