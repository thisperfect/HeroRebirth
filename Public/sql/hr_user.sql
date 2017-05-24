# SQL-Front 5.1  (Build 4.16)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: 192.168.197.129    Database: hr_user
# ------------------------------------------------------
# Server version 5.6.36

#
# Source for table accesslog
#

CREATE TABLE `accesslog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varbinary(51) NOT NULL DEFAULT '',
  `ip` varbinary(16) NOT NULL DEFAULT '',
  `optime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `msg` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='客户端访问log';

#
# Dumping data for table accesslog
#


#
# Source for table card
#

CREATE TABLE `card` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT '0000(id)aaaaaaaa(psw)',
  `passwd` char(8) NOT NULL DEFAULT '' COMMENT '随机12位',
  `cdkey_index` smallint(6) NOT NULL DEFAULT '0' COMMENT '-1随便领，0-127只允许领取一次',
  `limit_sys` tinyint(3) NOT NULL DEFAULT '0' COMMENT '限制系统1ios 2android',
  `limit_channel` tinyint(3) NOT NULL DEFAULT '0' COMMENT '限制渠道',
  `awardgroup` int(11) NOT NULL DEFAULT '0' COMMENT '奖励组',
  `overduetime` int(11) NOT NULL DEFAULT '0' COMMENT '过期时间戳',
  `userid` bigint(20) NOT NULL DEFAULT '0' COMMENT '使用者用户ID',
  `serverid` int(11) NOT NULL DEFAULT '0' COMMENT '使用者所在服务器id',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '使用角色ID',
  `usedtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '使用时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='兑换码';

#
# Dumping data for table card
#


#
# Source for table gate_list
#

CREATE TABLE `gate_list` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `ip` char(16) NOT NULL DEFAULT '127.0.0.1',
  `port` int(11) NOT NULL DEFAULT '10001',
  `new` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否导入服',
  `usernum` int(11) NOT NULL DEFAULT '0' COMMENT '当前用户数',
  `close` tinyint(3) NOT NULL DEFAULT '0',
  `force_android_ver` int(11) NOT NULL,
  `force_ios_ver` int(11) NOT NULL,
  `king_sevname` varchar(32) NOT NULL,
  `king_name` varchar(32) NOT NULL,
  `king_country` smallint(6) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '到量权重',
  `tempnum` int(11) NOT NULL DEFAULT '0' COMMENT '临时计数，倒量用',
  PRIMARY KEY (`id`),
  KEY `new` (`new`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务器网关列表';

#
# Dumping data for table gate_list
#


#
# Source for table ipdb
#

CREATE TABLE `ipdb` (
  `ip_start` varbinary(16) NOT NULL DEFAULT '',
  `ip_end` varbinary(16) NOT NULL DEFAULT '',
  `country` char(2) NOT NULL,
  PRIMARY KEY (`ip_start`),
  KEY `ip_end` (`ip_end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='国家IP库';

#
# Dumping data for table ipdb
#


#
# Source for table loginlog
#

CREATE TABLE `loginlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varbinary(51) NOT NULL DEFAULT '',
  `ip` varbinary(16) NOT NULL DEFAULT '',
  `optime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `msg` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='玩家登陆日志';

#
# Dumping data for table loginlog
#


#
# Source for table notice
#

