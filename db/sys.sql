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
  `tc_order` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sys_permit` (`tc_sys_permit_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,0,'Category management','分类管理','/admin/papercategory/get.action',27,'01'),(2,0,'Model management','模型管理','/admin/papermodel/get.action',2,'02'),(3,0,'System management','系统管理','',3,'03'),(4,3,'Menu management','菜单管理','/admin/sysmenu/get.action',4,'002'),(5,3,'Permit management','权限管理','/admin/syspermit/get.action',5,'001'),(6,3,'Role management','角色管理','/admin/sysrole/get.action',6,'003'),(7,3,'User management','用户管理','/admin/sysuser/get.action',7,'004');
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
  `pid` bigint(20) DEFAULT NULL,
  `tc_code` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_name` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_type` int(11) DEFAULT NULL COMMENT '1:菜单权限\n2:按钮权限',
  `tc_url` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tc_order` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_permit`
--

LOCK TABLES `sys_permit` WRITE;
/*!40000 ALTER TABLE `sys_permit` DISABLE KEYS */;
INSERT INTO `sys_permit` VALUES (2,0,'Model management','模型管理',NULL,'/admin/papermodel/get.action','02'),(3,0,'System management','系统管理',NULL,'','03'),(4,3,'Menu management','菜单管理',NULL,'/admin/sysmenu/get.action','032'),(5,3,'Permit management','权限管理',NULL,'/admin/syspermit/get.action','031'),(6,3,'Role management','角色管理',NULL,'/admin/sysrole/get.action','033'),(7,3,'User management','用户管理',NULL,'/admin/sysuser/get.action','034'),(13,2,'pbtn_add','添加',1,'/admin/papermodel/add.action','021'),(14,2,'pbtn_del','删除',1,'/admin/papermodel/del.action','022'),(15,2,'pbtn_upd','修改',1,'/admin/papermodel/upd.action','023'),(16,2,'pbtn_query','查询',1,'/admin/papermodel/getJson.action','024'),(17,2,'pbtn_getById','明细',1,'/admin/papermodel/getById.action','025'),(18,2,'pbtn_getImages','图片',1,'/admin/papermodel/getImages.action','026'),(27,0,'Category management','分类管理',NULL,'/admin/papercategory/get.action','01'),(28,27,'pbtn_add','添加',1,'/admin/papercategory/add.action','011'),(29,27,'pbtn_del','删除',1,'/admin/papercategory/del.action','012'),(30,27,'pbtn_upd','修改',1,'/admin/papercategory/upd.action','013'),(31,27,'pbtn_query','查询',1,'/admin/papercategory/getJson.action','014'),(32,27,'pbtn_getById','明细',1,'/admin/papercategory/getById.action','015');
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (28,'sysadmin','系统管理员'),(29,'r2','r2'),(31,'r4','r4'),(32,'r5','r5'),(33,'r3','r3'),(34,'r6','r6'),(35,'superadmin','超级管理员');
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
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_permit_mapping`
--

LOCK TABLES `sys_role_permit_mapping` WRITE;
/*!40000 ALTER TABLE `sys_role_permit_mapping` DISABLE KEYS */;
INSERT INTO `sys_role_permit_mapping` VALUES (50,31,3),(51,31,4),(53,32,3),(54,32,4),(55,32,2),(61,33,2),(275,28,8),(276,28,9),(277,28,10),(278,28,11),(279,28,2),(280,28,16),(281,28,17),(282,28,3),(283,28,7),(324,29,3),(325,29,4),(426,35,2),(427,35,13),(428,35,14),(429,35,15),(430,35,16),(431,35,17),(432,35,18),(433,35,3),(434,35,4),(435,35,5),(436,35,6),(437,35,7),(438,35,27),(439,35,31),(440,35,32);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (2,'u1','u1','u1@qq.com','123456','2016-10-31 05:09:24'),(3,'u2','u2','u2@qq.com','123456','2016-11-02 03:33:30'),(4,'u3','u3','u3@qq.com','123456','2016-11-02 03:37:02'),(5,'root','root','','63A9F0EA7BB98050796B649E85481845',NULL),(7,'sysadmin1','系统管理员1','','E3CEB5881A0A1FDAAD01296D7554868D','2016-11-07 03:29:47');
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role_mapping`
--

LOCK TABLES `sys_user_role_mapping` WRITE;
/*!40000 ALTER TABLE `sys_user_role_mapping` DISABLE KEYS */;
INSERT INTO `sys_user_role_mapping` VALUES (16,2,28),(21,4,28),(22,4,29),(23,4,31),(24,4,32),(30,3,29),(40,5,35),(43,7,28);
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

-- Dump completed on 2016-11-14 18:23:29
