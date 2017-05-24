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

REPLACE INTO `net_struct` VALUES (1,'NetC_Login','�ͻ��������¼',2,0);
REPLACE INTO `net_struct` VALUES (2,'NetU_Logined','�û����������ص�½',3,0);
REPLACE INTO `net_struct` VALUES (3,'NetS_Login','�������˷��͵�¼������ͻ���',1,0);
REPLACE INTO `net_struct` VALUES (4,'ListInfo','������ɫ���б���Ϣ',1,0);
REPLACE INTO `net_struct` VALUES (5,'NetS_List','�������˷��ͽ�ɫ�б�',1,0);
REPLACE INTO `net_struct` VALUES (6,'NetC_Create','�ͻ������󴴽���ɫ',2,0);
REPLACE INTO `net_struct` VALUES (7,'NetS_Create','���������ش�����ɫ���',1,0);
REPLACE INTO `net_struct` VALUES (8,'NetS_EnterInfo','���������ؽ�����Ϸ�����Ϣ',1,0);
REPLACE INTO `net_struct` VALUES (9,'NetS_Delete','����������ɾ����ɫ',1,0);
REPLACE INTO `net_struct` VALUES (10,'NetC_Heart','����',2,0);
REPLACE INTO `net_struct` VALUES (11,'NetS_Heart','����',1,0);
REPLACE INTO `net_struct` VALUES (12,'NetC_Gmcmd','GMָ��',2,0);
REPLACE INTO `net_struct` VALUES (13,'NetS_Notify','ͨ�ö���Ϣ',1,0);
REPLACE INTO `net_struct` VALUES (14,'NetU_UserAwarded','�û����������ضһ�����',3,0);
REPLACE INTO `net_struct` VALUES (15,'NetC_Gmlocalcmd','����GM��Ϣ',3,0);
REPLACE INTO `net_struct` VALUES (16,'NetC_AskInfo','�ͻ��˷��Ͷ�����',2,0);
REPLACE INTO `net_struct` VALUES (29,'NetS_ActorInfo','��ɫ������Ϣ',1,0);
REPLACE INTO `net_struct` VALUES (30,'Corrdinate','����',1,0);
REPLACE INTO `net_struct` VALUES (31,'NetS_ItemUse','����ʹ��|װ��',1,0);
REPLACE INTO `net_struct` VALUES (32,'NetS_ItemPut','���߷���|ж��',1,0);
REPLACE INTO `net_struct` VALUES (33,'NetS_ItemSettle','��������',1,0);
REPLACE INTO `net_struct` VALUES (34,'NetS_LostItem','��ʧ����',1,0);
REPLACE INTO `net_struct` VALUES (35,'NetS_GetItem','��õ���',1,0);
REPLACE INTO `net_struct` VALUES (36,'ItemSmpInfo','���߼�����Ϣ',1,0);
REPLACE INTO `net_struct` VALUES (37,'NetS_ItemList','�����б�',1,0);
REPLACE INTO `net_struct` VALUES (38,'ItemAttr','��������',1,0);
REPLACE INTO `net_struct` VALUES (39,'NetS_ItemInfo','������Ϣ',1,0);
REPLACE INTO `net_struct` VALUES (77,'NetS_AwardInfo','������Ϣ',1,0);
REPLACE INTO `net_struct` VALUES (78,'NetS_AwardInfoList','������Ϣ�б�',1,0);
REPLACE INTO `net_struct` VALUES (79,'NetS_Experience','�����ȡ',1,0);
REPLACE INTO `net_struct` VALUES (80,'NetS_Body','������ȡ',1,0);

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

