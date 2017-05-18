-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: 192.168.197.129    Database: war_game
-- ------------------------------------------------------
-- Server version	5.6.36

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
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity` (
  `activityid` int(11) NOT NULL AUTO_INCREMENT,
  `starttime` int(11) NOT NULL DEFAULT '0',
  `endtime` int(11) NOT NULL DEFAULT '0',
  `closetime` int(11) NOT NULL DEFAULT '0' COMMENT '真正结束时间',
  `value0` int(11) NOT NULL DEFAULT '0',
  `value1` int(11) NOT NULL DEFAULT '0',
  `value2` int(11) NOT NULL DEFAULT '0',
  `value3` bigint(20) NOT NULL DEFAULT '0',
  `strvalue` varchar(255) NOT NULL DEFAULT '',
  `openstat` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否调用过open',
  `endstat` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否调用过end',
  PRIMARY KEY (`activityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已经通过计时器设定完毕的活动';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor` (
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色编号',
  `userid` bigint(20) NOT NULL DEFAULT '0' COMMENT '账号编号',
  `username` varbinary(51) NOT NULL DEFAULT '' COMMENT '账号名',
  `admin` smallint(6) NOT NULL DEFAULT '0' COMMENT '管理员级别',
  `lastip` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0' COMMENT '上次登陆ip',
  `createtime` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `forbidtime` int(11) NOT NULL DEFAULT '0' COMMENT '禁言时间',
  `name` varchar(22) NOT NULL DEFAULT '' COMMENT '角色名称',
  `aclass` tinyint(4) NOT NULL DEFAULT '0' COMMENT '角色种类',
  `shape` tinyint(4) NOT NULL DEFAULT '0' COMMENT '形象',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '级别',
  `token` int(11) NOT NULL DEFAULT '0' COMMENT '钻石',
  `total_charge` int(11) NOT NULL DEFAULT '0' COMMENT '总充值',
  `itemext` tinyint(4) NOT NULL DEFAULT '0' COMMENT '扩展的背包栏位数',
  `sflag` int(11) NOT NULL DEFAULT '0' COMMENT '特定标志位',
  `fdate` int(11) NOT NULL DEFAULT '0' COMMENT '刷新的日子是哪天',
  `today_char` binary(128) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0' COMMENT 'char类型每日次数',
  `today_int0` int(11) NOT NULL DEFAULT '0' COMMENT 'int类型每日次数',
  `today_int1` int(11) NOT NULL DEFAULT '0' COMMENT 'int类型每日次数',
  `today_int2` int(11) NOT NULL DEFAULT '0' COMMENT 'int类型每日次数',
  `today_int3` int(11) NOT NULL DEFAULT '0' COMMENT 'int类型每日次数',
  `today_int4` int(11) NOT NULL DEFAULT '0' COMMENT 'int类型每日次数',
  `today_int5` int(11) NOT NULL DEFAULT '0' COMMENT 'int类型每日次数',
  `today_int6` int(11) NOT NULL DEFAULT '0' COMMENT 'int类型每日次数',
  `today_int7` int(11) NOT NULL DEFAULT '0' COMMENT 'int类型每日次数',
  `cd0` int(11) NOT NULL DEFAULT '0' COMMENT '通用CD时间',
  `cd1` int(11) NOT NULL DEFAULT '0' COMMENT '通用CD时间',
  `cd2` int(11) NOT NULL DEFAULT '0' COMMENT '通用CD时间',
  `cd3` int(11) NOT NULL DEFAULT '0' COMMENT '通用CD时间',
  `cd4` int(11) NOT NULL DEFAULT '0' COMMENT '通用CD时间',
  `cd5` int(11) NOT NULL DEFAULT '0' COMMENT '通用CD时间',
  `cd6` int(11) NOT NULL DEFAULT '0' COMMENT '通用CD时间',
  `cd7` int(11) NOT NULL DEFAULT '0' COMMENT '通用CD时间',
  `config` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0' COMMENT '玩家配置',
  `charge_dollar` double NOT NULL DEFAULT '0' COMMENT '总共充值多少美元',
  `cdkey1` int(11) NOT NULL DEFAULT '0' COMMENT '是否领取该批次兑换码',
  `cdkey2` int(11) NOT NULL DEFAULT '0' COMMENT '是否领取该批次兑换码',
  `cdkey3` int(11) NOT NULL DEFAULT '0' COMMENT '是否领取该批次兑换码',
  `cdkey4` int(11) NOT NULL DEFAULT '0' COMMENT '是否领取该批次兑换码',
  PRIMARY KEY (`actorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actor_item`
--

DROP TABLE IF EXISTS `actor_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor_item` (
  `itemid` bigint(20) NOT NULL DEFAULT '0' COMMENT '物品id',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `offset` smallint(6) NOT NULL DEFAULT '0' COMMENT '物品所在位置',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '物品种类',
  `num` smallint(6) NOT NULL DEFAULT '0' COMMENT '物品个数',
  `ability0` smallint(6) NOT NULL DEFAULT '0' COMMENT '属性',
  `ability1` smallint(6) NOT NULL DEFAULT '0' COMMENT '属性',
  `ability2` smallint(6) NOT NULL DEFAULT '0' COMMENT '属性',
  `ability3` smallint(6) NOT NULL DEFAULT '0' COMMENT '属性',
  `value0` int(11) NOT NULL DEFAULT '0' COMMENT '属性值',
  `value1` int(11) NOT NULL DEFAULT '0' COMMENT '属性值',
  `value2` int(11) NOT NULL DEFAULT '0' COMMENT '属性值',
  `value3` int(11) NOT NULL DEFAULT '0' COMMENT '属性值',
  `color_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '颜色等级',
  PRIMARY KEY (`itemid`),
  KEY `actorid` (`actorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actor_list`
--

DROP TABLE IF EXISTS `actor_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor_list` (
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色编号',
  `platid` int(11) NOT NULL DEFAULT '0' COMMENT '所属平台',
  `userid` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户编号',
  `username` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `offset` int(11) NOT NULL DEFAULT '0' COMMENT '所在位置(0启用-1删除)',
  `online` tinyint(3) NOT NULL DEFAULT '0' COMMENT '1在线，0不在线',
  `name` varchar(22) NOT NULL DEFAULT '' COMMENT '角色名字',
  `aclass` tinyint(3) NOT NULL DEFAULT '0' COMMENT '角色类型',
  `level` smallint(6) NOT NULL DEFAULT '0' COMMENT '等级',
  `lock_time` int(11) NOT NULL DEFAULT '0' COMMENT '锁定角色时间戳(到此时间解锁)',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '角色创建时间',
  `delete_stoptime` int(11) NOT NULL DEFAULT '0' COMMENT '删除角色时间',
  `logout_time` int(11) NOT NULL DEFAULT '0' COMMENT '下线时间',
  `channelid` smallint(6) NOT NULL DEFAULT '0' COMMENT '渠道ID，每个平台对应自己的渠道',
  `os` tinyint(3) NOT NULL DEFAULT '0' COMMENT '1:ios 2:android',
  `devdata` char(255) NOT NULL DEFAULT '' COMMENT '设备信息',
  PRIMARY KEY (`actorid`),
  UNIQUE KEY `name` (`name`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `cityid` int(11) NOT NULL AUTO_INCREMENT COMMENT '城池ID',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '城池类型',
  `name` varchar(22) NOT NULL DEFAULT '' COMMENT '名称',
  `shape` tinyint(4) NOT NULL DEFAULT '0' COMMENT '城池形象',
  `headid` int(11) NOT NULL DEFAULT '0' COMMENT '默认头像',
  `country` binary(3) NOT NULL DEFAULT '\0\0\0' COMMENT '选择的国家',
  `ipcountry` binary(3) NOT NULL DEFAULT '\0\0\0' COMMENT 'IP地址所在国家',
  `language` tinyint(4) NOT NULL DEFAULT '0' COMMENT '选择语言',
  `os` tinyint(4) NOT NULL DEFAULT '0' COMMENT '系统1ios 2android 3win',
  `platid` tinyint(4) NOT NULL DEFAULT '0' COMMENT '平台',
  `createtime` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `lastlogin` int(11) NOT NULL DEFAULT '0' COMMENT '上次登陆时间',
  `lastlogout` int(11) NOT NULL DEFAULT '0' COMMENT '上次登出时间',
  `state` tinyint(4) NOT NULL DEFAULT '0' COMMENT '城池当前状态',
  `posx` smallint(6) NOT NULL DEFAULT '0' COMMENT '位置',
  `posy` smallint(6) NOT NULL DEFAULT '0' COMMENT '位置',
  `sflag` int(11) NOT NULL DEFAULT '0' COMMENT '标志位',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '等级',
  `vipexp` int(11) NOT NULL DEFAULT '0' COMMENT 'VIP经验',
  `politics` smallint(6) NOT NULL DEFAULT '0' COMMENT '民生设施(一级属性)',
  `politics_exp` int(11) NOT NULL DEFAULT '0' COMMENT '民生设施经验',
  `farm` smallint(6) NOT NULL DEFAULT '0' COMMENT '农业设施(一级属性)',
  `farm_exp` int(11) NOT NULL DEFAULT '0' COMMENT '农业设施经验',
  `business` smallint(6) NOT NULL DEFAULT '0' COMMENT '商业设施(一级属性)',
  `business_exp` int(11) NOT NULL DEFAULT '0' COMMENT '商业设施经验',
  `military` smallint(6) NOT NULL DEFAULT '0' COMMENT '军事设施(一级属性)',
  `military_exp` int(11) NOT NULL DEFAULT '0' COMMENT '军事设施经验',
  `people` int(11) NOT NULL DEFAULT '0' COMMENT '人口(二级属性)',
  `food` int(11) NOT NULL DEFAULT '0' COMMENT '食物(二级属性)',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '金钱(二级属性)',
  `soldiers` int(11) NOT NULL DEFAULT '0' COMMENT '兵员(二级属性)',
  PRIMARY KEY (`cityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `command_data`
--

DROP TABLE IF EXISTS `command_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cond` int(11) NOT NULL DEFAULT '0',
  `cmd` int(11) NOT NULL DEFAULT '0' COMMENT 'GM指令',
  `value1` int(11) NOT NULL DEFAULT '0',
  `value2` int(11) NOT NULL DEFAULT '0',
  `value3` int(11) NOT NULL DEFAULT '0',
  `value4` int(11) NOT NULL DEFAULT '0',
  `strvalue` varchar(1024) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `timestr` varbinary(128) NOT NULL DEFAULT '',
  `addtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift`
--

DROP TABLE IF EXISTS `gift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色id',
  `kind1` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
  `num1` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `color1` tinyint(3) NOT NULL DEFAULT '0',
  `kind2` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
  `num2` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `color2` tinyint(3) NOT NULL DEFAULT '0',
  `kind3` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
  `num3` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `color3` tinyint(3) NOT NULL DEFAULT '0',
  `kind4` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
  `num4` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `color4` tinyint(3) NOT NULL DEFAULT '0',
  `path` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `actorid` (`actorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_uid`
--

DROP TABLE IF EXISTS `gift_uid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gift_uid` (
  `uid` varchar(64) NOT NULL DEFAULT '',
  `kind1` int(11) NOT NULL DEFAULT '0',
  `num1` int(11) NOT NULL DEFAULT '0',
  `color1` tinyint(3) NOT NULL DEFAULT '0',
  `kind2` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
  `num2` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `color2` tinyint(3) NOT NULL DEFAULT '0',
  `kind3` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
  `num3` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `color3` tinyint(3) NOT NULL DEFAULT '0',
  `kind4` int(11) NOT NULL DEFAULT '0' COMMENT '类型',
  `num4` int(11) NOT NULL DEFAULT '0' COMMENT '值',
  `color4` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='根据UID进行奖励';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail`
--

DROP TABLE IF EXISTS `mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_actorid` int(11) NOT NULL DEFAULT '0' COMMENT '发送人id',
  `from_name` varchar(32) NOT NULL DEFAULT '' COMMENT '发送人名称',
  `to_actorid` int(11) NOT NULL DEFAULT '0' COMMENT '收件人id',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '邮件类型',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(1024) NOT NULL DEFAULT '' COMMENT '内容',
  `attach` varchar(256) NOT NULL DEFAULT '' COMMENT '附件',
  `attach_isget` tinyint(3) NOT NULL DEFAULT '0' COMMENT '附件是否已经领取',
  `recvtime` int(11) NOT NULL DEFAULT '0' COMMENT '收件时间',
  `deltime` int(11) NOT NULL DEFAULT '0' COMMENT '删除时间',
  `read` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0未读，1已读',
  `fightid` bigint(20) NOT NULL DEFAULT '0' COMMENT '战斗录像',
  PRIMARY KEY (`id`),
  KEY `to_actorid` (`to_actorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pay_offline`
--

DROP TABLE IF EXISTS `pay_offline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_offline` (
  `actorid` int(11) NOT NULL DEFAULT '0',
  `orderid` char(32) NOT NULL DEFAULT '',
  `goodsid` smallint(6) NOT NULL DEFAULT '0',
  `optime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`actorid`,`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='离线的充值数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pay_order`
--

DROP TABLE IF EXISTS `pay_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_order` (
  `orderid` char(32) NOT NULL DEFAULT '',
  `userid` bigint(20) NOT NULL DEFAULT '0' COMMENT '游戏用户ID',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '游戏角色ID',
  `actorlevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '角色等级',
  `citylevel` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '主城等级',
  `productid` smallint(6) NOT NULL DEFAULT '0' COMMENT '平台产品ID',
  `goodsid` smallint(6) NOT NULL DEFAULT '0' COMMENT '游戏商品ID',
  `awardgroup` int(11) NOT NULL DEFAULT '0' COMMENT '奖励组',
  `ip` char(15) NOT NULL DEFAULT '0.0.0.0' COMMENT '地址',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '支付状态  0待支付 1支付成功',
  `optime` int(11) NOT NULL DEFAULT '0' COMMENT '生成时间',
  PRIMARY KEY (`orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `world_data`
--

DROP TABLE IF EXISTS `world_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `world_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(11) NOT NULL DEFAULT '0',
  `strvalue` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='世界数据';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-18 16:13:33
