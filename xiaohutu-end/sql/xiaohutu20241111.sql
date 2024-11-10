-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: xiaohutu
-- ------------------------------------------------------
-- Server version	8.0.31

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

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `address_id` bigint NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `province` varchar(100) DEFAULT NULL COMMENT '省份',
  `city` varchar(100) DEFAULT NULL COMMENT '城市',
  `district` varchar(100) DEFAULT NULL COMMENT '区县',
  `street_address` varchar(255) DEFAULT NULL COMMENT '街道地址',
  `postal_code` varchar(20) DEFAULT NULL COMMENT '邮政编码',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户地址表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'湖南','永州市','宁远县',NULL,'425000','',NULL,'',NULL),(2,'湖南','冷水滩','梧桐区',NULL,'425000','',NULL,'',NULL);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `post_id` bigint NOT NULL COMMENT '所评论的帖子ID，用于连接帖子表',
  `user_id` bigint NOT NULL COMMENT '评论用户ID，用于连接用户基础表(user_id)',
  `comment_text` text COMMENT '评论内容(text)',
  `comment_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  `comment_image` varchar(250) DEFAULT NULL COMMENT '评论内容(image)',
  `parent_comment_id` bigint DEFAULT '0' COMMENT '父评论id',
  `top_id` bigint DEFAULT '0' COMMENT '顶级评论id(0代表是）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`comment_id`),
  KEY `c_user_id` (`user_id`),
  KEY `post_id` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,1,'写得好','2024-11-09 13:48:20',NULL,0,0,NULL,NULL),(2,1,2,'哈哈哈哈','2024-11-09 15:36:35',NULL,1,1,NULL,NULL),(3,1,105,'www','2024-11-09 15:38:49',NULL,2,1,NULL,NULL),(4,1,1,'嗡嗡嗡','2024-11-09 15:46:21',NULL,1,2,'2024-11-09 23:46:22',NULL),(5,1,102,'@maike 你好呀','2024-11-10 06:21:04',NULL,1,1,'2024-11-10 14:21:05',NULL),(6,1,102,'哈哈哈','2024-11-10 06:31:30',NULL,0,0,'2024-11-10 14:31:31',NULL),(7,1,102,'@测试1号 你好呀','2024-11-10 06:31:50',NULL,6,6,'2024-11-10 14:31:51',NULL),(8,1,102,'@若依 阿阿嘎','2024-11-10 06:35:34',NULL,2,1,'2024-11-10 14:35:34',NULL),(9,54,102,'真的累了','2024-11-10 15:51:06',NULL,0,0,'2024-11-10 23:51:07',NULL),(10,4,102,'累了累了','2024-11-10 15:55:27',NULL,0,0,'2024-11-10 23:55:28',NULL),(11,5,102,'不写了，写完了','2024-11-10 15:57:15',NULL,0,0,'2024-11-10 23:57:16',NULL),(12,5,102,'@测试1号 回家睡觉了兄弟','2024-11-10 15:57:34',NULL,11,11,'2024-11-10 23:57:34',NULL),(13,4,102,'@测试1号 睡觉睡觉','2024-11-10 16:00:14',NULL,10,10,'2024-11-11 00:00:15',NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `comment_view`
--

DROP TABLE IF EXISTS `comment_view`;
/*!50001 DROP VIEW IF EXISTS `comment_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `comment_view` AS SELECT 
 1 AS `comment_id`,
 1 AS `post_id`,
 1 AS `user_id`,
 1 AS `comment_text`,
 1 AS `comment_time`,
 1 AS `comment_image`,
 1 AS `parent_comment_id`,
 1 AS `top_id`,
 1 AS `create_time`,
 1 AS `update_time`,
 1 AS `nick_name`,
 1 AS `user_name`,
 1 AS `avatar`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (1,'tb_user','用户表(前台)','tb_user_info','user_id','User','sub','element-plus','top.xiaohutu.user','user','user','前台用户管理','maike','0','/','{\"parentMenuId\":3}','admin','2024-10-28 11:08:28','','2024-10-28 11:28:43','用户表（前台用户）'),(2,'tb_user_info','用户详情表','','','UserInfo','crud','element-plus','top.xiaohutu.system','system','userInfo','用户详情','maike','0','/','{\"parentMenuId\":0}','admin','2024-10-28 11:08:28','','2024-11-09 13:07:40',NULL),(3,'tb_post','帖子表','','','Post','crud','element-plus','top.xiaohutu.post','post','post','帖子','maike','0','/','{\"parentMenuId\":2006}','admin','2024-11-01 12:25:17','','2024-11-01 12:51:02',NULL),(4,'tb_tag','标签（分类）表',NULL,NULL,'Tag','crud','element-plus','top.xiaohutu.post','post','tag','标签（分类）','maike','0','/','{\"parentMenuId\":2006}','admin','2024-11-07 14:00:44','','2024-11-07 14:05:46',NULL),(5,'tb_user_collection','收藏表',NULL,NULL,'UserCollection','crud','element-plus','top.xiaohutu.post','post','collection','收藏','maike','0','/','{\"parentMenuId\":2006}','admin','2024-11-09 18:21:40','','2024-11-09 18:23:31',NULL),(6,'tb_user_like','点赞表',NULL,NULL,'UserLike','crud','element-plus','top.xiaohutu.post','post','like','点赞','maike','0','/','{\"parentMenuId\":2006}','admin','2024-11-09 18:21:40','','2024-11-09 18:22:40',NULL),(7,'comment','评论表','','','Comment','tree','element-plus','top.xiaohutu.post','post','comment','评论','maike','0','/','{\"treeCode\":\"comment_id\",\"treeName\":\"comment_text\",\"treeParentCode\":\"parent_comment_id\",\"parentMenuId\":0}','admin','2024-11-09 21:48:38','','2024-11-09 23:30:40',NULL);
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (1,1,'id','用户表id','bigint','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(2,1,'user_name','用户名','varchar(30)','String','userName','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(3,1,'password','用户密码','varchar(50)','String','password','0','0','0','0','0','0','0','EQ','input','',3,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(4,1,'avatar','用户头像地址','varchar(500)','String','avatar','0','0','0','1','1','1','1','EQ','imageUpload','',4,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(5,1,'gender','性别','tinyint','Long','gender','0','0','1','1','1','1','1','EQ','radio','sys_user_sex',5,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(6,1,'nick_name','昵称','varchar(30)','String','nickName','0','0','1','1','1','1','1','LIKE','input','',6,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(7,1,'phone','手机号','varchar(20)','String','phone','0','0','1','1','1','1','1','LIKE','input','',7,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(8,1,'email','用户邮件','varchar(100)','String','email','0','0','1','1','1','1','1','EQ','input','',8,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(9,1,'status','帐号状态','char(1)','String','status','0','0','0','1','1','1','1','EQ','radio','user_status',9,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(10,1,'del_flag','是否注销','char(1)','String','delFlag','0','0','0','0','1','1','1','EQ','select','user_del_flag',10,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(11,1,'login_ip','最后登录IP','varchar(128)','String','loginIp','0','0','0','0','0','0','0','EQ','input','',11,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(12,1,'login_date','最后登录时间','datetime','Date','loginDate','0','0','0','0','0','0','0','EQ','datetime','',12,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(13,1,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0',NULL,NULL,NULL,'EQ','input','',13,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(14,1,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',14,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(15,1,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0',NULL,NULL,'EQ','input','',15,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(16,1,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0','1','1','EQ','datetime','',16,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(17,1,'remark','备注','varchar(500)','String','remark','0','0','0','0','0','0',NULL,'EQ','textarea','',17,'admin','2024-10-28 11:08:28','','2024-10-28 11:28:43'),(18,2,'id','ID 主键','bigint','Long','id','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(19,2,'user_id','用户id，连接用户基础表(c_user_id)','bigint','Long','userId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(20,2,'Birth_date','出生日期','date','Date','birthDate','0','0','0','1','1','1','1','EQ','datetime','',3,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(21,2,'bio','个人简介','varchar(2000)','String','bio','0','0','0','1','1','1','1','EQ','textarea','',4,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(22,2,'address_id','位置id','bigint','Long','addressId','0','0','0','1','1','1','1','EQ','input','',5,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(23,2,'followers_count','关注者数量（粉丝）','int','Long','followersCount','0','0','0','1','1','1','1','EQ','input','',6,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(24,2,'following_count','关注数量','int','Long','followingCount','0','0','0','1','1','1','1','EQ','input','',7,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(25,2,'all_likes','帖子总点赞数','bigint','Long','allLikes','0','0','0','1','1','1','1','EQ','input','',8,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(26,2,'create_by','创建者','varchar(64)','String','createBy','0','0','0','1',NULL,NULL,NULL,'EQ','input','',9,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(27,2,'create_time','创建时间','datetime','Date','createTime','0','0','0','1',NULL,NULL,NULL,'EQ','datetime','',10,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(28,2,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','1','1',NULL,NULL,'EQ','input','',11,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(29,2,'update_time','更新时间','datetime','Date','updateTime','0','0','0','1','1',NULL,NULL,'EQ','datetime','',12,'admin','2024-10-28 11:08:28','','2024-11-09 13:07:40'),(30,3,'id','帖子ID','bigint','Long','id','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(31,3,'user_id','用户','bigint','Long','userId','0','0','0','1','1','1','1','EQ','input','',2,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(32,3,'content_text','文本内容','text','String','contentText','0','0','0','1','1','1','1','EQ','textarea','',3,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(33,3,'content_image','图片地址','varchar(3000)','String','contentImage','0','0','0','1','1','1','0','EQ','imageUpload','',4,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(34,3,'like_count','点赞数','int','Long','likeCount','0','0','0','1','1','1','1','EQ','input','',5,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(35,3,'comment_count','评论数','int','Long','commentCount','0','0','0','1','1','1','0','EQ','input','',6,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(36,3,'tag_id','标签','bigint','Long','tagId','0','0','0','1','1','1','0','EQ','input','',7,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(37,3,'address_id','发布位置','bigint','Long','addressId','0','0','0','1','1','1','0','EQ','input','',8,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(38,3,'is_public','是否公开','tinyint(1)','Integer','isPublic','0','0','0','1','1','1','0','EQ','input','',9,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(39,3,'favorite_count','收藏数量','int','Long','favoriteCount','0','0','0','1','1','1','0','EQ','input','',10,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(40,3,'draft_status','是否发布（草稿）','int','Long','draftStatus','0','0','0','1','1','1','0','EQ','radio','',11,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(41,3,'status','帖子状态','int','Long','status','0','0','0','1','1','1','1','EQ','select','post_status',12,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(42,3,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0',NULL,NULL,NULL,'EQ','input','',13,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(43,3,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',14,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(44,3,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0',NULL,NULL,'EQ','input','',15,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(45,3,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0',NULL,NULL,'EQ','datetime','',16,'admin','2024-11-01 12:25:17','','2024-11-01 12:51:02'),(46,4,'id','标签id','bigint','Long','id','1','1','0','0',NULL,'1',NULL,'EQ','input','',1,'admin','2024-11-07 14:00:44','','2024-11-07 14:05:46'),(47,4,'tag_content','标签内容','varchar(20)','String','tagContent','0','0','0','1','1','1','1','EQ','input','',2,'admin','2024-11-07 14:00:44','','2024-11-07 14:05:46'),(48,4,'count','标签使用数量','int','Long','count','0','0','0','1','1','1','0','EQ','input','',3,'admin','2024-11-07 14:00:44','','2024-11-07 14:05:47'),(49,4,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0',NULL,NULL,NULL,'EQ','input','',4,'admin','2024-11-07 14:00:44','','2024-11-07 14:05:47'),(50,4,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',5,'admin','2024-11-07 14:00:44','','2024-11-07 14:05:47'),(51,4,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0',NULL,NULL,'EQ','input','',6,'admin','2024-11-07 14:00:44','','2024-11-07 14:05:47'),(52,4,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0',NULL,NULL,'EQ','datetime','',7,'admin','2024-11-07 14:00:44','','2024-11-07 14:05:47'),(53,5,'user_id','(用户ID) - 外键，关联到用户表，表示哪个用户收藏了这个条目','bigint','Long','userId','1','0','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-09 18:21:40','','2024-11-09 18:23:31'),(54,5,'post_id','(微博帖子ID) - 外键，关联到微博帖子表，表示哪个微博帖子被用户收藏','bigint','Long','postId','1','0','0','1',NULL,NULL,NULL,'EQ','input','',2,'admin','2024-11-09 18:21:40','','2024-11-09 18:23:31'),(55,5,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0',NULL,NULL,NULL,'EQ','input','',3,'admin','2024-11-09 18:21:40','','2024-11-09 18:23:31'),(56,5,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',4,'admin','2024-11-09 18:21:40','','2024-11-09 18:23:31'),(57,5,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0',NULL,NULL,'EQ','input','',5,'admin','2024-11-09 18:21:40','','2024-11-09 18:23:31'),(58,5,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0',NULL,NULL,'EQ','datetime','',6,'admin','2024-11-09 18:21:40','','2024-11-09 18:23:31'),(59,6,'user_id','点赞用户ID(连接用户详情表的c_user_id)','bigint','Long','userId','1','0','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-09 18:21:40','','2024-11-09 18:22:40'),(60,6,'post_id','被点赞帖子ID','bigint','Long','postId','1','0','0','1',NULL,NULL,NULL,'EQ','input','',2,'admin','2024-11-09 18:21:40','','2024-11-09 18:22:40'),(61,6,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0',NULL,NULL,NULL,'EQ','input','',3,'admin','2024-11-09 18:21:40','','2024-11-09 18:22:40'),(62,6,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',4,'admin','2024-11-09 18:21:40','','2024-11-09 18:22:40'),(63,6,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0',NULL,NULL,'EQ','input','',5,'admin','2024-11-09 18:21:40','','2024-11-09 18:22:40'),(64,6,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0',NULL,NULL,'EQ','datetime','',6,'admin','2024-11-09 18:21:40','','2024-11-09 18:22:40'),(65,7,'comment_id','评论ID','bigint','Long','commentId','1','1','0','0',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(66,7,'post_id','所评论的帖子ID，用于连接帖子表','bigint','Long','postId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(67,7,'user_id','评论用户ID，用于连接用户基础表(user_id)','bigint','Long','userId','0','0','1','1','1','1','1','EQ','input','',3,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(68,7,'comment_text','评论内容(text)','text','String','commentText','0','0','0','1','1','1','1','EQ','textarea','',4,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(69,7,'comment_time','评论时间','timestamp','Date','commentTime','0','0','0','0','0','0','0','EQ','datetime','',5,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(70,7,'comment_image','评论内容(image)','varchar(250)','String','commentImage','0','0','0','1','1','1','1','EQ','imageUpload','',6,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(71,7,'parent_comment_id','父评论id','bigint','Long','parentCommentId','0','0','0','1','1','1','1','EQ','input','',7,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(72,7,'top_id','顶级评论id(0代表是）','bigint','Long','topId','0','0','0','1','1','1','1','EQ','input','',8,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(73,7,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',9,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40'),(74,7,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0',NULL,NULL,'EQ','datetime','',10,'admin','2024-11-09 21:48:38','','2024-11-09 23:30:40');
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `post_user_view`
--

DROP TABLE IF EXISTS `post_user_view`;
/*!50001 DROP VIEW IF EXISTS `post_user_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `post_user_view` AS SELECT 
 1 AS `user_name`,
 1 AS `avatar`,
 1 AS `nick_name`,
 1 AS `tag_content`,
 1 AS `addr`,
 1 AS `like_count`,
 1 AS `favorite_count`,
 1 AS `comment_count`,
 1 AS `id`,
 1 AS `user_id`,
 1 AS `tag_id`,
 1 AS `address_id`,
 1 AS `content_text`,
 1 AS `content_image`,
 1 AS `post_title`,
 1 AS `create_by`,
 1 AS `update_by`,
 1 AS `is_public`,
 1 AS `create_time`,
 1 AS `update_time`,
 1 AS `draft_status`,
 1 AS `status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `qrtz_blob_triggers`
--

DROP TABLE IF EXISTS `qrtz_blob_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Blob类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_blob_triggers`
--

LOCK TABLES `qrtz_blob_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_blob_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_blob_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_calendars`
--

DROP TABLE IF EXISTS `qrtz_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日历信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_calendars`
--

LOCK TABLES `qrtz_calendars` WRITE;
/*!40000 ALTER TABLE `qrtz_calendars` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_cron_triggers`
--

DROP TABLE IF EXISTS `qrtz_cron_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Cron类型的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_cron_triggers`
--

LOCK TABLES `qrtz_cron_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_cron_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_cron_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_fired_triggers`
--

DROP TABLE IF EXISTS `qrtz_fired_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) NOT NULL COMMENT '状态',
  `job_name` varchar(200) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='已触发的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_fired_triggers`
--

LOCK TABLES `qrtz_fired_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_fired_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_fired_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_job_details`
--

DROP TABLE IF EXISTS `qrtz_job_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) NOT NULL COMMENT '任务组名',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_job_details`
--

LOCK TABLES `qrtz_job_details` WRITE;
/*!40000 ALTER TABLE `qrtz_job_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_job_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_locks`
--

DROP TABLE IF EXISTS `qrtz_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='存储的悲观锁信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_locks`
--

LOCK TABLES `qrtz_locks` WRITE;
/*!40000 ALTER TABLE `qrtz_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_paused_trigger_grps`
--

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='暂停的触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_paused_trigger_grps`
--

LOCK TABLES `qrtz_paused_trigger_grps` WRITE;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_paused_trigger_grps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_scheduler_state`
--

DROP TABLE IF EXISTS `qrtz_scheduler_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='调度器状态表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_scheduler_state`
--

LOCK TABLES `qrtz_scheduler_state` WRITE;
/*!40000 ALTER TABLE `qrtz_scheduler_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_scheduler_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simple_triggers`
--

DROP TABLE IF EXISTS `qrtz_simple_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='简单触发器的信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simple_triggers`
--

LOCK TABLES `qrtz_simple_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simple_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simple_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_simprop_triggers`
--

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='同步机制的行锁表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_simprop_triggers`
--

LOCK TABLES `qrtz_simprop_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_simprop_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qrtz_triggers`
--

DROP TABLE IF EXISTS `qrtz_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='触发器详细信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qrtz_triggers`
--

LOCK TABLES `qrtz_triggers` WRITE;
/*!40000 ALTER TABLE `qrtz_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `qrtz_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2024-10-18 09:39:08','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2024-10-18 09:39:08','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2024-10-18 09:39:08','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2024-10-18 09:39:08','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','true','Y','admin','2024-10-18 09:39:08','admin','2024-11-06 18:16:45','是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2024-10-18 09:39:08','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,0,'0','总部门',0,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','admin','2024-11-10 21:43:00'),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2024-10-18 09:39:08','',NULL);
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2024-10-18 09:39:08','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2024-10-18 09:39:08','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2024-10-18 09:39:08','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2024-10-18 09:39:08','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2024-10-18 09:39:08','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2024-10-18 09:39:08','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2024-10-18 09:39:08','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2024-10-18 09:39:08','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2024-10-18 09:39:08','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2024-10-18 09:39:08','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2024-10-18 09:39:08','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2024-10-18 09:39:08','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2024-10-18 09:39:08','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2024-10-18 09:39:08','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2024-10-18 09:39:08','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2024-10-18 09:39:08','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2024-10-18 09:39:08','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2024-10-18 09:39:08','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2024-10-18 09:39:08','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2024-10-18 09:39:08','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2024-10-18 09:39:08','',NULL,'停用状态'),(100,1,'正常','0','user_status',NULL,'default','N','0','admin','2024-10-28 11:22:47','',NULL,NULL),(101,2,'禁用','1','user_status',NULL,'default','N','0','admin','2024-10-28 11:23:15','',NULL,NULL),(102,1,'正常','0','user_del_flag',NULL,'default','N','0','admin','2024-10-28 11:24:31','',NULL,NULL),(103,2,'注销','2','user_del_flag',NULL,'default','N','0','admin','2024-10-28 11:24:51','',NULL,NULL),(104,1,'正常','0','post_status',NULL,'default','N','0','admin','2024-11-01 12:34:42','',NULL,NULL),(105,2,'审核不通过','2','post_status',NULL,'default','N','0','admin','2024-11-01 12:35:34','',NULL,NULL),(106,3,'审核中','1','post_status',NULL,'default','N','0','admin','2024-11-01 12:35:54','admin','2024-11-10 21:48:39',NULL);
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_type` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2024-10-18 09:39:08','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2024-10-18 09:39:08','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2024-10-18 09:39:08','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2024-10-18 09:39:08','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2024-10-18 09:39:08','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2024-10-18 09:39:08','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2024-10-18 09:39:08','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2024-10-18 09:39:08','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2024-10-18 09:39:08','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2024-10-18 09:39:08','',NULL,'登录状态列表'),(100,'前台用户状态','user_status','0','admin','2024-10-28 11:19:03','',NULL,NULL),(101,'前台用户注销状态','user_del_flag','0','admin','2024-10-28 11:24:07','',NULL,NULL),(102,'帖子状态','post_status','0','admin','2024-11-01 12:34:04','',NULL,NULL);
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job`
--

DROP TABLE IF EXISTS `sys_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`,`job_name`,`job_group`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job`
--

LOCK TABLES `sys_job` WRITE;
/*!40000 ALTER TABLE `sys_job` DISABLE KEYS */;
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2024-10-18 09:39:08','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2024-10-18 09:39:08','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2024-10-18 09:39:08','',NULL,'');
/*!40000 ALTER TABLE `sys_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_job_log`
--

DROP TABLE IF EXISTS `sys_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_job_log` (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='定时任务调度日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_job_log`
--

LOCK TABLES `sys_job_log` WRITE;
/*!40000 ALTER TABLE `sys_job_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-28 10:49:54'),(101,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-28 14:42:56'),(102,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-28 14:44:01'),(103,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-28 14:51:12'),(104,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-28 14:51:20'),(105,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-28 14:51:26'),(106,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-28 14:51:36'),(107,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2024-10-29 12:02:43'),(108,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-29 12:02:48'),(109,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-29 12:03:11'),(110,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-29 12:03:52'),(111,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-29 12:09:00'),(112,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-29 12:11:09'),(113,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-29 12:11:30'),(114,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-10-29 15:28:20'),(115,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-31 17:52:44'),(116,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2024-10-31 17:53:18'),(117,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-31 17:53:28'),(118,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-31 19:36:06'),(119,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-10-31 19:41:08'),(120,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-10-31 19:43:55'),(121,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','Cannot invoke \"String.equals(Object)\" because the return value of \"top.xiaohutu.user.domain.User.getDelFlag()\" is null','2024-10-31 19:44:13'),(122,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码已失效','2024-10-31 19:48:07'),(123,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','Cannot invoke \"String.equals(Object)\" because the return value of \"top.xiaohutu.user.domain.User.getDelFlag()\" is null','2024-10-31 19:48:15'),(124,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','Cannot invoke \"String.equals(Object)\" because the return value of \"top.xiaohutu.user.domain.User.getDelFlag()\" is null','2024-10-31 19:49:06'),(125,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','Cannot invoke \"String.equals(Object)\" because the return value of \"top.xiaohutu.user.domain.User.getDelFlag()\" is null','2024-10-31 19:50:43'),(126,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-10-31 19:52:01'),(127,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','Cannot invoke \"String.equals(Object)\" because the return value of \"top.xiaohutu.user.domain.User.getDelFlag()\" is null','2024-10-31 19:52:48'),(128,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','Cannot invoke \"String.equals(Object)\" because the return value of \"top.xiaohutu.user.domain.User.getDelFlag()\" is null','2024-10-31 19:55:52'),(129,NULL,'127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','* 必须填写','2024-10-31 19:56:04'),(130,NULL,'127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','* 必须填写','2024-10-31 19:56:24'),(131,NULL,'127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-10-31 19:56:48'),(132,NULL,'127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','* 必须填写','2024-10-31 19:56:54'),(133,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','Cannot invoke \"String.equals(Object)\" because the return value of \"top.xiaohutu.user.domain.User.getDelFlag()\" is null','2024-10-31 19:58:54'),(134,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','Cannot invoke \"String.equals(Object)\" because the return value of \"top.xiaohutu.user.domain.User.getDelFlag()\" is null','2024-10-31 20:03:01'),(135,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-10-31 20:03:26'),(136,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-10-31 20:03:34'),(137,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-10-31 20:03:54'),(138,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-10-31 20:24:41'),(139,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-10-31 20:24:48'),(140,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-31 20:25:18'),(141,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-31 20:26:48'),(142,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-31 20:27:19'),(143,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2024-10-31 20:31:44'),(144,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-31 20:32:17'),(145,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2024-10-31 20:32:49'),(146,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-10-31 20:32:54'),(147,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-10-31 20:33:23'),(148,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-01 11:19:58'),(149,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:23:54'),(150,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:24:38'),(151,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:29:08'),(152,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:29:29'),(153,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:29:54'),(154,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:31:47'),(155,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-11-01 11:32:03'),(156,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:32:11'),(157,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:34:01'),(158,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-01 11:35:16'),(159,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-02 17:23:34'),(160,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-05 16:41:13'),(161,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 09:47:32'),(162,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-06 09:52:32'),(163,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 16:52:14'),(164,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 16:53:38'),(165,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','1','用户不存在/密码错误','2024-11-06 16:53:50'),(166,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2024-11-06 16:54:11'),(167,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 16:54:16'),(168,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 16:54:56'),(169,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 16:55:02'),(170,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 16:55:08'),(171,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 16:55:15'),(172,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 16:56:07'),(173,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 16:56:15'),(174,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 16:56:28'),(175,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 16:56:34'),(176,'maike','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 16:56:45'),(177,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 16:56:55'),(178,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 17:03:58'),(179,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 18:16:09'),(180,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 18:16:25'),(181,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 18:17:39'),(182,'xiaohutu','127.0.0.1','内网IP','Chrome 13','Windows 10','0','注册成功','2024-11-06 18:18:03'),(183,'xiaohutu','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 18:18:19'),(184,'xiaohutu','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-06 18:18:36'),(185,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-06 18:19:17'),(186,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-11-06 19:14:37'),(187,'test2','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-11-06 19:16:17'),(188,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-06 19:16:34'),(189,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2024-11-07 08:59:11'),(190,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-07 08:59:16'),(191,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码已失效','2024-11-07 09:02:29'),(192,'xiaohutu','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','用户不存在/密码错误','2024-11-07 09:02:34'),(193,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码已失效','2024-11-07 09:02:53'),(194,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-07 09:03:00'),(195,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-11-07 11:29:00'),(196,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-07 11:29:07'),(197,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-08 08:44:33'),(198,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-08 09:24:58'),(199,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码已失效','2024-11-08 15:42:22'),(200,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-08 15:42:27'),(201,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','1','验证码错误','2024-11-08 19:40:54'),(202,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-08 19:41:02'),(203,'test1','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-09 01:36:25'),(204,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-09 12:37:57'),(205,'test3','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-11-09 13:24:12'),(206,'ttt','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','注册成功','2024-11-09 13:25:46'),(207,'test2','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','1','验证码错误','2024-11-09 13:26:30'),(208,'test2','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-09 13:26:34'),(209,'test3','127.0.0.1','内网IP','Mobile Safari','Mac OS X (iPhone)','0','登录成功','2024-11-09 14:23:32'),(210,'test1','127.0.0.1','内网IP','Chrome Mobile','Android 1.x','1','验证码错误','2024-11-10 12:42:43'),(211,'test1','127.0.0.1','内网IP','Chrome Mobile','Android 1.x','1','验证码已失效','2024-11-10 12:42:47'),(212,'test1','127.0.0.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-11-10 12:42:52'),(213,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-10 19:17:34'),(214,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-10 21:00:17'),(215,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-10 21:00:36'),(216,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','退出成功','2024-11-10 21:00:47'),(217,'admin','127.0.0.1','内网IP','Chrome 13','Windows 10','0','登录成功','2024-11-10 21:00:59'),(218,'test1','127.0.0.1','内网IP','Chrome Mobile','Android 1.x','0','登录成功','2024-11-10 21:05:05');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) DEFAULT '' COMMENT '路由名称',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2031 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2024-10-18 09:39:08','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2024-10-18 09:39:08','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2024-10-18 09:39:08','',NULL,'系统工具目录'),(4,'小糊涂官网',0,4,'https://xiaohutu.top',NULL,'','',0,0,'M','0','0','','guide','admin','2024-10-18 09:39:08','admin','2024-10-28 14:40:03','若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2024-10-18 09:39:08','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2024-10-18 09:39:08','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2024-10-18 09:39:08','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2024-10-18 09:39:08','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'position','system/post/index','','',1,0,'C','0','0','system:position:list','post','admin','2024-10-18 09:39:08','admin','2024-10-28 14:58:02','岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2024-10-18 09:39:08','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2024-10-18 09:39:08','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2024-10-18 09:39:08','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2024-10-18 09:39:08','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2024-10-18 09:39:08','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2024-10-18 09:39:08','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2024-10-18 09:39:08','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2024-10-18 09:39:08','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2024-10-18 09:39:08','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2024-10-18 09:39:08','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2024-10-18 09:39:08','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2024-10-18 09:39:08','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2024-10-18 09:39:08','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2024-10-18 09:39:08','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2024-10-18 09:39:08','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2024-10-18 09:39:08','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2024-10-18 09:39:08','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2024-10-18 09:39:08','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2024-10-18 09:39:08','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2024-10-18 09:39:08','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2024-10-18 09:39:08','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2024-10-18 09:39:08','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2024-10-18 09:39:08','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2024-10-18 09:39:08','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2024-10-18 09:39:08','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2024-10-18 09:39:08','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2024-10-18 09:39:08','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2024-10-18 09:39:08','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2024-10-18 09:39:08','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2024-10-18 09:39:08','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2024-10-18 09:39:08','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2024-10-18 09:39:08','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2024-10-18 09:39:08','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2024-10-18 09:39:08','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2024-10-18 09:39:08','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2024-10-18 09:39:08','',NULL,''),(2006,'前台管理',0,3,'xiaohutu',NULL,NULL,'',1,0,'M','0','0',NULL,'monitor','admin','2024-10-28 14:33:50','',NULL,''),(2007,'帖子管理',2006,1,'post','post/post/index',NULL,'',1,0,'C','0','0','post:post:list','post','admin','2024-11-01 13:20:41','admin','2024-11-01 13:33:46','帖子菜单'),(2008,'帖子查询',2007,1,'#','',NULL,'',1,0,'F','0','0','post:post:query','#','admin','2024-11-01 13:20:41','',NULL,''),(2009,'帖子新增',2007,2,'#','',NULL,'',1,0,'F','0','0','post:post:add','#','admin','2024-11-01 13:20:41','',NULL,''),(2010,'帖子修改',2007,3,'#','',NULL,'',1,0,'F','0','0','post:post:edit','#','admin','2024-11-01 13:20:41','',NULL,''),(2011,'帖子删除',2007,4,'#','',NULL,'',1,0,'F','0','0','post:post:remove','#','admin','2024-11-01 13:20:41','',NULL,''),(2012,'帖子导出',2007,5,'#','',NULL,'',1,0,'F','0','0','post:post:export','#','admin','2024-11-01 13:20:41','',NULL,''),(2013,'标签管理',2006,1,'tag','post/tag/index',NULL,'',1,0,'C','0','0','post:tag:list','list','admin','2024-11-07 14:08:17','admin','2024-11-07 15:06:53','标签（分类）菜单'),(2014,'标签（分类）查询',2013,1,'#','',NULL,'',1,0,'F','0','0','post:tag:query','#','admin','2024-11-07 14:08:17','',NULL,''),(2015,'标签（分类）新增',2013,2,'#','',NULL,'',1,0,'F','0','0','post:tag:add','#','admin','2024-11-07 14:08:17','',NULL,''),(2016,'标签（分类）修改',2013,3,'#','',NULL,'',1,0,'F','0','0','post:tag:edit','#','admin','2024-11-07 14:08:17','',NULL,''),(2017,'标签（分类）删除',2013,4,'#','',NULL,'',1,0,'F','0','0','post:tag:remove','#','admin','2024-11-07 14:08:17','',NULL,''),(2018,'标签（分类）导出',2013,5,'#','',NULL,'',1,0,'F','0','0','post:tag:export','#','admin','2024-11-07 14:08:17','',NULL,''),(2025,'评论',2006,1,'comment','post/comment/index',NULL,'',1,0,'C','0','0','post:comment:list','#','admin','2024-11-09 23:32:13','admin','2024-11-10 21:42:12','评论菜单'),(2026,'评论查询',2025,1,'#','',NULL,'',1,0,'F','0','0','post:comment:query','#','admin','2024-11-09 23:32:13','',NULL,''),(2027,'评论新增',2025,2,'#','',NULL,'',1,0,'F','0','0','post:comment:add','#','admin','2024-11-09 23:32:13','',NULL,''),(2028,'评论修改',2025,3,'#','',NULL,'',1,0,'F','0','0','post:comment:edit','#','admin','2024-11-09 23:32:13','',NULL,''),(2029,'评论删除',2025,4,'#','',NULL,'',1,0,'F','0','0','post:comment:remove','#','admin','2024-11-09 23:32:13','',NULL,''),(2030,'评论导出',2025,5,'#','',NULL,'',1,0,'F','0','0','post:comment:export','#','admin','2024-11-09 23:32:13','',NULL,'');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2024-10-18 09:39:08','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2024-10-18 09:39:08','',NULL,'管理员');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB AUTO_INCREMENT=336 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'代码生成',6,'top.xiaohutu.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tb_user,tb_user_info\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:08:28',213),(101,'字典类型',1,'top.xiaohutu.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"前台用户状态\",\"dictType\":\"user_status\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:19:03',9),(102,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user\",\"className\":\"User\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户表id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserName\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"user_name\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"用户密码\",\"columnId\":3,\"columnName\":\"password\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Avatar\",\"columnComment\":\"用户头像地址\",\"columnId\":4,\"columnName\":\"avatar\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaFiel','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:22:24',44),(103,'字典数据',1,'top.xiaohutu.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"正常\",\"dictSort\":1,\"dictType\":\"user_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:22:47',9),(104,'字典数据',1,'top.xiaohutu.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"禁用\",\"dictSort\":2,\"dictType\":\"user_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:23:15',8),(105,'字典类型',1,'top.xiaohutu.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"前台用户注销状态\",\"dictType\":\"user_del_flag\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:24:07',7),(106,'字典数据',1,'top.xiaohutu.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"正常\",\"dictSort\":1,\"dictType\":\"user_del_flag\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:24:31',8),(107,'字典数据',1,'top.xiaohutu.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"cssClass\":\"\",\"default\":false,\"dictLabel\":\"注销\",\"dictSort\":2,\"dictType\":\"user_del_flag\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:24:51',7),(108,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user\",\"className\":\"User\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户表id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:22:24\",\"usableColumn\":false},{\"capJavaField\":\"UserName\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"user_name\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:22:24\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"用户密码\",\"columnId\":3,\"columnName\":\"password\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:22:24\",\"usableColumn\":false},{\"capJavaField\":\"Avatar\",\"columnComment\":\"用户头像地址\",\"columnId\":4,\"columnName\":\"avatar\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEd','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:27:44',30),(109,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"user\",\"className\":\"User\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户表id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:27:44\",\"usableColumn\":false},{\"capJavaField\":\"UserName\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"user_name\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:27:44\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"用户密码\",\"columnId\":3,\"columnName\":\"password\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:27:44\",\"usableColumn\":false},{\"capJavaField\":\"Avatar\",\"columnComment\":\"用户头像地址\",\"columnId\":4,\"columnName\":\"avatar\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEd','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:28:43',26),(110,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"info\",\"className\":\"UserInfo\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"ID 主键\",\"columnId\":18,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户id，连接用户基础表(c_user_id)\",\"columnId\":19,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"BirthDate\",\"columnComment\":\"出生日期\",\"columnId\":20,\"columnName\":\"Birth_date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"birthDate\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Bio\",\"columnComment\":\"个人简介\",\"columnId\":21,\"columnName\":\"bio\",\"columnType\":\"varchar(2000)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 11:28:58',19),(111,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_user\"}',NULL,0,NULL,'2024-10-28 11:29:04',261),(112,'用户头像',2,'top.xiaohutu.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','',NULL,1,'Illegal char <:> at index 36: E:\\Datas\\projects\\xiaohutu\\classpath:\\upload\\avatar\\2024\\10\\28\\IMG_20201115_180648_20241028141721A001.jpg','2024-10-28 14:17:21',77),(113,'用户头像',2,'top.xiaohutu.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','',NULL,1,'Illegal char <:> at index 36: E:\\Datas\\projects\\xiaohutu\\classpath:\\upload\\avatar\\2024\\10\\28\\aa_20241028141818A002.jpg','2024-10-28 14:18:18',1),(114,'用户头像',2,'top.xiaohutu.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','',NULL,1,'Illegal char <:> at index 36: E:\\Datas\\projects\\xiaohutu\\classpath:\\upload\\avatar\\2024\\10\\28\\aa_20241028141822A003.jpg','2024-10-28 14:18:22',1),(115,'用户头像',2,'top.xiaohutu.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','',NULL,1,'Illegal char <:> at index 36: E:\\Datas\\projects\\xiaohutu\\classpath:\\upload\\avatar\\2024\\10\\28\\aa_20241028141906A004.jpg','2024-10-28 14:19:06',1),(116,'用户头像',2,'top.xiaohutu.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','','{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2024/10/28/aa_20241028142038A001.jpg\",\"code\":200}',0,NULL,'2024-10-28 14:20:38',116),(117,'个人信息',2,'top.xiaohutu.web.controller.system.SysProfileController.updateProfile()','PUT',1,'admin','研发部门','/system/user/profile','127.0.0.1','内网IP','{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"maike\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"1\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:20:52',23),(118,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"user/user/index\",\"createTime\":\"2024-10-28 11:30:52\",\"icon\":\"people\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"前台用户管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"user-front\",\"perms\":\"user:user:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:27:22',13),(119,'菜单管理',1,'top.xiaohutu.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"前台管理\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"xiaohutu\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:33:50',9),(120,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"user/user/index\",\"createTime\":\"2024-10-28 11:30:52\",\"icon\":\"people\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"前台用户管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2006,\"path\":\"user-front\",\"perms\":\"user:user:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:34:14',8),(121,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createTime\":\"2024-10-18 09:39:08\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"小糊涂官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"https://xiaohutu.top\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:40:03',8),(122,'角色管理',2,'top.xiaohutu.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2024-10-18 09:39:08\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2006,2000,2001,2002,2003,2004,2005,4],\"params\":{},\"remark\":\"普通管理员\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:41:42',51),(123,'用户管理',1,'top.xiaohutu.web.controller.system.SysUserController.add()','POST',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"maike\",\"params\":{},\"phonenumber\":\"13344556677\",\"postIds\":[4],\"remark\":\"普通管理员\",\"roleIds\":[2],\"sex\":\"1\",\"status\":\"0\",\"userId\":100,\"userName\":\"maike\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:42:44',108),(124,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/position/index\",\"createTime\":\"2024-10-18 09:39:08\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"position\",\"perms\":\"system:position:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:54:43',9),(125,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2024-10-18 09:39:08\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"position\",\"perms\":\"system:position:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 14:58:02',9),(126,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_user,tb_user_info\"}',NULL,0,NULL,'2024-10-28 16:05:54',667),(127,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"info\",\"className\":\"UserInfo\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"ID 主键\",\"columnId\":18,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:28:58\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户id，连接用户基础表(c_user_id)\",\"columnId\":19,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:28:58\",\"usableColumn\":false},{\"capJavaField\":\"BirthDate\",\"columnComment\":\"出生日期\",\"columnId\":20,\"columnName\":\"Birth_date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"birthDate\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 11:28:58\",\"usableColumn\":false},{\"capJavaField\":\"Bio\",\"columnComment\":\"个人简介\",\"columnId\":21,\"columnName\":\"bio\",\"columnType\":\"varchar(2000)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-10-28 16:11:00',195),(128,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_user,tb_user_info\"}',NULL,0,NULL,'2024-10-28 16:11:05',434),(129,'代码生成',6,'top.xiaohutu.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tb_post\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 12:25:17',441),(130,'字典类型',1,'top.xiaohutu.web.controller.system.SysDictTypeController.add()','POST',1,'admin','研发部门','/system/dict/type','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"dictName\":\"帖子状态\",\"dictType\":\"post_status\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 12:34:04',28),(131,'字典数据',1,'top.xiaohutu.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"正常\",\"dictSort\":1,\"dictType\":\"post_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 12:34:42',18),(132,'字典数据',1,'top.xiaohutu.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"审核不通过\",\"dictSort\":2,\"dictType\":\"post_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 12:35:34',13),(133,'字典数据',1,'top.xiaohutu.web.controller.system.SysDictDataController.add()','POST',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"审核通过\",\"dictSort\":3,\"dictType\":\"post_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 12:35:54',12),(134,'字典数据',2,'top.xiaohutu.web.controller.system.SysDictDataController.edit()','PUT',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:35:54\",\"default\":false,\"dictCode\":106,\"dictLabel\":\"禁用\",\"dictSort\":3,\"dictType\":\"post_status\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 12:37:38',15),(135,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"post\",\"className\":\"Post\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"帖子ID\",\"columnId\":30,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:25:17\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户\",\"columnId\":31,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:25:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ContentText\",\"columnComment\":\"文本内容\",\"columnId\":32,\"columnName\":\"content_text\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:25:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"contentText\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ContentImage\",\"columnComment\":\"图片地址\",\"columnId\":33,\"columnName\":\"content_image\",\"columnType\":\"varchar(3000)\",\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:25:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaFi','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 12:38:06',117),(136,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"post\",\"className\":\"Post\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"帖子ID\",\"columnId\":30,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:25:17\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2024-11-01 12:38:06\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户\",\"columnId\":31,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:25:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2024-11-01 12:38:06\",\"usableColumn\":false},{\"capJavaField\":\"ContentText\",\"columnComment\":\"文本内容\",\"columnId\":32,\"columnName\":\"content_text\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:25:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"contentText\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2024-11-01 12:38:06\",\"usableColumn\":false},{\"capJavaField\":\"ContentImage\",\"columnComment\":\"图片地址\",\"columnId\":33,\"columnName\":\"content_image\",\"columnType\":\"varchar(3000)\",\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:25:17\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"is','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 12:51:02',59),(137,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_post\"}',NULL,0,NULL,'2024-11-01 13:19:16',441),(138,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"post/post/index\",\"createTime\":\"2024-11-01 13:20:41\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"帖子\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"post\",\"perms\":\"post:post:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 13:33:26',49),(139,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"post/post/index\",\"createTime\":\"2024-11-01 13:20:41\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"帖子管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"post\",\"perms\":\"post:post:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-01 13:33:46',10),(140,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"addressId\":1,\"commentCount\":0,\"contentImage\":\"/profile/upload/2024/11/05/微信图片_20220929192635_20241105164419A001.jpg\",\"contentText\":\"今天天气好的很\",\"createTime\":\"2024-11-05 16:45:24\",\"favoriteCount\":0,\"id\":8,\"isPublic\":1,\"likeCount\":0,\"params\":{},\"status\":0,\"tagId\":8,\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-05 16:45:24',42),(141,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"addressId\":1,\"commentCount\":6,\"contentImage\":\"/profile/upload/2024/11/05/aefea4c1a2a622fab643caece8faf0b9_20241105170146A001.png,/profile/upload/2024/11/05/aa89202b1f51f4c93cf69a70097ca4a_20241105170150A002.jpg,/profile/upload/2024/11/05/f7ca6a8145705d7a057955d36d86bde_20241105170156A003.jpg\",\"contentText\":\"今天天气真好\",\"createBy\":\"\",\"draftStatus\":0,\"favoriteCount\":1,\"id\":1,\"isPublic\":1,\"likeCount\":0,\"params\":{},\"status\":0,\"tagId\":8,\"updateBy\":\"\",\"updateTime\":\"2024-11-05 17:01:58\",\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-05 17:01:59',29),(142,'角色管理',2,'top.xiaohutu.web.controller.system.SysRoleController.edit()','PUT',1,'admin','研发部门','/system/role','127.0.0.1','内网IP','{\"admin\":false,\"createTime\":\"2024-10-18 09:39:08\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"普通管理员\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 16:56:02',31),(143,'菜单管理',3,'top.xiaohutu.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2000','127.0.0.1','内网IP','{}','{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}',0,NULL,'2024-11-06 17:16:42',27),(144,'菜单管理',3,'top.xiaohutu.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2001','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 17:16:49',43),(145,'菜单管理',3,'top.xiaohutu.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2005','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 17:16:59',18),(146,'菜单管理',3,'top.xiaohutu.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2002','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 17:17:02',43),(147,'菜单管理',3,'top.xiaohutu.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2003','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 17:17:05',17),(148,'菜单管理',3,'top.xiaohutu.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2004','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 17:17:07',21),(149,'菜单管理',3,'top.xiaohutu.web.controller.system.SysMenuController.remove()','DELETE',1,'admin','研发部门','/system/menu/2000','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 17:17:12',19),(150,'参数管理',2,'top.xiaohutu.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2024-10-18 09:39:08\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 18:16:04',22),(151,'参数管理',2,'top.xiaohutu.web.controller.system.SysConfigController.edit()','PUT',1,'admin','研发部门','/system/config','127.0.0.1','内网IP','{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2024-10-18 09:39:08\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2024-11-06 18:16:04\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 18:16:45',13),(152,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"addressId\":1,\"commentCount\":1,\"contentImage\":\"/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg\",\"contentText\":\"哈哈哈\",\"createBy\":\"\",\"draftStatus\":0,\"favoriteCount\":1,\"id\":2,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"status\":0,\"tagId\":4,\"updateBy\":\"\",\"updateTime\":\"2024-11-06 20:07:01\",\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 20:07:01',105),(153,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"addressId\":3,\"commentCount\":2,\"contentImage\":\"/profile/upload/2024/11/06/mmexport1606021214496_20241106200709A002.jpg\",\"contentText\":\"今天又是敲代码的一天\",\"createBy\":\"\",\"draftStatus\":0,\"favoriteCount\":1,\"id\":3,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"status\":0,\"tagId\":1,\"updateBy\":\"\",\"updateTime\":\"2024-11-06 20:07:10\",\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 20:07:10',12),(154,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"addressId\":3,\"commentCount\":1,\"contentImage\":\"/profile/upload/2024/11/06/48cc215defbfb6eb02543f5061dbb7a_20241106200723A003.jpg\",\"contentText\":\"不想敲代码\",\"createBy\":\"\",\"draftStatus\":0,\"favoriteCount\":1,\"id\":4,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"status\":0,\"tagId\":3,\"updateBy\":\"\",\"updateTime\":\"2024-11-06 20:07:23\",\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 20:07:24',6),(155,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"addressId\":3,\"commentCount\":1,\"contentImage\":\"/profile/upload/2024/11/06/微信图片_20220929192707_20241106204641A004.jpg\",\"contentText\":\"不想敲代码第2天\",\"createBy\":\"\",\"draftStatus\":0,\"favoriteCount\":1,\"id\":5,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"status\":0,\"tagId\":0,\"updateBy\":\"\",\"updateTime\":\"2024-11-06 20:46:42\",\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-06 20:46:42',32),(156,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"createTime\":\"2024-11-07 13:58:47\",\"id\":34,\"params\":{}}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-07 13:58:47',111),(157,'代码生成',6,'top.xiaohutu.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tb_tag\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-07 14:00:44',268),(158,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"tag\",\"className\":\"Tag\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"标签id\",\"columnId\":46,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-07 14:00:44\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TagContent\",\"columnComment\":\"标签内容\",\"columnId\":47,\"columnName\":\"tag_content\",\"columnType\":\"varchar(20)\",\"createBy\":\"admin\",\"createTime\":\"2024-11-07 14:00:44\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"tagContent\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Count\",\"columnComment\":\"标签使用数量\",\"columnId\":48,\"columnName\":\"count\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2024-11-07 14:00:44\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"count\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreateBy\",\"columnComment\":\"创建者\",\"columnId\":49,\"columnName\":\"create_by\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2024-11-07 14:00:44\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"createBy\",\"javaType\":\"String\",\"list\":fal','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-07 14:05:47',54),(159,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_tag\"}',NULL,0,NULL,'2024-11-07 14:05:50',147),(160,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"post/tag/index\",\"createTime\":\"2024-11-07 14:08:17\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"标签管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"tag\",\"perms\":\"post:tag:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-07 15:06:53',22),(161,'用户头像',2,'top.xiaohutu.web.controller.system.SysProfileController.avatar()','POST',1,'admin','研发部门','/system/user/profile/avatar','127.0.0.1','内网IP','','{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2024/11/08/微信图片_20220929192707_20241108154301A004.jpg\",\"code\":200}',0,NULL,'2024-11-08 15:43:01',39),(162,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/pro_20241109002254A002.jpg,/profile/upload/2024/11/09/xiaohutu_20241109002254A001.png\",\"contentText\":\"test\",\"createTime\":\"2024-11-09 00:22:54\",\"isPublic\":1,\"params\":{},\"postTitle\":\"test\",\"tagId\":\"1,2,4\",\"userId\":102}',NULL,1,'top.xiaohutu.post.domain.PostTag Not Found TableInfoCache.','2024-11-09 00:22:54',43),(163,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/pro_20241109002535A002.jpg,/profile/upload/2024/11/09/xiaohutu_20241109002535A001.png\",\"contentText\":\"aaa\",\"createTime\":\"2024-11-09 00:25:35\",\"isPublic\":1,\"params\":{},\"postTitle\":\"a\",\"tagId\":\"2,3\",\"userId\":102}',NULL,1,'top.xiaohutu.post.domain.PostTag Not Found TableInfoCache.','2024-11-09 00:25:36',39),(164,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/pro_20241109003053A002.jpg,/profile/upload/2024/11/09/xiaohutu_20241109003053A001.png\",\"contentText\":\"aaa\",\"createTime\":\"2024-11-09 00:30:53\",\"isPublic\":1,\"params\":{},\"postTitle\":\"a\",\"tagId\":\"2,3\",\"userId\":102}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null\r\n### The error may exist in file [E:\\Datas\\projects\\xiaohutu\\xiaohutu-end\\xiaohutu-post\\target\\classes\\mapper\\post\\PostTagMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_post_tag(post_id,tag_id) values                        (?,?)          ,              (?,?)\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null\n; Column \'post_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null','2024-11-09 00:30:53',131),(165,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/pro_20241109003208A004.jpg,/profile/upload/2024/11/09/xiaohutu_20241109003208A003.png\",\"contentText\":\"aaa\",\"createTime\":\"2024-11-09 00:32:08\",\"isPublic\":1,\"params\":{},\"postTitle\":\"a\",\"tagId\":\"2,3\",\"userId\":102}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null\r\n### The error may exist in file [E:\\Datas\\projects\\xiaohutu\\xiaohutu-end\\xiaohutu-post\\target\\classes\\mapper\\post\\PostTagMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_post_tag(post_id,tag_id) values                        (?,?)          ,              (?,?)\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null\n; Column \'post_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null','2024-11-09 00:32:55',46981),(166,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/pro_20241109003357A005.jpg,/profile/upload/2024/11/09/xiaohutu_20241109003357A006.png\",\"contentText\":\"aaa\",\"createTime\":\"2024-11-09 00:33:58\",\"isPublic\":1,\"params\":{},\"postTitle\":\"a\",\"tagId\":\"2,3\",\"userId\":102}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null\r\n### The error may exist in file [E:\\Datas\\projects\\xiaohutu\\xiaohutu-end\\xiaohutu-post\\target\\classes\\mapper\\post\\PostTagMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_post_tag(post_id,tag_id) values                        (?,?)          ,              (?,?)\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null\n; Column \'post_id\' cannot be null; nested exception is java.sql.SQLIntegrityConstraintViolationException: Column \'post_id\' cannot be null','2024-11-09 00:33:58',6),(167,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/pro_20241109003434A002.jpg,/profile/upload/2024/11/09/xiaohutu_20241109003434A001.png\",\"contentText\":\"aaa\",\"createTime\":\"2024-11-09 00:34:34\",\"id\":35,\"isPublic\":1,\"params\":{},\"postTitle\":\"a\",\"tagId\":\"2,3\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 00:34:34',61),(168,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/pro_20241109004439A002.jpg,/profile/upload/2024/11/09/xiaohutu_20241109004439A001.png\",\"contentText\":\"testttt\",\"createTime\":\"2024-11-09 00:44:39\",\"id\":36,\"isPublic\":1,\"params\":{},\"postTitle\":\"test\",\"tagId\":\"1,3\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 00:44:40',79),(169,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/xiaohutu_20241109004634A003.png,\",\"contentText\":\"汝坤否？\",\"createTime\":\"2024-11-09 00:46:34\",\"id\":37,\"isPublic\":0,\"params\":{},\"postTitle\":\"tttttttttt不想写了\",\"tagId\":\"3,4\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 00:46:34',11),(170,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"666\",\"createTime\":\"2024-11-09 01:03:24\",\"id\":38,\"isPublic\":0,\"params\":{},\"postTitle\":\"睡觉了兄弟\",\"tagId\":\"1\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 01:03:24',41),(171,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈\",\"createTime\":\"2024-11-09 01:21:06\",\"id\":39,\"isPublic\":0,\"params\":{},\"postTitle\":\"人机吧你\",\"tagId\":\"1\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 01:21:06',24),(172,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"userInfo\",\"className\":\"UserInfo\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"ID 主键\",\"columnId\":18,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 16:10:59\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户id，连接用户基础表(c_user_id)\",\"columnId\":19,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 16:10:59\",\"usableColumn\":false},{\"capJavaField\":\"BirthDate\",\"columnComment\":\"出生日期\",\"columnId\":20,\"columnName\":\"Birth_date\",\"columnType\":\"date\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"birthDate\",\"javaType\":\"Date\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2024-10-28 16:10:59\",\"usableColumn\":false},{\"capJavaField\":\"Bio\",\"columnComment\":\"个人简介\",\"columnId\":21,\"columnName\":\"bio\",\"columnType\":\"varchar(2000)\",\"createBy\":\"admin\",\"createTime\":\"2024-10-28 11:08:28\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEd','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 13:07:40',136),(173,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_user_info\"}',NULL,0,NULL,'2024-11-09 13:07:45',476),(174,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test3',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/09/8D6B9EEDA99F8050C9DA6249CFF0D617_20241109181159A001.jpg\",\"contentText\":\"人机\",\"createTime\":\"2024-11-09 18:11:59\",\"id\":40,\"isPublic\":0,\"params\":{},\"postTitle\":\"嘎嘎嘎\",\"tagId\":\"3\",\"updateTime\":\"2024-11-09 18:11:59\",\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 18:11:59',108),(175,'代码生成',6,'top.xiaohutu.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"tb_user_like,tb_user_collection\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 18:21:40',275),(176,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"like\",\"className\":\"UserLike\",\"columns\":[{\"capJavaField\":\"UserId\",\"columnComment\":\"点赞用户ID(连接用户详情表的c_user_id)\",\"columnId\":59,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 18:21:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PostId\",\"columnComment\":\"被点赞帖子ID\",\"columnId\":60,\"columnName\":\"post_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 18:21:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"postId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreateBy\",\"columnComment\":\"创建者\",\"columnId\":61,\"columnName\":\"create_by\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 18:21:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"createBy\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":true,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreateTime\",\"columnComment\":\"创建时间\",\"columnId\":62,\"columnName\":\"create_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 18:21:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":false,\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"createTime\",\"javaType\":\"Date\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"q','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 18:22:40',92),(177,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"collection\",\"className\":\"UserCollection\",\"columns\":[{\"capJavaField\":\"UserId\",\"columnComment\":\"(用户ID) - 外键，关联到用户表，表示哪个用户收藏了这个条目\",\"columnId\":53,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 18:21:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PostId\",\"columnComment\":\"(微博帖子ID) - 外键，关联到微博帖子表，表示哪个微博帖子被用户收藏\",\"columnId\":54,\"columnName\":\"post_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 18:21:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"postId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreateBy\",\"columnComment\":\"创建者\",\"columnId\":55,\"columnName\":\"create_by\",\"columnType\":\"varchar(64)\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 18:21:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"createBy\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":true,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreateTime\",\"columnComment\":\"创建时间\",\"columnId\":56,\"columnName\":\"create_time\",\"columnType\":\"datetime\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 18:21:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":false,\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isPk\":\"0\",\"isRequired\":\"0\",\"javaField\":\"createTime\",\"javaType\":\"Date\",\"lis','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 18:23:31',25),(178,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_user_like\"}',NULL,0,NULL,'2024-11-09 18:23:43',464),(179,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"tb_user_collection\"}',NULL,0,NULL,'2024-11-09 20:04:34',573),(180,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test3',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:43:15\",\"params\":{},\"postId\":40,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:43:15',50),(181,'点赞',3,'top.xiaohutu.post.controller.UserLikeController.remove()','DELETE',1,'test3',NULL,'/post/like/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-09 20:44:40',86),(182,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test3',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:45:16\",\"params\":{},\"postId\":40,\"userId\":105}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'105-40\' for key \'tb_user_like.PRIMARY\'\r\n### The error may exist in file [E:\\Datas\\projects\\xiaohutu\\xiaohutu-end\\xiaohutu-post\\target\\classes\\mapper\\post\\UserLikeMapper.xml]\r\n### The error may involve top.xiaohutu.post.mapper.UserLikeMapper.insertUserLike-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into tb_user_like          ( user_id,             post_id,                          create_time )           values ( ?,             ?,                          ? )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'105-40\' for key \'tb_user_like.PRIMARY\'\n; Duplicate entry \'105-40\' for key \'tb_user_like.PRIMARY\'; nested exception is java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'105-40\' for key \'tb_user_like.PRIMARY\'','2024-11-09 20:45:16',89),(183,'点赞',3,'top.xiaohutu.post.controller.UserLikeController.remove()','DELETE',1,'test3',NULL,'/post/like/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-09 20:45:40',20460),(184,'点赞',3,'top.xiaohutu.post.controller.UserLikeController.remove()','DELETE',1,'test3',NULL,'/post/like/delete','127.0.0.1','内网IP','{}',NULL,1,'nested exception is org.apache.ibatis.type.TypeException: Could not set parameters for mapping: ParameterMapping{property=\'userId\', mode=IN, javaType=class java.lang.String, jdbcType=null, numericScale=null, resultMapId=\'null\', jdbcTypeName=\'null\', expression=\'null\'}. Cause: org.apache.ibatis.type.TypeException: Error setting non null for parameter #1 with JdbcType null . Try setting a different JdbcType for this parameter or a different configuration property. Cause: java.lang.ClassCastException: java.lang.Long cannot be cast to java.lang.String','2024-11-09 20:46:08',16),(185,'点赞',3,'top.xiaohutu.post.controller.UserLikeController.remove()','DELETE',1,'test3',NULL,'/post/like/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:47:58',33),(186,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test3',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:47:59\",\"params\":{},\"postId\":40,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:47:59',23),(187,'点赞',3,'top.xiaohutu.post.controller.UserLikeController.remove()','DELETE',1,'test3',NULL,'/post/like/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:48:00',5),(188,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test3',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:48:04\",\"params\":{},\"postId\":40,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:48:04',8),(189,'点赞',3,'top.xiaohutu.post.controller.UserLikeController.remove()','DELETE',1,'test3',NULL,'/post/like/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:48:07',6),(190,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:54:39\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:54:39',74),(191,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:54:39',16),(192,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:54:40\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:54:40',6),(193,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:54:40',6),(194,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:54:40\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:54:40',6),(195,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:54:40',7),(196,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:54:41\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:54:41',6),(197,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:54:41',9),(198,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:55:05\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:05',9),(199,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:06',6),(200,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:55:48\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:48',6),(201,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:50',5),(202,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:55:50\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:50',4),(203,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test3',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:55:51\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:51',7),(204,'点赞',3,'top.xiaohutu.post.controller.UserLikeController.remove()','DELETE',1,'test3',NULL,'/post/like/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:51',6),(205,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test3',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:55:52\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:52',6),(206,'点赞',3,'top.xiaohutu.post.controller.UserLikeController.remove()','DELETE',1,'test3',NULL,'/post/like/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:52',6),(207,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:53',3),(208,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:55:53\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:53',4),(209,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:54',4),(210,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:55:54\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:55:54',4),(211,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:56:31',31),(212,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:56:33\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:56:33',5),(213,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:56:34',4),(214,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:56:34\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:56:34',4),(215,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:56:35',5),(216,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:56:36\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:56:36',4),(217,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:57:05',7),(218,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:57:06\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:57:06',6),(219,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:57:06',5),(220,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 20:57:07\",\"params\":{},\"postId\":36,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 20:57:07',7),(221,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-09 21:28:30',89),(222,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:28:30\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:30',233),(223,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:30',11),(224,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:28:38\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:38',6),(225,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:39',7),(226,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:28:41\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:41',4),(227,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:41',5),(228,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:28:42\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:42',9),(229,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:43',5),(230,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:28:48\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:48',5),(231,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:52',3),(232,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:28:53\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:28:53',5),(233,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:13',8),(234,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:33\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:33',8),(235,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:35',4),(236,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:36\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:36',5),(237,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:37',5),(238,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:37\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:37',4),(239,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:37',5),(240,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:37\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:37',3),(241,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:37',4),(242,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:38\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:38',5),(243,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:38',3),(244,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:38\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:38',4),(245,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:38',4),(246,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:38\",\"params\":{},\"postId\":24,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:38',4),(247,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:39',3),(248,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:44\",\"params\":{},\"postId\":40,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:44',5),(249,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test3',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:45',5),(250,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test3',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-09 21:29:47\",\"params\":{},\"postId\":40,\"userId\":105}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:29:47',5),(251,'代码生成',6,'top.xiaohutu.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"comment\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:48:38',164),(252,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"comment\",\"className\":\"Comment\",\"columns\":[{\"capJavaField\":\"CommentId\",\"columnComment\":\"评论ID\",\"columnId\":65,\"columnName\":\"comment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"commentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PostId\",\"columnComment\":\"所评论的帖子ID，用于连接帖子表\",\"columnId\":66,\"columnName\":\"post_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"postId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"评论用户ID，用于连接用户基础表(user_id)\",\"columnId\":67,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CommentText\",\"columnComment\":\"评论内容(text)\",\"columnId\":68,\"columnName\":\"comment_text\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"is','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 21:50:49',63),(253,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"comment\"}',NULL,0,NULL,'2024-11-09 23:27:52',684),(254,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"comment\",\"className\":\"Comment\",\"columns\":[{\"capJavaField\":\"CommentId\",\"columnComment\":\"评论ID\",\"columnId\":65,\"columnName\":\"comment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"commentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2024-11-09 21:50:49\",\"usableColumn\":false},{\"capJavaField\":\"PostId\",\"columnComment\":\"所评论的帖子ID，用于连接帖子表\",\"columnId\":66,\"columnName\":\"post_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"postId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2024-11-09 21:50:49\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"评论用户ID，用于连接用户基础表(user_id)\",\"columnId\":67,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2024-11-09 21:50:49\",\"usableColumn\":false},{\"capJavaField\":\"CommentText\",\"columnComment\":\"评论内容(text)\",\"columnId\":68,\"columnName\":\"comment_text\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 23:30:31',46),(255,'代码生成',2,'top.xiaohutu.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"comment\",\"className\":\"Comment\",\"columns\":[{\"capJavaField\":\"CommentId\",\"columnComment\":\"评论ID\",\"columnId\":65,\"columnName\":\"comment_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"commentId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2024-11-09 23:30:31\",\"usableColumn\":false},{\"capJavaField\":\"PostId\",\"columnComment\":\"所评论的帖子ID，用于连接帖子表\",\"columnId\":66,\"columnName\":\"post_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"postId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2024-11-09 23:30:31\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"评论用户ID，用于连接用户基础表(user_id)\",\"columnId\":67,\"columnName\":\"user_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2024-11-09 23:30:31\",\"usableColumn\":false},{\"capJavaField\":\"CommentText\",\"columnComment\":\"评论内容(text)\",\"columnId\":68,\"columnName\":\"comment_text\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2024-11-09 21:48:38\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 23:30:40',39),(256,'代码生成',8,'top.xiaohutu.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"comment\"}',NULL,0,NULL,'2024-11-09 23:30:43',156),(257,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'admin','研发部门','/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":4,\"commentText\":\"嗡嗡嗡\",\"createTime\":\"2024-11-09 23:46:21\",\"params\":{},\"parentCommentId\":0,\"postId\":1,\"topId\":1,\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-09 23:46:21',88),(258,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":5,\"commentText\":\"@maike 你好呀\",\"createTime\":\"2024-11-10 14:21:04\",\"params\":{},\"parentCommentId\":1,\"postId\":1,\"topId\":1,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 14:21:04',42),(259,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":6,\"commentText\":\"哈哈哈\",\"createTime\":\"2024-11-10 14:31:30\",\"params\":{},\"parentCommentId\":0,\"postId\":1,\"topId\":0,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 14:31:30',5),(260,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":7,\"commentText\":\"@测试1号 你好呀\",\"createTime\":\"2024-11-10 14:31:50\",\"params\":{},\"parentCommentId\":6,\"postId\":1,\"topId\":6,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 14:31:50',6),(261,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":8,\"commentText\":\"@若依 阿阿嘎\",\"createTime\":\"2024-11-10 14:35:34\",\"params\":{},\"parentCommentId\":2,\"postId\":1,\"topId\":1,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 14:35:34',9),(262,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"哈哈哈哈哈\",\"createTime\":\"2024-11-10 15:04:01\",\"id\":41,\"isPublic\":0,\"params\":{},\"postTitle\":\"绘画\",\"tagId\":\"3,4,5\",\"updateTime\":\"2024-11-10 15:04:01\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 15:04:01',96),(263,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test1',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-10 16:00:41\",\"params\":{},\"postId\":2,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 16:00:41',54),(264,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test1',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-10 16:07:51\",\"params\":{},\"postId\":4,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 16:07:51',27),(265,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test1',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-10 16:08:29\",\"params\":{},\"postId\":35,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 16:08:29',9),(266,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"八八八八\",\"createTime\":\"2024-11-10 16:33:35\",\"id\":42,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊啊啊\",\"tagId\":\"\",\"updateTime\":\"2024-11-10 16:33:35\",\"userId\":102}',NULL,1,'For input string: \"\"','2024-11-10 16:33:35',55),(267,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"啊a\",\"createTime\":\"2024-11-10 16:37:42\",\"id\":43,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊啊啊\",\"tagId\":\"\",\"updateTime\":\"2024-11-10 16:37:42\",\"userId\":102}',NULL,1,'For input string: \"\"','2024-11-10 16:37:42',16),(268,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"啊啊啊\",\"createTime\":\"2024-11-10 16:37:57\",\"id\":44,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊啊啊\",\"tagId\":\"\",\"updateTime\":\"2024-11-10 16:37:57\",\"userId\":102}',NULL,1,'For input string: \"\"','2024-11-10 16:38:23',25728),(269,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"\",\"createTime\":\"2024-11-10 16:40:15\",\"id\":45,\"isPublic\":0,\"params\":{},\"postTitle\":\"啵啵啵宝宝\",\"tagId\":\"\",\"updateTime\":\"2024-11-10 16:40:15\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 16:40:15',59),(270,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"手动阀十分\",\"createTime\":\"2024-11-10 16:41:08\",\"id\":46,\"isPublic\":0,\"params\":{},\"postTitle\":\"\",\"tagId\":\"\",\"updateTime\":\"2024-11-10 16:41:08\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 16:41:24',15905),(271,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"\",\"createTime\":\"2024-11-10 16:41:56\",\"id\":47,\"isPublic\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"tagId\":\"\",\"updateTime\":\"2024-11-10 16:41:56\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 16:41:56',12),(272,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"\",\"createTime\":\"2024-11-10 16:42:41\",\"draftStatus\":1,\"id\":48,\"isPublic\":0,\"params\":{},\"postTitle\":\"哇哇哇\",\"tagId\":\"\",\"updateTime\":\"2024-11-10 16:42:41\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 16:42:42',9),(273,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:24:41\",\"draftStatus\":1,\"favoriteCount\":0,\"id\":49,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":0,\"tagId\":\"\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 17:24:41\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 17:24:41',165),(274,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦从顶顶顶顶顶\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:24:41\",\"draftStatus\":1,\"favoriteCount\":0,\"id\":49,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":0,\"tagId\":\"\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 17:30:26\",\"userId\":102}',NULL,1,'For input string: \"\"','2024-11-10 17:30:26',29),(275,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦从顶顶顶顶顶帆帆帆帆\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:24:41\",\"draftStatus\":1,\"favoriteCount\":0,\"id\":49,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":0,\"tagId\":\"\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 17:32:40\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 17:32:40',41),(276,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"/profile/upload/2024/11/10/8D6B9EEDA99F8050C9DA6249CFF0D617_20241110173450A001.jpg\",\"contentText\":\"烦烦烦从顶顶顶顶顶帆帆帆帆\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:50\",\"draftStatus\":1,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":0,\"tagId\":\"3\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 17:34:50\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 17:34:50',40),(277,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦从顶顶顶顶顶帆帆帆帆\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":1,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":0,\"tagId\":\"\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 17:35:47\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 17:35:47',11),(278,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"/profile/upload/2024/11/10/8D6B9EEDA99F8050C9DA6249CFF0D617_20241110173627A002.jpg\",\"contentText\":\"烦烦烦从顶顶顶顶顶帆帆帆帆\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":0,\"tagId\":\"4,3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 17:36:27\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 17:36:28',8),(279,'帖子',3,'top.xiaohutu.post.controller.PostController.remove()','DELETE',1,'admin','研发部门','/post/post/49','127.0.0.1','内网IP','{}',NULL,1,'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [array, arg0]','2024-11-10 19:18:06',22),(280,'帖子',3,'top.xiaohutu.post.controller.PostController.remove()','DELETE',1,'admin','研发部门','/post/post/48,47,46','127.0.0.1','内网IP','{}',NULL,1,'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'userId\' not found. Available parameters are [array, arg0]','2024-11-10 19:18:33',4),(281,'帖子',3,'top.xiaohutu.post.controller.PostController.remove()','DELETE',1,'test1',NULL,'/post/post/48','127.0.0.1','内网IP','{}',NULL,1,'nested exception is org.apache.ibatis.binding.BindingException: Parameter \'array\' not found. Available parameters are [ids, userId, param1, param2]','2024-11-10 19:22:03',36),(282,'帖子',3,'top.xiaohutu.post.controller.PostController.remove()','DELETE',1,'test1',NULL,'/post/post/48','127.0.0.1','内网IP','{}',NULL,1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'== 102\' at line 5\r\n### The error may exist in file [E:\\Datas\\projects\\xiaohutu\\xiaohutu-end\\xiaohutu-post\\target\\classes\\mapper\\post\\PostMapper.xml]\r\n### The error may involve top.xiaohutu.post.mapper.PostMapper.deletePostByIds-Inline\r\n### The error occurred while setting parameters\r\n### SQL: delete from tb_post where id in           (               ?          )          and user_id == ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'== 102\' at line 5\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'== 102\' at line 5','2024-11-10 19:23:27',60),(283,'帖子',3,'top.xiaohutu.post.controller.PostController.remove()','DELETE',1,'test1',NULL,'/post/post/48','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 19:24:03',27),(284,'帖子',3,'top.xiaohutu.post.controller.PostController.remove()','DELETE',1,'test1',NULL,'/post/post/47','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 19:26:10',15),(285,'点赞',1,'top.xiaohutu.post.controller.UserLikeController.add()','POST',1,'test1',NULL,'/post/like','127.0.0.1','内网IP','{\"createTime\":\"2024-11-10 20:11:56\",\"params\":{},\"postId\":37,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 20:11:56',67),(286,'收藏',1,'top.xiaohutu.post.controller.UserCollectionController.add()','POST',1,'test1',NULL,'/post/collection','127.0.0.1','内网IP','{\"createTime\":\"2024-11-10 21:12:01\",\"params\":{},\"postId\":35,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:12:01',29),(287,'收藏',3,'top.xiaohutu.post.controller.UserCollectionController.remove()','DELETE',1,'test1',NULL,'/post/collection/delete','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:12:01',26),(288,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦从顶顶顶顶顶帆帆帆帆\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:24:41\",\"draftStatus\":1,\"favoriteCount\":0,\"id\":49,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":0,\"tagId\":\"\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 21:17:27\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:17:27',40),(289,'帖子',3,'top.xiaohutu.post.controller.PostController.remove()','DELETE',1,'test1',NULL,'/post/post/39','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:18:08',50),(290,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"666，不想当牛马\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"今天差不多终于写完了\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:20:12\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:20:13',22),(291,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"666，不想当牛马\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"今天差不多终于写完了\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:20:44\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:20:44',7),(292,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"666，不想当牛马\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"今天差不多终于写完了\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:21:13\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:21:13',12),(293,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"666，不想当牛马\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"今天差不多终于写完了\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:21:24\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:21:24',5),(294,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"666，不想当牛马\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"今天差不多终于写完了\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:21:27\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:21:27',10),(295,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"666，不想当牛马\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"今天差不多终于写完了\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:21:34\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:21:34',8),(296,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"终于差不多了\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"差不多了\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:22:07\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:22:07',5),(297,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"终于差不多了\",\"draftStatus\":1,\"isPublic\":0,\"params\":{},\"postTitle\":\"差不多了\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:22:19\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:22:19',5),(298,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦从顶顶顶顶顶帆帆帆帆嘎嘎嘎\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:24:41\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":49,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":0,\"tagId\":\"3\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 21:25:09\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:25:09',17),(299,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"啊啊啊但是公司的\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊啊啊\",\"tagId\":\"4\",\"updateTime\":\"2024-11-10 21:25:36\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:25:36',4),(300,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"啊啊啊但是公司的\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊啊啊\",\"tagId\":\"4\",\"updateTime\":\"2024-11-10 21:26:36\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:26:36',5),(301,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"阿斯顿发生\",\"draftStatus\":0,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊啊啊的撒发生\",\"tagId\":\"3\",\"updateTime\":\"2024-11-10 21:30:27\",\"userId\":102}','{\"msg\":\"操作失败\",\"code\":500}',0,NULL,'2024-11-10 21:30:27',7),(302,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"撒旦发射点发\",\"createTime\":\"2024-11-10 21:32:31\",\"draftStatus\":0,\"id\":51,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊发士大夫\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:32:31\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:32:31',176),(303,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"士大夫阿斯蒂芬\",\"createTime\":\"2024-11-10 21:32:58\",\"draftStatus\":0,\"id\":52,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊士大夫大师傅\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:32:58\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:32:58',12),(304,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"\",\"contentText\":\"阿斯蒂芬\",\"createTime\":\"2024-11-10 21:34:34\",\"draftStatus\":0,\"id\":53,\"isPublic\":0,\"params\":{},\"postTitle\":\"啊范德萨\",\"tagId\":\"1\",\"updateTime\":\"2024-11-10 21:34:34\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:34:34',8),(305,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"撒旦发射点发\",\"createBy\":\"\",\"createTime\":\"2024-11-10 21:32:31\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":51,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啊发士大夫\",\"status\":0,\"tagId\":\"1\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 21:36:25\",\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:36:25',13),(306,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"阿斯蒂芬\",\"createBy\":\"\",\"createTime\":\"2024-11-10 21:34:35\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":53,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啊范德萨\",\"status\":0,\"tagId\":\"1\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 21:37:07\",\"userId\":1}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:37:07',7),(307,'菜单管理',2,'top.xiaohutu.web.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"component\":\"post/comment/index\",\"createTime\":\"2024-11-09 23:32:13\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"评论\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2006,\"path\":\"comment\",\"perms\":\"post:comment:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:42:12',32),(308,'部门管理',2,'top.xiaohutu.web.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"总部门\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:43:00',38),(309,'字典数据',2,'top.xiaohutu.web.controller.system.SysDictDataController.edit()','PUT',1,'admin','研发部门','/system/dict/data','127.0.0.1','内网IP','{\"createBy\":\"admin\",\"createTime\":\"2024-11-01 12:35:54\",\"default\":false,\"dictCode\":106,\"dictLabel\":\"审核中\",\"dictSort\":3,\"dictType\":\"post_status\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 21:48:39',24),(310,'帖子',3,'top.xiaohutu.post.controller.PostController.remove()','DELETE',1,'test1',NULL,'/post/post/53','127.0.0.1','内网IP','{}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 22:46:12',47),(311,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"士大夫阿斯蒂芬gggggggg\",\"createBy\":\"\",\"createTime\":\"2024-11-10 21:32:58\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":52,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啊士大夫大师傅\",\"status\":2,\"tagId\":\"3\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 22:59:52\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 22:59:52',89),(312,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"士大夫阿斯蒂芬gggggggg,干什么玩意\",\"createBy\":\"\",\"createTime\":\"2024-11-10 21:32:58\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":52,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啊士大夫大师傅\",\"status\":2,\"tagId\":\"1\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:01:28\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:01:28',32),(313,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"士大夫阿斯蒂芬gggggggg,干什么玩意撒旦发射点\",\"createBy\":\"\",\"createTime\":\"2024-11-10 21:32:58\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":52,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啊士大夫大师傅\",\"status\":1,\"tagId\":\"1\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:03:32\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:03:32',46),(314,'帖子',1,'top.xiaohutu.post.controller.PostController.add()','POST',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"contentImage\":\"/profile/upload/2024/11/10/images (1)_20241110231423A001.jpg,/profile/upload/2024/11/10/images_20241110231423A002.jpg,/profile/upload/2024/11/10/b20abda7f1a9457bac49cee0b5a4e09b_20241110231423A003.jpeg\",\"contentText\":\"为什么\",\"createTime\":\"2024-11-10 23:14:23\",\"draftStatus\":0,\"id\":54,\"isPublic\":0,\"params\":{},\"postTitle\":\"测试帖子\",\"tagId\":\"1,2,3\",\"updateTime\":\"2024-11-10 23:14:23\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:14:23',76),(315,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"/profile/upload/2024/11/10/images (1)_20241110231423A001.jpg,/profile/upload/2024/11/10/images_20241110231423A002.jpg,/profile/upload/2024/11/10/b20abda7f1a9457bac49cee0b5a4e09b_20241110231423A003.jpeg\",\"contentText\":\"为什么\",\"createBy\":\"\",\"createTime\":\"2024-11-10 23:14:23\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":54,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"测试帖子\",\"status\":1,\"tagId\":\"1,2,3\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:14:56\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:14:56',14),(316,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'admin','研发部门','/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"/profile/upload/2024/11/10/images (1)_20241110231423A001.jpg,/profile/upload/2024/11/10/images_20241110231423A002.jpg,/profile/upload/2024/11/10/b20abda7f1a9457bac49cee0b5a4e09b_20241110231423A003.jpeg\",\"contentText\":\"为什么\",\"createBy\":\"\",\"createTime\":\"2024-11-10 23:14:23\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":54,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"测试帖子\",\"status\":0,\"tagId\":\"1,2,3\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:16:09\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:16:09',74),(317,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"不想写了\",\"createBy\":\"\",\"createTime\":\"2024-11-10 23:14:23\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":54,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"测试帖子\",\"status\":1,\"tagId\":\"1,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:16:28\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:16:28',15),(318,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦从顶顶顶顶顶帆帆帆帆撒旦发射点发大师傅士大夫撒旦\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:23:42\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:23:42',19),(319,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"/profile/upload/2024/11/10/下载_20241110232559A001.jpg\",\"contentText\":\"烦烦烦从顶\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:25:59\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:25:59',9),(320,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦从顶大师傅大师傅士大夫\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:26:07\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:26:07',10),(321,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"/profile/upload/2024/11/10/下载_20241110233155A002.jpg\",\"contentText\":\"烦烦烦从顶大师傅大师傅士大夫\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:31:55\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:31:55',6),(322,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"烦烦烦从顶大师傅大师傅士大夫啊啊啊sdfsfd\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:32:28\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:32:28',8),(323,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\",\",\"contentText\":\"夫啊啊啊sdfsfd\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:39:31\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:39:31',10),(324,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\",,\",\"contentText\":\"夫啊啊啊sdfsfd\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:39:59\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:39:59',6),(325,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\",,,,\",\"contentText\":\"夫啊啊啊sdfsfd\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:41:27\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:41:27',8),(326,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\",,,,,\",\"contentText\":\"夫啊啊啊sdfsfd\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:42:44\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:42:44',7),(327,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\",,\",\"contentText\":\"夫啊啊啊\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:44:23\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:44:23',8),(328,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"\",\"contentText\":\"夫啊啊啊\",\"createBy\":\"\",\"createTime\":\"2024-11-10 17:34:51\",\"draftStatus\":1,\"favoriteCount\":0,\"id\":50,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"啦啦啦啦啦啦啦\",\"status\":1,\"tagId\":\"3,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:45:43\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:45:43',10),(329,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\",/profile/upload/2024/11/10/images_20241110234603A011.jpg,/profile/upload/2024/11/10/下载_20241110234603A010.jpg\",\"contentText\":\"不想写了\",\"createBy\":\"\",\"createTime\":\"2024-11-10 23:14:23\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":54,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"测试帖子\",\"status\":1,\"tagId\":\"1,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:46:03\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:46:03',6),(330,'帖子',2,'top.xiaohutu.post.controller.PostController.edit()','PUT',1,'test1',NULL,'/post/post','127.0.0.1','内网IP','{\"commentCount\":0,\"contentImage\":\"/profile/upload/2024/11/10/images_20241110234603A011.jpg,/profile/upload/2024/11/10/下载_20241110234603A010.jpg,,\",\"contentText\":\"不想写了\",\"createBy\":\"\",\"createTime\":\"2024-11-10 23:14:23\",\"draftStatus\":0,\"favoriteCount\":0,\"id\":54,\"isPublic\":0,\"likeCount\":0,\"params\":{},\"postTitle\":\"测试帖子,累了兄弟\",\"status\":1,\"tagId\":\"1,2\",\"updateBy\":\"\",\"updateTime\":\"2024-11-10 23:50:06\",\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:50:06',8),(331,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":9,\"commentText\":\"真的累了\",\"createTime\":\"2024-11-10 23:51:06\",\"params\":{},\"parentCommentId\":0,\"postId\":54,\"topId\":0,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:51:07',62),(332,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":10,\"commentText\":\"累了累了\",\"createTime\":\"2024-11-10 23:55:27\",\"params\":{},\"parentCommentId\":0,\"postId\":4,\"topId\":0,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:55:27',5),(333,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":11,\"commentText\":\"不写了，写完了\",\"createTime\":\"2024-11-10 23:57:15\",\"params\":{},\"parentCommentId\":0,\"postId\":5,\"topId\":0,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:57:15',5),(334,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":12,\"commentText\":\"@测试1号 回家睡觉了兄弟\",\"createTime\":\"2024-11-10 23:57:34\",\"params\":{},\"parentCommentId\":11,\"postId\":5,\"topId\":11,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-10 23:57:34',4),(335,'评论',1,'top.xiaohutu.post.controller.CommentController.add()','POST',1,'test1',NULL,'/post/comment','127.0.0.1','内网IP','{\"children\":[],\"commentId\":13,\"commentText\":\"@测试1号 睡觉睡觉\",\"createTime\":\"2024-11-11 00:00:14\",\"params\":{},\"parentCommentId\":10,\"postId\":4,\"topId\":10,\"userId\":102}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2024-11-11 00:00:14',8);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2024-10-18 09:39:08','',NULL,''),(2,'se','项目经理',2,'0','admin','2024-10-18 09:39:08','',NULL,''),(3,'hr','人力资源',3,'0','admin','2024-10-18 09:39:08','',NULL,''),(4,'user','普通员工',4,'0','admin','2024-10-18 09:39:08','',NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2024-10-18 09:39:08','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2024-10-18 09:39:08','admin','2024-11-06 16:56:02','普通管理员');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
INSERT INTO `sys_role_dept` VALUES (2,100),(2,101),(2,105);
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','maike','00','ry@163.com','15888888888','1','/profile/avatar/2024/11/08/微信图片_20220929192707_20241108154301A004.jpg','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2024-11-10 21:01:00','admin','2024-10-18 09:39:08','','2024-11-10 21:00:59','管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2024-10-18 09:39:08','admin','2024-10-18 09:39:08','',NULL,'测试员'),(100,NULL,'maike','maike','1','','13344556677','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2024-11-06 16:56:35','admin','2024-10-28 14:42:44','','2024-11-06 16:56:34','普通管理员'),(101,NULL,'xiaohutu','xiaohutu','00','','','0','','$2a$10$sSfgqJpbbtOaXE/OWFjFQ.dKC.srLxOIcGIhIsKWuLZw2g1kK8mre','0','0','127.0.0.1','2024-11-06 18:18:20','','2024-11-06 18:18:03','','2024-11-06 18:18:19',NULL),(102,NULL,'test1','测试1号','00','','','2','/profile/upload/2024/11/10/70E3465958D37EE48A4EF7856DEE9302_20241110142218A001.jpg','$2a$10$rdvsjpDTPqJmdqw5H/l4Y.o.Fq1sjpxNb7KVf5bwSTBYkPc0cAeFC','0','0','127.0.0.1','2024-11-10 21:05:06','','2024-11-06 19:14:37','','2024-11-10 21:05:05',NULL),(103,NULL,'test2','cs2ha哈','00','','','1','','$2a$10$vGCLlzIhp8X1TyNZxh8NOu/2JR1OTUbVE1crpLfvy0V56sUz/kHKu','0','0','127.0.0.1','2024-11-09 13:26:35','','2024-11-06 19:16:17','','2024-11-09 13:26:34',NULL),(105,NULL,'test3888','hhhh666','00','','','1','/profile/upload/2024/11/09/70E3465958D37EE48A4EF7856DEE9302_20241109174330A005.jpg','$2a$10$r3E8TBa7ND30WfzyFrMVRu07DZHStXwm0Bzb8zT8Z.okUgLGyhD3G','0','0','127.0.0.1','2024-11-09 14:23:32','','2024-11-09 13:24:12','','2024-11-09 19:20:04',NULL),(106,NULL,'ttt','HHHH','00','','','1','','$2a$10$.4odygz3nrJ/PYVvQvZlt.ZM5GLoRZoBegNMgld4mv2dXg2juPTj2','0','0','',NULL,'','2024-11-09 13:25:46','',NULL,NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_address`
--

DROP TABLE IF EXISTS `sys_user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_address` (
  `user_id` bigint NOT NULL COMMENT '用户id',
  `address_id` bigint NOT NULL COMMENT '地址id',
  PRIMARY KEY (`user_id`,`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和地址关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_address`
--

LOCK TABLES `sys_user_address` WRITE;
/*!40000 ALTER TABLE `sys_user_address` DISABLE KEYS */;
INSERT INTO `sys_user_address` VALUES (102,1),(102,2);
/*!40000 ALTER TABLE `sys_user_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1),(2,2),(100,4);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(2,2),(100,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_draft`
--

DROP TABLE IF EXISTS `tb_draft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_draft` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL COMMENT '帖子id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='草稿箱';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_draft`
--

LOCK TABLES `tb_draft` WRITE;
/*!40000 ALTER TABLE `tb_draft` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_draft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_history`
--

DROP TABLE IF EXISTS `tb_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_history` (
  `user_id` bigint NOT NULL COMMENT '用户id',
  `post_id` bigint NOT NULL COMMENT '浏览的帖子id',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `user_history_post__fk` (`post_id`),
  CONSTRAINT `user_history_post__fk` FOREIGN KEY (`post_id`) REFERENCES `tb_post` (`id`),
  CONSTRAINT `user_history_user__fk` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_history`
--

LOCK TABLES `tb_history` WRITE;
/*!40000 ALTER TABLE `tb_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_post`
--

DROP TABLE IF EXISTS `tb_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_post` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '帖子ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID(连接用户表的id)',
  `post_title` varchar(30) DEFAULT NULL COMMENT '帖子标题',
  `content_text` text COMMENT '文本内容',
  `content_image` varchar(3000) DEFAULT NULL COMMENT '图片地址',
  `like_count` int DEFAULT '0' COMMENT '点赞数',
  `comment_count` int DEFAULT '0' COMMENT '评论数',
  `tag_id` varchar(50) DEFAULT NULL COMMENT '标签',
  `address_id` bigint DEFAULT NULL COMMENT '发布位置',
  `is_public` tinyint(1) DEFAULT '0' COMMENT '是否公开(0代表公开，1是私密)',
  `favorite_count` int DEFAULT '0' COMMENT '收藏数量',
  `draft_status` int DEFAULT '0' COMMENT '草稿状态（0是正常，1是草稿）',
  `status` int DEFAULT '1' COMMENT '帖子状态（0：正常，1:审核中，2：审核未通过）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `idx_full_content` (`content_text`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='帖子表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post`
--

LOCK TABLES `tb_post` WRITE;
/*!40000 ALTER TABLE `tb_post` DISABLE KEYS */;
INSERT INTO `tb_post` VALUES (1,1,'记录今天生活','今天天气真好','/profile/upload/2024/11/05/aefea4c1a2a622fab643caece8faf0b9_20241105170146A001.png,/profile/upload/2024/11/05/aa89202b1f51f4c93cf69a70097ca4a_20241105170150A002.jpg,/profile/upload/2024/11/05/f7ca6a8145705d7a057955d36d86bde_20241105170156A003.jpg',0,6,'8',1,0,1,0,0,'',NULL,'','2024-11-05 17:01:59'),(2,1,NULL,'哈哈哈','/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg',2,1,'4',1,0,1,0,0,'',NULL,'','2024-11-06 20:07:01'),(3,1,NULL,'今天又是敲代码的一天','/profile/upload/2024/11/06/mmexport1606021214496_20241106200709A002.jpg',2,2,'1',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:11'),(4,1,NULL,'不想敲代码','/profile/upload/2024/11/06/48cc215defbfb6eb02543f5061dbb7a_20241106200723A003.jpg',2,1,'3',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:24'),(5,1,NULL,'不想敲代码第2天','/profile/upload/2024/11/06/微信图片_20220929192707_20241106204641A004.jpg',2,1,'0',3,0,1,0,0,'',NULL,'','2024-11-06 20:46:43'),(6,2,NULL,'不想敲代码第3天','',2,2,'0',3,1,1,0,0,'',NULL,'',NULL),(7,2,NULL,'不想敲代码第4天','',0,2,'1',3,1,1,0,0,'',NULL,'',NULL),(8,1,NULL,'今天天气好的很','/profile/upload/2024/11/05/微信图片_20220929192635_20241105164419A001.jpg',0,0,'8',1,1,0,1,0,'','2024-11-05 16:45:24','',NULL),(9,1,NULL,'今天天气真好','/profile/upload/2024/11/05/aefea4c1a2a622fab643caece8faf0b9_20241105170146A001.png,/profile/upload/2024/11/05/aa89202b1f51f4c93cf69a70097ca4a_20241105170150A002.jpg,/profile/upload/2024/11/05/f7ca6a8145705d7a057955d36d86bde_20241105170156A003.jpg',0,6,'8',1,0,1,0,0,'',NULL,'','2024-11-05 17:01:59'),(10,1,NULL,'哈哈哈','/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg',0,1,'4',1,0,1,0,0,'',NULL,'','2024-11-06 20:07:01'),(11,1,NULL,'今天又是敲代码的一天','/profile/upload/2024/11/06/mmexport1606021214496_20241106200709A002.jpg',0,2,'1',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:11'),(12,1,NULL,'不想敲代码','/profile/upload/2024/11/06/48cc215defbfb6eb02543f5061dbb7a_20241106200723A003.jpg',0,1,'3',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:24'),(13,1,NULL,'今天天气真好','/profile/upload/2024/11/05/aefea4c1a2a622fab643caece8faf0b9_20241105170146A001.png,/profile/upload/2024/11/05/aa89202b1f51f4c93cf69a70097ca4a_20241105170150A002.jpg,/profile/upload/2024/11/05/f7ca6a8145705d7a057955d36d86bde_20241105170156A003.jpg',0,6,'8',1,0,1,0,0,'',NULL,'','2024-11-05 17:01:59'),(14,1,NULL,'哈哈哈','/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg',0,1,'4',1,0,1,0,0,'',NULL,'','2024-11-06 20:07:01'),(15,1,NULL,'今天又是敲代码的一天','/profile/upload/2024/11/06/mmexport1606021214496_20241106200709A002.jpg',0,2,'1',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:11'),(16,1,NULL,'不想敲代码','/profile/upload/2024/11/06/48cc215defbfb6eb02543f5061dbb7a_20241106200723A003.jpg',0,1,'3',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:24'),(17,1,NULL,'今天天气真好','/profile/upload/2024/11/05/aefea4c1a2a622fab643caece8faf0b9_20241105170146A001.png,/profile/upload/2024/11/05/aa89202b1f51f4c93cf69a70097ca4a_20241105170150A002.jpg,/profile/upload/2024/11/05/f7ca6a8145705d7a057955d36d86bde_20241105170156A003.jpg',0,6,'8',1,0,1,0,0,'',NULL,'','2024-11-05 17:01:59'),(18,1,NULL,'哈哈哈','/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg',0,1,'4',1,0,1,0,0,'',NULL,'','2024-11-06 20:07:01'),(19,1,NULL,'今天又是敲代码的一天','/profile/upload/2024/11/06/mmexport1606021214496_20241106200709A002.jpg',0,2,'1',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:11'),(20,1,NULL,'不想敲代码','/profile/upload/2024/11/06/48cc215defbfb6eb02543f5061dbb7a_20241106200723A003.jpg',0,1,'3',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:24'),(21,1,NULL,'今天天气真好','/profile/upload/2024/11/05/aefea4c1a2a622fab643caece8faf0b9_20241105170146A001.png,/profile/upload/2024/11/05/aa89202b1f51f4c93cf69a70097ca4a_20241105170150A002.jpg,/profile/upload/2024/11/05/f7ca6a8145705d7a057955d36d86bde_20241105170156A003.jpg',0,6,'8',1,0,1,0,0,'',NULL,'','2024-11-05 17:01:59'),(22,1,NULL,'哈哈哈','/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg',0,1,'4',1,0,1,0,0,'',NULL,'','2024-11-06 20:07:01'),(23,1,NULL,'今天又是敲代码的一天','/profile/upload/2024/11/06/mmexport1606021214496_20241106200709A002.jpg',0,2,'1',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:11'),(24,1,NULL,'不想敲代码','/profile/upload/2024/11/06/48cc215defbfb6eb02543f5061dbb7a_20241106200723A003.jpg',0,1,'3',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:24'),(25,1,NULL,'哈哈哈','/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg',0,1,'4',1,0,1,0,0,'',NULL,'','2024-11-06 20:07:01'),(26,1,NULL,'今天又是敲代码的一天','/profile/upload/2024/11/06/mmexport1606021214496_20241106200709A002.jpg',0,2,'1',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:11'),(27,1,NULL,'不想敲代码','/profile/upload/2024/11/06/48cc215defbfb6eb02543f5061dbb7a_20241106200723A003.jpg',0,1,'3',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:24'),(28,1,NULL,'今天天气真好','/profile/upload/2024/11/05/aefea4c1a2a622fab643caece8faf0b9_20241105170146A001.png,/profile/upload/2024/11/05/aa89202b1f51f4c93cf69a70097ca4a_20241105170150A002.jpg,/profile/upload/2024/11/05/f7ca6a8145705d7a057955d36d86bde_20241105170156A003.jpg',0,6,'8',1,0,1,0,0,'',NULL,'','2024-11-05 17:01:59'),(29,1,NULL,'哈哈哈','/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg',0,1,'4',1,0,1,0,0,'',NULL,'','2024-11-06 20:07:01'),(30,1,NULL,'今天又是敲代码的一天','/profile/upload/2024/11/06/mmexport1606021214496_20241106200709A002.jpg',0,2,'1',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:11'),(31,1,NULL,'不想敲代码','/profile/upload/2024/11/06/48cc215defbfb6eb02543f5061dbb7a_20241106200723A003.jpg',0,1,'3',3,0,1,0,0,'',NULL,'','2024-11-06 20:07:24'),(32,1,NULL,'今天天气真好','/profile/upload/2024/11/05/aefea4c1a2a622fab643caece8faf0b9_20241105170146A001.png,/profile/upload/2024/11/05/aa89202b1f51f4c93cf69a70097ca4a_20241105170150A002.jpg,/profile/upload/2024/11/05/f7ca6a8145705d7a057955d36d86bde_20241105170156A003.jpg',0,6,'8',1,0,1,0,0,'',NULL,'','2024-11-05 17:01:59'),(33,1,NULL,'哈哈哈','/profile/upload/2024/11/06/0a7258c4188daf214a2f2564b986050_20241106200700A001.jpg',0,1,'4',1,0,1,0,0,'',NULL,'','2024-11-06 20:07:01'),(35,102,'a','aaa','/profile/upload/2024/11/09/pro_20241109003434A002.jpg,/profile/upload/2024/11/09/xiaohutu_20241109003434A001.png',0,0,'2,3',NULL,0,0,0,1,'','2024-11-09 00:34:34','',NULL),(36,102,'test','testttt','/profile/upload/2024/11/09/pro_20241109004439A002.jpg,/profile/upload/2024/11/09/xiaohutu_20241109004439A001.png',0,0,'1,3',NULL,0,0,0,2,'','2024-11-09 00:44:40','',NULL),(37,102,'tttttttttt不想写了','汝坤否？','/profile/upload/2024/11/09/xiaohutu_20241109004634A003.png,',0,0,'3,4',NULL,0,0,0,2,'','2024-11-09 00:46:35','',NULL),(38,102,'睡觉了兄弟','666','',0,0,'1',NULL,0,0,0,2,'','2024-11-09 01:03:24','',NULL),(40,105,'嘎嘎嘎','人机','/profile/upload/2024/11/09/8D6B9EEDA99F8050C9DA6249CFF0D617_20241109181159A001.jpg',0,0,'3',NULL,0,0,0,2,'','2024-11-09 18:11:59','','2024-11-09 18:11:59'),(41,102,'绘画','哈哈哈哈哈','',0,0,'3,4,5',NULL,0,0,0,2,'','2024-11-10 15:04:01','','2024-11-10 15:04:01'),(45,102,'啵啵啵宝宝','','',0,0,'',NULL,0,0,1,0,'','2024-11-10 16:40:16','','2024-11-10 16:40:16'),(46,102,'','手动阀十分','',0,0,'',NULL,0,0,1,0,'','2024-11-10 16:41:08','','2024-11-10 16:41:08'),(49,102,'啦啦啦啦啦啦啦','烦烦烦从顶顶顶顶顶帆帆帆帆嘎嘎嘎','',0,0,'3',NULL,0,0,0,0,'','2024-11-10 17:24:41','','2024-11-10 21:25:10'),(50,102,'啦啦啦啦啦啦啦','夫啊啊啊','',0,0,'3,2',NULL,0,0,1,1,'','2024-11-10 17:34:51','','2024-11-10 23:45:43'),(51,102,'啊发士大夫','撒旦发射点发','',0,0,'1',NULL,0,0,0,0,'','2024-11-10 21:32:31','','2024-11-10 21:36:26'),(52,102,'啊士大夫大师傅','士大夫阿斯蒂芬gggggggg,干什么玩意撒旦发射点','',0,0,'1',NULL,0,0,0,1,'','2024-11-10 21:32:58','','2024-11-10 23:03:33'),(54,102,'测试帖子,累了兄弟','不想写了','/profile/upload/2024/11/10/images_20241110234603A011.jpg,/profile/upload/2024/11/10/下载_20241110234603A010.jpg,,',0,0,'1,2',NULL,0,0,0,1,'','2024-11-10 23:14:23','','2024-11-10 23:50:06');
/*!40000 ALTER TABLE `tb_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_post_tag`
--

DROP TABLE IF EXISTS `tb_post_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_post_tag` (
  `post_id` bigint NOT NULL COMMENT '帖子id',
  `tag_id` bigint NOT NULL COMMENT '标签id',
  PRIMARY KEY (`post_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='帖子和标签关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_post_tag`
--

LOCK TABLES `tb_post_tag` WRITE;
/*!40000 ALTER TABLE `tb_post_tag` DISABLE KEYS */;
INSERT INTO `tb_post_tag` VALUES (1,4),(1,5),(1,8),(2,4),(3,1),(4,3),(5,0),(6,0),(7,1),(8,8),(9,8),(10,4),(11,1),(12,3),(13,8),(14,4),(15,1),(16,3),(17,8),(18,4),(19,1),(20,3),(21,8),(22,4),(23,1),(24,3),(25,4),(26,1),(27,3),(28,8),(29,4),(30,1),(31,3),(32,8),(33,4),(35,2),(35,3),(36,1),(36,3),(37,3),(37,4),(38,1),(39,1),(40,3),(41,3),(41,4),(41,5);
/*!40000 ALTER TABLE `tb_post_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_tag`
--

DROP TABLE IF EXISTS `tb_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tag_content` varchar(20) DEFAULT NULL COMMENT '标签内容',
  `count` int DEFAULT '0' COMMENT '标签使用数量',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='标签（分类）表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_tag`
--

LOCK TABLES `tb_tag` WRITE;
/*!40000 ALTER TABLE `tb_tag` DISABLE KEYS */;
INSERT INTO `tb_tag` VALUES (0,'推荐',0,'',NULL,'',NULL),(1,'生活',0,'','2024-11-05 16:53:47','',NULL),(2,'自律',0,'','2024-11-05 16:53:53','',NULL),(3,'教育',0,'',NULL,'',NULL),(4,'学习',0,'',NULL,'',NULL),(5,'财经',0,'',NULL,'',NULL),(6,'游戏',0,'',NULL,'',NULL),(7,'汽车',0,'',NULL,'',NULL),(8,'舞蹈',0,'',NULL,'',NULL),(9,'历史',0,'',NULL,'',NULL),(10,'情感',0,'',NULL,'',NULL),(11,'数码',0,'',NULL,'',NULL),(12,'搞笑',0,'',NULL,'',NULL),(13,'体育',0,'',NULL,'',NULL),(14,'程序员',0,'',NULL,'',NULL),(15,'新闻',0,'',NULL,'',NULL);
/*!40000 ALTER TABLE `tb_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户表id',
  `user_name` varchar(30) DEFAULT NULL COMMENT '用户名',
  `password` varchar(350) DEFAULT NULL COMMENT '用户密码',
  `avatar` varchar(500) DEFAULT NULL COMMENT '用户头像地址',
  `gender` tinyint DEFAULT NULL COMMENT '性别（0:男，1:女，2:未知）',
  `nick_name` varchar(30) DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `email` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_pk` (`user_name`),
  KEY `index_nickname` (`nick_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表(前台)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user`
--

LOCK TABLES `tb_user` WRITE;
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` VALUES (1,'xiaohutu','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','http://www.daduomei.com/cjpic/frombd/2/253/1104495164/2685218353.jpg',1,'小糊涂','13345455454','aaa@gmail.com','0','0','',NULL,'',NULL,'',NULL,NULL);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user_collection`
--

DROP TABLE IF EXISTS `tb_user_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user_collection` (
  `user_id` bigint NOT NULL COMMENT '(用户ID) - 外键，关联到用户表，表示哪个用户收藏了这个条目',
  `post_id` bigint NOT NULL COMMENT '(微博帖子ID) - 外键，关联到微博帖子表，表示哪个微博帖子被用户收藏',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `user_collection_post__fk` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user_collection`
--

LOCK TABLES `tb_user_collection` WRITE;
/*!40000 ALTER TABLE `tb_user_collection` DISABLE KEYS */;
INSERT INTO `tb_user_collection` VALUES (102,4,'','2024-11-10 16:07:52','','2024-11-10 16:07:51'),(105,36,'','2024-11-09 20:57:07','','2024-11-09 20:57:07'),(105,40,'','2024-11-09 21:29:47','','2024-11-09 21:29:47');
/*!40000 ALTER TABLE `tb_user_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user_info`
--

DROP TABLE IF EXISTS `tb_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID 主键',
  `user_id` bigint NOT NULL COMMENT '用户id，连接用户基础表(user_id)',
  `birth_date` date DEFAULT NULL COMMENT '出生日期',
  `bio` varchar(2000) DEFAULT NULL COMMENT '个人简介',
  `address_id` bigint DEFAULT NULL COMMENT '位置id',
  `followers_count` int DEFAULT '0' COMMENT '关注者数量（粉丝）',
  `following_count` int DEFAULT '0' COMMENT '关注数量',
  `all_likes` bigint DEFAULT '0' COMMENT '帖子总点赞数',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `background_image` varchar(500) DEFAULT NULL COMMENT '背景图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user_info`
--

LOCK TABLES `tb_user_info` WRITE;
/*!40000 ALTER TABLE `tb_user_info` DISABLE KEYS */;
INSERT INTO `tb_user_info` VALUES (1,102,'2023-10-01','可爱大叔一枚',1,0,0,0,'','2024-11-06 19:14:37','','2024-11-10 14:22:31','/profile/upload/2024/11/10/微信图片_202304281037221_20241110142228A002.jpg'),(2,105,NULL,'本人拥有5年后端开发经验，精通Java、Python等编程语言，熟练掌握Spring Boot、Django等主流框架。对微服务架构、分布式系统有深入理解，具备独立设计、开发、部署复杂系统的能力。曾参与多个大型项目，负责核心模块的设计与实现，具备良好的代码编写习惯和问题解决能力。',2,0,0,0,'','2024-11-09 13:24:12','','2024-11-09 19:19:25','/profile/upload/2024/11/09/微信图片_202304281037221_20241109192002A002.jpg'),(3,106,NULL,NULL,1,0,0,0,'',NULL,'',NULL,NULL);
/*!40000 ALTER TABLE `tb_user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_user_like`
--

DROP TABLE IF EXISTS `tb_user_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user_like` (
  `user_id` bigint NOT NULL COMMENT '点赞用户ID(连接用户详情表的c_user_id)',
  `post_id` bigint NOT NULL COMMENT '被点赞帖子ID',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`,`post_id`),
  KEY `user_like_post__fk` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='点赞表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_user_like`
--

LOCK TABLES `tb_user_like` WRITE;
/*!40000 ALTER TABLE `tb_user_like` DISABLE KEYS */;
INSERT INTO `tb_user_like` VALUES (1,1,'','2024-11-09 18:36:59','','2024-11-09 18:36:59'),(1,3,'','2024-11-09 18:38:03','','2024-11-09 18:38:03'),(2,1,'','2024-11-09 18:38:03','','2024-11-09 18:38:03'),(2,2,'','2024-11-09 18:38:03','','2024-11-09 18:38:03'),(102,1,'','2024-11-09 18:38:03','','2024-11-09 18:38:03'),(102,2,'','2024-11-10 16:00:42','','2024-11-10 16:00:41'),(102,35,'','2024-11-10 16:08:29','','2024-11-10 16:08:29'),(102,37,'','2024-11-10 20:11:56','','2024-11-10 20:11:56'),(103,2,'','2024-11-09 18:38:03','','2024-11-10 19:59:19'),(105,3,'','2024-11-09 19:35:22','','2024-11-09 19:36:33');
/*!40000 ALTER TABLE `tb_user_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_info_view`
--

DROP TABLE IF EXISTS `user_info_view`;
/*!50001 DROP VIEW IF EXISTS `user_info_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_info_view` AS SELECT 
 1 AS `user_id`,
 1 AS `dept_id`,
 1 AS `user_name`,
 1 AS `nick_name`,
 1 AS `user_type`,
 1 AS `email`,
 1 AS `phonenumber`,
 1 AS `sex`,
 1 AS `avatar`,
 1 AS `password`,
 1 AS `status`,
 1 AS `del_flag`,
 1 AS `login_ip`,
 1 AS `login_date`,
 1 AS `create_by`,
 1 AS `create_time`,
 1 AS `update_by`,
 1 AS `update_time`,
 1 AS `remark`,
 1 AS `bio`,
 1 AS `total_likes`,
 1 AS `followers_count`,
 1 AS `following_count`,
 1 AS `background_image`,
 1 AS `birth_date`,
 1 AS `addr`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `comment_view`
--

/*!50001 DROP VIEW IF EXISTS `comment_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `comment_view` AS select `c`.`comment_id` AS `comment_id`,`c`.`post_id` AS `post_id`,`c`.`user_id` AS `user_id`,`c`.`comment_text` AS `comment_text`,`c`.`comment_time` AS `comment_time`,`c`.`comment_image` AS `comment_image`,`c`.`parent_comment_id` AS `parent_comment_id`,`c`.`top_id` AS `top_id`,`c`.`create_time` AS `create_time`,`c`.`update_time` AS `update_time`,`su`.`nick_name` AS `nick_name`,`su`.`user_name` AS `user_name`,`su`.`avatar` AS `avatar` from (`comment` `c` left join `sys_user` `su` on((`c`.`user_id` = `su`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `post_user_view`
--

/*!50001 DROP VIEW IF EXISTS `post_user_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `post_user_view` AS select `u`.`user_name` AS `user_name`,`u`.`avatar` AS `avatar`,`u`.`nick_name` AS `nick_name`,group_concat(`t`.`tag_content` separator ',') AS `tag_content`,ifnull(`a`.`city`,'未知') AS `addr`,(select count(0) from `tb_user_like` `tul` where (`tul`.`post_id` = `p`.`id`)) AS `like_count`,(select count(0) from `tb_user_collection` `tuc` where (`tuc`.`post_id` = `p`.`id`)) AS `favorite_count`,(select count(0) from `comment` `c` where (`c`.`post_id` = `p`.`id`)) AS `comment_count`,`p`.`id` AS `id`,`p`.`user_id` AS `user_id`,`p`.`tag_id` AS `tag_id`,`p`.`address_id` AS `address_id`,`p`.`content_text` AS `content_text`,`p`.`content_image` AS `content_image`,`p`.`post_title` AS `post_title`,`p`.`create_by` AS `create_by`,`p`.`update_by` AS `update_by`,`p`.`is_public` AS `is_public`,`p`.`create_time` AS `create_time`,`p`.`update_time` AS `update_time`,`p`.`draft_status` AS `draft_status`,`p`.`status` AS `status` from ((((`tb_post` `p` left join `sys_user` `u` on((`u`.`user_id` = `p`.`user_id`))) left join `addresses` `a` on((`a`.`address_id` = `p`.`address_id`))) left join `tb_post_tag` `pt` on((`pt`.`post_id` = `p`.`id`))) left join `tb_tag` `t` on((`t`.`id` = `pt`.`tag_id`))) group by `p`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_info_view`
--

/*!50001 DROP VIEW IF EXISTS `user_info_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_info_view` AS select `u`.`user_id` AS `user_id`,`u`.`dept_id` AS `dept_id`,`u`.`user_name` AS `user_name`,`u`.`nick_name` AS `nick_name`,`u`.`user_type` AS `user_type`,`u`.`email` AS `email`,`u`.`phonenumber` AS `phonenumber`,`u`.`sex` AS `sex`,`u`.`avatar` AS `avatar`,`u`.`password` AS `password`,`u`.`status` AS `status`,`u`.`del_flag` AS `del_flag`,`u`.`login_ip` AS `login_ip`,`u`.`login_date` AS `login_date`,`u`.`create_by` AS `create_by`,`u`.`create_time` AS `create_time`,`u`.`update_by` AS `update_by`,`u`.`update_time` AS `update_time`,`u`.`remark` AS `remark`,`info`.`bio` AS `bio`,count(`tul`.`user_id`) AS `total_likes`,`info`.`followers_count` AS `followers_count`,`info`.`following_count` AS `following_count`,`info`.`background_image` AS `background_image`,`info`.`birth_date` AS `birth_date`,max(concat(`a`.`province`,' ',`a`.`city`)) AS `addr` from ((((`sys_user` `u` left join `tb_user_info` `info` on((`u`.`user_id` = `info`.`user_id`))) left join `tb_post` `tp` on((`u`.`user_id` = `tp`.`user_id`))) left join `addresses` `a` on((`info`.`address_id` = `a`.`address_id`))) left join `tb_user_like` `tul` on((`tp`.`id` = `tul`.`post_id`))) group by `u`.`user_id`,`info`.`bio`,`info`.`followers_count`,`info`.`following_count`,`info`.`birth_date`,`info`.`background_image`,`info`.`address_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-11  0:01:18
