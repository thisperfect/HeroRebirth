# SQL-Front 5.1  (Build 4.16)

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE */;
/*!40101 SET SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES */;
/*!40103 SET SQL_NOTES='ON' */;


# Host: 192.168.197.129    Database: hr_autoconfig
# ------------------------------------------------------
# Server version 5.6.36

#
# Source for table net_struct
#

CREATE TABLE `net_struct` (
  `structid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varbinary(32) NOT NULL DEFAULT '',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `struct_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '1server,2client,3logined',
  `sortindex` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`structid`)
) ENGINE=MyISAM AUTO_INCREMENT=1828 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table net_struct
#

REPLACE INTO `net_struct` VALUES (1,'NetC_Login','客户端请求登录',2,0);
REPLACE INTO `net_struct` VALUES (2,'NetU_Logined','用户服务器返回登陆',3,0);
REPLACE INTO `net_struct` VALUES (3,'NetS_Login','服务器端发送登录结果给客户端',1,0);
REPLACE INTO `net_struct` VALUES (4,'ListInfo','单个角色的列表信息',1,0);
REPLACE INTO `net_struct` VALUES (5,'NetS_List','服务器端发送角色列表',1,0);
REPLACE INTO `net_struct` VALUES (6,'NetC_Create','客户端请求创建角色',2,0);
REPLACE INTO `net_struct` VALUES (7,'NetS_Create','服务器返回创建角色结果',1,0);
REPLACE INTO `net_struct` VALUES (8,'NetS_EnterInfo','服务器返回进入游戏后的信息',1,0);
REPLACE INTO `net_struct` VALUES (9,'NetS_Delete','服务器返回删除角色',1,0);
REPLACE INTO `net_struct` VALUES (10,'NetC_Heart','心跳',2,0);
REPLACE INTO `net_struct` VALUES (11,'NetS_Heart','心跳',1,0);
REPLACE INTO `net_struct` VALUES (12,'NetC_Gmcmd','GM指令',2,0);
REPLACE INTO `net_struct` VALUES (13,'NetS_Notify','通用短消息',1,0);
REPLACE INTO `net_struct` VALUES (14,'NetU_UserAwarded','用户服务器返回兑换奖励',3,0);
REPLACE INTO `net_struct` VALUES (15,'NetC_Gmlocalcmd','本地GM信息',3,0);
REPLACE INTO `net_struct` VALUES (16,'NetC_AskInfo','客户端发送短请求',2,0);
REPLACE INTO `net_struct` VALUES (29,'NetS_ActorInfo','角色基本信息',1,0);
REPLACE INTO `net_struct` VALUES (30,'Corrdinate','坐标',1,0);
REPLACE INTO `net_struct` VALUES (31,'NetS_ItemUse','道具使用|装备',1,0);
REPLACE INTO `net_struct` VALUES (32,'NetS_ItemPut','道具放置|卸下',1,0);
REPLACE INTO `net_struct` VALUES (33,'NetS_ItemSettle','道具整理',1,0);
REPLACE INTO `net_struct` VALUES (34,'NetS_LostItem','丢失道具',1,0);
REPLACE INTO `net_struct` VALUES (35,'NetS_GetItem','获得道具',1,0);
REPLACE INTO `net_struct` VALUES (36,'ItemSmpInfo','道具简易信息',1,0);
REPLACE INTO `net_struct` VALUES (37,'NetS_ItemList','道具列表',1,0);
REPLACE INTO `net_struct` VALUES (38,'ItemAttr','道具属性',1,0);
REPLACE INTO `net_struct` VALUES (39,'NetS_ItemInfo','道具信息',1,0);
REPLACE INTO `net_struct` VALUES (77,'NetS_AwardInfo','奖励信息',1,0);
REPLACE INTO `net_struct` VALUES (78,'NetS_AwardInfoList','奖励信息列表',1,0);
REPLACE INTO `net_struct` VALUES (79,'NetS_Experience','经验获取',1,0);
REPLACE INTO `net_struct` VALUES (80,'NetS_Body','体力获取',1,0);

#
# Source for table net_struct_conf
#

CREATE TABLE `net_struct_conf` (
  `dataid` int(11) NOT NULL AUTO_INCREMENT,
  `structid` int(11) DEFAULT NULL,
  `offset` smallint(6) NOT NULL DEFAULT '0',
  `name` varbinary(32) NOT NULL DEFAULT '',
  `data_type` smallint(6) NOT NULL DEFAULT '0',
  `data_count` smallint(6) NOT NULL DEFAULT '0',
  `data_size` smallint(6) NOT NULL DEFAULT '0',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `notsave` tinyint(4) NOT NULL DEFAULT '0',
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `m_fix` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`dataid`)
) ENGINE=MyISAM AUTO_INCREMENT=2360112 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table net_struct_conf
#