REPLACE INTO `net_struct_conf` VALUES (1000,1,0,'username_length',-2,0,0,'�ͻ�������-�û�������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1001,1,1,'username',-1,-1,51,'�ͻ�������-�û���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1002,1,2,'password_length',-2,0,0,'�ͻ�������-���볤��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1003,1,3,'password',-1,-1,256,'�ͻ�������-����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1004,1,4,'deviceid_length',-2,0,0,'�ͻ�������-�豸��ʾ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1005,1,5,'deviceid',-1,-1,65,'�ͻ�������-�豸��ʾ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1006,1,6,'isnew',-2,0,0,'�ͻ�������-�Ƿ����û�',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1007,1,7,'ipcountry_length',-2,0,0,'�ͻ�������-IP��ַ���ڹ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (1008,1,8,'ipcountry',-1,-1,16,'�ͻ�������-IP��ַ���ڹ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2000,2,0,'result',-3,0,0,'�û�����������-��¼����ֵ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2001,2,1,'client_index',-3,0,0,'�û�����������-��ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2002,2,2,'authid',-3,0,0,'�û�����������-��֤ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2003,2,3,'userid',-1,21,0,'�û�����������-�û�ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2004,2,4,'username',-1,51,0,'�û�����������-�û���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2005,2,5,'usertype',-2,0,0,'�û�����������-�û�����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2006,2,6,'checkflag',-1,0,0,'�û�����������-�����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2007,2,7,'isdeep',-1,0,0,'�û�����������-Ҫ������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2008,2,8,'access_token',-1,65,0,'�û�����������-360���û�����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2009,2,9,'expires_in',-3,0,0,'�û�����������-360��������Ч��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2010,2,10,'refresh_token',-1,65,0,'�û�����������-360��ˢ������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (2011,2,11,'deviceid',-1,65,0,'�û�����������-���ص��豸ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3000,3,0,'result',-3,0,0,'����������-����ֵ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3001,3,1,'username_length',-2,0,0,'����������-�û�������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3002,3,2,'username',-1,-1,51,'����������-�û���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3003,3,3,'token_length',-2,0,0,'����������-token����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3004,3,4,'token',-1,-1,256,'����������-token',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (3005,3,5,'usertype',-2,0,0,'����������-�û�����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4000,4,0,'actorid',-3,0,0,'��ɫID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4001,4,1,'name',-1,22,0,'��ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4002,4,2,'aclass',-1,0,0,'��ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4003,4,3,'level',-2,0,0,'��ɫ�ȼ�',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4004,4,4,'offset',-1,0,0,'��ɫλ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4005,4,5,'lockstat',-1,0,0,'����״̬',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4006,4,6,'delete_stoptime',-3,0,0,'ɾ��ʱ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (4007,4,7,'lock_endtime',-3,0,0,'����ʱ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (5000,5,0,'actor_num',-1,0,0,'����˷���-��ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (5001,5,1,'listinfo',4,-1,8,'����˷���-��ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (6000,6,0,'aclass',-1,0,0,'�ͻ�������-�����Ľ�ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (6001,6,1,'name_length',-2,0,0,'�ͻ�������-�����Ľ�ɫ���Ƴ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (6002,6,2,'name',-1,-1,22,'�ͻ�������-�����Ľ�ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (7000,7,0,'result',-1,0,0,'����˷���-������ɫ�Ľ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (7001,7,1,'actorid',-3,0,0,'����˷���-������ɫ�ı��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (7002,7,2,'createtime',-3,0,0,'����˷���-������ɫ��ʱ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8000,8,0,'actorid',-3,0,0,'����˷���-������Ϸ��ɫID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8001,8,1,'data_int',-3,0,0,'����˷���-������Ϸ��������[����]',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8002,8,2,'data_short',-2,0,0,'����˷���-������Ϸ��������[����]',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8003,8,3,'data_char',-1,0,0,'����˷���-������Ϸ��������[����]',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8004,8,4,'serverid',-2,0,0,'����˷���-����ķ�����ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8005,8,5,'servertime',-3,0,0,'����˷���-����ķ�����ʱ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (8006,8,6,'createtime',-3,0,0,'����˷���-������ɫʱ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (9000,9,0,'result',-3,0,0,'����������-ɾ������ֵ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (9001,9,1,'actorid',-3,0,0,'����������-ɾ���Ľ�ɫ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (10000,10,0,'value',-3,2,0,'����-��ֵ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (11000,11,0,'value',-3,2,0,'����-��ֵ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (12000,12,0,'cmd',-2,0,0,'�ͻ��˷���-GMָ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (12001,12,1,'value',-3,4,0,'�ͻ��˷���-GMָ����ֵ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (12002,12,2,'msg_length',-2,0,0,'�ͻ��˷���-GMָ���ַ�������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (12003,12,3,'msg',-1,-1,256,'�ͻ��˷���-GMָ���ַ�������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13000,13,0,'msgid',-2,0,0,'����������-����ϢID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13001,13,1,'valuenum',-2,0,0,'����������-����Ϣ��������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13002,13,2,'value',-3,-1,10,'����������-����Ϣ��ֵ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13003,13,3,'msg_length',-2,0,0,'����������-����Ϣ�ַ�����Ϣ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (13004,13,4,'msg',-1,-1,256,'����������-����Ϣ�ַ�������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14000,14,0,'result',-3,0,0,'�û�����������-�һ��������ֵ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14001,14,1,'client_index',-3,0,0,'�û�����������-��ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14002,14,2,'authid',-3,0,0,'�û�����������-��֤ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14003,14,3,'cdkey_index',-2,0,0,'�û�����������-�һ���浵����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14004,14,4,'awardgroup',-3,0,0,'�û�����������-�һ��뽱����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (14005,14,5,'cardnumber',-1,32,0,'�û�����������-�һ��뿨��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (15000,15,0,'cmd',-2,0,0,'ָ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (15001,15,1,'value',-3,4,0,'��ֵ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (15002,15,2,'msglen',-2,0,0,'�ַ�������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (15003,15,3,'msg',-1,-1,1024,'�ַ�������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16000,16,0,'msgid',-2,0,0,'�ͻ��˷���-������ID',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16001,16,1,'valuenum',-2,0,0,'�ͻ��˷���-�������������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16002,16,2,'value',-3,-1,10,'�ͻ��˷���-���������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16003,16,3,'msg_length',-2,0,0,'�ͻ��˷���-�������ַ�������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (16004,16,4,'msg',-1,-1,256,'�ͻ��˷���-�������ַ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29000,29,0,'actorid',-3,0,0,'������������һ�����Ϣ-��ɫ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29001,29,1,'name',-1,22,0,'������������һ�����Ϣ-��ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29002,29,2,'aclass',-1,0,0,'������������һ�����Ϣ-��ɫ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29003,29,3,'shape',-2,0,0,'������������һ�����Ϣ-����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29004,29,4,'level',-2,0,0,'������������һ�����Ϣ-����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29005,29,5,'experience',-4,0,0,'������������һ�����Ϣ-����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29006,29,6,'experience_max',-4,0,0,'������������һ�����Ϣ-��������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29008,29,8,'token',-3,0,0,'������������һ�����Ϣ-��ʯ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (29009,29,9,'viplevel',-1,0,0,'������������һ�����Ϣ-VIP�ȼ�',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (30000,30,0,'posx',-2,0,0,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (30001,30,1,'posy',-2,0,0,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (31000,31,0,'itemoffset',-2,0,0,'��Ʒλ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (31001,31,1,'usenum',-2,0,0,'ʹ�ø�����װ��λ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (31002,31,2,'effres',-3,0,0,'Ӱ�죬һ��������Ч��ʾ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (32000,32,0,'res_offset',-2,0,0,'��ƷԴ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (32001,32,1,'res_num',-2,0,0,'��ƷԴ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (32002,32,2,'target_offset',-2,0,0,'��ƷĿ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (32003,32,3,'target_num',-2,0,0,'Ŀ�����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (33000,33,0,'itemnum',-2,0,0,'�������ĸ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (33001,33,1,'itemoffset',-2,-1,100,'���õ���Ʒλ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (34000,34,0,'itemoffset',-2,0,0,'��Ʒλ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (34001,34,1,'itemnum',-2,0,0,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (34002,34,2,'targetid',-3,0,0,'����Ķ���id',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (34003,34,3,'path',-1,0,0,';��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35000,35,0,'itemoffset',-2,0,0,'��Ʒλ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35001,35,1,'kind',-2,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35002,35,2,'type',-2,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35003,35,3,'color',-1,0,0,'��ɫ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35004,35,4,'num',-2,0,0,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35005,35,5,'targetid',-3,0,0,'����Ķ���id',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35006,35,6,'path',-1,0,0,';��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (35007,35,7,'situation',-11,0,0,'ʹ��״̬',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36000,36,0,'offset',-2,0,0,'��Ʒλ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36001,36,1,'kind',-2,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36002,36,2,'num',-2,0,0,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36003,36,3,'situation',-11,0,0,'ʹ��״̬',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (36004,36,4,'color_level',-1,0,0,'��ɫ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (37000,37,0,'itemext',-1,0,0,'��չ�ĸ���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (37001,37,1,'kindnum',-2,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (37002,37,2,'item',36,-1,300,'��Ʒ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (38000,38,0,'type',-2,0,0,'��Ʒ������������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (38001,38,1,'ability',-2,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (38002,38,2,'value',-3,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (38003,38,3,'addvalue',-3,0,0,'��Ʒ��������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39000,39,0,'itemoffset',-2,0,0,'��Ʒλ��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39001,39,1,'itemkind',-2,0,0,'װ��kind,У��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39002,39,2,'type',-2,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39003,39,3,'level',-2,0,0,'һ��ȼ�',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39004,39,4,'color_level',-1,0,0,'��ɫ�ּ�',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39005,39,5,'price',-3,0,0,'�ۼ�',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39006,39,6,'attr_num',-2,0,0,'���Ը���',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (39007,39,7,'attr',38,-1,10,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (50000,50,0,'info',44,0,0,'���µ�ͼ��ʾ��Ԫ��Ϣ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (77000,77,0,'kind',-3,0,0,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (77001,77,1,'num',-3,0,0,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (78000,78,0,'count',-2,0,0,'��������',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (78001,78,1,'list',77,-1,32,'�����б�',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (78002,78,2,'callback_code',-2,0,0,'�ĸ�ϵͳҪ��ʾ���ش�',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (79000,79,0,'addexp',-3,0,0,'�����ȡ',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (79001,79,1,'curexp',-4,0,0,'��ǰ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (79002,79,2,'isup',-1,0,0,'�Ƿ�����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (79003,79,4,'path',-2,0,0,';��',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (80000,80,0,'body',-2,0,0,'����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (80001,80,1,'addbody',-2,0,0,'��ȡ����',0,0,1);
REPLACE INTO `net_struct_conf` VALUES (80002,80,2,'path',-3,0,0,';��',0,0,1);

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

REPLACE INTO `netccmd` VALUES (-4,'userawarded',14,0,'�û��������������Ľ���',0);
REPLACE INTO `netccmd` VALUES (-3,'gmlocalcmd',15,0,'GM����ָ��',0);
REPLACE INTO `netccmd` VALUES (-2,'logined',2,0,'�û����������͵�½��Ϣ',0);
REPLACE INTO `netccmd` VALUES (-1,'timer',-1,0,'����������ʱ����Ϣ',0);
REPLACE INTO `netccmd` VALUES (1,'login',1,0,'�����¼',0);
REPLACE INTO `netccmd` VALUES (2,'create',6,1,'���󴴽���ɫ',0);
REPLACE INTO `netccmd` VALUES (3,'list',-1,1,'�����ɫ�б�',0);
REPLACE INTO `netccmd` VALUES (4,'entergame',-3,1,'������Ϸ',0);
REPLACE INTO `netccmd` VALUES (5,'delete',-3,0,'ɾ����ɫ',0);
REPLACE INTO `netccmd` VALUES (6,'heart',10,0,'����',0);
REPLACE INTO `netccmd` VALUES (7,'gmcmd',12,0,'GMָ��',0);
REPLACE INTO `netccmd` VALUES (9,'askinfo',16,0,'��������Ϣ',0);

#
# Source for table netgcmd
#

CREATE TABLE `netgcmd` (
  `cmdid` int(11) NOT NULL AUTO_INCREMENT,
  `cmdstr` varbinary(32) NOT NULL DEFAULT '',
  `structid` int(11) NOT NULL DEFAULT '0',
  `target_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '���Ϊ1��ʾ�Զ��еķ�ʽ��ͨ��Ϊ������ɫ�����ݲ���',
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

REPLACE INTO `netscmd` VALUES (1,'login',3,0,'��¼��Ϣ',0,0);
REPLACE INTO `netscmd` VALUES (2,'list',5,0,'��ɫ�б�',0,0);
REPLACE INTO `netscmd` VALUES (3,'create',7,0,'���ش�����ɫ��Ϣ',0,0);
REPLACE INTO `netscmd` VALUES (4,'enterinfo',8,0,'������Ϸ����Ϣ',0,0);
REPLACE INTO `netscmd` VALUES (5,'delete',9,0,'ɾ����ɫ',0,0);
REPLACE INTO `netscmd` VALUES (6,'heart',11,0,'����',0,0);
REPLACE INTO `netscmd` VALUES (7,'notify',13,0,'����Ϣ',0,0);
REPLACE INTO `netscmd` VALUES (8,'actorinfo',29,0,'��ɫ������Ϣ',0,0);
REPLACE INTO `netscmd` VALUES (9,'itemuse',31,0,'����ʹ��',0,0);
REPLACE INTO `netscmd` VALUES (10,'itemput',32,0,'���߷���|ж��',0,0);
REPLACE INTO `netscmd` VALUES (11,'itemsettle',33,0,'��������',0,0);
REPLACE INTO `netscmd` VALUES (12,'lostitem',34,0,'��ʧ����',0,0);
REPLACE INTO `netscmd` VALUES (13,'getitem',35,0,'��õ���',0,0);
REPLACE INTO `netscmd` VALUES (14,'itemlist',37,0,'��Ʒ�б�',0,0);
REPLACE INTO `netscmd` VALUES (15,'iteminfo',39,0,'������Ϣ',0,0);
REPLACE INTO `netscmd` VALUES (24,'awardinfolist',78,0,'������Ϣ�б�',0,0);
REPLACE INTO `netscmd` VALUES (25,'experience',79,0,'��þ���',0,0);
REPLACE INTO `netscmd` VALUES (26,'body',80,0,'����',0,0);

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

REPLACE INTO `scsrv_c_struct` VALUES (1,'c_item_name','��ȡ��Ʒ����',0,-3,'itemkind',9,'itemname',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (2,'c_item_hasone','�ж��Ƿ�ӵ��ĳ����',0,-3,'actor_index',-3,'itemkind',1,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (3,'c_item_emptycount','��ÿ��౳������',0,-3,'actor_index',3,'count',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (4,'c_item_lost','������ҵĵ��ߣ�������Ʒkind��',3,-3,'actor_index',-3,'itemkind',-3,'count',-3,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (5,'c_item_lostitem','���������Ʒ�����ݱ���������',0,-3,'actor_index',-3,'itemoffset',-3,'count',-3,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (6,'c_item_getitem','��ȡ��Ʒ��ȫ������',0,-3,'actor_index',-3,'itemkind',-3,'count',-1,'color',-1,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (7,'c_item_get_base_ability','��ȡ����ָ��λ�õ����ԣ�������',0,-3,'itemkind',-1,'pos',2,'ability',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (8,'c_item_get_base_value','��ȡ����ָ��λ�õ���ֵ��������',0,-3,'itemkind',-1,'pos',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (9,'c_item_get_ability_value','����ability��ȡ����value������+��̬��',0,-3,'itemkind',-2,'ability',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (10,'c_item_set_abilityvalue_offset','���ݱ���������ȡ��Ʒ����',0,-3,'actor_index',-3,'item_offset',-1,'pos',-2,'ability',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (11,'c_item_get_abilityvalue_offset','���ݱ�������������Ʒ����',0,-3,'actor_index',-3,'item_offset',-1,'pos',2,'rtn_ability',3,'rtn_value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (12,'c_item_getinfo','��ȡ��Ʒ��Ϣ',0,-3,'itemkind',9,'name',2,'level',1,'color',3,'price',3,'type',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (13,'c_actor_info','��ý�ɫ��Ϣ',0,-3,'actor_index',3,'actorid',3,'aclass',3,'level',9,'name',2,'language',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (14,'c_actor_notify','��ʾ��Ϣ',2,-3,'actor_index',-9,'msg',-3,'msgid',0,'0',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (15,'c_actor_notify_value','��ʾ��Ϣ������',3,-3,'actor_index',-9,'msg',-3,'msgid',-3,'value1',-3,'value2',-3,'value3',-3,'value4',-3,'value5',-3,'value6',-3,'value7',-3,'value8',-3,'value9',-3,'value10',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (16,'c_actor_add_today_char_times','���ÿ����Ϣ(char)',0,-3,'actor_index',-2,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (17,'c_actor_get_today_char_times','���ÿ����Ϣ(char)',0,-3,'actor_index',-2,'offset',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (18,'c_actor_set_today_char_times','����ÿ����Ϣ(char)',0,-3,'actor_index',-2,'offset',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (19,'c_actor_add_today_int_times','���ÿ�մ���(int)',0,-3,'actor_index',-2,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (20,'c_actor_get_today_int_times','���ÿ�մ���(int)',0,-3,'actor_index',-2,'offset',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (21,'c_actor_set_today_int_times','����ÿ�մ���(int)',0,-3,'actor_index',-2,'offset',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (22,'c_actor_set_sflag','0,1�ı�־����',0,-3,'actor_index',-2,'offset',-2,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (23,'c_actor_get_sflag','0,1�ı�־����',0,-3,'actor_index',-2,'offset',2,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (24,'c_actor_set_uselimit_cd','�������CD����',0,-3,'actor_index',-1,'index',-3,'cdtime',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (25,'c_actor_get_uselimit_cd','������CD����',0,-3,'actor_index',-1,'index',3,'rtn',0,'0',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (26,'c_actor_add_week_times','������',0,-3,'actor_index',-3,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (27,'c_actor_get_week_times','������',0,-3,'actor_index',-3,'offset',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_c_struct` VALUES (60,'c_map_addobject','��ӵ�ͼ��������',0,-1,'type',-2,'posx',-2,'posy',-1,'unittype',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (61,'c_map_delobject','ɾ����ͼ��������',0,-1,'type',-2,'posx',-2,'posy',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (62,'c_map_getrandpos','���һ���հ�λ��',0,-1,'type',2,'posx',2,'posy',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (190,'c_world_data_get','��������',0,-3,'id',3,'value',9,'strvalue',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (191,'c_world_data_set','��������',2,-3,'id',-3,'value',-9,'strvalue',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (200,'c_system_getruntime','��ȡ��������ʱ��',0,3,'time',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (201,'c_system_getopentime','��ȡ����ʱ��',0,3,'time',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (202,'c_system_getfday','��ȡ����',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (203,'c_system_gettoday','��ȡ������',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (204,'c_system_getweek','��ȡ������',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (205,'c_system_getmonth','��ȡ������',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_c_struct` VALUES (210,'c_award_getaward','������',0,-3,'actor_index',-3,'kind',-3,'count',-1,'color',-1,'path',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');

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

REPLACE INTO `scsrv_in_struct` VALUES (1,'Script_Init','�ű���ʼ��',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (2,'Script_Timer','�ű��߼�ÿ����һ��',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (3,'Script_Command','�ű�GM����',0,-3,'nValue1',-3,'nValue2',-3,'nValue3',-3,'nValue4',-9,'pMsg',-3,'actor_index',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (4,'Script_Exec','�ű�ִ��',0,-3,'id',-3,'value1',-3,'value2',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (5,'Script_Hour','�ű��߼�ÿСʱһ��',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (6,'OnClockProcess','����ִ��',0,-3,'hour',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (7,'ClientMsg','���Կͻ��˵Ľű�����',0,-3,'nPlayerIndex',-3,'nCmd',-3,'nValue1',-3,'nValue2',-3,'nValue3',-3,'nValue4',-9,'pMsg',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (8,'ActivityOnOpen','�����',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (9,'ActivityOnLogic','��߼�',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (10,'ActivityOnEnd','�����',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (11,'ActivityOnClose','��ر�',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (12,'UseItem','ʹ����Ʒ',0,-3,'nPlayerIndex',-3,'nMember',-3,'nItemIndex',-3,'nItemKind',-3,'nUseNum',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (13,'OnActorIn','����ɫ������Ϸ',0,-3,'nPlayerIndex',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
REPLACE INTO `scsrv_in_struct` VALUES (14,'OnMailReadAttach','��ȡ����',0,-3,'nPlayerIndex',-9,'szAttach',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (15,'TimeString','ʱ���ת��ʱ���ַ���',0,-3,'timestamp',9,'out',3,'len',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (16,'OnWorldMapInit','��ͼ��ʼ��',0,-3,'nMaxWidth',-3,'nMaxHeight',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (17,'OnWorldMapBlock','��ͼ�赲',0,-2,'posx',-2,'posy',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
REPLACE INTO `scsrv_in_struct` VALUES (18,'OnWorldMapBrush','ˢ��ͼ',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');

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

REPLACE INTO `st_actor_conf` VALUES (1,1,'actorid',-3,0,0,'��ɫ���',0,1,0);
REPLACE INTO `st_actor_conf` VALUES (2,2,'accountid',-3,0,0,'��½id',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (3,3,'userid',-4,0,0,'�˺ű��',3,0,0);
REPLACE INTO `st_actor_conf` VALUES (4,4,'username',-1,51,0,'�˺���',3,0,0);
REPLACE INTO `st_actor_conf` VALUES (5,5,'admin',-2,0,0,'����Ա����',2,0,0);
REPLACE INTO `st_actor_conf` VALUES (6,6,'lastip',-1,16,0,'�ϴε�½ip',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (7,7,'createtime',-3,0,0,'����ʱ��',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (8,8,'forbidtime',-3,0,0,'����ʱ��',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (9,9,'savetime',-3,0,0,'�ϴα���ʱ��',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (10,10,'isexit',-11,0,0,'�Ƿ��뿪��Ϸ��',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (11,11,'fight_index',-3,0,0,'ս������',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (12,12,'view_areaindex',-2,0,0,'��ǰ�ӿڵĵ�ͼ����',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (13,13,'name',-1,22,0,'��ɫ����',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (14,14,'aclass',-1,0,0,'��ɫ����',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (15,15,'shape',-11,0,0,'����',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (16,16,'level',-11,0,0,'����',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (17,17,'exp',-3,0,0,'����',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (18,18,'money',-3,0,0,'��Ǯ',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (21,21,'token',-3,0,0,'��ʯ',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (22,22,'total_charge',-3,0,0,'�ܳ�ֵ',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (24,24,'itemext',-11,0,0,'��չ�ı�����λ��',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (25,25,'item',-102,500,0,'��ɫЯ���ĵ���',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (26,26,'equip',-102,10,0,'װ��',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (37,37,'sflag',-3,0,0,'�ض���־λ',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (38,38,'fdate',-3,0,0,'ˢ�µ�����������',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (39,39,'today_char',-7,-1,128,'char����ÿ�մ���',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (40,40,'today_int',-3,8,0,'int����ÿ�մ���',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (41,41,'cd',-3,8,0,'ͨ��CDʱ��',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (42,42,'config',-7,-1,8,'�������',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (64,64,'view_lastframe',-3,0,0,'�ϴη��͵�������Ϣʱ��',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (65,65,'subscribe_cmd',-2,8,0,'���ĵ���ϢID',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (80,80,'cdkey1',-3,0,0,'�Ƿ���ȡ�����ζһ���',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (81,81,'cdkey2',-3,0,0,'�Ƿ���ȡ�����ζһ���',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (82,82,'cdkey3',-3,0,0,'�Ƿ���ȡ�����ζһ���',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (83,83,'cdkey4',-3,0,0,'�Ƿ���ȡ�����ζһ���',0,0,0);
REPLACE INTO `st_actor_conf` VALUES (122,122,'talkspeed_frame',-3,0,0,'˵���ӳ�',1,0,0);
REPLACE INTO `st_actor_conf` VALUES (124,124,'cdkeywait',-1,0,0,'CDKEY�ȴ�',1,0,0);

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

REPLACE INTO `st_actor_hero_conf` VALUES (1,1,'heroid',-4,0,0,'Ӣ��ΨһID',0,1,0);
REPLACE INTO `st_actor_hero_conf` VALUES (2,2,'actorid',-3,0,0,'������ɫID',0,2,0);
REPLACE INTO `st_actor_hero_conf` VALUES (3,3,'offset',-2,0,0,'����',0,3,0);
REPLACE INTO `st_actor_hero_conf` VALUES (4,4,'kind',-2,0,0,'����',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (5,5,'level',-2,0,0,'�ȼ�',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (6,6,'exp',-3,0,0,'����',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (7,7,'color',-1,0,0,'Ʒ����ɫ',0,0,0);

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

REPLACE INTO `st_actor_hero_conf` VALUES (1,1,'heroid',-4,0,0,'Ӣ��ΨһID',0,1,0);
REPLACE INTO `st_actor_hero_conf` VALUES (2,2,'actorid',-3,0,0,'������ɫID',0,2,0);
REPLACE INTO `st_actor_hero_conf` VALUES (3,3,'offset',-2,0,0,'����',0,3,0);
REPLACE INTO `st_actor_hero_conf` VALUES (4,4,'kind',-2,0,0,'����',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (5,5,'level',-2,0,0,'�ȼ�',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (6,6,'exp',-3,0,0,'����',0,0,0);
REPLACE INTO `st_actor_hero_conf` VALUES (7,7,'color',-1,0,0,'Ʒ����ɫ',0,0,0);

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

REPLACE INTO `st_actor_item_conf` VALUES (1,1,'itemid',-4,0,0,'��Ʒid',0,1,1);
REPLACE INTO `st_actor_item_conf` VALUES (2,2,'actorid',-3,0,0,'��ɫID',0,2,0);
REPLACE INTO `st_actor_item_conf` VALUES (3,3,'offset',-2,0,0,'��Ʒ����λ��',0,3,0);
REPLACE INTO `st_actor_item_conf` VALUES (4,4,'kind',-3,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `st_actor_item_conf` VALUES (5,5,'num',-2,0,0,'��Ʒ����',0,0,1);
REPLACE INTO `st_actor_item_conf` VALUES (6,6,'ability',-2,4,0,'����',0,0,1);
REPLACE INTO `st_actor_item_conf` VALUES (7,7,'value',-3,4,0,'����ֵ',0,0,1);
REPLACE INTO `st_actor_item_conf` VALUES (8,8,'color_level',-1,0,0,'��ɫ�ȼ�',0,0,1);

#
# Source for table struct_data
#

CREATE TABLE `struct_data` (
  `id` int(11) NOT NULL DEFAULT '0',
  `table` varchar(255) NOT NULL DEFAULT '' COMMENT '����',
  `table_name` varchar(255) NOT NULL DEFAULT '' COMMENT '���ݿ����',
  `table_struct` varchar(255) NOT NULL DEFAULT '' COMMENT '����Ľṹ����',
  `load_key_dataid` tinyint(3) NOT NULL DEFAULT '0' COMMENT '��ȡ�ļ���0ȫ������Ӧÿ����ڼ�����',
  `load_get_cb` tinyint(3) NOT NULL DEFAULT '0' COMMENT '��ȡ֮ǰ�ĺ����ص�',
  `load_end_cb` tinyint(3) NOT NULL DEFAULT '0' COMMENT '��ȡ֮��ĺ����ص�',
  `load_cb_dataid1` tinyint(3) NOT NULL DEFAULT '0' COMMENT '�ص�key',
  `load_cb_dataid2` tinyint(3) NOT NULL DEFAULT '0' COMMENT '�ص�key',
  `save_key_dataid` tinyint(3) NOT NULL DEFAULT '0' COMMENT '�浵������0ȫ��',
  `save_clear` tinyint(3) NOT NULL DEFAULT '0' COMMENT '�浵ǰ�Ƿ��������ݿ�',
  `save_batch` int(11) NOT NULL DEFAULT '0' COMMENT '>0ʹ��replace�������﷨',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '�������ͣ��������⴦��һ��',
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
  `table` varchar(255) NOT NULL DEFAULT '' COMMENT '����',
  `struct_name` varchar(255) NOT NULL DEFAULT '' COMMENT '�ṹ����',
  `variable_name` varchar(255) NOT NULL DEFAULT '' COMMENT '������',
  `skip_field1` varchar(32) NOT NULL DEFAULT '' COMMENT '�����ֶ�',
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
