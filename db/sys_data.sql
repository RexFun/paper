-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: localhost    Database: paper
-- ------------------------------------------------------
-- Server version	5.5.49

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT NULL,
  `tc_code` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_name` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_sys_permit_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sys_permit` (`tc_sys_permit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,0,'Category management','类别管理','/admin/papercategory/get.action',2),(2,0,'Model management','模型管理','/admin/papermodel/get.action',4),(3,0,'System management','系统管理','',3),(4,3,'Menu management','菜单管理','/admin/sysmenu/get.action',4),(5,3,'Permit management','权限管理','/admin/syspermit/get.action',5),(6,3,'Role management','角色管理','/admin/sysrole/get.action',6),(7,3,'User management','用户管理','/admin/sysuser/get.action',7);
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_permit`
--

DROP TABLE IF EXISTS `sys_permit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_permit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tc_code` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_name` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_type` int(11) DEFAULT NULL COMMENT '1:菜单权限\n2:按钮权限',
  `pid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_permit`
--

LOCK TABLES `sys_permit` WRITE;
/*!40000 ALTER TABLE `sys_permit` DISABLE KEYS */;
INSERT INTO `sys_permit` VALUES (1,'Category management','类别管理',NULL,0),(2,'Model management','模型管理',NULL,0),(3,'System management','系统管理',NULL,0),(4,'Menu management','菜单管理',NULL,3),(5,'Permit management','权限管理',NULL,3),(6,'Role management','角色管理',NULL,3),(7,'User management','用户管理',NULL,3);
/*!40000 ALTER TABLE `sys_permit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tc_code` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_name` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (28,'r1','r1'),(29,'r2','r2'),(31,'r4','r4'),(32,'r5','r5'),(33,'r3','r3'),(34,'r6','r6');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_permit_mapping`
--

DROP TABLE IF EXISTS `sys_role_permit_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_permit_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tc_sys_role_id` bigint(20) NOT NULL,
  `tc_sys_permit_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sys_permit` (`tc_sys_permit_id`),
  KEY `fk_sys_role` (`tc_sys_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_permit_mapping`
--

LOCK TABLES `sys_role_permit_mapping` WRITE;
/*!40000 ALTER TABLE `sys_role_permit_mapping` DISABLE KEYS */;
INSERT INTO `sys_role_permit_mapping` VALUES (46,29,1),(47,29,4),(49,31,1),(50,31,3),(51,31,4),(52,32,1),(53,32,3),(54,32,4),(55,32,2),(61,33,2),(67,28,1),(68,28,3);
/*!40000 ALTER TABLE `sys_role_permit_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tc_code` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_name` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_email` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_password` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_add_time` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (2,'u1','u1','u1@qq.com','123456','2016-10-31 05:09:24'),(3,'u2','u2','u2@qq.com','123456','2016-11-02 03:33:30'),(4,'u3','u3','u3@qq.com','123456','2016-11-02 03:37:02');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role_mapping`
--

DROP TABLE IF EXISTS `sys_user_role_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role_mapping` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tc_sys_user_id` bigint(20) NOT NULL,
  `tc_sys_role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sys_role` (`tc_sys_role_id`),
  KEY `fk_sys_user` (`tc_sys_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role_mapping`
--

LOCK TABLES `sys_user_role_mapping` WRITE;
/*!40000 ALTER TABLE `sys_user_role_mapping` DISABLE KEYS */;
INSERT INTO `sys_user_role_mapping` VALUES (16,2,28),(21,4,28),(22,4,29),(23,4,31),(24,4,32),(30,3,29);
/*!40000 ALTER TABLE `sys_user_role_mapping` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-04 17:35:20
