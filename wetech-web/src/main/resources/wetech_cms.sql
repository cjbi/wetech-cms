-- MySQL dump 10.13  Distrib 5.1.26-rc, for Win32 (ia32)
--
-- Host: localhost    Database: fz_cms
-- ------------------------------------------------------
-- Server version	5.1.26-rc-community

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
-- Table structure for table `t_attachment`
--

DROP TABLE IF EXISTS `t_attachment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_attach` int(11) DEFAULT NULL,
  `is_img` int(11) DEFAULT NULL,
  `is_index_pic` int(11) DEFAULT NULL,
  `new_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `old_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `size` bigint(20) NOT NULL,
  `suffix` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK48549DCEEFDD7FD5` (`tid`),
  CONSTRAINT `FK48549DCEEFDD7FD5` FOREIGN KEY (`tid`) REFERENCES `t_topic` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_attachment`
--

LOCK TABLES `t_attachment` WRITE;
/*!40000 ALTER TABLE `t_attachment` DISABLE KEYS */;
INSERT INTO `t_attachment` VALUES (1,0,1,0,'1371195524565.jpg','01',181015,'jpg','application/octet-stream',NULL),(2,0,1,0,'1371195622989.jpg','01',181015,'jpg','application/octet-stream',NULL),(3,0,1,0,'1371195726459.jpg','01',181015,'jpg','application/octet-stream',NULL),(4,0,1,0,'1371195852981.jpg','01',181015,'jpg','application/octet-stream',NULL),(9,0,1,0,'1371196648991.jpg','01',181015,'jpg','application/octet-stream',NULL),(10,0,1,0,'1371197542525.jpg','01',181015,'jpg','application/octet-stream',NULL),(11,0,0,0,'1371197614016.XLS','15688',52736,'XLS','application/octet-stream',NULL),(12,0,0,0,'1371197665065.DOC','15686',21504,'DOC','application/octet-stream',NULL),(13,0,0,0,'1371197724741.doc','1286596139966',27136,'doc','application/octet-stream',NULL),(14,0,0,0,'1371197764854.XLS','15688',52736,'XLS','application/octet-stream',NULL),(15,0,0,0,'1371197813715.XLS','15688',52736,'XLS','application/octet-stream',NULL),(16,0,0,0,'1371197872688.doc','1286596139966',27136,'doc','application/octet-stream',NULL),(19,0,0,0,'1371199752486.xls','2009特岗',151552,'xls','application/octet-stream',NULL),(20,0,0,0,'1371199752638.xls','2010年特岗',160768,'xls','application/octet-stream',NULL),(21,1,0,0,'1371201903030.xls','2009特岗',151552,'xls','application/octet-stream',NULL),(22,1,0,0,'1371201903298.xls','2010年特岗',160768,'xls','application/octet-stream',NULL),(23,0,0,0,'1371202151434.xls','2009特岗',151552,'xls','application/octet-stream',NULL),(24,0,0,0,'1371202151748.xls','2010年特岗',160768,'xls','application/octet-stream',NULL),(25,0,0,0,'1371202316962.xls','2009特岗',151552,'xls','application/octet-stream',NULL),(26,0,0,0,'1371202317112.xls','2010年特岗',160768,'xls','application/octet-stream',NULL),(27,0,0,0,'1371202354804.xls','2009特岗',151552,'xls','application/octet-stream',NULL),(28,0,0,0,'1371202355146.xls','2010年特岗',160768,'xls','application/octet-stream',NULL),(30,1,0,0,'1371202483415.xls','2009特岗',151552,'xls','application/octet-stream',6),(31,1,0,0,'1371202483547.xls','2010年特岗',160768,'xls','application/octet-stream',6),(33,0,1,0,'1371203031079.jpg','02',264541,'jpg','application/octet-stream',7),(34,0,0,0,'1371203031447.DOC','15686',21504,'DOC','application/octet-stream',7),(35,0,0,0,'1371203031588.XLS','15688',52736,'XLS','application/octet-stream',7),(38,0,1,0,'1371454388182.png','03',299740,'png','application/octet-stream',NULL),(39,1,1,1,'1371455812685.jpg','01',181015,'jpg','application/octet-stream',12),(40,0,1,0,'1371455824981.jpg','02',264541,'jpg','application/octet-stream',12),(41,0,1,0,'1371456230556.jpg','01',181015,'jpg','application/octet-stream',10);
/*!40000 ALTER TABLE `t_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_channel`
--

DROP TABLE IF EXISTS `t_channel`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_link` int(11) DEFAULT NULL,
  `custom_link_url` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `is_index` int(11) DEFAULT '0',
  `is_top_nav` int(11) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `orders` int(11) NOT NULL,
  `recommend` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL,
  `type` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `show_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE79D7038D7DDF6E5` (`pid`),
  CONSTRAINT `FKE79D7038D7DDF6E5` FOREIGN KEY (`pid`) REFERENCES `t_channel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_channel`
--

LOCK TABLES `t_channel` WRITE;
/*!40000 ALTER TABLE `t_channel` DISABLE KEYS */;
INSERT INTO `t_channel` VALUES (1,0,'#',0,0,'用户管理模块',1,0,1,0,NULL,NULL),(2,0,'#',0,0,'用户管理1',1,0,1,1,1,NULL),(3,0,'#',0,0,'用户管理2',2,0,1,1,1,NULL),(4,0,'#',0,0,'用户管理3',3,0,0,1,1,NULL),(5,0,'#',0,0,'用户管理4',4,0,1,1,1,NULL),(6,0,'#',0,0,'文章管理模块',2,0,1,0,NULL,NULL),(7,0,'#',0,0,'文章管理1',1,0,0,1,6,NULL),(8,0,'#',0,0,'文章管理2',2,0,1,1,6,NULL),(9,0,'#',0,0,'文章管理3',3,0,0,1,6,NULL),(10,0,'#',0,0,'文章管理4',4,0,1,1,6,NULL),(11,0,'#',0,0,'系统管理模块',3,0,1,0,NULL,NULL),(12,0,'#',0,0,'系统管理1',1,0,1,1,11,NULL),(13,0,'#',0,0,'系统管理2',2,0,1,1,11,NULL),(14,0,'#',0,0,'系统管理3',3,0,0,1,11,NULL),(15,0,'#',0,0,'系统管理4',4,0,1,1,11,NULL),(16,0,'#',0,0,'招生管理模块',4,0,0,0,NULL,NULL),(17,0,'#',0,0,'招生管理1',1,0,1,1,16,NULL),(18,0,'#',0,0,'招生管理2',2,0,1,1,16,NULL),(19,0,'#',0,0,'招生管理3',3,0,1,1,16,NULL),(20,0,'#',0,0,'招生管理4',4,0,1,1,16,NULL);
/*!40000 ALTER TABLE `t_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_group`
--

DROP TABLE IF EXISTS `t_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descr` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_group`
--

LOCK TABLES `t_group` WRITE;
/*!40000 ALTER TABLE `t_group` DISABLE KEYS */;
INSERT INTO `t_group` VALUES (1,'负责财务部门的网页','财务处'),(2,'负责财务部门的网页','计科系'),(3,'负责财务部门的网页','宣传部');
/*!40000 ALTER TABLE `t_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_group_channel`
--

DROP TABLE IF EXISTS `t_group_channel`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_group_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `c_id` int(11) DEFAULT NULL,
  `g_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKB7D322B8D80AB7D1` (`c_id`),
  KEY `FKB7D322B8EF562C89` (`g_id`),
  CONSTRAINT `FKB7D322B8D80AB7D1` FOREIGN KEY (`c_id`) REFERENCES `t_channel` (`id`),
  CONSTRAINT `FKB7D322B8EF562C89` FOREIGN KEY (`g_id`) REFERENCES `t_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_group_channel`
--

LOCK TABLES `t_group_channel` WRITE;
/*!40000 ALTER TABLE `t_group_channel` DISABLE KEYS */;
INSERT INTO `t_group_channel` VALUES (2,3,1),(3,4,1),(4,5,1),(5,7,1),(6,12,1),(7,17,1),(8,1,1),(9,6,1),(10,11,1),(11,16,1),(32,6,2),(33,8,2),(34,11,2),(35,13,2),(36,16,2),(37,18,2),(39,10,2),(40,14,2);
/*!40000 ALTER TABLE `t_group_channel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_keyword`
--

DROP TABLE IF EXISTS `t_keyword`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `name_full_py` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `name_short_py` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `times` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_keyword`
--

LOCK TABLES `t_keyword` WRITE;
/*!40000 ALTER TABLE `t_keyword` DISABLE KEYS */;
INSERT INTO `t_keyword` VALUES (1,'ab','ab',NULL,1),(2,'bc','bc',NULL,2),(3,'cd','cd',NULL,3),(4,'ef','ef',NULL,4),(5,'fg','fg',NULL,5),(6,'abc','abc',NULL,6),(7,'bcd','bcd',NULL,7),(8,'efg','efg',NULL,8),(9,'aaa','aaa',NULL,9),(10,'bbb','bbb',NULL,10),(11,'测试lanm','ceshilanm','cs',3),(12,'栏目','lanmu','lm',2),(13,'新生入学','xinshengruxue','xsrx',1),(14,'报到信息','baodaoxinxi','bdxx',2),(15,'导航','daohang','dh',1),(16,'新生报到','xinshengbaodao','xsbd',2),(17,'打击乐','dajile','djl',3);
/*!40000 ALTER TABLE `t_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role`
--

DROP TABLE IF EXISTS `t_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `role_type` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_role`
--

LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` VALUES (1,'超级管理员','ROLE_ADMIN'),(2,'文章审核人员','ROLE_AUDIT'),(3,'文章发布人员','ROLE_PUBLISH');
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_topic`
--

DROP TABLE IF EXISTS `t_topic`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `channel_pic_id` int(11) DEFAULT NULL,
  `content` text COLLATE utf8_bin,
  `create_date` datetime DEFAULT NULL,
  `keyword` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `publish_date` datetime DEFAULT NULL,
  `recommend` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `summary` text COLLATE utf8_bin,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `cname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA10609A4D7DDC618` (`cid`),
  KEY `FKA10609A452119F24` (`uid`),
  CONSTRAINT `FKA10609A452119F24` FOREIGN KEY (`uid`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FKA10609A4D7DDC618` FOREIGN KEY (`cid`) REFERENCES `t_channel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_topic`
--

LOCK TABLES `t_topic` WRITE;
/*!40000 ALTER TABLE `t_topic` DISABLE KEYS */;
INSERT INTO `t_topic` VALUES (5,'超级管理员',0,'阿什拉夫空间啊十六大会计法拉萨宽带<a href=\"/cms/resources/upload/1371201903298.xls\" id=\"attach_22\">2010年特岗</a>计费拉克丝焦点房','2013-06-14 17:25:18','测试文章\\|质量监督\\|','2013-06-14 00:00:00',0,0,'啊十大了附件阿斯兰的会计法律思考觉得法拉省的','阿斯兰多夫加拉斯空军',3,3,'用户管理2'),(6,'超级管理员',0,'撒旦发撒旦发撒旦发生的<a href=\"/cms/resources/upload/1371202483145.doc\" id=\"attach_29\">2009年云南省公务员招考公告</a>','2013-06-14 17:34:56','测试lanm|栏目|','2013-06-14 00:00:00',0,0,'阿斯顿发生大幅','刻录机阿斯利科技',2,3,'用户管理1'),(7,'超级管理员',0,'asasdfasdfa<a href=\"/cms/resources/upload/1371203031447.DOC\" id=\"attach_34\">15686</a>sdf','2013-06-14 17:44:16','测试lanm|栏目|','2013-06-14 00:00:00',0,0,'asdfasdf','一篇测试文章',3,3,'用户管理2'),(8,'超级管理员',0,'阿斯顿飞卡司机的法律卡机市地方拉升阶段法律框架啊十大','2013-06-14 17:47:09','导航|新生报到|','2013-06-14 00:00:00',0,0,'','新生入学须知',4,3,'用户管理3'),(9,'超级管理员',0,'阿斯顿李开复就阿隆索宽带计费啦市地方','2013-06-14 17:47:47','报到信息|新生报到|','2013-06-14 00:00:00',0,1,'','老生报到',4,3,'用户管理3'),(10,'超级管理员',0,'阿斯顿飞噶是的噶是<img src=\"/cms/resources/upload/1371456230556.jpg\" id=\"attach_41\" alt=\"\" />大法师地方','2013-06-14 18:17:09','','2013-06-14 16:03:58',0,1,'啊撒旦发撒旦发生大法','萨达伽师道嘎上的浪费空间卢萨卡地方',4,3,'用户管理3'),(11,'超级管理员',0,'啊撒旦发撒旦发生大法','2013-06-14 18:17:38','','2013-06-01 18:17:38',0,0,'','啊撒旦发撒旦发生大法',3,3,'用户管理2'),(12,'超级管理员',40,'<p style=\"margin: 0px 0px 10px; padding: 0px; border: 0px; float: left; font-size: 14px; line-height: 21px; clear: both; width: 610px;\">在此前发布的Java Enterprise Edition（<a href=\"http://java.sun.com/javaee/\" style=\"text-decoration: none; color: rgb(40, 106, 178); margin: 0px; border: 0px; padding: 0px; outline: none !important;\">JEE</a>）6<a href=\"http://www.infoq.com/bycategory/newsbycategory.action?idx=2&amp;alias=javaee5\" id=\"c_u_\" title=\"系列文章\" style=\"text-decoration: none; color: rgb(40, 106, 178); margin: 0px; border: 0px; padding: 0px; outline: none !important;\">系列文章</a>中，我们介绍了Java API for RESTful Web Services（<a href=\"http://www.infoq.com/news/2010/02/javaee6-rest\" style=\"text-decoration: none; color: rgb(40, 106, 178); margin: 0px; border: 0px; padding: 0px; outline: none !important;\">JAX-RS</a>）、Contexts and Dependency Injection（<a href=\"http://www.infoq.com/news/2010/01/javaee6-di\" style=\"text-decoration: none; color: rgb(40, 106, 178); margin: 0px; border: 0px; padding: 0px; outline: none !important;\">CDI</a>）、<a href=\"http://www.infoq.com/news/2010/01/jsf20\" id=\"dop1\" title=\"Web端\" style=\"text-decoration: none; color: rgb(40, 106, 178); margin: 0px; border: 0px; padding: 0px; outline: none !important;\">Web端</a>（Servlet 3、JSF 2）以及EJB 3.1。在本系列文章行将结束之际，我们再来谈谈Bean Validation（<a href=\"http://jcp.org/en/jsr/detail?id=303\" style=\"text-decoration: none; color: rgb(40, 106, 178); margin: 0px; border: 0px; padding: 0px; outline: none !important;\">JSR 303</a>）——Java EE 6的一个核心特性，它为实体验证定义了一个元数据模型和API。其默认的元数据源是注解，但开发者可以通过XML描述符对其进行扩展。Validation API并不依赖特定的应用层或是编程模型，这样同一套验证可由应用的所有层共享。它还提供了通过扩展Validation API来增加客户化验证约束的机制以及查询约束元数据仓库的手段。</p><p style=\"margin: 0px 0px 10px; padding: 0px; border: 0px; float: left; font-size: 14px; line-height: 21px; clear: both; width: 610px;\">在JEE6的Bean Validation出现之前，开发者不得不在表示层框架、业务层以及持久层中编写验证规则以保证这些规则的同步性，但这么做非常浪费时间而且极易出错。Bean Validation是通过约束实现的，这些约束以注解的形式出现，注解可以放在JavaBean（如backing bean）的属性、方法或是类上面。&nbsp; 约束既可以是内建的注解（位于<a href=\"http://java.sun.com/javaee/6/docs/api/index.html?javax/validation/constraints/package-summary.html\" style=\"text-decoration: none; color: rgb(40, 106, 178); margin: 0px; border: 0px; padding: 0px; outline: none !important;\">javax.validation.constraints</a>包下面），也可以由用户定义。一些常用的内建注解列举如下：</p><ul style=\"margin: 0px 0px 10px 10px; padding: 0px; list-style-position: initial; list-style-image: initial; border: 0px; clear: left; font-size: 14px; line-height: 21px;\"><li style=\"margin: 0px 0px 0px 15px; padding: 0px; border: 0px; float: none; clear: none;\"><span style=\"margin: 0px; border: 0px; padding: 0px;\">Min</span>：被<a href=\"http://java.sun.com/javaee/6/docs/api/index.html?javax/validation/constraints/Min.html\" style=\"text-decoration: none; color: rgb(40, 106, 178); outline: none !important; margin: 0px; border: 0px; padding: 0px;\">@Min</a>所注解的元素必须是个数字，其值要大于或等于给定的最小值。</li><li style=\"margin: 0px 0px 0px 15px; padding: 0px; border: 0px; float: none; clear: none;\"><span style=\"margin: 0px; border: 0px; padding: 0px;\">Max</span>：被<a href=\"http://java.sun.com/javaee/6/docs/api/index.html?javax/validation/constraints/Max.html\" style=\"text-decoration: none; color: rgb(40, 106, 178); outline: none !important; margin: 0px; border: 0px; padding: 0px;\">@Max</a>所注解的元素必须是个数字，其值要小于或等于给定的最大值。</li><li style=\"margin: 0px 0px 0px 15px; padding: 0px; border: 0px; float: none; clear: none;\"><span style=\"margin: 0px; border: 0px; padding: 0px;\">Size</span>：<a href=\"http://java.sun.com/javaee/6/docs/api/index.html?javax/validation/constraints/Size.html\" style=\"text-decoration: none; color: rgb(40, 106, 178); outline: none !important; margin: 0px; border: 0px; padding: 0px;\">@Size</a>表示被注解的元素必须位于给定的最小值和最大值之间。支持Size验证的数据类型有String、Collection（计算集合的大小）、Map以及数组。</li><li style=\"margin: 0px 0px 0px 15px; padding: 0px; border: 0px; float: none; clear: none;\"><span style=\"margin: 0px; border: 0px; padding: 0px;\">NotNull</span>：<a href=\"http://java.sun.com/javaee/6/docs/api/index.html?javax/validation/constraints/NotNull.html\" style=\"text-decoration: none; color: rgb(40, 106, 178); outline: none !important; margin: 0px; border: 0px; padding: 0px;\">@NotNull</a>确保被注解的元素不能为null。</li><li style=\"margin: 0px 0px 0px 15px; padding: 0px; border: 0px; float: none; clear: none;\"><span style=\"margin: 0px; border: 0px; padding: 0px;\">Null</span>：<a href=\"http://java.sun.com/javaee/6/docs/api/index.html?javax/validation/constraints/Null.html\" style=\"text-decoration: none; color: rgb(40, 106, 178); outline: none !important; margin: 0px; border: 0px; padding: 0px;\">@Null</a>确保被注解的元素一定为null。</li><li style=\"margin: 0px 0px 0px 15px; padding: 0px; border: 0px; float: none; clear: none;\"><span style=\"margin: 0px; border: 0px; padding: 0px;\">Pattern</span>：<a href=\"http://java.sun.com/javaee/6/docs/api/index.html?javax/validation/constraints/Pattern.html\" id=\"u.b3\" title=\"@Pattern\" style=\"text-decoration: none; color: rgb(40, 106, 178); outline: none !important; margin: 0px; border: 0px; padding: 0px;\">@Pattern</a>确保被注解的元素（String）一定会匹配给定的Java正则表达式。</li></ul><p style=\"margin: 0px 0px 10px; padding: 0px; border: 0px; float: left; font-size: 14px; line-height: 21px; clear: both; width: 610px;\">下面的示例来自于Java EE 6<a href=\"http://java.sun.com/developer/technicalArticles/JavaEE/JavaEE6Overview.html\" id=\"ptmg\" title=\"系列文章\" style=\"text-decoration: none; color: rgb(40, 106, 178); margin: 0px; border: 0px; padding: 0px; outline: none !important;\">系列文章</a>，代码中通过Bean Validation注解声明了一些约束：</p>','2013-06-14 18:20:00','测试lanm|','2013-06-14 15:59:08',0,1,'','啊撒旦发撒旦发生大法',9,3,'文章管理3');
/*!40000 ALTER TABLE `t_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `nickname` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `phone` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `status` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'2010-12-12 00:00:00','admin1@admin.com','管理员','123','110',0,'guanly'),(2,'2010-12-12 00:00:00','admin1@admin.com','文章发布人员','123','110',0,'admin2'),(3,'2013-06-03 13:39:13','','超级管理员','192023a7bbd73250516f069df18b500','123',1,'admin');
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user_group`
--

DROP TABLE IF EXISTS `t_user_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `g_id` int(11) DEFAULT NULL,
  `u_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK300645B6EF562C89` (`g_id`),
  KEY `FK300645B652467BF9` (`u_id`),
  CONSTRAINT `FK300645B652467BF9` FOREIGN KEY (`u_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FK300645B6EF562C89` FOREIGN KEY (`g_id`) REFERENCES `t_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_user_group`
--

LOCK TABLES `t_user_group` WRITE;
/*!40000 ALTER TABLE `t_user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user_role`
--

DROP TABLE IF EXISTS `t_user_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `t_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `r_id` int(11) DEFAULT NULL,
  `u_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK331DEE5F5243B387` (`r_id`),
  KEY `FK331DEE5F52467BF9` (`u_id`),
  CONSTRAINT `FK331DEE5F5243B387` FOREIGN KEY (`r_id`) REFERENCES `t_role` (`id`),
  CONSTRAINT `FK331DEE5F52467BF9` FOREIGN KEY (`u_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `t_user_role`
--

LOCK TABLES `t_user_role` WRITE;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */;
INSERT INTO `t_user_role` VALUES (1,1,3);
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-07-02  8:29:00
