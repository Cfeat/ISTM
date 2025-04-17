-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: ry-vue
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `class_plan`
--

DROP TABLE IF EXISTS `class_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_plan` (
  `plan_id` bigint NOT NULL AUTO_INCREMENT COMMENT '教案ID',
  `title` varchar(30) NOT NULL COMMENT '教案标题',
  `plan_type` varchar(50) DEFAULT '' COMMENT '教案类型',
  `grade` varchar(11) DEFAULT '' COMMENT '适用年级',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `content` varchar(1000) DEFAULT '' COMMENT '内容',
  `people_count` int DEFAULT '0' COMMENT '点击人数',
  `note1` varchar(11) DEFAULT '' COMMENT '冗余1',
  `note2` varchar(100) DEFAULT '' COMMENT '冗余2',
  `note3` varchar(100) DEFAULT '' COMMENT '冗余3',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教案表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_plan`
--

LOCK TABLES `class_plan` WRITE;
/*!40000 ALTER TABLE `class_plan` DISABLE KEYS */;
INSERT INTO `class_plan` VALUES (100,'足球巡检教案','足球','大一','/profile/upload/2025/02/13/微信图片_20220822093608_20250213213934A001.jpg','啊范德萨房贷首付人头人肉原图原图',1,'','','','','2025-02-13 21:39:42','','2025-02-13 21:46:13','这是一份足交巡检教案'),(101,'篮球训练','篮球','大三','','篮球训练',0,'','','','','2025-02-14 08:02:55','',NULL,NULL);
/*!40000 ALTER TABLE `class_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ecases`
--

DROP TABLE IF EXISTS `ecases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ecases` (
  `case_id` int NOT NULL AUTO_INCREMENT,
  `plan_id` int DEFAULT NULL,
  `description` text,
  `correction` text,
  PRIMARY KEY (`case_id`),
  KEY `plan_id` (`plan_id`),
  CONSTRAINT `ecases_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `lplans` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ecases`
--

LOCK TABLES `ecases` WRITE;
/*!40000 ALTER TABLE `ecases` DISABLE KEYS */;
/*!40000 ALTER TABLE `ecases` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
INSERT INTO `gen_table` VALUES (6,'class_plan','教案表',NULL,NULL,'ClassPlan','crud','element-ui','com.ruoyi.system','system','plan','教案管理','lkh','0','/','{}','admin','2025-02-13 21:19:25','','2025-02-13 21:22:28',NULL),(8,'istm_class','课程表',NULL,NULL,'IstmClass','crud','element-ui','com.ruoyi.system','system','class','课程管理','lkh','0','/','{}','admin','2025-02-13 22:42:25','','2025-02-13 22:44:11',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
INSERT INTO `gen_table_column` VALUES (41,6,'plan_id','教案ID','bigint','Long','planId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(42,6,'title','教案标题','varchar(30)','String','title','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(43,6,'plan_type','教案类型','varchar(50)','String','planType','0','0','0','1','1','1','1','LIKE','select','',3,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(44,6,'grade','适用年级','varchar(11)','String','grade','0','0','0','1','1','1','1','LIKE','input','',4,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(45,6,'avatar','头像地址','varchar(100)','String','avatar','0','0','0','1','1','0','0','EQ','imageUpload','',5,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(46,6,'content','内容','varchar(1000)','String','content','0','0','0','1','1','1','1','LIKE','editor','',6,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(47,6,'people_count','点击人数','int','Long','peopleCount','0','0','0','1','1','1','1','EQ','input','',7,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(48,6,'note1','冗余1','varchar(11)','String','note1','0','0','0','0','0','0','0','EQ','input','',8,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(49,6,'note2','冗余2','varchar(100)','String','note2','0','0','0','0','0','0','0','EQ','input','',9,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(50,6,'note3','冗余3','varchar(100)','String','note3','0','0','0','0','0','0','0','EQ','input','',10,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(51,6,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0',NULL,NULL,NULL,'EQ','input','',11,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(52,6,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',12,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(53,6,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0',NULL,NULL,'EQ','input','',13,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(54,6,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0',NULL,NULL,'EQ','datetime','',14,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(55,6,'remark','备注','varchar(500)','String','remark','0','0','0','1','1','0','1','LIKE','textarea','',15,'admin','2025-02-13 21:19:25','','2025-02-13 21:22:28'),(73,8,'class_id','教案ID','bigint','Long','classId','1','1','0','1',NULL,NULL,NULL,'EQ','input','',1,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(74,8,'class_name','课程标题','varchar(100)','String','className','0','0','1','1','1','1','1','LIKE','input','',2,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(75,8,'class_type','课程类型','varchar(100)','String','classType','0','0','0','1','1','1','1','LIKE','input','',3,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(76,8,'class_process','教学过程','varchar(1000)','String','classProcess','0','0','0','1','1','1','1','LIKE','textarea','',4,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(77,8,'class_purpose','教学目标','varchar(1000)','String','classPurpose','0','0','0','1','1','1','1','LIKE','textarea','',5,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(78,8,'plan_id','教案序号','int','Long','planId','0','0','0','1','1','1','1','EQ','input','',6,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(79,8,'student_count','学生人数','int','Long','studentCount','0','0','0','1','1','1','1','EQ','input','',7,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(80,8,'user_id','用户序号','int','Long','userId','0','0','0','1','1','1','1','EQ','input','',8,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(81,8,'duration','持续时间','int','Long','duration','0','0','0','1','1','1','0','EQ','input','',9,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(82,8,'note1','冗余1','varchar(11)','String','note1','0','0','0','0','0','0','0','EQ','input','',10,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(83,8,'note2','冗余2','varchar(100)','String','note2','0','0','0','0','0','0','0','EQ','input','',11,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(84,8,'note3','冗余3','varchar(100)','String','note3','0','0','0','0','0','0','0','EQ','input','',12,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(85,8,'create_by','创建者','varchar(64)','String','createBy','0','0','0','0',NULL,NULL,NULL,'EQ','input','',13,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(86,8,'create_time','创建时间','datetime','Date','createTime','0','0','0','0',NULL,NULL,NULL,'EQ','datetime','',14,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(87,8,'update_by','更新者','varchar(64)','String','updateBy','0','0','0','0','0',NULL,NULL,'EQ','input','',15,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(88,8,'update_time','更新时间','datetime','Date','updateTime','0','0','0','0','0',NULL,NULL,'EQ','datetime','',16,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11'),(89,8,'remark','备注','varchar(500)','String','remark','0','0','0','1','1','0','1','EQ','textarea','',17,'admin','2025-02-13 22:42:25','','2025-02-13 22:44:11');
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `istm_class`
--

DROP TABLE IF EXISTS `istm_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `istm_class` (
  `class_id` bigint NOT NULL AUTO_INCREMENT COMMENT '教案ID',
  `class_name` varchar(100) NOT NULL COMMENT '课程标题',
  `class_type` varchar(100) DEFAULT '' COMMENT '课程类型',
  `class_process` varchar(1000) DEFAULT '' COMMENT '教学过程',
  `class_purpose` varchar(1000) DEFAULT '' COMMENT '教学目标',
  `plan_id` int DEFAULT '0' COMMENT '教案序号',
  `student_count` int DEFAULT '0' COMMENT '学生人数',
  `user_id` int DEFAULT '0' COMMENT '用户序号',
  `duration` int DEFAULT '0' COMMENT '持续时间',
  `note1` varchar(11) DEFAULT '' COMMENT '冗余1',
  `note2` varchar(100) DEFAULT '' COMMENT '冗余2',
  `note3` varchar(100) DEFAULT '' COMMENT '冗余3',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`class_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='课程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `istm_class`
--

LOCK TABLES `istm_class` WRITE;
/*!40000 ALTER TABLE `istm_class` DISABLE KEYS */;
INSERT INTO `istm_class` VALUES (100,'篮球训练','篮球','wdwad','adwsada',1,20,23131,45,'','','','','2025-02-14 08:04:17','',NULL,NULL),(101,'123','123','2131','123',213,3123,123,123,'','','','','2025-02-23 12:41:47','',NULL,NULL);
/*!40000 ALTER TABLE `istm_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lplans`
--

DROP TABLE IF EXISTS `lplans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lplans` (
  `plan_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lplans`
--

LOCK TABLES `lplans` WRITE;
/*!40000 ALTER TABLE `lplans` DISABLE KEYS */;
/*!40000 ALTER TABLE `lplans` ENABLE KEYS */;
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
INSERT INTO `sys_config` VALUES (1,'主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y','admin','2025-02-06 20:48:50','',NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'用户管理-账号初始密码','sys.user.initPassword','123456','Y','admin','2025-02-06 20:48:50','',NULL,'初始化密码 123456'),(3,'主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y','admin','2025-02-06 20:48:50','',NULL,'深色主题theme-dark，浅色主题theme-light'),(4,'账号自助-验证码开关','sys.account.captchaEnabled','true','Y','admin','2025-02-06 20:48:50','',NULL,'是否开启验证码功能（true开启，false关闭）'),(5,'账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y','admin','2025-02-06 20:48:50','',NULL,'是否开启注册用户功能（true开启，false关闭）'),(6,'用户登录-黑名单列表','sys.login.blackIPList','','Y','admin','2025-02-06 20:48:50','',NULL,'设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
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
INSERT INTO `sys_dept` VALUES (100,0,'0','若依科技',0,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(101,100,'0,100','深圳总公司',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(102,100,'0,100','长沙分公司',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(103,101,'0,100,101','研发部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(104,101,'0,100,101','市场部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(105,101,'0,100,101','测试部门',3,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(106,101,'0,100,101','财务部门',4,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(107,101,'0,100,101','运维部门',5,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(108,102,'0,100,102','市场部门',1,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL),(109,102,'0,100,102','财务部门',2,'若依','15888888888','ry@qq.com','0','0','admin','2025-02-06 20:48:49','',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,1,'男','0','sys_user_sex','','','Y','0','admin','2025-02-06 20:48:50','',NULL,'性别男'),(2,2,'女','1','sys_user_sex','','','N','0','admin','2025-02-06 20:48:50','',NULL,'性别女'),(3,3,'未知','2','sys_user_sex','','','N','0','admin','2025-02-06 20:48:50','',NULL,'性别未知'),(4,1,'显示','0','sys_show_hide','','primary','Y','0','admin','2025-02-06 20:48:50','',NULL,'显示菜单'),(5,2,'隐藏','1','sys_show_hide','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'隐藏菜单'),(6,1,'正常','0','sys_normal_disable','','primary','Y','0','admin','2025-02-06 20:48:50','',NULL,'正常状态'),(7,2,'停用','1','sys_normal_disable','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'停用状态'),(8,1,'正常','0','sys_job_status','','primary','Y','0','admin','2025-02-06 20:48:50','',NULL,'正常状态'),(9,2,'暂停','1','sys_job_status','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'停用状态'),(10,1,'默认','DEFAULT','sys_job_group','','','Y','0','admin','2025-02-06 20:48:50','',NULL,'默认分组'),(11,2,'系统','SYSTEM','sys_job_group','','','N','0','admin','2025-02-06 20:48:50','',NULL,'系统分组'),(12,1,'是','Y','sys_yes_no','','primary','Y','0','admin','2025-02-06 20:48:50','',NULL,'系统默认是'),(13,2,'否','N','sys_yes_no','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'系统默认否'),(14,1,'通知','1','sys_notice_type','','warning','Y','0','admin','2025-02-06 20:48:50','',NULL,'通知'),(15,2,'公告','2','sys_notice_type','','success','N','0','admin','2025-02-06 20:48:50','',NULL,'公告'),(16,1,'正常','0','sys_notice_status','','primary','Y','0','admin','2025-02-06 20:48:50','',NULL,'正常状态'),(17,2,'关闭','1','sys_notice_status','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'关闭状态'),(18,99,'其他','0','sys_oper_type','','info','N','0','admin','2025-02-06 20:48:50','',NULL,'其他操作'),(19,1,'新增','1','sys_oper_type','','info','N','0','admin','2025-02-06 20:48:50','',NULL,'新增操作'),(20,2,'修改','2','sys_oper_type','','info','N','0','admin','2025-02-06 20:48:50','',NULL,'修改操作'),(21,3,'删除','3','sys_oper_type','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'删除操作'),(22,4,'授权','4','sys_oper_type','','primary','N','0','admin','2025-02-06 20:48:50','',NULL,'授权操作'),(23,5,'导出','5','sys_oper_type','','warning','N','0','admin','2025-02-06 20:48:50','',NULL,'导出操作'),(24,6,'导入','6','sys_oper_type','','warning','N','0','admin','2025-02-06 20:48:50','',NULL,'导入操作'),(25,7,'强退','7','sys_oper_type','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'强退操作'),(26,8,'生成代码','8','sys_oper_type','','warning','N','0','admin','2025-02-06 20:48:50','',NULL,'生成操作'),(27,9,'清空数据','9','sys_oper_type','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'清空操作'),(28,1,'成功','0','sys_common_status','','primary','N','0','admin','2025-02-06 20:48:50','',NULL,'正常状态'),(29,2,'失败','1','sys_common_status','','danger','N','0','admin','2025-02-06 20:48:50','',NULL,'停用状态');
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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'用户性别','sys_user_sex','0','admin','2025-02-06 20:48:50','',NULL,'用户性别列表'),(2,'菜单状态','sys_show_hide','0','admin','2025-02-06 20:48:50','',NULL,'菜单状态列表'),(3,'系统开关','sys_normal_disable','0','admin','2025-02-06 20:48:50','',NULL,'系统开关列表'),(4,'任务状态','sys_job_status','0','admin','2025-02-06 20:48:50','',NULL,'任务状态列表'),(5,'任务分组','sys_job_group','0','admin','2025-02-06 20:48:50','',NULL,'任务分组列表'),(6,'系统是否','sys_yes_no','0','admin','2025-02-06 20:48:50','',NULL,'系统是否列表'),(7,'通知类型','sys_notice_type','0','admin','2025-02-06 20:48:50','',NULL,'通知类型列表'),(8,'通知状态','sys_notice_status','0','admin','2025-02-06 20:48:50','',NULL,'通知状态列表'),(9,'操作类型','sys_oper_type','0','admin','2025-02-06 20:48:50','',NULL,'操作类型列表'),(10,'系统状态','sys_common_status','0','admin','2025-02-06 20:48:50','',NULL,'登录状态列表');
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
INSERT INTO `sys_job` VALUES (1,'系统默认（无参）','DEFAULT','ryTask.ryNoParams','0/10 * * * * ?','3','1','1','admin','2025-02-06 20:48:50','',NULL,''),(2,'系统默认（有参）','DEFAULT','ryTask.ryParams(\'ry\')','0/15 * * * * ?','3','1','1','admin','2025-02-06 20:48:50','',NULL,''),(3,'系统默认（多参）','DEFAULT','ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)','0/20 * * * * ?','3','1','1','admin','2025-02-06 20:48:50','',NULL,'');
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
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (100,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-02-07 11:03:33'),(101,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-02-09 11:14:50'),(102,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-02-13 10:09:42'),(103,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-02-13 20:47:53'),(104,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','验证码错误','2025-02-14 08:01:48'),(105,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-02-14 08:01:51'),(106,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','1','验证码错误','2025-02-22 12:36:46'),(107,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-02-22 12:36:48'),(108,'admin','127.0.0.1','内网IP','Chrome 12','Windows 10','0','登录成功','2025-02-23 12:41:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=2013 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'','',1,0,'M','0','0','','system','admin','2025-02-06 20:48:49','',NULL,'系统管理目录'),(2,'系统监控',0,2,'monitor',NULL,'','',1,0,'M','0','0','','monitor','admin','2025-02-06 20:48:49','',NULL,'系统监控目录'),(3,'系统工具',0,3,'tool',NULL,'','',1,0,'M','0','0','','tool','admin','2025-02-06 20:48:49','',NULL,'系统工具目录'),(4,'若依官网',0,4,'http://ruoyi.vip',NULL,'','',0,0,'M','0','0','','guide','admin','2025-02-06 20:48:49','',NULL,'若依官网地址'),(100,'用户管理',1,1,'user','system/user/index','','',1,0,'C','0','0','system:user:list','user','admin','2025-02-06 20:48:49','',NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','','',1,0,'C','0','0','system:role:list','peoples','admin','2025-02-06 20:48:49','',NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','','',1,0,'C','0','0','system:menu:list','tree-table','admin','2025-02-06 20:48:49','',NULL,'菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','','',1,0,'C','0','0','system:dept:list','tree','admin','2025-02-06 20:48:49','',NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','','',1,0,'C','0','0','system:post:list','post','admin','2025-02-06 20:48:49','',NULL,'岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','','',1,0,'C','0','0','system:dict:list','dict','admin','2025-02-06 20:48:49','',NULL,'字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','','',1,0,'C','0','0','system:config:list','edit','admin','2025-02-06 20:48:49','',NULL,'参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','','',1,0,'C','0','0','system:notice:list','message','admin','2025-02-06 20:48:49','',NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','','',1,0,'M','0','0','','log','admin','2025-02-06 20:48:49','',NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','','',1,0,'C','0','0','monitor:online:list','online','admin','2025-02-06 20:48:49','',NULL,'在线用户菜单'),(110,'定时任务',2,2,'job','monitor/job/index','','',1,0,'C','0','0','monitor:job:list','job','admin','2025-02-06 20:48:49','',NULL,'定时任务菜单'),(111,'数据监控',2,3,'druid','monitor/druid/index','','',1,0,'C','0','0','monitor:druid:list','druid','admin','2025-02-06 20:48:49','',NULL,'数据监控菜单'),(112,'服务监控',2,4,'server','monitor/server/index','','',1,0,'C','0','0','monitor:server:list','server','admin','2025-02-06 20:48:49','',NULL,'服务监控菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','','',1,0,'C','0','0','monitor:cache:list','redis','admin','2025-02-06 20:48:49','',NULL,'缓存监控菜单'),(114,'缓存列表',2,6,'cacheList','monitor/cache/list','','',1,0,'C','0','0','monitor:cache:list','redis-list','admin','2025-02-06 20:48:49','',NULL,'缓存列表菜单'),(115,'表单构建',3,1,'build','tool/build/index','','',1,0,'C','0','0','tool:build:list','build','admin','2025-02-06 20:48:49','',NULL,'表单构建菜单'),(116,'代码生成',3,2,'gen','tool/gen/index','','',1,0,'C','0','0','tool:gen:list','code','admin','2025-02-06 20:48:49','',NULL,'代码生成菜单'),(117,'系统接口',3,3,'swagger','tool/swagger/index','','',1,0,'C','0','0','tool:swagger:list','swagger','admin','2025-02-06 20:48:49','',NULL,'系统接口菜单'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','','',1,0,'C','0','0','monitor:operlog:list','form','admin','2025-02-06 20:48:49','',NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','','',1,0,'C','0','0','monitor:logininfor:list','logininfor','admin','2025-02-06 20:48:49','',NULL,'登录日志菜单'),(1000,'用户查询',100,1,'','','','',1,0,'F','0','0','system:user:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1001,'用户新增',100,2,'','','','',1,0,'F','0','0','system:user:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1002,'用户修改',100,3,'','','','',1,0,'F','0','0','system:user:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1003,'用户删除',100,4,'','','','',1,0,'F','0','0','system:user:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1004,'用户导出',100,5,'','','','',1,0,'F','0','0','system:user:export','#','admin','2025-02-06 20:48:49','',NULL,''),(1005,'用户导入',100,6,'','','','',1,0,'F','0','0','system:user:import','#','admin','2025-02-06 20:48:49','',NULL,''),(1006,'重置密码',100,7,'','','','',1,0,'F','0','0','system:user:resetPwd','#','admin','2025-02-06 20:48:49','',NULL,''),(1007,'角色查询',101,1,'','','','',1,0,'F','0','0','system:role:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1008,'角色新增',101,2,'','','','',1,0,'F','0','0','system:role:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1009,'角色修改',101,3,'','','','',1,0,'F','0','0','system:role:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1010,'角色删除',101,4,'','','','',1,0,'F','0','0','system:role:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1011,'角色导出',101,5,'','','','',1,0,'F','0','0','system:role:export','#','admin','2025-02-06 20:48:49','',NULL,''),(1012,'菜单查询',102,1,'','','','',1,0,'F','0','0','system:menu:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1013,'菜单新增',102,2,'','','','',1,0,'F','0','0','system:menu:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1014,'菜单修改',102,3,'','','','',1,0,'F','0','0','system:menu:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1015,'菜单删除',102,4,'','','','',1,0,'F','0','0','system:menu:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1016,'部门查询',103,1,'','','','',1,0,'F','0','0','system:dept:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1017,'部门新增',103,2,'','','','',1,0,'F','0','0','system:dept:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1018,'部门修改',103,3,'','','','',1,0,'F','0','0','system:dept:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1019,'部门删除',103,4,'','','','',1,0,'F','0','0','system:dept:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1020,'岗位查询',104,1,'','','','',1,0,'F','0','0','system:post:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1021,'岗位新增',104,2,'','','','',1,0,'F','0','0','system:post:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1022,'岗位修改',104,3,'','','','',1,0,'F','0','0','system:post:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1023,'岗位删除',104,4,'','','','',1,0,'F','0','0','system:post:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1024,'岗位导出',104,5,'','','','',1,0,'F','0','0','system:post:export','#','admin','2025-02-06 20:48:49','',NULL,''),(1025,'字典查询',105,1,'#','','','',1,0,'F','0','0','system:dict:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1026,'字典新增',105,2,'#','','','',1,0,'F','0','0','system:dict:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1027,'字典修改',105,3,'#','','','',1,0,'F','0','0','system:dict:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1028,'字典删除',105,4,'#','','','',1,0,'F','0','0','system:dict:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1029,'字典导出',105,5,'#','','','',1,0,'F','0','0','system:dict:export','#','admin','2025-02-06 20:48:49','',NULL,''),(1030,'参数查询',106,1,'#','','','',1,0,'F','0','0','system:config:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1031,'参数新增',106,2,'#','','','',1,0,'F','0','0','system:config:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1032,'参数修改',106,3,'#','','','',1,0,'F','0','0','system:config:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1033,'参数删除',106,4,'#','','','',1,0,'F','0','0','system:config:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1034,'参数导出',106,5,'#','','','',1,0,'F','0','0','system:config:export','#','admin','2025-02-06 20:48:49','',NULL,''),(1035,'公告查询',107,1,'#','','','',1,0,'F','0','0','system:notice:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1036,'公告新增',107,2,'#','','','',1,0,'F','0','0','system:notice:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1037,'公告修改',107,3,'#','','','',1,0,'F','0','0','system:notice:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1038,'公告删除',107,4,'#','','','',1,0,'F','0','0','system:notice:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1039,'操作查询',500,1,'#','','','',1,0,'F','0','0','monitor:operlog:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1040,'操作删除',500,2,'#','','','',1,0,'F','0','0','monitor:operlog:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1041,'日志导出',500,3,'#','','','',1,0,'F','0','0','monitor:operlog:export','#','admin','2025-02-06 20:48:49','',NULL,''),(1042,'登录查询',501,1,'#','','','',1,0,'F','0','0','monitor:logininfor:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1043,'登录删除',501,2,'#','','','',1,0,'F','0','0','monitor:logininfor:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1044,'日志导出',501,3,'#','','','',1,0,'F','0','0','monitor:logininfor:export','#','admin','2025-02-06 20:48:49','',NULL,''),(1045,'账户解锁',501,4,'#','','','',1,0,'F','0','0','monitor:logininfor:unlock','#','admin','2025-02-06 20:48:49','',NULL,''),(1046,'在线查询',109,1,'#','','','',1,0,'F','0','0','monitor:online:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1047,'批量强退',109,2,'#','','','',1,0,'F','0','0','monitor:online:batchLogout','#','admin','2025-02-06 20:48:49','',NULL,''),(1048,'单条强退',109,3,'#','','','',1,0,'F','0','0','monitor:online:forceLogout','#','admin','2025-02-06 20:48:49','',NULL,''),(1049,'任务查询',110,1,'#','','','',1,0,'F','0','0','monitor:job:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1050,'任务新增',110,2,'#','','','',1,0,'F','0','0','monitor:job:add','#','admin','2025-02-06 20:48:49','',NULL,''),(1051,'任务修改',110,3,'#','','','',1,0,'F','0','0','monitor:job:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1052,'任务删除',110,4,'#','','','',1,0,'F','0','0','monitor:job:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1053,'状态修改',110,5,'#','','','',1,0,'F','0','0','monitor:job:changeStatus','#','admin','2025-02-06 20:48:49','',NULL,''),(1054,'任务导出',110,6,'#','','','',1,0,'F','0','0','monitor:job:export','#','admin','2025-02-06 20:48:49','',NULL,''),(1055,'生成查询',116,1,'#','','','',1,0,'F','0','0','tool:gen:query','#','admin','2025-02-06 20:48:49','',NULL,''),(1056,'生成修改',116,2,'#','','','',1,0,'F','0','0','tool:gen:edit','#','admin','2025-02-06 20:48:49','',NULL,''),(1057,'生成删除',116,3,'#','','','',1,0,'F','0','0','tool:gen:remove','#','admin','2025-02-06 20:48:49','',NULL,''),(1058,'导入代码',116,4,'#','','','',1,0,'F','0','0','tool:gen:import','#','admin','2025-02-06 20:48:49','',NULL,''),(1059,'预览代码',116,5,'#','','','',1,0,'F','0','0','tool:gen:preview','#','admin','2025-02-06 20:48:49','',NULL,''),(1060,'生成代码',116,6,'#','','','',1,0,'F','0','0','tool:gen:code','#','admin','2025-02-06 20:48:49','',NULL,''),(2000,'istm',0,4,'istm',NULL,NULL,'',1,0,'M','0','0',NULL,'build','admin','2025-02-13 10:47:22','',NULL,''),(2001,'教案管理',3,1,'plan','system/plan/index',NULL,'',1,0,'C','0','0','system:plan:list','#','admin','2025-02-13 21:37:27','',NULL,'教案管理菜单'),(2002,'教案管理查询',2001,1,'#','',NULL,'',1,0,'F','0','0','system:plan:query','#','admin','2025-02-13 21:37:27','',NULL,''),(2003,'教案管理新增',2001,2,'#','',NULL,'',1,0,'F','0','0','system:plan:add','#','admin','2025-02-13 21:37:27','',NULL,''),(2004,'教案管理修改',2001,3,'#','',NULL,'',1,0,'F','0','0','system:plan:edit','#','admin','2025-02-13 21:37:27','',NULL,''),(2005,'教案管理删除',2001,4,'#','',NULL,'',1,0,'F','0','0','system:plan:remove','#','admin','2025-02-13 21:37:27','',NULL,''),(2006,'教案管理导出',2001,5,'#','',NULL,'',1,0,'F','0','0','system:plan:export','#','admin','2025-02-13 21:37:27','',NULL,''),(2007,'课程管理',3,1,'class','system/class/index',NULL,'',1,0,'C','0','0','system:class:list','#','admin','2025-02-13 22:51:55','',NULL,'课程管理菜单'),(2008,'课程管理查询',2007,1,'#','',NULL,'',1,0,'F','0','0','system:class:query','#','admin','2025-02-13 22:51:55','',NULL,''),(2009,'课程管理新增',2007,2,'#','',NULL,'',1,0,'F','0','0','system:class:add','#','admin','2025-02-13 22:51:55','',NULL,''),(2010,'课程管理修改',2007,3,'#','',NULL,'',1,0,'F','0','0','system:class:edit','#','admin','2025-02-13 22:51:55','',NULL,''),(2011,'课程管理删除',2007,4,'#','',NULL,'',1,0,'F','0','0','system:class:remove','#','admin','2025-02-13 22:51:55','',NULL,''),(2012,'课程管理导出',2007,5,'#','',NULL,'',1,0,'F','0','0','system:class:export','#','admin','2025-02-13 22:51:55','',NULL,'');
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
INSERT INTO `sys_notice` VALUES (1,'温馨提醒：2018-07-01 若依新版本发布啦','2',_binary '新版本内容','0','admin','2025-02-06 20:48:50','',NULL,'管理员'),(2,'维护通知：2018-07-01 若依系统凌晨维护','1',_binary '维护内容','0','admin','2025-02-06 20:48:50','',NULL,'管理员');
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
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (100,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"-- 创建数据库\\nCREATE DATABASE IF NOT EXISTS istm_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\\n\\nUSE istm_db;\\n\\n-- 用户（教师）表\\nCREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\n-- 教案表\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\n-- 虚拟课堂表\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\n\\tclass_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\n-- 错误案例库表\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:30:41',16),(101,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"\\nCREATE DATABASE IF NOT EXISTS istm_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;\\n\\nUSE istm_db;\\n\\n\\nCREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\n-- 教案表\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\n-- 虚拟课堂表\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\n\\tclass_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\n-- 错误案例库表\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:30:56',4),(102,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"\\n\\n\\n\\nCREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\n-- 教案表\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\n-- 虚拟课堂表\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\n\\tclass_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\n-- 错误案例库表\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:31:09',2),(103,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"CREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\n\\tclass_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:32:24',3),(104,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"CREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\n\\tclass_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:32:48',2),(105,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"CREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\n\\tclass_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:33:11',1),(106,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"CREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\nclass_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:34:02',2),(107,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"CREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\n    class_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:34:06',1),(108,'创建表',0,'com.ruoyi.generator.controller.GenController.createTableSave()','POST',1,'admin','研发部门','/tool/gen/createTable','127.0.0.1','内网IP','{\"sql\":\"CREATE TABLE users (\\n    user_id INT AUTO_INCREMENT PRIMARY KEY,\\n    username VARCHAR(50) NOT NULL UNIQUE,\\n    password VARCHAR(255) NOT NULL,\\n    email VARCHAR(100),\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\n-- 教案表\\nCREATE TABLE lplans (\\n    plan_id INT AUTO_INCREMENT PRIMARY KEY,\\n    title VARCHAR(255) NOT NULL,\\n    content TEXT,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\\n);\\n\\n-- 虚拟课堂表\\nCREATE TABLE vclassrooms (\\n    classroom_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    user_id INT,\\n    classroom_name VARCHAR(255),\\n    classroom_type VARCHAR(255),\\n    class_process TEXT,\\n\\tclass_purpose TEXT,\\n    student_count INT DEFAULT 0,\\n    duration TIME,\\n    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id),\\n    FOREIGN KEY (user_id) REFERENCES users(user_id)\\n);\\n\\n-- 错误案例库表\\nCREATE TABLE ecases (\\n    case_id INT AUTO_INCREMENT PRIMARY KEY,\\n    plan_id INT,\\n    description TEXT,\\n    correction TEXT,\\n    FOREIGN KEY (plan_id) REFERENCES lplans(plan_id)\\n);\"}','{\"msg\":\"创建表结构异常\",\"code\":500}',0,NULL,'2025-02-13 10:36:22',2),(109,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"ecases,lplans,users,vclassrooms\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 10:42:34',148),(110,'菜单管理',1,'com.ruoyi.web.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"children\":[],\"createBy\":\"admin\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"istm\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"istm\",\"status\":\"0\",\"visible\":\"0\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 10:47:22',21),(111,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"ecases\"}',NULL,0,NULL,'2025-02-13 10:47:37',193),(112,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"ecases\",\"className\":\"Ecases\",\"columns\":[{\"capJavaField\":\"CaseId\",\"columnId\":1,\"columnName\":\"case_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"caseId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PlanId\",\"columnId\":2,\"columnName\":\"plan_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnId\":3,\"columnName\":\"description\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Correction\",\"columnId\":4,\"columnName\":\"correction\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"correction\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 10:48:27',40),(113,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"ecases\",\"className\":\"Ecases\",\"columns\":[{\"capJavaField\":\"CaseId\",\"columnComment\":\"示例序号\",\"columnId\":1,\"columnName\":\"case_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"caseId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 10:48:27\",\"usableColumn\":false},{\"capJavaField\":\"PlanId\",\"columnComment\":\"教案序号\",\"columnId\":2,\"columnName\":\"plan_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 10:48:27\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"描述\",\"columnId\":3,\"columnName\":\"description\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 10:48:27\",\"usableColumn\":false},{\"capJavaField\":\"Correction\",\"columnComment\":\"纠正\",\"columnId\":4,\"columnName\":\"correction\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isI','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 10:49:13',19),(114,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"lplans\",\"className\":\"Lplans\",\"columns\":[{\"capJavaField\":\"PlanId\",\"columnComment\":\"教案序号\",\"columnId\":5,\"columnName\":\"plan_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"标题\",\"columnId\":6,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Content\",\"columnComment\":\"内容\",\"columnId\":7,\"columnName\":\"content\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"editor\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"content\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CreatedAt\",\"columnComment\":\"创建时间\",\"columnId\":8,\"columnName\":\"created_at\",\"columnType\":\"timestamp\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"datetime\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"createdAt\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 10:51:26',19),(115,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"ecases\",\"className\":\"Ecases\",\"columns\":[{\"capJavaField\":\"CaseId\",\"columnComment\":\"示例序号\",\"columnId\":1,\"columnName\":\"case_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"caseId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 10:49:13\",\"usableColumn\":false},{\"capJavaField\":\"PlanId\",\"columnComment\":\"教案序号\",\"columnId\":2,\"columnName\":\"plan_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 10:49:13\",\"usableColumn\":false},{\"capJavaField\":\"Description\",\"columnComment\":\"描述\",\"columnId\":3,\"columnName\":\"description\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"description\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 10:49:13\",\"usableColumn\":false},{\"capJavaField\":\"Correction\",\"columnComment\":\"纠正\",\"columnId\":4,\"columnName\":\"correction\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isI','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 10:51:49',17),(116,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"users\",\"className\":\"Users\",\"columns\":[{\"capJavaField\":\"UserId\",\"columnComment\":\"用户序号\",\"columnId\":9,\"columnName\":\"user_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Username\",\"columnComment\":\"用户名\",\"columnId\":10,\"columnName\":\"username\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"username\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"密码\",\"columnId\":11,\"columnName\":\"password\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Email\",\"columnComment\":\"邮箱\",\"columnId\":12,\"columnName\":\"email\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"emai','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 10:52:52',23),(117,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"vclassrooms\",\"className\":\"Vclassrooms\",\"columns\":[{\"capJavaField\":\"ClassroomId\",\"columnComment\":\"课程序号\",\"columnId\":14,\"columnName\":\"classroom_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"classroomId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PlanId\",\"columnComment\":\"教案序号\",\"columnId\":15,\"columnName\":\"plan_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户序号\",\"columnId\":16,\"columnName\":\"user_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ClassroomName\",\"columnComment\":\"课程名称\",\"columnId\":17,\"columnName\":\"classroom_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 10:42:34\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 10:55:58',39),(118,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"ecases\"}',NULL,0,NULL,'2025-02-13 10:56:14',41),(119,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"lplans\"}',NULL,0,NULL,'2025-02-13 10:56:15',37),(120,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"users\"}',NULL,0,NULL,'2025-02-13 10:56:16',34),(121,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"vclassrooms\"}',NULL,0,NULL,'2025-02-13 10:56:17',43),(122,'代码生成',3,'com.ruoyi.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/1','127.0.0.1','内网IP','[1]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:16:11',69),(123,'代码生成',3,'com.ruoyi.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/2','127.0.0.1','内网IP','[2]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:16:13',11),(124,'代码生成',3,'com.ruoyi.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/3','127.0.0.1','内网IP','[3]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:16:15',10),(125,'代码生成',3,'com.ruoyi.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/4','127.0.0.1','内网IP','[4]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:16:16',10),(126,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"class_plan\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:16:20',111),(127,'代码生成',3,'com.ruoyi.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/5','127.0.0.1','内网IP','[5]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:19:21',10),(128,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"class_plan\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:19:25',75),(129,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"plan\",\"className\":\"ClassPlan\",\"columns\":[{\"capJavaField\":\"PlanId\",\"columnComment\":\"教案ID\",\"columnId\":41,\"columnName\":\"plan_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 21:19:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"教案标题\",\"columnId\":42,\"columnName\":\"title\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 21:19:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PlanType\",\"columnComment\":\"教案类型\",\"columnId\":43,\"columnName\":\"plan_type\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 21:19:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"planType\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Grade\",\"columnComment\":\"适用年级\",\"columnId\":44,\"columnName\":\"grade\",\"columnType\":\"varchar(11)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 21:19:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaFiel','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:22:28',92),(130,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"class_plan\"}',NULL,0,NULL,'2025-02-13 21:23:05',246),(131,'教案管理',1,'com.ruoyi.web.controller.system.ClassPlanController.add()','POST',1,'admin','研发部门','/system/plan','127.0.0.1','内网IP','{\"avatar\":\"/profile/upload/2025/02/13/微信图片_20220822093608_20250213213934A001.jpg\",\"content\":\"awdwad\",\"createTime\":\"2025-02-13 21:39:41\",\"grade\":\"2\",\"params\":{},\"peopleCount\":1,\"planId\":100,\"remark\":\"awdaw\",\"title\":\"ahwiodhawiod\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:39:41',119),(132,'教案管理',2,'com.ruoyi.web.controller.system.ClassPlanController.edit()','PUT',1,'admin','研发部门','/system/plan','127.0.0.1','内网IP','{\"avatar\":\"/profile/upload/2025/02/13/微信图片_20220822093608_20250213213934A001.jpg\",\"content\":\"awdwad\",\"createBy\":\"\",\"createTime\":\"2025-02-13 21:39:42\",\"grade\":\"2\",\"note1\":\"\",\"note2\":\"\",\"note3\":\"\",\"params\":{},\"peopleCount\":1,\"planId\":100,\"planType\":\"\",\"remark\":\"awdaw\",\"title\":\"ahwiodhawiod\",\"updateBy\":\"\",\"updateTime\":\"2025-02-13 21:39:53\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:39:53',11),(133,'教案管理',2,'com.ruoyi.web.controller.system.ClassPlanController.edit()','PUT',1,'admin','研发部门','/system/plan','127.0.0.1','内网IP','{\"avatar\":\"/profile/upload/2025/02/13/微信图片_20220822093608_20250213213934A001.jpg\",\"content\":\"awdwad\",\"createBy\":\"\",\"createTime\":\"2025-02-13 21:39:42\",\"grade\":\"大一\",\"note1\":\"\",\"note2\":\"\",\"note3\":\"\",\"params\":{},\"peopleCount\":1,\"planId\":100,\"planType\":\"足球\",\"remark\":\"这是一份足交巡检教案\",\"title\":\"足球巡检教案\",\"updateBy\":\"\",\"updateTime\":\"2025-02-13 21:43:56\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:43:56',5),(134,'教案管理',2,'com.ruoyi.web.controller.system.ClassPlanController.edit()','PUT',1,'admin','研发部门','/system/plan','127.0.0.1','内网IP','{\"avatar\":\"/profile/upload/2025/02/13/微信图片_20220822093608_20250213213934A001.jpg\",\"content\":\"啊范德萨房贷首付人头人肉原图原图\",\"createBy\":\"\",\"createTime\":\"2025-02-13 21:39:42\",\"grade\":\"大一\",\"note1\":\"\",\"note2\":\"\",\"note3\":\"\",\"params\":{},\"peopleCount\":1,\"planId\":100,\"planType\":\"足球\",\"remark\":\"这是一份足交巡检教案\",\"title\":\"足球巡检教案\",\"updateBy\":\"\",\"updateTime\":\"2025-02-13 21:46:12\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 21:46:12',6),(135,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"class\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 22:23:36',233),(136,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"class\",\"className\":\"Class\",\"columns\":[{\"capJavaField\":\"ClassId\",\"columnComment\":\"教案ID\",\"columnId\":56,\"columnName\":\"class_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:23:36\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"classId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ClassName\",\"columnComment\":\"课程标题\",\"columnId\":57,\"columnName\":\"class_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:23:36\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"className\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ClassType\",\"columnComment\":\"课程类型\",\"columnId\":58,\"columnName\":\"class_type\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:23:36\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"classType\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ClassProcess\",\"columnComment\":\"教学过程\",\"columnId\":59,\"columnName\":\"class_process\",\"columnType\":\"varchar(1000)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:23:36\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQu','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 22:27:00',99),(137,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"class\"}',NULL,0,NULL,'2025-02-13 22:27:06',219),(138,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"class\"}',NULL,0,NULL,'2025-02-13 22:27:52',60),(139,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"class\"}',NULL,0,NULL,'2025-02-13 22:31:55',50),(140,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"class\",\"className\":\"Class\",\"columns\":[{\"capJavaField\":\"ClassId\",\"columnComment\":\"教案ID\",\"columnId\":56,\"columnName\":\"class_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:23:36\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"classId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 22:27:00\",\"usableColumn\":false},{\"capJavaField\":\"ClassName\",\"columnComment\":\"课程标题\",\"columnId\":57,\"columnName\":\"class_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:23:36\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"className\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 22:27:00\",\"usableColumn\":false},{\"capJavaField\":\"ClassType\",\"columnComment\":\"课程类型\",\"columnId\":58,\"columnName\":\"class_type\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:23:36\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"classType\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"updateTime\":\"2025-02-13 22:27:00\",\"usableColumn\":false},{\"capJavaField\":\"ClassProcess\",\"columnComment\":\"教学过程\",\"columnId\":59,\"columnName\":\"class_process\",\"columnType\":\"varchar(1000)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:23:36\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"i','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 22:35:32',67),(141,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"class\"}',NULL,0,NULL,'2025-02-13 22:35:37',45),(142,'代码生成',3,'com.ruoyi.generator.controller.GenController.remove()','DELETE',1,'admin','研发部门','/tool/gen/7','127.0.0.1','内网IP','[7]','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 22:42:18',48),(143,'代码生成',6,'com.ruoyi.generator.controller.GenController.importTableSave()','POST',1,'admin','研发部门','/tool/gen/importTable','127.0.0.1','内网IP','{\"tables\":\"istm_class\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 22:42:25',124),(144,'代码生成',2,'com.ruoyi.generator.controller.GenController.editSave()','PUT',1,'admin','研发部门','/tool/gen','127.0.0.1','内网IP','{\"businessName\":\"class\",\"className\":\"IstmClass\",\"columns\":[{\"capJavaField\":\"ClassId\",\"columnComment\":\"教案ID\",\"columnId\":73,\"columnName\":\"class_id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:42:25\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"classId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ClassName\",\"columnComment\":\"课程标题\",\"columnId\":74,\"columnName\":\"class_name\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:42:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"className\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ClassType\",\"columnComment\":\"课程类型\",\"columnId\":75,\"columnName\":\"class_type\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:42:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"classType\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ClassProcess\",\"columnComment\":\"教学过程\",\"columnId\":76,\"columnName\":\"class_process\",\"columnType\":\"varchar(1000)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-13 22:42:25\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\"','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-13 22:44:11',89),(145,'代码生成',8,'com.ruoyi.generator.controller.GenController.batchGenCode()','GET',1,'admin','研发部门','/tool/gen/batchGenCode','127.0.0.1','内网IP','{\"tables\":\"istm_class\"}',NULL,0,NULL,'2025-02-13 22:44:15',215),(146,'教案管理',1,'com.ruoyi.web.controller.system.ClassPlanController.add()','POST',1,'admin','研发部门','/system/plan','127.0.0.1','内网IP','{\"content\":\"篮球训练\",\"createTime\":\"2025-02-14 08:02:54\",\"grade\":\"大三\",\"params\":{},\"peopleCount\":0,\"planId\":101,\"planType\":\"篮球\",\"title\":\"篮球训练\"}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-14 08:02:54',21),(147,'课程管理',1,'com.ruoyi.web.controller.system.IstmClassController.add()','POST',1,'admin','研发部门','/system/class','127.0.0.1','内网IP','{\"classId\":100,\"className\":\"篮球训练\",\"classProcess\":\"wdwad\",\"classPurpose\":\"adwsada\",\"classType\":\"篮球\",\"createTime\":\"2025-02-14 08:04:17\",\"duration\":45,\"params\":{},\"planId\":1,\"studentCount\":20,\"userId\":23131}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-14 08:04:17',18),(148,'课程管理',1,'com.ruoyi.web.controller.system.IstmClassController.add()','POST',1,'admin','研发部门','/system/class','127.0.0.1','内网IP','{\"classId\":101,\"className\":\"123\",\"classProcess\":\"2131\",\"classPurpose\":\"123\",\"classType\":\"123\",\"createTime\":\"2025-02-23 12:41:46\",\"duration\":123,\"params\":{},\"planId\":213,\"studentCount\":3123,\"userId\":123}','{\"msg\":\"操作成功\",\"code\":200}',0,NULL,'2025-02-23 12:41:46',23);
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
INSERT INTO `sys_post` VALUES (1,'ceo','董事长',1,'0','admin','2025-02-06 20:48:49','',NULL,''),(2,'se','项目经理',2,'0','admin','2025-02-06 20:48:49','',NULL,''),(3,'hr','人力资源',3,'0','admin','2025-02-06 20:48:49','',NULL,''),(4,'user','普通员工',4,'0','admin','2025-02-06 20:48:49','',NULL,'');
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
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin',1,'1',1,1,'0','0','admin','2025-02-06 20:48:49','',NULL,'超级管理员'),(2,'普通角色','common',2,'2',1,1,'0','0','admin','2025-02-06 20:48:49','',NULL,'普通角色');
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
INSERT INTO `sys_role_menu` VALUES (2,1),(2,2),(2,3),(2,4),(2,100),(2,101),(2,102),(2,103),(2,104),(2,105),(2,106),(2,107),(2,108),(2,109),(2,110),(2,111),(2,112),(2,113),(2,114),(2,115),(2,116),(2,117),(2,500),(2,501),(2,1000),(2,1001),(2,1002),(2,1003),(2,1004),(2,1005),(2,1006),(2,1007),(2,1008),(2,1009),(2,1010),(2,1011),(2,1012),(2,1013),(2,1014),(2,1015),(2,1016),(2,1017),(2,1018),(2,1019),(2,1020),(2,1021),(2,1022),(2,1023),(2,1024),(2,1025),(2,1026),(2,1027),(2,1028),(2,1029),(2,1030),(2,1031),(2,1032),(2,1033),(2,1034),(2,1035),(2,1036),(2,1037),(2,1038),(2,1039),(2,1040),(2,1041),(2,1042),(2,1043),(2,1044),(2,1045),(2,1046),(2,1047),(2,1048),(2,1049),(2,1050),(2,1051),(2,1052),(2,1053),(2,1054),(2,1055),(2,1056),(2,1057),(2,1058),(2,1059),(2,1060);
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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,103,'admin','若依','00','ry@163.com','15888888888','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-02-23 12:41:03','admin','2025-02-06 20:48:49','','2025-02-23 12:41:02','管理员'),(2,105,'ry','若依','00','ry@qq.com','15666666666','1','','$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2025-02-06 20:48:49','admin','2025-02-06 20:48:49','',NULL,'测试员');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
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
INSERT INTO `sys_user_post` VALUES (1,1),(2,2);
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
INSERT INTO `sys_user_role` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-15 12:49:27
