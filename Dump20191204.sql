-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: itunes2
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `album` (
  `album_id` int(11) NOT NULL,
  `album_name` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1051394208,'25'),(1250843437,'Loose Tonight - Single');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `artist` (
  `artist_id` int(11) NOT NULL,
  `artist_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (262836961,'Adele'),(1273822548,'Hips');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `genres` (
  `genre_name` varchar(50) NOT NULL,
  `genre_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`genre_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES ('Anime',3),('Pop',2),('R&B/Soul',1);
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playlist`
--

DROP TABLE IF EXISTS `playlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `playlist` (
  `playlistId` int(11) NOT NULL,
  `playlistName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`playlistId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playlist`
--

LOCK TABLES `playlist` WRITE;
/*!40000 ALTER TABLE `playlist` DISABLE KEYS */;
INSERT INTO `playlist` VALUES (1,'awef');
/*!40000 ALTER TABLE `playlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song`
--

DROP TABLE IF EXISTS `song`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `song` (
  `song_id` int(11) DEFAULT NULL,
  `song_name` varchar(150) DEFAULT NULL,
  `album_id` int(11) DEFAULT NULL,
  `artist_id` int(11) DEFAULT NULL,
  `song_length` time DEFAULT NULL,
  `genre_name` varchar(50) DEFAULT NULL,
  `play_order` int(11) NOT NULL AUTO_INCREMENT,
  `playlist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`play_order`),
  KEY `genre_name` (`genre_name`),
  KEY `playlist_id` (`playlist_id`),
  CONSTRAINT `song_ibfk_1` FOREIGN KEY (`genre_name`) REFERENCES `genres` (`genre_name`),
  CONSTRAINT `song_ibfk_2` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`playlistId`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song`
--

LOCK TABLES `song` WRITE;
/*!40000 ALTER TABLE `song` DISABLE KEYS */;
INSERT INTO `song` VALUES (1051394215,'Hello',1051394208,262836961,'00:04:55','Pop',74,1),(1454775278,'Bloody Stream (From \"Jojo\'s Bizarre Adventure: Battle Tendency\")',1454775277,1307745669,'00:04:22','Anime',76,1),(1051394215,'Hello',1051394208,262836961,'00:04:55','Pop',77,1),(1454775278,'Bloody Stream (From \"Jojo\'s Bizarre Adventure: Battle Tendency\")',1454775277,1307745669,'00:04:22','Anime',78,1),(1454775278,'Bloody Stream (From \"Jojo\'s Bizarre Adventure: Battle Tendency\")',1454775277,1307745669,'00:04:22','Anime',79,1),(1250843782,'Loose Tonight',1250843437,1273822548,'00:04:32','R&B/Soul',81,1);
/*!40000 ALTER TABLE `song` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_update_genres` BEFORE INSERT ON `song` FOR EACH ROW begin
	if new.genre_name not in (select genre_name from genres)
    then insert into genres(genre_name, genre_count) values (new.genre_name, 1);
    else
    update genres set genre_count = genre_count + 1 where genre_name = new.genre_name;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'itunes2'
--

--
-- Dumping routines for database 'itunes2'
--
/*!50003 DROP PROCEDURE IF EXISTS `deleteSong` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteSong`(in songName varchar(150))
begin
	declare genre_name_temp varchar(50);
    declare is_genre_count_0 int;
    declare artist_id_temp int;
    declare album_id_temp int;
    set genre_name_temp = (select genre_name from song where song_name = songName limit 1);
    set artist_id_temp = (select artist_id from song where song_name = songName limit 1);
    select artist_id_temp;
    set album_id_temp = (select album_id from song where song_name = songName limit 1);
    select album_id_temp;
    delete from song where song_name = songName limit 1;
    set is_genre_count_0 = (select genre_count from genres where genre_name = genre_name_temp limit 1);
    update genres set genre_count = genre_count - 1 where genre_name = genre_name_temp;
    if is_genre_count_0 - 1 = 0
    then delete from genres where genre_name = genre_name_temp limit 1;
    end if;
    delete from album where album_id = album_id_temp limit 1;
    delete from artist where artist_id = artist_id_temp limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-04 23:10:35