REPLACE INTO `net_struct_conf` VALUES (1000,1,0,'username_length',-2,0,0,'客户端请求-用户名长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1001,1,1,'username',-1,-1,51,'客户端请求-用户名',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1002,1,2,'password_length',-2,0,0,'客户端请求-密码长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1003,1,3,'password',-1,-1,256,'客户端请求-密码',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1004,1,4,'deviceid_length',-2,0,0,'客户端请求-设备标示长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1005,1,5,'deviceid',-1,-1,65,'客户端请求-设备标示',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1006,1,6,'isnew',-2,0,0,'客户端请求-是否新用户',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1007,1,7,'ipcountry_length',-2,0,0,'客户端请求-IP地址所在国家',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1008,1,8,'ipcountry',-1,-1,16,'客户端请求-IP地址所在国家',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2000,2,0,'result',-3,0,0,'用户服务器返回-登录返回值',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2001,2,1,'client_index',-3,0,0,'用户服务器返回-角色索引',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2002,2,2,'authid',-3,0,0,'用户服务器返回-认证ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2003,2,3,'userid',-1,21,0,'用户服务器返回-用户ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2004,2,4,'username',-1,51,0,'用户服务器返回-用户名',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2005,2,5,'usertype',-2,0,0,'用户服务器返回-用户类型',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2006,2,6,'checkflag',-1,0,0,'用户服务器返回-检测标记',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2007,2,7,'isdeep',-1,0,0,'用户服务器返回-要防沉迷',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2008,2,8,'access_token',-1,65,0,'用户服务器返回-360的用户令牌',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2009,2,9,'expires_in',-3,0,0,'用户服务器返回-360的令牌有效期',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2010,2,10,'refresh_token',-1,65,0,'用户服务器返回-360的刷新令牌',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2011,2,11,'deviceid',-1,65,0,'用户服务器返回-传回的设备ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3000,3,0,'result',-3,0,0,'服务器返回-返回值',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3001,3,1,'username_length',-2,0,0,'服务器返回-用户名长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3002,3,2,'username',-1,-1,51,'服务器返回-用户名',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3003,3,3,'token_length',-2,0,0,'服务器返回-token长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3004,3,4,'token',-1,-1,256,'服务器返回-token',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3005,3,5,'usertype',-2,0,0,'服务器返回-用户类型',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4000,4,0,'actorid',-3,0,0,'角色ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4001,4,1,'name',-1,22,0,'角色名字',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4002,4,2,'aclass',-1,0,0,'角色种族',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4003,4,3,'level',-2,0,0,'角色等级',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4004,4,4,'offset',-1,0,0,'角色位置',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4005,4,5,'lockstat',-1,0,0,'锁定状态',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4006,4,6,'delete_stoptime',-3,0,0,'删除时间',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4007,4,7,'lock_endtime',-3,0,0,'锁定时间',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (5000,5,0,'actor_num',-1,0,0,'服务端返回-角色个数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (5001,5,1,'listinfo',4,-1,8,'服务端返回-角色数组',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (6000,6,0,'aclass',-1,0,0,'客户端请求-创建的角色种类',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (6001,6,1,'name_length',-2,0,0,'客户端请求-创建的角色名称长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (6002,6,2,'name',-1,-1,22,'客户端请求-创建的角色名称',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (7000,7,0,'result',-1,0,0,'服务端返回-创建角色的结果',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (7001,7,1,'actorid',-3,0,0,'服务端返回-创建角色的编号',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (7002,7,2,'createtime',-3,0,0,'服务端返回-创建角色的时间',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8000,8,0,'actorid',-3,0,0,'服务端返回-进入游戏角色ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8001,8,1,'data_int',-3,0,0,'服务端返回-进入游戏额外数据[备用]',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8002,8,2,'data_short',-2,0,0,'服务端返回-进入游戏额外数据[备用]',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8003,8,3,'data_char',-1,0,0,'服务端返回-进入游戏额外数据[备用]',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8004,8,4,'serverid',-2,0,0,'服务端返回-进入的服务器ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8005,8,5,'servertime',-3,0,0,'服务端返回-进入的服务器时间戳',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8006,8,6,'createtime',-3,0,0,'服务端返回-创建角色时间',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (9000,9,0,'result',-3,0,0,'服务器返回-删除返回值',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (9001,9,1,'actorid',-3,0,0,'服务器返回-删除的角色编号',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (10000,10,0,'value',-3,2,0,'心跳-数值',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (11000,11,0,'value',-3,2,0,'心跳-数值',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (12000,12,0,'cmd',-2,0,0,'客户端发来-GM指令',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (12001,12,1,'value',-3,4,0,'客户端发来-GM指令数值参数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (12002,12,2,'msg_length',-2,0,0,'客户端发来-GM指令字符串长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (12003,12,3,'msg',-1,-1,256,'客户端发来-GM指令字符串参数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13000,13,0,'msgid',-2,0,0,'服务器发送-短消息ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13001,13,1,'valuenum',-2,0,0,'服务器发送-短消息参数个数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13002,13,2,'value',-3,-1,10,'服务器发送-短消息数值参数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13003,13,3,'msg_length',-2,0,0,'服务器发送-短消息字符串消息长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13004,13,4,'msg',-1,-1,256,'服务器发送-短消息字符串参数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14000,14,0,'result',-3,0,0,'用户服务器返回-兑换结果返回值',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14001,14,1,'client_index',-3,0,0,'用户服务器返回-角色索引',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14002,14,2,'authid',-3,0,0,'用户服务器返回-认证ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14003,14,3,'cdkey_index',-2,0,0,'用户服务器返回-兑换码存档索引',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14004,14,4,'awardgroup',-3,0,0,'用户服务器返回-兑换码奖励组',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14005,14,5,'cardnumber',-1,32,0,'用户服务器返回-兑换码卡号',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (15000,15,0,'cmd',-2,0,0,'指令',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (15001,15,1,'value',-3,4,0,'数值参数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (15002,15,2,'msglen',-2,0,0,'字符串长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (15003,15,3,'msg',-1,-1,1024,'字符串参数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16000,16,0,'msgid',-2,0,0,'客户端发送-短请求ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16001,16,1,'valuenum',-2,0,0,'客户端发送-短请求参数个数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16002,16,2,'value',-3,-1,10,'客户端发送-短请求参数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16003,16,3,'msg_length',-2,0,0,'客户端发送-短请求字符串长度',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16004,16,4,'msg',-1,-1,256,'客户端发送-短请求字符串',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29000,29,0,'actorid',-3,0,0,'服务器发送玩家基本信息-角色编号',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29001,29,1,'name',-1,22,0,'服务器发送玩家基本信息-角色名称',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29002,29,2,'aclass',-1,0,0,'服务器发送玩家基本信息-角色种类',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29003,29,3,'shape',-2,0,0,'服务器发送玩家基本信息-形象',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29004,29,4,'level',-2,0,0,'服务器发送玩家基本信息-级别',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29005,29,5,'experience',-4,0,0,'服务器发送玩家基本信息-经验',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29006,29,6,'experience_max',-4,0,0,'服务器发送玩家基本信息-经验上限',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29008,29,8,'token',-3,0,0,'服务器发送玩家基本信息-钻石',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29009,29,9,'viplevel',-1,0,0,'服务器发送玩家基本信息-VIP等级',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (30000,30,0,'posx',-2,0,0,'坐标',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (30001,30,1,'posy',-2,0,0,'坐标',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (31000,31,0,'itemoffset',-2,0,0,'物品位置',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (31001,31,1,'usenum',-2,0,0,'使用个数或装备位置',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (31002,31,2,'effres',-3,0,0,'影响，一般用于特效显示',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (32000,32,0,'res_offset',-2,0,0,'物品源',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (32001,32,1,'res_num',-2,0,0,'物品源个数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (32002,32,2,'target_offset',-2,0,0,'物品目标',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (32003,32,3,'target_num',-2,0,0,'目标个数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (33000,33,0,'itemnum',-2,0,0,'整理背包的个数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (33001,33,1,'itemoffset',-2,-1,100,'重置的物品位置',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (34000,34,0,'itemoffset',-2,0,0,'物品位置',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (34001,34,1,'itemnum',-2,0,0,'数量',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (34002,34,2,'targetid',-3,0,0,'赋予的对象id',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (34003,34,3,'path',-1,0,0,'途径',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35000,35,0,'itemoffset',-2,0,0,'物品位置',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35001,35,1,'kind',-2,0,0,'物品种类',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35002,35,2,'type',-2,0,0,'物品类型',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35003,35,3,'color',-1,0,0,'颜色',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35004,35,4,'num',-2,0,0,'数量',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35005,35,5,'targetid',-3,0,0,'赋予的对象id',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35006,35,6,'path',-1,0,0,'途径',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35007,35,7,'situation',-11,0,0,'使用状态',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36000,36,0,'offset',-2,0,0,'物品位置',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36001,36,1,'kind',-2,0,0,'物品种类',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36002,36,2,'num',-2,0,0,'数量',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36003,36,3,'situation',-11,0,0,'使用状态',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36004,36,4,'color_level',-1,0,0,'颜色',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (37000,37,0,'itemext',-1,0,0,'扩展的格子',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (37001,37,1,'kindnum',-2,0,0,'物品数量',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (37002,37,2,'item',36,-1,300,'物品',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (38000,38,0,'type',-2,0,0,'物品属性所属类型',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (38001,38,1,'ability',-2,0,0,'物品属性',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (38002,38,2,'value',-3,0,0,'物品数据',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (38003,38,3,'addvalue',-3,0,0,'物品增加数据',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39000,39,0,'itemoffset',-2,0,0,'物品位置',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39001,39,1,'itemkind',-2,0,0,'装备kind,校验',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39002,39,2,'type',-2,0,0,'物品类型',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39003,39,3,'level',-2,0,0,'一般等级',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39004,39,4,'color_level',-1,0,0,'颜色分级',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39005,39,5,'price',-3,0,0,'售价',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39006,39,6,'attr_num',-2,0,0,'属性个数',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39007,39,7,'attr',38,-1,10,'属性',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (50000,50,0,'info',44,0,0,'更新地图显示单元信息',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (77000,77,0,'kind',-3,0,0,'种类',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (77001,77,1,'num',-3,0,0,'数量',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (78000,78,0,'count',-2,0,0,'奖励数量',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (78001,78,1,'list',77,-1,32,'奖励列表',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (78002,78,2,'callback_code',-2,0,0,'哪个系统要显示，回传',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (79000,79,0,'addexp',-3,0,0,'经验获取',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (79001,79,1,'curexp',-4,0,0,'当前经验',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (79002,79,2,'isup',-1,0,0,'是否升级',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (79003,79,4,'path',-2,0,0,'途径',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (80000,80,0,'body',-2,0,0,'体力',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (80001,80,1,'addbody',-2,0,0,'获取体力',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (80002,80,2,'path',-3,0,0,'途径',0,0,1);

#
# Source for table netccmd
#

CREATE TABLE `netccmd` (
  `cmdid` int(11) NOT NULL AUTO_INCREMENT,
  `cmdstr` varbinary(32) NOT NULL DEFAULT '',
  `structid` int(11) NOT NULL DEFAULT '0',
  `target_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '1queue',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `unuse` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cmdid`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table netccmd
#

REPLACE INTO `netccmd` VALUES (-4,'userawarded',14,0,'用户服务器发过来的奖励',0);
REPLACE INTO `netccmd` VALUES (-3,'gmlocalcmd',15,0,'GM本地指令',0);
REPLACE INTO `netccmd` VALUES (-2,'logined',2,0,'用户服务器发送登陆信息',0);
REPLACE INTO `netccmd` VALUES (-1,'timer',-1,0,'服务器本地时间消息',0);
REPLACE INTO `netccmd` VALUES (1,'login',1,0,'请求登录',0);
REPLACE INTO `netccmd` VALUES (2,'create',6,1,'请求创建角色',0);
REPLACE INTO `netccmd` VALUES (3,'list',-1,1,'请求角色列表',0);
REPLACE INTO `netccmd` VALUES (4,'entergame',-3,1,'进入游戏',0);
REPLACE INTO `netccmd` VALUES (5,'delete',-3,0,'删除角色',0);
REPLACE INTO `netccmd` VALUES (6,'heart',10,0,'心跳',0);
REPLACE INTO `netccmd` VALUES (7,'gmcmd',12,0,'GM指令',0);
REPLACE INTO `netccmd` VALUES (9,'askinfo',16,0,'短请求信息',0);

#
# Source for table netgcmd
#

CREATE TABLE `netgcmd` (
  `cmdid` int(11) NOT NULL AUTO_INCREMENT,
  `cmdstr` varbinary(32) NOT NULL DEFAULT '',
  `structid` int(11) NOT NULL DEFAULT '0',
  `target_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '如果为1表示以队列的方式，通常为创建角色等数据操作',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `unuse` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cmdid`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table netgcmd
#


#
# Source for table netscmd
#

CREATE TABLE `netscmd` (
  `cmdid` int(11) NOT NULL AUTO_INCREMENT,
  `cmdstr` varbinary(32) NOT NULL DEFAULT '',
  `structid` int(11) NOT NULL DEFAULT '0',
  `target_type` tinyint(4) NOT NULL DEFAULT '0',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `nolua` tinyint(3) NOT NULL DEFAULT '0',
  `unuse` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cmdid`)
) ENGINE=MyISAM AUTO_INCREMENT=204 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table netscmd
#

REPLACE INTO `netscmd` VALUES (1,'login',3,0,'登录信息',0,0);
REPLACE INTO `netscmd` VALUES (2,'list',5,0,'角色列表',0,0);
REPLACE INTO `netscmd` VALUES (3,'create',7,0,'返回创建角色信息',0,0);
REPLACE INTO `netscmd` VALUES (4,'enterinfo',8,0,'进入游戏的信息',0,0);
REPLACE INTO `netscmd` VALUES (5,'delete',9,0,'删除角色',0,0);
REPLACE INTO `netscmd` VALUES (6,'heart',11,0,'心跳',0,0);
REPLACE INTO `netscmd` VALUES (7,'notify',13,0,'短消息',0,0);
REPLACE INTO `netscmd` VALUES (8,'actorinfo',29,0,'角色基本信息',0,0);
REPLACE INTO `netscmd` VALUES (9,'itemuse',31,0,'道具使用',0,0);
REPLACE INTO `netscmd` VALUES (10,'itemput',32,0,'道具放置|卸下',0,0);
REPLACE INTO `netscmd` VALUES (11,'itemsettle',33,0,'道具整理',0,0);
REPLACE INTO `netscmd` VALUES (12,'lostitem',34,0,'丢失道具',0,0);
REPLACE INTO `netscmd` VALUES (13,'getitem',35,0,'获得道具',0,0);
REPLACE INTO `netscmd` VALUES (14,'itemlist',37,0,'物品列表',0,0);
REPLACE INTO `netscmd` VALUES (15,'iteminfo',39,0,'道具信息',0,0);
REPLACE INTO `netscmd` VALUES (24,'awardinfolist',78,0,'奖励信息列表',0,0);
REPLACE INTO `netscmd` VALUES (25,'experience',79,0,'获得经验',0,0);
REPLACE INTO `netscmd` VALUES (26,'body',80,0,'体力',0,0);

#
# Source for table scsrv_c_struct
#

CREATE TABLE `scsrv_c_struct` (
  `structid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varbinary(64) NOT NULL DEFAULT '',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `limitcount` smallint(6) NOT NULL DEFAULT '0',
  `t1` tinyint(3) NOT NULL DEFAULT '0',
  `arg1` varbinary(32) NOT NULL DEFAULT '',
  `t2` tinyint(3) NOT NULL DEFAULT '0',
  `arg2` varbinary(32) NOT NULL DEFAULT '',
  `t3` tinyint(3) NOT NULL DEFAULT '0',
  `arg3` varbinary(32) NOT NULL DEFAULT '',
  `t4` tinyint(3) NOT NULL DEFAULT '0',
  `arg4` varbinary(32) NOT NULL DEFAULT '',
  `t5` tinyint(3) NOT NULL DEFAULT '0',
  `arg5` varbinary(32) NOT NULL DEFAULT '',
  `t6` tinyint(3) NOT NULL DEFAULT '0',
  `arg6` varbinary(32) NOT NULL DEFAULT '',
  `t7` tinyint(3) NOT NULL DEFAULT '0',
  `arg7` varbinary(32) NOT NULL DEFAULT '',
  `t8` tinyint(3) NOT NULL DEFAULT '0',
  `arg8` varbinary(32) NOT NULL DEFAULT '',
  `t9` tinyint(3) NOT NULL DEFAULT '0',
  `arg9` varbinary(32) NOT NULL DEFAULT '',
  `t10` tinyint(3) NOT NULL DEFAULT '0',
  `arg10` varbinary(32) NOT NULL DEFAULT '',
  `t11` tinyint(3) NOT NULL DEFAULT '0',
  `arg11` varbinary(32) NOT NULL DEFAULT '',
  `t12` tinyint(3) NOT NULL DEFAULT '0',
  `arg12` varbinary(32) NOT NULL DEFAULT '',
  `t13` tinyint(3) NOT NULL DEFAULT '0',
  `arg13` varbinary(32) NOT NULL DEFAULT '',
  `t14` tinyint(3) NOT NULL DEFAULT '0',
  `arg14` varbinary(32) NOT NULL DEFAULT '',
  `t15` tinyint(3) NOT NULL DEFAULT '0',
  `arg15` varbinary(32) NOT NULL DEFAULT '',
  `t16` tinyint(3) NOT NULL DEFAULT '0',
  `arg16` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`structid`)
) ENGINE=MyISAM AUTO_INCREMENT=227 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table scsrv_c_struct
#

REPLACE INTO `scsrv_c_struct` VALUES (1,'c_item_name','获取物品名称',0,-3,'itemkind',9,'itemname',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (2,'c_item_hasone','判断是否拥有某道具',0,-3,'actor_index',-3,'itemkind',1,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (3,'c_item_emptycount','获得空余背包个数',0,-3,'actor_index',3,'count',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (4,'c_item_lost','剥夺玩家的道具（根据物品kind）',3,-3,'actor_index',-3,'itemkind',-3,'count',-3,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (5,'c_item_lostitem','丢掉玩家物品（根据背包索引）',0,-3,'actor_index',-3,'itemoffset',-3,'count',-3,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (6,'c_item_getitem','获取物品（全参数）',0,-3,'actor_index',-3,'itemkind',-3,'count',-1,'color',-1,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (7,'c_item_get_base_ability','获取道具指定位置的属性（基础）',0,-3,'itemkind',-1,'pos',2,'ability',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (8,'c_item_get_base_value','获取道具指定位置的数值（基础）',0,-3,'itemkind',-1,'pos',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (9,'c_item_get_ability_value','根据ability获取道具value（基础+动态）',0,-3,'itemkind',-2,'ability',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (10,'c_item_set_abilityvalue_offset','根据背包索引获取物品属性',0,-3,'actor_index',-3,'item_offset',-1,'pos',-2,'ability',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (11,'c_item_get_abilityvalue_offset','根据背包索引设置物品属性',0,-3,'actor_index',-3,'item_offset',-1,'pos',2,'rtn_ability',3,'rtn_value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (12,'c_item_getinfo','获取物品信息',0,-3,'itemkind',9,'name',2,'level',1,'color',3,'price',3,'type',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (13,'c_actor_info','获得角色信息',0,-3,'actor_index',3,'actorid',3,'aclass',3,'level',9,'name',2,'language',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (14,'c_actor_notify','提示信息',2,-3,'actor_index',-9,'msg',-3,'msgid',0,'0',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (15,'c_actor_notify_value','提示信息带变量',3,-3,'actor_index',-9,'msg',-3,'msgid',-3,'value1',-3,'value2',-3,'value3',-3,'value4',-3,'value5',-3,'value6',-3,'value7',-3,'value8',-3,'value9',-3,'value10',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (16,'c_actor_add_today_char_times','添加每日信息(char)',0,-3,'actor_index',-2,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (17,'c_actor_get_today_char_times','获得每日信息(char)',0,-3,'actor_index',-2,'offset',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (18,'c_actor_set_today_char_times','设置每日信息(char)',0,-3,'actor_index',-2,'offset',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (19,'c_actor_add_today_int_times','添加每日次数(int)',0,-3,'actor_index',-2,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (20,'c_actor_get_today_int_times','获得每日次数(int)',0,-3,'actor_index',-2,'offset',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (21,'c_actor_set_today_int_times','设置每日次数(int)',0,-3,'actor_index',-2,'offset',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (22,'c_actor_set_sflag','0,1的标志操作',0,-3,'actor_index',-2,'offset',-2,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (23,'c_actor_get_sflag','0,1的标志操作',0,-3,'actor_index',-2,'offset',2,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (24,'c_actor_set_uselimit_cd','设置玩家CD限制',0,-3,'actor_index',-1,'index',-3,'cdtime',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (25,'c_actor_get_uselimit_cd','检查玩家CD限制',0,-3,'actor_index',-1,'index',3,'rtn',0,'0',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (26,'c_actor_add_week_times','周数据',0,-3,'actor_index',-3,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (27,'c_actor_get_week_times','周数据',0,-3,'actor_index',-3,'offset',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (60,'c_map_addobject','添加地图格子数据',0,-1,'type',-2,'posx',-2,'posy',-1,'unittype',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (61,'c_map_delobject','删除地图格子数据',0,-1,'type',-2,'posx',-2,'posy',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (62,'c_map_getrandpos','随机一个空白位置',0,-1,'type',2,'posx',2,'posy',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (190,'c_world_data_get','世界数据',0,-3,'id',3,'value',9,'strvalue',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (191,'c_world_data_set','世界数据',2,-3,'id',-3,'value',-9,'strvalue',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (200,'c_system_getruntime','获取开服流逝时间',0,3,'time',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (201,'c_system_getopentime','获取开服时间',0,3,'time',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (202,'c_system_getfday','获取天数',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (203,'c_system_gettoday','获取日期天',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (204,'c_system_getweek','获取日期周',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (205,'c_system_getmonth','获取日期月',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (210,'c_award_getaward','给奖励',0,-3,'actor_index',-3,'kind',-3,'count',-1,'color',-1,'path',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');

#
# Source for table scsrv_in_struct
#

CREATE TABLE `scsrv_in_struct` (
  `structid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varbinary(32) NOT NULL DEFAULT '',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `limitcount` smallint(6) NOT NULL DEFAULT '0',
  `t1` tinyint(3) NOT NULL DEFAULT '0',
  `arg1` varbinary(32) NOT NULL DEFAULT '',
  `t2` tinyint(3) NOT NULL DEFAULT '0',
  `arg2` varbinary(32) NOT NULL DEFAULT '',
  `t3` tinyint(3) NOT NULL DEFAULT '0',
  `arg3` varbinary(32) NOT NULL DEFAULT '',
  `t4` tinyint(3) NOT NULL DEFAULT '0',
  `arg4` varbinary(32) NOT NULL DEFAULT '',
  `t5` tinyint(3) NOT NULL DEFAULT '0',
  `arg5` varbinary(32) NOT NULL DEFAULT '',
  `t6` tinyint(3) NOT NULL DEFAULT '0',
  `arg6` varbinary(32) NOT NULL DEFAULT '',
  `t7` tinyint(3) NOT NULL DEFAULT '0',
  `arg7` varbinary(32) NOT NULL DEFAULT '',
  `t8` tinyint(3) NOT NULL DEFAULT '0',
  `arg8` varbinary(32) NOT NULL DEFAULT '',
  `t9` tinyint(3) NOT NULL DEFAULT '0',
  `arg9` varbinary(32) NOT NULL DEFAULT '',
  `t10` tinyint(3) NOT NULL DEFAULT '0',
  `arg10` varbinary(32) NOT NULL DEFAULT '',
  `t11` tinyint(3) NOT NULL DEFAULT '0',
  `arg11` varbinary(32) NOT NULL DEFAULT '',
  `t12` tinyint(3) NOT NULL DEFAULT '0',
  `arg12` varbinary(32) NOT NULL DEFAULT '',
  `t13` tinyint(3) NOT NULL DEFAULT '0',
  `arg13` varbinary(32) NOT NULL DEFAULT '',
  `t14` tinyint(3) NOT NULL DEFAULT '0',
  `arg14` varbinary(32) NOT NULL DEFAULT '',
  `t15` tinyint(3) NOT NULL DEFAULT '0',
  `arg15` varbinary(32) NOT NULL DEFAULT '',
  `t16` tinyint(3) NOT NULL DEFAULT '0',
  `arg16` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`structid`)
) ENGINE=MyISAM AUTO_INCREMENT=1001 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table scsrv_in_struct
#

REPLACE INTO `scsrv_in_struct` VALUES (1,'Script_Init','脚本初始化',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (2,'Script_Timer','脚本逻辑每分钟一次',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (3,'Script_Command','脚本GM命令',0,-3,'nValue1',-3,'nValue2',-3,'nValue3',-3,'nValue4',-9,'pMsg',-3,'actor_index',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (4,'Script_Exec','脚本执行',0,-3,'id',-3,'value1',-3,'value2',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (5,'Script_Hour','脚本逻辑每小时一次',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (6,'OnClockProcess','整点执行',0,-3,'hour',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (7,'ClientMsg','来自客户端的脚本请求',0,-3,'nPlayerIndex',-3,'nCmd',-3,'nValue1',-3,'nValue2',-3,'nValue3',-3,'nValue4',-9,'pMsg',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (8,'ActivityOnOpen','活动开启',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (9,'ActivityOnLogic','活动逻辑',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (10,'ActivityOnEnd','活动结束',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (11,'ActivityOnClose','活动关闭',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (12,'UseItem','使用物品',0,-3,'nPlayerIndex',-3,'nMember',-3,'nItemIndex',-3,'nItemKind',-3,'nUseNum',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (13,'OnActorIn','当角色进入游戏',0,-3,'nPlayerIndex',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (14,'OnMailReadAttach','读取附件',0,-3,'nPlayerIndex',-9,'szAttach',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (15,'TimeString','时间戳转换时间字符串',0,-3,'timestamp',9,'out',3,'len',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (16,'OnWorldMapInit','地图初始化',0,-3,'nMaxWidth',-3,'nMaxHeight',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (17,'OnWorldMapBlock','地图阻挡',0,-2,'posx',-2,'posy',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (18,'OnWorldMapBrush','刷地图',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');

#
# Source for table st_actor_conf
#

CREATE TABLE `st_actor_conf` (
  `dataid` int(11) NOT NULL AUTO_INCREMENT,
  `offset` int(11) NOT NULL DEFAULT '0',
  `name` varbinary(32) NOT NULL DEFAULT '',
  `data_type` smallint(6) NOT NULL DEFAULT '0',
  `data_count` smallint(6) NOT NULL DEFAULT '0',
  `data_size` smallint(6) NOT NULL DEFAULT '0',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `notsave` tinyint(4) NOT NULL DEFAULT '0',
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `m_fix` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dataid`)
) ENGINE=MyISAM AUTO_INCREMENT=1137 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table st_actor_conf
#

REPLACE INTO `st_actor_conf` VALUES (1,1,'actorid',-3,0,0,'角色编号',0,1,0);
REPLACE INTO `st_actor_conf` VALUES (2,2,'accountid',-3,0,0,'登陆id',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (3,3,'userid',-4,0,0,'账号编号',3,0,0);
REPLACE INTO `st_actor_conf` VALUES (4,4,'username',-1,51,0,'账号名',3,0,0);
REPLACE INTO `st_actor_conf` VALUES (5,5,'admin',-2,0,0,'管理员级别',2,0,0);
REPLACE INTO `st_actor_conf` VALUES (6,6,'lastip',-1,16,0,'上次登陆ip',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (7,7,'createtime',-3,0,0,'创建时间',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (8,8,'forbidtime',-3,0,0,'禁言时间',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (9,9,'savetime',-3,0,0,'上次保存时间',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (10,10,'isexit',-11,0,0,'是否离开游戏中',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (11,11,'fight_index',-3,0,0,'战场索引',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (12,12,'view_areaindex',-2,0,0,'当前视口的地图区域',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (13,13,'name',-1,22,0,'角色名称',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (14,14,'aclass',-1,0,0,'角色种类',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (15,15,'shape',-11,0,0,'形象',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (16,16,'level',-11,0,0,'级别',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (17,17,'exp',-3,0,0,'经验',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (18,18,'money',-3,0,0,'金钱',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (21,21,'token',-3,0,0,'钻石',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (22,22,'total_charge',-3,0,0,'总充值',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (24,24,'itemext',-11,0,0,'扩展的背包栏位数',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (25,25,'item',-102,500,0,'角色携带的道具',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (26,26,'equip',-102,10,0,'装备',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (37,37,'sflag',-3,0,0,'特定标志位',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (38,38,'fdate',-3,0,0,'刷新的日子是哪天',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (39,39,'today_char',-7,-1,128,'char类型每日次数',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (40,40,'today_int',-3,8,0,'int类型每日次数',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (41,41,'cd',-3,8,0,'通用CD时间',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (42,42,'config',-7,-1,8,'玩家配置',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (64,64,'view_lastframe',-3,0,0,'上次发送的区域信息时间',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (65,65,'subscribe_cmd',-2,8,0,'订阅的消息ID',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (80,80,'cdkey1',-3,0,0,'是否领取该批次兑换码',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (81,81,'cdkey2',-3,0,0,'是否领取该批次兑换码',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (82,82,'cdkey3',-3,0,0,'是否领取该批次兑换码',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (83,83,'cdkey4',-3,0,0,'是否领取该批次兑换码',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (122,122,'talkspeed_frame',-3,0,0,'说话延迟',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (124,124,'cdkeywait',-1,0,0,'CDKEY等待',1,0,0);

#
# Source for table st_actor_hero_conf
#

CREATE TABLE `st_actor_hero_conf` (
  `dataid` int(11) NOT NULL AUTO_INCREMENT,
  `offset` int(11) NOT NULL DEFAULT '0',
  `name` varbinary(32) NOT NULL DEFAULT '',
  `data_type` smallint(6) NOT NULL DEFAULT '0',
  `data_count` smallint(6) NOT NULL DEFAULT '0',
  `data_size` smallint(6) NOT NULL DEFAULT '0',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `notsave` tinyint(4) NOT NULL DEFAULT '0',
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `m_fix` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dataid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table st_actor_hero_conf
#

REPLACE INTO `st_actor_hero_conf` VALUES (1,1,'heroid',-4,0,0,'英雄唯一ID',0,1,0);
REPLACE INTO `st_actor_hero_conf` VALUES (2,2,'actorid',-3,0,0,'所属角色ID',0,2,0);
REPLACE INTO `st_actor_hero_conf` VALUES (3,3,'offset',-2,0,0,'索引',0,3,0);
REPLACE INTO `st_actor_hero_conf` VALUES (4,4,'kind',-2,0,0,'种类',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (5,5,'level',-2,0,0,'等级',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (6,6,'exp',-3,0,0,'经验',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (7,7,'color',-1,0,0,'品质颜色',0,0,0);

#
# Source for table st_actor_hero_conf
#

CREATE TABLE `st_actor_hero_conf` (
  `dataid` int(11) NOT NULL AUTO_INCREMENT,
  `offset` int(11) NOT NULL DEFAULT '0',
  `name` varbinary(32) NOT NULL DEFAULT '',
  `data_type` smallint(6) NOT NULL DEFAULT '0',
  `data_count` smallint(6) NOT NULL DEFAULT '0',
  `data_size` smallint(6) NOT NULL DEFAULT '0',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `notsave` tinyint(4) NOT NULL DEFAULT '0',
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `m_fix` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dataid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table st_actor_hero_conf
#

REPLACE INTO `st_actor_hero_conf` VALUES (1,1,'heroid',-4,0,0,'英雄唯一ID',0,1,0);
REPLACE INTO `st_actor_hero_conf` VALUES (2,2,'actorid',-3,0,0,'所属角色ID',0,2,0);
REPLACE INTO `st_actor_hero_conf` VALUES (3,3,'offset',-2,0,0,'索引',0,3,0);
REPLACE INTO `st_actor_hero_conf` VALUES (4,4,'kind',-2,0,0,'种类',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (5,5,'level',-2,0,0,'等级',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (6,6,'exp',-3,0,0,'经验',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (7,7,'color',-1,0,0,'品质颜色',0,0,0);

#
# Source for table st_actor_item_conf
#

CREATE TABLE `st_actor_item_conf` (
  `dataid` int(11) NOT NULL AUTO_INCREMENT,
  `offset` int(11) NOT NULL DEFAULT '0',
  `name` varbinary(32) NOT NULL DEFAULT '',
  `data_type` smallint(6) NOT NULL DEFAULT '0',
  `data_count` smallint(6) NOT NULL DEFAULT '0',
  `data_size` smallint(6) NOT NULL DEFAULT '0',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `notsave` tinyint(4) NOT NULL DEFAULT '0',
  `kind` tinyint(4) NOT NULL DEFAULT '0',
  `m_fix` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dataid`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

#
# Dumping data for table st_actor_item_conf
#

REPLACE INTO `st_actor_item_conf` VALUES (1,1,'itemid',-4,0,0,'物品id',0,1,1);
REPLACE INTO `st_actor_item_conf` VALUES (2,2,'actorid',-3,0,0,'角色ID',0,2,0);
REPLACE INTO `st_actor_item_conf` VALUES (3,3,'offset',-2,0,0,'物品所在位置',0,3,0);
REPLACE INTO `st_actor_item_conf` VALUES (4,4,'kind',-3,0,0,'物品种类',0,0,1);
REPLACE INTO `st_actor_item_conf` VALUES (5,5,'num',-2,0,0,'物品个数',0,0,1);
REPLACE INTO `st_actor_item_conf` VALUES (6,6,'ability',-2,4,0,'属性',0,0,1);
REPLACE INTO `st_actor_item_conf` VALUES (7,7,'value',-3,4,0,'属性值',0,0,1);
REPLACE INTO `st_actor_item_conf` VALUES (8,8,'color_level',-1,0,0,'颜色等级',0,0,1);

#
# Source for table struct_data
#

CREATE TABLE `struct_data` (
  `id` int(11) NOT NULL DEFAULT '0',
  `table` varchar(255) NOT NULL DEFAULT '' COMMENT '表名',
  `table_name` varchar(255) NOT NULL DEFAULT '' COMMENT '数据库表名',
  `table_struct` varchar(255) NOT NULL DEFAULT '' COMMENT '输出的结构体名',
  `load_key_dataid` tinyint(3) NOT NULL DEFAULT '0' COMMENT '读取的键，0全读，对应每个表第几个键',
  `load_get_cb` tinyint(3) NOT NULL DEFAULT '0' COMMENT '读取之前的函数回调',
  `load_end_cb` tinyint(3) NOT NULL DEFAULT '0' COMMENT '读取之后的函数回调',
  `load_cb_dataid1` tinyint(3) NOT NULL DEFAULT '0' COMMENT '回调key',
  `load_cb_dataid2` tinyint(3) NOT NULL DEFAULT '0' COMMENT '回调key',
  `save_key_dataid` tinyint(3) NOT NULL DEFAULT '0' COMMENT '存档主键，0全存',
  `save_clear` tinyint(3) NOT NULL DEFAULT '0' COMMENT '存档前是否先清数据库',
  `save_batch` int(11) NOT NULL DEFAULT '0' COMMENT '>0使用replace的批量语法',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '特殊类型，代码特殊处理一下',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

#
# Dumping data for table struct_data
#

REPLACE INTO `struct_data` VALUES (1,'st_actor_conf','actor','Actor',1,0,0,0,0,0,0,0,0);
REPLACE INTO `struct_data` VALUES (2,'st_actor_item_conf','actor_item','Item',2,1,0,2,3,0,0,0,1);
REPLACE INTO `struct_data` VALUES (3,'st_actor_hero_conf','actor_hero','Hero',2,1,0,2,3,0,0,0,1);

#
# Source for table struct_serv_data
#

CREATE TABLE `struct_serv_data` (
  `id` int(11) NOT NULL DEFAULT '0',
  `table` varchar(255) NOT NULL DEFAULT '' COMMENT '表名',
  `struct_name` varchar(255) NOT NULL DEFAULT '' COMMENT '结构体名',
  `variable_name` varchar(255) NOT NULL DEFAULT '' COMMENT '变量名',
  `skip_field1` varchar(32) NOT NULL DEFAULT '' COMMENT '跳过字段',
  `skip_field2` varchar(32) NOT NULL DEFAULT '',
  `skip_field3` varchar(32) NOT NULL DEFAULT '',
  `skip_field4` varchar(32) NOT NULL DEFAULT '',
  `fix` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;

#
# Dumping data for table struct_serv_data
#

REPLACE INTO `struct_serv_data` VALUES (1,'item','ItemKind','g_itemkind','used','','','',1);
REPLACE INTO `struct_serv_data` VALUES (2,'platinfo','PlatInfo','g_platinfo','desc','','','',0);
REPLACE INTO `struct_serv_data` VALUES (3,'upgrade','UpgradeInfo','g_upgradeinfo','','','','',0);
REPLACE INTO `struct_serv_data` VALUES (4,'paycountry','PayCountry','g_paycountry','name','','','',0);
REPLACE INTO `struct_serv_data` VALUES (5,'paygoods','PayGoods','g_paygoods','name','','','',0);

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