CREATE TABLE `notice` (
  `id` int(11) NOT NULL,
  `desc` varchar(255) NOT NULL DEFAULT '',
  `zh-cn` text NOT NULL,
  `zh-tw` text NOT NULL,
  `en-us` text NOT NULL,
  `de-de` text NOT NULL,
  `ar-ar` text NOT NULL,
  `fr-fr` text NOT NULL,
  `pt-pt` text NOT NULL,
  `ru-ru` text NOT NULL,
  `es-es` text NOT NULL,
  `tr-tr` text NOT NULL,
  `pl-pl` text NOT NULL,
  `kr-kr` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公告类文字表';

#
# Dumping data for table notice
#


#
# Source for table payerror
#

CREATE TABLE `payerror` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varbinary(51) NOT NULL DEFAULT '' COMMENT '游戏订单号',
  `channel_orderid` varbinary(255) NOT NULL DEFAULT '' COMMENT '渠道订单号',
  `channel_uid` varbinary(51) NOT NULL DEFAULT '',
  `msg` varbinary(255) NOT NULL DEFAULT '',
  `ip` char(15) NOT NULL DEFAULT '',
  `optime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='支付错误日志';

#
# Dumping data for table payerror
#


#
# Source for table paylog
#

CREATE TABLE `paylog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varbinary(51) NOT NULL DEFAULT '' COMMENT '游戏订单号',
  `platid` smallint(6) NOT NULL DEFAULT '0' COMMENT '平台ID',
  `serverid` smallint(6) NOT NULL DEFAULT '0' COMMENT '服务器ID',
  `userid` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `country` char(3) NOT NULL DEFAULT '0' COMMENT '国家',
  `channel_orderid` varbinary(255) NOT NULL DEFAULT '' COMMENT '渠道订单号',
  `channel_uid` varbinary(51) NOT NULL DEFAULT '' COMMENT '渠道UID',
  `productid` smallint(6) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `goodsid` smallint(6) NOT NULL DEFAULT '0' COMMENT '游戏商品ID',
  `currency` smallint(6) NOT NULL DEFAULT '0' COMMENT '货币类型',
  `money` float(9,2) NOT NULL DEFAULT '0.00' COMMENT '支付金额',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '支付IP',
  `optime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '支付时间',
  PRIMARY KEY (`id`),
  KEY `serverid` (`serverid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='支付成功日志';

#
# Dumping data for table paylog
#


#
# Source for table pushlog
#

CREATE TABLE `pushlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL DEFAULT '',
  `action` tinyint(3) NOT NULL DEFAULT '0',
  `lang` smallint(6) NOT NULL DEFAULT '0',
  `optime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67684 DEFAULT CHARSET=utf8;

#
# Dumping data for table pushlog
#


#
# Source for table report_chat
#

CREATE TABLE `report_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverid` smallint(6) NOT NULL DEFAULT '0' COMMENT '服务器ID',
  `cityid` int(11) NOT NULL DEFAULT '0' COMMENT '城池ID',
  `headid` int(11) NOT NULL DEFAULT '0' COMMENT '头像ID',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `vip` tinyint(3) NOT NULL DEFAULT '0',
  `r_actorid` int(11) NOT NULL DEFAULT '0' COMMENT '举报人',
  `r_name` varchar(32) NOT NULL DEFAULT '' COMMENT '举报人姓名',
  `msg` varchar(512) NOT NULL DEFAULT '',
  `sign` char(32) NOT NULL DEFAULT '' COMMENT 'MD5验证串，统计这句话被举报次数用',
  `optime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='举报聊天';

#
# Dumping data for table report_chat
#


#
# Source for table report_head
#

CREATE TABLE `report_head` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverid` smallint(6) NOT NULL DEFAULT '0' COMMENT '服务器ID',
  `cityid` int(11) NOT NULL DEFAULT '0' COMMENT '城池ID',
  `headid` int(11) NOT NULL DEFAULT '0' COMMENT '头像ID',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `vip` tinyint(3) NOT NULL DEFAULT '0',
  `r_actorid` int(11) NOT NULL DEFAULT '0' COMMENT '举报人',
  `r_name` varchar(32) NOT NULL DEFAULT '' COMMENT '举报人姓名',
  `sign` char(32) NOT NULL DEFAULT '' COMMENT 'MD5验证串，统计这句话被举报次数用',
  `optime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='举报头像';

#
# Dumping data for table report_head
#


#
# Source for table report_name
#

CREATE TABLE `report_name` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serverid` smallint(6) NOT NULL DEFAULT '0' COMMENT '服务器ID',
  `cityid` int(11) NOT NULL DEFAULT '0' COMMENT '城池ID',
  `headid` int(11) NOT NULL DEFAULT '0' COMMENT '头像ID',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `vip` tinyint(3) NOT NULL DEFAULT '0',
  `r_actorid` int(11) NOT NULL DEFAULT '0' COMMENT '举报人',
  `r_name` varchar(32) NOT NULL DEFAULT '' COMMENT '举报人姓名',
  `sign` char(32) NOT NULL DEFAULT '' COMMENT 'MD5验证串，统计这句话被举报次数用',
  `optime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='举报名称';

#
# Dumping data for table report_name
#


#
# Source for table retention
#

CREATE TABLE `retention` (
  `deviceid` varbinary(36) NOT NULL DEFAULT '',
  `firsttime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `day01` tinyint(3) NOT NULL DEFAULT '0',
  `day02` tinyint(3) NOT NULL DEFAULT '0',
  `day03` tinyint(3) NOT NULL DEFAULT '0',
  `day04` tinyint(3) NOT NULL DEFAULT '0',
  `day05` tinyint(3) NOT NULL DEFAULT '0',
  `day06` tinyint(3) NOT NULL DEFAULT '0',
  `day07` tinyint(3) NOT NULL DEFAULT '0',
  `day08` tinyint(3) NOT NULL DEFAULT '0',
  `day09` tinyint(3) NOT NULL DEFAULT '0',
  `day10` tinyint(3) NOT NULL DEFAULT '0',
  `day11` tinyint(3) NOT NULL DEFAULT '0',
  `day12` tinyint(3) NOT NULL DEFAULT '0',
  `day13` tinyint(3) NOT NULL DEFAULT '0',
  `day14` tinyint(3) NOT NULL DEFAULT '0',
  `day15` tinyint(3) NOT NULL DEFAULT '0',
  `day16` tinyint(3) NOT NULL DEFAULT '0',
  `day17` tinyint(3) NOT NULL DEFAULT '0',
  `day18` tinyint(3) NOT NULL DEFAULT '0',
  `day19` tinyint(3) NOT NULL DEFAULT '0',
  `day20` tinyint(3) NOT NULL DEFAULT '0',
  `day21` tinyint(3) NOT NULL DEFAULT '0',
  `day22` tinyint(3) NOT NULL DEFAULT '0',
  `day23` tinyint(3) NOT NULL DEFAULT '0',
  `day24` tinyint(3) NOT NULL DEFAULT '0',
  `day25` tinyint(3) NOT NULL DEFAULT '0',
  `day26` tinyint(3) NOT NULL DEFAULT '0',
  `day27` tinyint(3) NOT NULL DEFAULT '0',
  `day28` tinyint(3) NOT NULL DEFAULT '0',
  `day29` tinyint(3) NOT NULL DEFAULT '0',
  `day30` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`deviceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='留存统计';

#
# Dumping data for table retention
#


#
# Source for table server_list
#

CREATE TABLE `server_list` (
  `id` int(11) NOT NULL DEFAULT '0',
  `serverid` int(11) NOT NULL DEFAULT '0',
  `name` varbinary(16) NOT NULL DEFAULT '',
  `ip` char(16) NOT NULL DEFAULT '127.0.0.1',
  `port` int(11) NOT NULL DEFAULT '30001' COMMENT 'GM端口',
  `dbh` varbinary(64) NOT NULL DEFAULT '',
  `dbu` varbinary(32) NOT NULL DEFAULT '',
  `dbp` varbinary(32) NOT NULL DEFAULT '',
  `dbd` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `serverid` (`serverid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='服务器列表，后台使用';

#
# Dumping data for table server_list
#


#
# Source for table tracklog
#

CREATE TABLE `tracklog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deviceid` binary(51) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0' COMMENT 'éè±?ID',
  `step` int(11) NOT NULL DEFAULT '0' COMMENT '2??è',
  `step_time` int(11) NOT NULL DEFAULT '0' COMMENT '2??èê±??',
  `country` char(4) NOT NULL DEFAULT '' COMMENT '1ú?ò',
  `system` smallint(6) NOT NULL DEFAULT '0' COMMENT '?μí3',
  `clientver` char(16) NOT NULL DEFAULT '' COMMENT '3ìDò°?±?o?',
  `resver` int(11) NOT NULL DEFAULT '0' COMMENT '×ê?′°?±?',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='追踪日志';

#
# Dumping data for table tracklog
#


#
# Source for table user
#

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `name` varbinary(64) NOT NULL DEFAULT '' COMMENT '用户名（渠道存UID）',
  `passwd` varbinary(64) NOT NULL DEFAULT '' COMMENT '密码（渠道不使用）',
  `usertype` smallint(6) NOT NULL DEFAULT '0' COMMENT '用户类型',
  `serverid` smallint(6) NOT NULL DEFAULT '0' COMMENT '当前所在服务器',
  `locktime` int(11) NOT NULL DEFAULT '0' COMMENT '账户锁定时间',
  `activeflag` tinyint(3) NOT NULL DEFAULT '0' COMMENT '账户是否激活',
  `lang` char(4) NOT NULL DEFAULT '' COMMENT 'è???¤?èˉ-è¨',
  `country` char(4) NOT NULL DEFAULT '' COMMENT 'è???¤???°??o',
  `point_totle` int(11) NOT NULL DEFAULT '0' COMMENT '?′ˉè???……??é??',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `regip` char(15) NOT NULL DEFAULT '',
  `lastip` char(15) NOT NULL DEFAULT '',
  `login_time` int(11) NOT NULL DEFAULT '0',
  `token` varbinary(51) NOT NULL DEFAULT '' COMMENT 'è?¤èˉ????',
  `flashtime` int(11) NOT NULL DEFAULT '0' COMMENT 'è?¤èˉ??????·?–°?—?é—′',
  `channelid` smallint(6) NOT NULL DEFAULT '0',
  `sys` tinyint(3) NOT NULL DEFAULT '0' COMMENT '?3????',
  `ipcountry` char(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户';

#
# Dumping data for table user
#


#
# Source for table zclient_error
#

CREATE TABLE `zclient_error` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(1024) NOT NULL DEFAULT '',
  `source` varchar(1024) NOT NULL DEFAULT '',
  `serverid` varchar(16) NOT NULL DEFAULT '',
  `actorid` varchar(16) NOT NULL DEFAULT '',
  `ver` varchar(32) NOT NULL DEFAULT '',
  `optime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='脚本错误收集';

#
# Dumping data for table zclient_error
#


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
