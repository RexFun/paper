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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_permit`
--

LOCK TABLES `sys_permit` WRITE;
/*!40000 ALTER TABLE `sys_permit` DISABLE KEYS */;
INSERT INTO `sys_permit` VALUES (2,0,'Model management','模型管理',NULL,'/admin/papermodel/get.action','02'),(3,0,'System management','系统管理',NULL,'','03'),(4,3,'Menu management','菜单管理',NULL,'/admin/sysmenu/get.action','032'),(5,3,'Permit management','权限管理',NULL,'/admin/syspermit/get.action','031'),(6,3,'Role management','角色管理',NULL,'/admin/sysrole/get.action','033'),(7,3,'User management','用户管理',NULL,'/admin/sysuser/get.action','034'),(13,2,'pbtn_add','添加',1,'/admin/papermodel/add1.action','021'),(14,2,'pbtn_del','删除',1,'/admin/papermodel/del.action','022'),(15,2,'pbtn_upd','修改',1,'/admin/papermodel/upd1.action','023'),(16,2,'pbtn_query','查询',1,'/admin/papermodel/getJson.action','024'),(17,2,'pbtn_getById','明细',1,'/admin/papermodel/getById.action','025'),(18,2,'pbtn_getImages','图片',1,'/admin/papermodel/getImages.action','026'),(27,0,'Category management','分类管理',NULL,'/admin/papercategory/get.action','01'),(28,27,'pbtn_add','添加',1,'/admin/papercategory/add1.action','011'),(29,27,'pbtn_del','删除',1,'/admin/papercategory/del.action','012'),(30,27,'pbtn_upd','修改',1,'/admin/papercategory/upd1.action','013'),(31,27,'pbtn_query','查询',1,'/admin/papercategory/getJson.action','014'),(32,27,'pbtn_getById','明细',1,'/admin/papercategory/getById.action','015'),(33,5,'pbtn_add','添加',1,'/admin/syspermit/add1.action','0311'),(34,5,'pbtn_del','删除',1,'/admin/syspermit/del.action','0312'),(35,5,'pbtn_upd','修改',1,'/admin/syspermit/upd1.action','0313'),(36,5,'pbtn_query','查询',1,'/admin/syspermit/getJson.action','0314'),(37,5,'pbtn_getById','明细',1,'/admin/syspermit/getById.action','0315'),(38,4,'pbtn_add','添加',1,'/admin/sysmenu/add1.action','0321'),(39,4,'pbtn_del','删除',1,'/admin/sysmenu/del.action','0322'),(40,4,'pbtn_upd','修改',1,'/admin/sysmenu/upd1.action','0323'),(41,4,'pbtn_query','查询',1,'/admin/sysmenu/getJson.action','0324'),(42,4,'pbtn_getById','明细',1,'/admin/sysmenu/getById.action','0325'),(43,6,'pbtn_add','添加',1,'/admin/sysrole/add1.action','0331'),(44,6,'pbtn_del','删除',1,'/admin/sysrole/del.action','0332'),(45,6,'pbtn_upd','修改',1,'/admin/sysrole/upd1.action','0333'),(46,6,'pbtn_query','查询',1,'/admin/sysrole/getJson.action','0334'),(47,6,'pbtn_getById','明细',1,'/admin/sysrole/getById.action','0335'),(48,7,'pbtn_add','添加',1,'/admin/sysuser/add1.action','0341'),(49,7,'pbtn_del','删除',1,'/admin/sysuser/del.action','0342'),(50,7,'pbtn_upd','修改',1,'/admin/sysuser/upd1.action','0343'),(51,7,'pbtn_query','查询',1,'/admin/sysuser/getJson.action','0344'),(52,7,'pbtn_getById','明细',1,'/admin/sysuser/getById.action','0345');
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
) ENGINE=InnoDB AUTO_INCREMENT=552 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_permit_mapping`
--

LOCK TABLES `sys_role_permit_mapping` WRITE;
/*!40000 ALTER TABLE `sys_role_permit_mapping` DISABLE KEYS */;
INSERT INTO `sys_role_permit_mapping` VALUES (50,31,3),(51,31,4),(53,32,3),(54,32,4),(55,32,2),(61,33,2),(324,29,3),(325,29,4),(476,35,27),(477,35,28),(478,35,29),(479,35,30),(480,35,31),(481,35,32),(482,35,2),(483,35,13),(484,35,14),(485,35,15),(486,35,16),(487,35,17),(488,35,18),(489,35,3),(490,35,5),(491,35,33),(492,35,34),(493,35,35),(494,35,36),(495,35,37),(496,35,4),(497,35,38),(498,35,39),(499,35,40),(500,35,41),(501,35,42),(502,35,6),(503,35,43),(504,35,44),(505,35,45),(506,35,46),(507,35,47),(508,35,7),(509,35,48),(510,35,49),(511,35,50),(512,35,51),(513,35,52),(542,28,2),(543,28,16),(544,28,17),(545,28,3),(546,28,5),(547,28,36),(548,28,37),(549,28,7),(550,28,51),(551,28,52);
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

-- Dump completed on 2016-11-18 17:56:38
