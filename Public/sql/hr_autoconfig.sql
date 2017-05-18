-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: 192.168.197.129    Database: war_autoconfig
-- ------------------------------------------------------
-- Server version	5.6.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES gbk */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `net_struct`
--

DROP TABLE IF EXISTS `net_struct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `net_struct` (
  `structid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varbinary(32) NOT NULL DEFAULT '',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `struct_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '1是服务器,2是客户端,3是特殊处理logined',
  `sortindex` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`structid`)
) ENGINE=MyISAM AUTO_INCREMENT=1828 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `net_struct`
--

LOCK TABLES `net_struct` WRITE;
/*!40000 ALTER TABLE `net_struct` DISABLE KEYS */;
INSERT INTO `net_struct` VALUES (1,'NetC_Login','�ͻ��������¼',2,0),(2,'NetU_Logined','�û����������ص�½',3,0),(3,'NetS_Login','�������˷��͵�¼������ͻ���',1,0),(4,'ListInfo','������ɫ���б���Ϣ',1,0),(5,'NetS_List','�������˷��ͽ�ɫ�б�',1,0),(6,'NetC_Create','�ͻ������󴴽���ɫ',2,0),(7,'NetS_Create','���������ش�����ɫ���',1,0),(8,'NetS_EnterInfo','���������ؽ�����Ϸ�����Ϣ',1,0),(9,'NetS_Delete','����������ɾ����ɫ',1,0),(10,'NetC_Heart','����',2,0),(11,'NetS_Heart','����',1,0),(12,'NetC_Gmcmd','GMָ��',2,0),(13,'NetS_Notify','ͨ�ö���Ϣ',1,0),(16,'NetC_AskInfo','�ͻ��˷��Ͷ�����',2,0),(29,'NetS_ActorInfo','��ɫ������Ϣ',1,0),(30,'Corrdinate','����',1,0),(31,'NetS_ItemUse','����ʹ��|װ��',1,0),(32,'NetS_ItemPut','���߷���|ж��',1,0),(33,'NetS_ItemSettle','��������',1,0),(34,'NetS_LostItem','��ʧ����',1,0),(35,'NetS_GetItem','��õ���',1,0),(36,'ItemSmpInfo','���߼�����Ϣ',1,0),(37,'NetS_ItemList','�����б�',1,0),(38,'ItemAttr','��������',1,0),(39,'NetS_ItemInfo','������Ϣ',1,0),(44,'NetS_AddMapUnit','��ʾ��Ԫ�����ͼ',1,0),(45,'NetS_DelMapUnit','��ʾ��Ԫ�뿪��ͼ',1,0),(46,'NetS_WorldMapInfo','�����ͼ��Ϣ',1,0),(47,'NetS_MapUnitCorrdinate','��ͼ��ʾ��Ԫλ��',1,0),(48,'NetS_AddMarchRoute','�о�·��',1,0),(49,'NetS_DelMarchRoute','ɾ���о�·��',1,0),(15,'NetC_Gmlocalcmd','����GM��Ϣ',3,0),(40,'WalkPath','�ƶ�·��',1,0),(77,'NetS_AwardInfo','������Ϣ',1,0),(78,'NetS_AwardInfoList','������Ϣ�б�',1,0),(79,'NetS_Experience','�����ȡ',1,0),(80,'NetS_Body','������ȡ',1,0),(50,'NetS_UpdateMapUnit','���µ�ͼ��ʾ��Ԫ��Ϣ',1,0),(14,'NetU_UserAwarded','�û����������ضһ�����',3,0);
/*!40000 ALTER TABLE `net_struct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `net_struct_conf`
--

DROP TABLE IF EXISTS `net_struct_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `net_struct_conf`
--

LOCK TABLES `net_struct_conf` WRITE;
/*!40000 ALTER TABLE `net_struct_conf` DISABLE KEYS */;
INSERT INTO `net_struct_conf` VALUES (1000,1,0,'username_length',-2,0,0,'�ͻ�������-�û�������',0,0,1),(1001,1,1,'username',-1,-1,51,'�ͻ�������-�û���',0,0,1),(1002,1,2,'password_length',-2,0,0,'�ͻ�������-���볤��',0,0,1),(1003,1,3,'password',-1,-1,256,'�ͻ�������-����',0,0,1),(1004,1,4,'deviceid_length',-2,0,0,'�ͻ�������-�豸��ʾ����',0,0,1),(1005,1,5,'deviceid',-1,-1,65,'�ͻ�������-�豸��ʾ',0,0,1),(1006,1,6,'isnew',-2,0,0,'�ͻ�������-�Ƿ����û�',0,0,1),(1007,1,7,'ipcountry_length',-2,0,0,'�ͻ�������-IP��ַ���ڹ���',0,0,1),(1008,1,8,'ipcountry',-1,-1,16,'�ͻ�������-IP��ַ���ڹ���',0,0,1),(2000,2,0,'result',-3,0,0,'�û�����������-��¼����ֵ',0,0,1),(2001,2,1,'client_index',-3,0,0,'�û�����������-��ɫ����',0,0,1),(2002,2,2,'authid',-3,0,0,'�û�����������-��֤ID',0,0,1),(2003,2,3,'userid',-1,21,0,'�û�����������-�û�ID',0,0,1),(2004,2,4,'username',-1,51,0,'�û�����������-�û���',0,0,1),(2005,2,5,'usertype',-2,0,0,'�û�����������-�û�����',0,0,1),(2006,2,6,'checkflag',-1,0,0,'�û�����������-�����',0,0,1),(2007,2,7,'isdeep',-1,0,0,'�û�����������-Ҫ������',0,0,1),(2008,2,8,'access_token',-1,65,0,'�û�����������-360���û�����',0,0,1),(2009,2,9,'expires_in',-3,0,0,'�û�����������-360��������Ч��',0,0,1),(2010,2,10,'refresh_token',-1,65,0,'�û�����������-360��ˢ������',0,0,1),(2011,2,11,'deviceid',-1,65,0,'�û�����������-���ص��豸ID',0,0,1),(3000,3,0,'result',-3,0,0,'����������-����ֵ',0,0,1),(3001,3,1,'username_length',-2,0,0,'����������-�û�������',0,0,1),(3002,3,2,'username',-1,-1,51,'����������-�û���',0,0,1),(3003,3,3,'token_length',-2,0,0,'����������-token����',0,0,1),(3004,3,4,'token',-1,-1,256,'����������-token',0,0,1),(3005,3,5,'usertype',-2,0,0,'����������-�û�����',0,0,1),(4000,4,0,'actorid',-3,0,0,'��ɫID',0,0,1),(4001,4,1,'name',-1,22,0,'��ɫ����',0,0,1),(4002,4,2,'aclass',-1,0,0,'��ɫ����',0,0,1),(4003,4,3,'level',-2,0,0,'��ɫ�ȼ�',0,0,1),(4004,4,4,'offset',-1,0,0,'��ɫλ��',0,0,1),(4005,4,5,'lockstat',-1,0,0,'����״̬',0,0,1),(4006,4,6,'delete_stoptime',-3,0,0,'ɾ��ʱ��',0,0,1),(4007,4,7,'lock_endtime',-3,0,0,'����ʱ��',0,0,1),(5000,5,0,'actor_num',-1,0,0,'����˷���-��ɫ����',0,0,1),(5001,5,1,'listinfo',4,-1,8,'����˷���-��ɫ����',0,0,1),(6000,6,0,'aclass',-1,0,0,'�ͻ�������-�����Ľ�ɫ����',0,0,1),(6001,6,1,'name_length',-2,0,0,'�ͻ�������-�����Ľ�ɫ���Ƴ���',0,0,1),(6002,6,2,'name',-1,-1,22,'�ͻ�������-�����Ľ�ɫ����',0,0,1),(7000,7,0,'result',-1,0,0,'����˷���-������ɫ�Ľ��',0,0,1),(7001,7,1,'actorid',-3,0,0,'����˷���-������ɫ�ı��',0,0,1),(7002,7,2,'createtime',-3,0,0,'����˷���-������ɫ��ʱ��',0,0,1),(8000,8,0,'actorid',-3,0,0,'����˷���-������Ϸ��ɫID',0,0,1),(8001,8,1,'data_int',-3,0,0,'����˷���-������Ϸ��������[����]',0,0,1),(8002,8,2,'data_short',-2,0,0,'����˷���-������Ϸ��������[����]',0,0,1),(8003,8,3,'data_char',-1,0,0,'����˷���-������Ϸ��������[����]',0,0,1),(8004,8,4,'serverid',-2,0,0,'����˷���-����ķ�����ID',0,0,1),(8005,8,5,'servertime',-3,0,0,'����˷���-����ķ�����ʱ���',0,0,1),(8006,8,6,'createtime',-3,0,0,'����˷���-������ɫʱ��',0,0,1),(9000,9,0,'result',-3,0,0,'����������-ɾ������ֵ',0,0,1),(9001,9,1,'actorid',-3,0,0,'����������-ɾ���Ľ�ɫ���',0,0,1),(10000,10,0,'value',-3,2,0,'����-��ֵ',0,0,1),(11000,11,0,'value',-3,2,0,'����-��ֵ',0,0,1),(12000,12,0,'cmd',-2,0,0,'�ͻ��˷���-GMָ��',0,0,1),(12001,12,1,'value',-3,4,0,'�ͻ��˷���-GMָ����ֵ����',0,0,1),(12002,12,2,'msg_length',-2,0,0,'�ͻ��˷���-GMָ���ַ�������',0,0,1),(12003,12,3,'msg',-1,-1,256,'�ͻ��˷���-GMָ���ַ�������',0,0,1),(13000,13,0,'msgid',-2,0,0,'����������-����ϢID',0,0,1),(13001,13,1,'valuenum',-2,0,0,'����������-����Ϣ��������',0,0,1),(13002,13,2,'value',-3,-1,10,'����������-����Ϣ��ֵ����',0,0,1),(13003,13,3,'msg_length',-2,0,0,'����������-����Ϣ�ַ�����Ϣ����',0,0,1),(13004,13,4,'msg',-1,-1,256,'����������-����Ϣ�ַ�������',0,0,1),(40002,40,2,'len',-2,0,0,'·����ṹ',0,0,1),(79000,79,0,'addexp',-3,0,0,'',0,0,1),(79001,79,1,'curexp',-4,0,0,'',0,0,1),(79002,79,2,'isup',-1,0,0,'',0,0,1),(79003,79,4,'path',-2,0,0,'',0,0,1),(16000,16,0,'msgid',-2,0,0,'�ͻ��˷���-������ID',0,0,1),(16001,16,1,'valuenum',-2,0,0,'�ͻ��˷���-�������������',0,0,1),(16002,16,2,'value',-3,-1,10,'�ͻ��˷���-���������',0,0,1),(16003,16,3,'msg_length',-2,0,0,'�ͻ��˷���-�������ַ�������',0,0,1),(16004,16,4,'msg',-1,-1,256,'�ͻ��˷���-�������ַ���',0,0,1),(29000,29,0,'actorid',-3,0,0,'������������һ�����Ϣ-��ɫ���',0,0,1),(29001,29,1,'name',-1,22,0,'������������һ�����Ϣ-��ɫ����',0,0,1),(29002,29,2,'aclass',-1,0,0,'������������һ�����Ϣ-��ɫ����',0,0,1),(29003,29,3,'shape',-2,0,0,'������������һ�����Ϣ-����',0,0,1),(29004,29,4,'level',-2,0,0,'������������һ�����Ϣ-����',0,0,1),(29005,29,5,'experience',-4,0,0,'������������һ�����Ϣ-����',0,0,1),(29006,29,6,'experience_max',-4,0,0,'������������һ�����Ϣ-��������',0,0,1),(29008,29,8,'token',-3,0,0,'������������һ�����Ϣ-��ʯ',0,0,1),(29009,29,9,'viplevel',-1,0,0,'������������һ�����Ϣ-VIP�ȼ�',0,0,1),(30000,30,0,'posx',-2,0,0,'����',0,0,1),(30001,30,1,'posy',-2,0,0,'����',0,0,1),(31000,31,0,'itemoffset',-2,0,0,'��Ʒλ��',0,0,1),(31001,31,1,'usenum',-2,0,0,'ʹ�ø�����װ��λ��',0,0,1),(31002,31,2,'effres',-3,0,0,'Ӱ�죬һ��������Ч��ʾ',0,0,1),(32000,32,0,'res_offset',-2,0,0,'��ƷԴ',0,0,1),(32001,32,1,'res_num',-2,0,0,'��ƷԴ����',0,0,1),(32002,32,2,'target_offset',-2,0,0,'��ƷĿ��',0,0,1),(32003,32,3,'target_num',-2,0,0,'Ŀ�����',0,0,1),(33000,33,0,'itemnum',-2,0,0,'�������ĸ���',0,0,1),(33001,33,1,'itemoffset',-2,-1,100,'���õ���Ʒλ��',0,0,1),(34000,34,0,'itemoffset',-2,0,0,'��Ʒλ��',0,0,1),(34001,34,1,'itemnum',-2,0,0,'����',0,0,1),(34002,34,2,'targetid',-3,0,0,'����Ķ���id',0,0,1),(34003,34,3,'path',-1,0,0,';��',0,0,1),(35000,35,0,'itemoffset',-2,0,0,'��Ʒλ��',0,0,1),(35001,35,1,'kind',-2,0,0,'��Ʒ����',0,0,1),(35002,35,2,'type',-2,0,0,'��Ʒ����',0,0,1),(35003,35,3,'color',-1,0,0,'��ɫ',0,0,1),(35004,35,4,'num',-2,0,0,'����',0,0,1),(35005,35,5,'targetid',-3,0,0,'����Ķ���id',0,0,1),(35006,35,6,'path',-1,0,0,';��',0,0,1),(35007,35,7,'situation',-11,0,0,'ʹ��״̬',0,0,1),(36000,36,0,'offset',-2,0,0,'��Ʒλ��',0,0,1),(36001,36,1,'kind',-2,0,0,'��Ʒ����',0,0,1),(36002,36,2,'num',-2,0,0,'����',0,0,1),(36003,36,3,'situation',-11,0,0,'ʹ��״̬',0,0,1),(36004,36,4,'color_level',-1,0,0,'��ɫ',0,0,1),(37000,37,0,'itemext',-1,0,0,'��չ�ĸ���',0,0,1),(37001,37,1,'kindnum',-2,0,0,'��Ʒ����',0,0,1),(37002,37,2,'item',36,-1,300,'��Ʒ',0,0,1),(38000,38,0,'type',-2,0,0,'��Ʒ������������',0,0,1),(38001,38,1,'ability',-2,0,0,'��Ʒ����',0,0,1),(38002,38,2,'value',-3,0,0,'��Ʒ����',0,0,1),(38003,38,3,'addvalue',-3,0,0,'��Ʒ��������',0,0,1),(39000,39,0,'itemoffset',-2,0,0,'��Ʒλ��',0,0,1),(39001,39,1,'itemkind',-2,0,0,'װ��kind,У��',0,0,1),(39002,39,2,'type',-2,0,0,'��Ʒ����',0,0,1),(39003,39,3,'level',-2,0,0,'һ��ȼ�',0,0,1),(39004,39,4,'color_level',-1,0,0,'��ɫ�ּ�',0,0,1),(39005,39,5,'price',-3,0,0,'�ۼ�',0,0,1),(39006,39,6,'attr_num',-2,0,0,'���Ը���',0,0,1),(39007,39,7,'attr',38,-1,10,'����',0,0,1),(44000,44,4,'unit_index',-3,0,0,'��ͼ��Ԫ-���',0,0,1),(44001,44,1,'type',-1,0,0,'��ͼ��Ԫ-����',0,0,1),(44002,44,2,'state',-1,0,0,'��ͼ��Ԫ-״̬',0,0,1),(44003,44,3,'posx',-2,0,0,'��ͼ��Ԫ-��ǰ����',0,0,1),(44004,44,4,'posy',-2,0,0,'��ͼ��Ԫ-��ǰ����',0,0,1),(44005,44,5,'namelen',-1,0,0,'��ͼ��Ԫ-���Ƴ���',0,0,1),(44006,44,6,'name',-1,-1,32,'��ͼ��Ԫ-����',0,0,1),(44007,44,7,'char_value_count',-1,0,0,'��ͼ��Ԫ-ͨ���ֶγ���',0,0,1),(44008,44,8,'char_value',-7,-1,16,'��ͼ��Ԫ-ͨ���ֶ�',0,0,1),(44009,44,9,'short_value_count',-1,0,0,'��ͼ��Ԫ-ͨ���ֶγ���',0,0,1),(44010,44,10,'short_value',-2,-1,8,'��ͼ��Ԫ-ͨ���ֶ�',0,0,1),(44011,44,11,'int_value_count',-1,0,0,'��ͼ��Ԫ-ͨ���ֶγ���',0,0,1),(44012,44,12,'int_value',-3,-1,8,'��ͼ��Ԫ-ͨ���ֶ�',0,0,1),(44013,44,13,'prefixlen',-1,0,0,'��ͼ��Ԫ-�ƺų���',0,0,1),(44014,44,14,'prefix',-1,-1,22,'��ͼ��Ԫ-�ƺ�',0,0,1),(45000,45,0,'unit_index',-3,0,0,'��ͼ��Ԫ-���',0,0,1),(46000,46,0,'map_width',-2,0,0,'�����ͼ��С����������',0,0,1),(46001,46,1,'map_height',-2,0,0,'�����ͼ��С����������',0,0,1),(46002,46,2,'area_width',-1,0,0,'�����С��һ�����򼸸���ͼ���ӣ�',0,0,1),(46003,46,3,'area_height',-1,0,0,'�����С��һ�����򼸸���ͼ���ӣ�',0,0,1),(46004,46,4,'map_area_xnum',-2,0,0,'һ����ͼ�ж�������',0,0,1),(46005,46,5,'map_area_ynum',-2,0,0,'һ����ͼ�ж�������',0,0,1),(46006,46,6,'my_city_posx',-2,0,0,'�ҵĳǳ�λ��',0,0,1),(46007,46,7,'my_city_posy',-2,0,0,'�ҵĳǳ�λ��',0,0,1),(46008,46,8,'my_city_unit_index',-3,0,0,'�ҵĳǳص�ͼ��Ԫ-���',0,0,1),(46010,46,10,'citystate',-1,0,0,'�ҵĳǳ�״̬',0,0,1),(46011,46,11,'target_posx',-2,0,0,'Ŀ�ĵ�',0,0,1),(46012,46,12,'target_posy',-2,0,0,'Ŀ�ĵ�',0,0,1),(47000,47,0,'unit_index',-3,0,0,'��ͼ��Ԫ-���',0,0,1),(47001,47,1,'posx',-2,0,0,'��ͼ��Ԫ-��ǰ����',0,0,1),(47002,47,2,'posy',-2,0,0,'��ͼ��Ԫ-��ǰ����',0,0,1),(48000,48,0,'from_type',-1,0,0,'�о�·��-������Ԫ����',0,0,1),(48001,48,1,'from_posx',-2,0,0,'�о�·��-����λ��',0,0,1),(48002,48,2,'from_posy',-2,0,0,'�о�·��-����λ��',0,0,1),(48003,48,3,'to_type',-1,0,0,'�о�·��-���ﵥԪ����',0,0,1),(48004,48,4,'to_posx',-2,0,0,'�о�·��-����λ��',0,0,1),(48005,48,5,'to_posy',-2,0,0,'�о�·��-����λ��',0,0,1),(48006,48,6,'state',-1,0,0,'�о�·��-״̬',0,0,1),(48007,48,7,'from_cityid',-3,0,0,'�о�·��-����',0,0,1),(48008,48,8,'from_clubid',-3,0,0,'�о�·��-����',0,0,1),(48009,48,9,'to_cityid',-3,0,0,'�о�·��-Ŀ�����',0,0,1),(48010,48,10,'to_clubid',-3,0,0,'�о�·��-Ŀ������',0,0,1),(48011,48,11,'army_index',-3,0,0,'�о�·��-��������',0,0,1),(48012,48,12,'action',-1,0,0,'�о�·��-��Ϊ',0,0,1),(49000,49,0,'army_index',-3,0,0,'ɾ����-��������',0,0,1),(15000,15,0,'cmd',-2,0,0,'ָ��',0,0,1),(15001,15,1,'value',-3,4,0,'��ֵ����',0,0,1),(15002,15,2,'msglen',-2,0,0,'�ַ�������',0,0,1),(15003,15,3,'msg',-1,-1,1024,'�ַ�������',0,0,1),(40001,40,1,'pathy',-2,100,0,'·����ṹ',0,0,1),(40000,40,0,'pathx',-2,100,0,'·����ṹ',0,0,1),(77000,77,0,'kind',-3,0,0,'����',0,0,1),(77001,77,1,'num',-3,0,0,'����',0,0,1),(78000,78,0,'count',-2,0,0,'��������',0,0,1),(78001,78,1,'list',77,-1,32,'�����б�',0,0,1),(78002,78,2,'callback_code',-2,0,0,'�ĸ�ϵͳҪ��ʾ���ش�',0,0,1),(80000,80,0,'body',-2,0,0,'����',0,0,1),(80001,80,1,'addbody',-2,0,0,'��ȡ����',0,0,1),(80002,80,2,'path',-3,0,0,';��',0,0,1),(50000,50,0,'info',44,0,0,'���µ�ͼ��ʾ��Ԫ��Ϣ',0,0,1),(14000,14,0,'result',-3,0,0,'�û�����������-�һ��������ֵ',0,0,1),(14001,14,1,'client_index',-3,0,0,'�û�����������-��ɫ����',0,0,1),(14002,14,2,'authid',-3,0,0,'�û�����������-��֤ID',0,0,1),(14003,14,3,'cdkey_index',-2,0,0,'�û�����������-�һ���浵����',0,0,1),(14004,14,4,'awardgroup',-3,0,0,'�û�����������-�һ��뽱����',0,0,1),(14005,14,5,'cardnumber',-1,32,0,'�û�����������-�һ��뿨��',0,0,1);
/*!40000 ALTER TABLE `net_struct_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netccmd`
--

DROP TABLE IF EXISTS `netccmd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netccmd` (
  `cmdid` int(11) NOT NULL AUTO_INCREMENT,
  `cmdstr` varbinary(32) NOT NULL DEFAULT '',
  `structid` int(11) NOT NULL DEFAULT '0',
  `target_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '如果为1表示以队列的方式，通常为创建角色等数据操作',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `unuse` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cmdid`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netccmd`
--

LOCK TABLES `netccmd` WRITE;
/*!40000 ALTER TABLE `netccmd` DISABLE KEYS */;
INSERT INTO `netccmd` VALUES (-4,'userawarded',14,0,'�û��������������Ľ���',0),(-3,'gmlocalcmd',15,0,'GM����ָ��',0),(-2,'logined',2,0,'�û����������͵�½��Ϣ',0),(-1,'timer',-1,0,'����������ʱ����Ϣ',0),(1,'login',1,0,'�����¼',0),(2,'create',6,1,'���󴴽���ɫ',0),(3,'list',-1,1,'�����ɫ�б�',0),(4,'entergame',-3,1,'������Ϸ',0),(5,'delete',-3,0,'ɾ����ɫ',0),(6,'heart',10,0,'����',0),(7,'gmcmd',12,0,'GMָ��',0),(9,'askinfo',16,0,'��������Ϣ',0);
/*!40000 ALTER TABLE `netccmd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netgcmd`
--

DROP TABLE IF EXISTS `netgcmd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netgcmd` (
  `cmdid` int(11) NOT NULL AUTO_INCREMENT,
  `cmdstr` varbinary(32) NOT NULL DEFAULT '',
  `structid` int(11) NOT NULL DEFAULT '0',
  `target_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '如果为1表示以队列的方式，通常为创建角色等数据操作',
  `context` varbinary(128) NOT NULL DEFAULT '',
  `unuse` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cmdid`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netgcmd`
--

LOCK TABLES `netgcmd` WRITE;
/*!40000 ALTER TABLE `netgcmd` DISABLE KEYS */;
/*!40000 ALTER TABLE `netgcmd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netscmd`
--

DROP TABLE IF EXISTS `netscmd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netscmd`
--

LOCK TABLES `netscmd` WRITE;
/*!40000 ALTER TABLE `netscmd` DISABLE KEYS */;
INSERT INTO `netscmd` VALUES (1,'login',3,0,'��¼��Ϣ',0,0),(2,'list',5,0,'��ɫ�б�',0,0),(3,'create',7,0,'���ش�����ɫ��Ϣ',0,0),(4,'enterinfo',8,0,'������Ϸ����Ϣ',0,0),(5,'delete',9,0,'ɾ����ɫ',0,0),(6,'heart',11,0,'����',0,0),(7,'notify',13,0,'����Ϣ',0,0),(8,'actorinfo',29,0,'��ɫ������Ϣ',0,0),(16,'addmapunit',44,10,'��ʾ��Ԫ�����ͼ',0,0),(17,'delmapunit',45,10,'��ʾ��Ԫ�뿪��ͼ',0,0),(9,'itemuse',31,0,'����ʹ��',0,0),(10,'itemput',32,0,'���߷���|ж��',0,0),(11,'itemsettle',33,0,'��������',0,0),(12,'lostitem',34,0,'��ʧ����',0,0),(13,'getitem',35,0,'��õ���',0,0),(14,'itemlist',37,0,'��Ʒ�б�',0,0),(15,'iteminfo',39,0,'������Ϣ',0,0),(20,'worldmapinfo',46,0,'�����ͼ��Ϣ',0,0),(21,'mapunitcorrdinate',47,10,'��ͼ��ʾ��Ԫλ��',0,0),(22,'addmarchroute',48,10,'����о�·��',0,0),(23,'delmarchroute',49,10,'ɾ���о�·��',0,0),(24,'awardinfolist',78,0,'������Ϣ�б�',0,0),(25,'experience',79,0,'��þ���',0,0),(26,'body',80,0,'����',0,0),(18,'updatemapunit',50,10,'���µ�ͼ��ʾ��Ԫ��Ϣ',0,0),(19,'mapunitsingle',44,0,'��ͼ��Ԫ ����һ����Ϣ',0,0);
/*!40000 ALTER TABLE `netscmd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scsrv_c_struct`
--

DROP TABLE IF EXISTS `scsrv_c_struct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scsrv_c_struct`
--

LOCK TABLES `scsrv_c_struct` WRITE;
/*!40000 ALTER TABLE `scsrv_c_struct` DISABLE KEYS */;
INSERT INTO `scsrv_c_struct` VALUES (1,'c_item_name','��ȡ��Ʒ����',0,-3,'itemkind',9,'itemname',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(2,'c_item_hasone','�ж��Ƿ�ӵ��ĳ����',0,-3,'actor_index',-3,'itemkind',1,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(3,'c_item_emptycount','��ÿ��౳������',0,-3,'actor_index',3,'count',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(4,'c_item_lost','������ҵĵ��ߣ�������Ʒkind��',3,-3,'actor_index',-3,'itemkind',-3,'count',-3,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(5,'c_item_lostitem','���������Ʒ�����ݱ���������',0,-3,'actor_index',-3,'itemoffset',-3,'count',-3,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(6,'c_item_getitem','��ȡ��Ʒ��ȫ������',0,-3,'actor_index',-3,'itemkind',-3,'count',-1,'color',-1,'path',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(7,'c_item_get_base_ability','��ȡ����ָ��λ�õ����ԣ�������',0,-3,'itemkind',-1,'pos',2,'ability',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(8,'c_item_get_base_value','��ȡ����ָ��λ�õ���ֵ��������',0,-3,'itemkind',-1,'pos',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(9,'c_item_get_ability_value','����ability��ȡ����value������+��̬��',0,-3,'itemkind',-2,'ability',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(10,'c_item_set_abilityvalue_offset','���ݱ���������ȡ��Ʒ����',0,-3,'actor_index',-3,'item_offset',-1,'pos',-2,'ability',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(11,'c_item_get_abilityvalue_offset','���ݱ�������������Ʒ����',0,-3,'actor_index',-3,'item_offset',-1,'pos',2,'rtn_ability',3,'rtn_value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(12,'c_item_getinfo','��ȡ��Ʒ��Ϣ',0,-3,'itemkind',9,'name',2,'level',1,'color',3,'price',3,'type',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(13,'c_actor_info','��ý�ɫ��Ϣ',0,-3,'actor_index',3,'actorid',3,'aclass',3,'level',9,'name',2,'language',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(14,'c_actor_notify','��ʾ��Ϣ',2,-3,'actor_index',-9,'msg',-3,'msgid',0,'0',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(15,'c_actor_notify_value','��ʾ��Ϣ������',3,-3,'actor_index',-9,'msg',-3,'msgid',-3,'value1',-3,'value2',-3,'value3',-3,'value4',-3,'value5',-3,'value6',-3,'value7',-3,'value8',-3,'value9',-3,'value10',0,'',0,'',0,'\"\"'),(16,'c_actor_add_today_char_times','���ÿ����Ϣ(char)',0,-3,'actor_index',-2,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(17,'c_actor_get_today_char_times','���ÿ����Ϣ(char)',0,-3,'actor_index',-2,'offset',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(18,'c_actor_set_today_char_times','����ÿ����Ϣ(char)',0,-3,'actor_index',-2,'offset',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(19,'c_actor_add_today_int_times','���ÿ�մ���(int)',0,-3,'actor_index',-2,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(20,'c_actor_get_today_int_times','���ÿ�մ���(int)',0,-3,'actor_index',-2,'offset',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(21,'c_actor_set_today_int_times','����ÿ�մ���(int)',0,-3,'actor_index',-2,'offset',-3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(22,'c_actor_set_sflag','0,1�ı�־����',0,-3,'actor_index',-2,'offset',-2,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(23,'c_actor_get_sflag','0,1�ı�־����',0,-3,'actor_index',-2,'offset',2,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(24,'c_actor_set_uselimit_cd','�������CD����',0,-3,'actor_index',-1,'index',-3,'cdtime',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(25,'c_actor_get_uselimit_cd','������CD����',0,-3,'actor_index',-1,'index',3,'rtn',0,'0',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(26,'c_actor_add_week_times','������',0,-3,'actor_index',-3,'offset',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(27,'c_actor_get_week_times','������',0,-3,'actor_index',-3,'offset',3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(60,'c_map_addobject','��ӵ�ͼ��������',0,-1,'type',-2,'posx',-2,'posy',-1,'unittype',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(61,'c_map_delobject','ɾ����ͼ��������',0,-1,'type',-2,'posx',-2,'posy',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(62,'c_map_getrandpos','���һ���հ�λ��',0,-1,'type',2,'posx',2,'posy',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(190,'c_world_data_get','��������',0,-3,'id',3,'value',9,'strvalue',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(191,'c_world_data_set','��������',2,-3,'id',-3,'value',-9,'strvalue',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(200,'c_system_getruntime','��ȡ��������ʱ��',0,3,'time',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(201,'c_system_getopentime','��ȡ����ʱ��',0,3,'time',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(202,'c_system_getfday','��ȡ����',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(203,'c_system_gettoday','��ȡ������',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(204,'c_system_getweek','��ȡ������',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(205,'c_system_getmonth','��ȡ������',0,3,'value',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(210,'c_award_getaward','������',0,-3,'actor_index',-3,'kind',-3,'count',-1,'color',-1,'path',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'');
/*!40000 ALTER TABLE `scsrv_c_struct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scsrv_in_struct`
--

DROP TABLE IF EXISTS `scsrv_in_struct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scsrv_in_struct`
--

LOCK TABLES `scsrv_in_struct` WRITE;
/*!40000 ALTER TABLE `scsrv_in_struct` DISABLE KEYS */;
INSERT INTO `scsrv_in_struct` VALUES (1,'Script_Init','�ű���ʼ��',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(2,'Script_Timer','�ű��߼�ÿ����һ��',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(3,'Script_Command','�ű�GM����',0,-3,'nValue1',-3,'nValue2',-3,'nValue3',-3,'nValue4',-9,'pMsg',-3,'actor_index',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(12,'UseItem','ʹ����Ʒ',0,-3,'nPlayerIndex',-3,'nMember',-3,'nItemIndex',-3,'nItemKind',-3,'nUseNum',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(13,'OnActorIn','����ɫ������Ϸ',0,-3,'nPlayerIndex',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(7,'ClientMsg','���Կͻ��˵Ľű�����',0,-3,'nPlayerIndex',-3,'nCmd',-3,'nValue1',-3,'nValue2',-3,'nValue3',-3,'nValue4',-9,'pMsg',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"'),(14,'OnMailReadAttach','��ȡ����',0,-3,'nPlayerIndex',-9,'szAttach',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(16,'OnWorldMapInit','��ͼ��ʼ��',0,-3,'nMaxWidth',-3,'nMaxHeight',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(17,'OnWorldMapBlock','��ͼ�赲',0,-2,'posx',-2,'posy',3,'rtn',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(18,'OnWorldMapBrush','ˢ��ͼ',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(6,'OnClockProcess','����ִ��',0,-3,'hour',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(8,'ActivityOnOpen','�����',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(11,'ActivityOnClose','��ر�',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(9,'ActivityOnLogic','��߼�',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(15,'TimeString','ʱ���ת��ʱ���ַ���',0,-3,'timestamp',9,'out',3,'len',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(4,'Script_Exec','�ű�ִ��',0,-3,'id',-3,'value1',-3,'value2',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(5,'Script_Hour','�ű��߼�ÿСʱһ��',0,0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,''),(10,'ActivityOnEnd','�����',0,-3,'activityid',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'',0,'\"\"');
/*!40000 ALTER TABLE `scsrv_in_struct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_actor_conf`
--

DROP TABLE IF EXISTS `st_actor_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_actor_conf`
--

LOCK TABLES `st_actor_conf` WRITE;
/*!40000 ALTER TABLE `st_actor_conf` DISABLE KEYS */;
INSERT INTO `st_actor_conf` VALUES (1,1,'actorid',-3,0,0,'��ɫ���',0,1,0),(2,2,'accountid',-3,0,0,'��½id',1,0,0),(3,3,'userid',-4,0,0,'�˺ű��',3,0,0),(4,4,'username',-1,51,0,'�˺���',3,0,0),(5,5,'admin',-2,0,0,'����Ա����',2,0,0),(6,6,'lastip',-1,16,0,'�ϴε�½ip',0,0,0),(7,7,'createtime',-3,0,0,'����ʱ��',0,0,0),(8,8,'forbidtime',-3,0,0,'����ʱ��',0,0,0),(9,9,'savetime',-3,0,0,'�ϴα���ʱ��',1,0,0),(10,10,'isexit',-11,0,0,'�Ƿ��뿪��Ϸ��',1,0,0),(12,12,'view_areaindex',-2,0,0,'��ǰ�ӿڵĵ�ͼ����',1,0,0),(13,13,'name',-1,22,0,'��ɫ����',0,0,0),(14,14,'aclass',-1,0,0,'��ɫ����',0,0,0),(15,15,'shape',-11,0,0,'����',0,0,0),(16,16,'level',-11,0,0,'����',0,0,0),(20,20,'city_index',-3,0,0,'�ǳ�����',1,0,0),(21,21,'token',-3,0,0,'��ʯ',0,0,0),(22,22,'total_charge',-3,0,0,'�ܳ�ֵ',0,0,0),(24,24,'itemext',-11,0,0,'��չ�ı�����λ��',0,0,0),(25,25,'item',-102,500,0,'��ɫЯ���ĵ���',1,0,0),(26,26,'equip',-102,10,0,'��ɫװ����',1,0,0),(37,37,'sflag',-3,0,0,'�ض���־λ',0,0,0),(38,38,'fdate',-3,0,0,'ˢ�µ�����������',0,0,0),(39,39,'today_char',-7,-1,128,'char����ÿ�մ���',0,0,0),(40,40,'today_int',-3,8,0,'int����ÿ�մ���',0,0,0),(41,41,'cd',-3,8,0,'ͨ��CDʱ��',0,0,0),(42,42,'config',-7,-1,8,'�������',0,0,0),(64,64,'view_lastframe',-3,0,0,'�ϴη��͵�������Ϣʱ��',1,0,0),(65,65,'subscribe_cmd',-2,8,0,'���ĵ���ϢID',1,0,0),(72,72,'charge_dollar',-5,0,0,'�ܹ���ֵ������Ԫ',0,0,0),(80,80,'cdkey1',-3,0,0,'�Ƿ���ȡ�����ζһ���',0,0,0),(81,81,'cdkey2',-3,0,0,'�Ƿ���ȡ�����ζһ���',0,0,0),(82,82,'cdkey3',-3,0,0,'�Ƿ���ȡ�����ζһ���',0,0,0),(83,83,'cdkey4',-3,0,0,'�Ƿ���ȡ�����ζһ���',0,0,0),(122,122,'talkspeed_frame',-3,0,0,'˵���ӳ�',1,0,0),(124,124,'cdkeywait',-1,0,0,'CDKEY�ȴ�',1,0,0);
/*!40000 ALTER TABLE `st_actor_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_actor_item_conf`
--

DROP TABLE IF EXISTS `st_actor_item_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_actor_item_conf`
--

LOCK TABLES `st_actor_item_conf` WRITE;
/*!40000 ALTER TABLE `st_actor_item_conf` DISABLE KEYS */;
INSERT INTO `st_actor_item_conf` VALUES (1,1,'itemid',-4,0,0,'��Ʒid',0,1,1),(2,2,'actorid',-3,0,0,'��ɫID',0,2,0),(3,3,'offset',-2,0,0,'��Ʒ����λ��',0,3,0),(4,4,'kind',-3,0,0,'��Ʒ����',0,0,1),(5,5,'num',-2,0,0,'��Ʒ����',0,0,1),(6,6,'ability',-2,4,0,'����',0,0,1),(7,7,'value',-3,4,0,'����ֵ',0,0,1),(8,8,'color_level',-1,0,0,'��ɫ�ȼ�',0,0,1);
/*!40000 ALTER TABLE `st_actor_item_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_army_conf`
--

DROP TABLE IF EXISTS `st_army_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `st_army_conf` (
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
) ENGINE=MyISAM AUTO_INCREMENT=219 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_army_conf`
--

LOCK TABLES `st_army_conf` WRITE;
/*!40000 ALTER TABLE `st_army_conf` DISABLE KEYS */;
INSERT INTO `st_army_conf` VALUES (1,1,'index',-3,0,0,'��������',0,1,0),(2,2,'id',-3,0,0,'����ΨһID,�Ϸ�����֤',0,0,0),(100,100,'walk_path',40,0,0,'�����ƶ�·��',1,0,0),(11,11,'from_posx',-2,0,0,'�����Ķ�������',0,0,0),(12,12,'from_posy',-2,0,0,'�����Ķ�������',0,0,0),(50,16,'to_posx',-2,0,0,'Ŀ�Ķ�������',0,0,0),(60,17,'to_posy',-2,0,0,'Ŀ�Ķ�������',0,0,0),(90,20,'walk_len',-2,0,0,'�Ѿ��ƶ�����',0,0,0),(70,18,'posx',-2,0,0,'��ǰ����',0,0,0),(80,19,'posy',-2,0,0,'��ǰ����',0,0,0),(4,4,'state',-1,0,0,'״̬',0,0,0),(5,5,'statetime',-3,0,0,'״̬ʱ���',0,0,0),(6,6,'stateduration',-3,0,0,'״̬����������',0,0,0),(7,7,'action',-3,0,0,'��Ϊ',0,0,0),(3,3,'unit_index',-3,0,0,'��ʾ����',1,0,0),(8,8,'from_type',-2,0,0,'�����Ķ�������',0,0,0),(9,9,'from_id',-3,0,0,'�����Ķ���ID',0,0,0),(10,10,'from_index',-3,0,0,'�����Ķ�������',0,0,0),(200,200,'name',-1,22,0,'�Զ�������',0,0,0),(201,201,'soldiers',-3,0,0,'����',0,0,0),(202,202,'wounded',-3,0,0,'��Ա',0,0,0),(203,203,'body',-1,0,0,'����',0,0,0),(204,204,'morale',-1,0,0,'ʿ��',0,0,0),(205,205,'attack',-2,0,0,'����',0,0,0),(206,206,'defense',-2,0,0,'����',0,0,0),(207,207,'attack_speed',-2,0,0,'�����ٶ�',0,0,0),(208,208,'move_speed',-2,0,0,'�ƶ��ٶ�',0,0,0),(209,209,'attrpoint',-2,0,0,'δ�������',0,0,0),(210,210,'level',-2,0,0,'ս���ȼ�',0,0,0),(211,211,'exp',-1,0,0,'ս������',0,0,0),(212,212,'equip',-2,6,0,'ӵ��װ��',0,0,0),(213,213,'skillid',-2,4,0,'ӵ�м���',0,0,0),(40,13,'to_type',-2,0,0,'Ŀ�Ķ�������',0,0,0),(41,14,'to_id',-3,0,0,'Ŀ�Ķ���ID',0,0,0),(42,15,'to_index',-3,0,0,'Ŀ�Ķ�������',0,0,0),(214,214,'food',-3,0,0,'Я����ʳ',0,0,0),(215,215,'money',-3,0,0,'Я����Ǯ',0,0,0),(216,216,'itemkind',-2,4,0,'Я����Ʒ����',0,0,0),(217,217,'itemnum',-3,4,0,'Я����Ʒ����',0,0,0),(218,218,'sec',-3,0,0,'�����',0,0,0);
/*!40000 ALTER TABLE `st_army_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_city_conf`
--

DROP TABLE IF EXISTS `st_city_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `st_city_conf` (
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
) ENGINE=MyISAM AUTO_INCREMENT=206 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_city_conf`
--

LOCK TABLES `st_city_conf` WRITE;
/*!40000 ALTER TABLE `st_city_conf` DISABLE KEYS */;
INSERT INTO `st_city_conf` VALUES (1,1,'cityid',-3,0,0,'�ǳ�ID',0,1,0),(2,2,'actorid',-3,0,0,'��ɫID',0,0,0),(201,201,'actor_index',-3,0,0,'��ɫ����',1,0,0),(200,200,'city_index',-3,0,0,'�ǳ�����',1,0,0),(31,31,'people',-3,0,0,'�˿�(��������)',0,0,0),(202,202,'unit_index',-3,0,0,'��ʾ����',1,0,0),(32,32,'food',-3,0,0,'ʳ��(��������)',0,0,0),(33,33,'money',-3,0,0,'��Ǯ(��������)',0,0,0),(23,23,'politics',-2,0,0,'������ʩ(һ������)',0,0,0),(25,25,'farm',-2,0,0,'ũҵ��ʩ(һ������)',0,0,0),(27,27,'business',-2,0,0,'��ҵ��ʩ(һ������)',0,0,0),(29,29,'military',-2,0,0,'������ʩ(һ������)',0,0,0),(6,6,'shape',-1,0,0,'�ǳ�����',0,0,0),(18,18,'posy',-2,0,0,'λ��',0,0,0),(17,17,'posx',-2,0,0,'λ��',0,0,0),(7,7,'headid',-3,0,0,'Ĭ��ͷ��',0,0,0),(5,5,'type',-1,0,0,'�ǳ�����',0,0,0),(8,8,'country',-1,3,0,'ѡ��Ĺ���',0,0,0),(9,9,'ipcountry',-1,3,0,'IP��ַ���ڹ���',0,0,0),(10,10,'language',-1,0,0,'ѡ������',0,0,0),(14,14,'lastlogin',-3,0,0,'�ϴε�½ʱ��',0,0,0),(15,15,'lastlogout',-3,0,0,'�ϴεǳ�ʱ��',0,0,0),(16,16,'state',-1,0,0,'�ǳص�ǰ״̬',0,0,0),(19,19,'sflag',-3,0,0,'��־λ',0,0,0),(11,11,'os',-1,0,0,'ϵͳ1ios 2android 3win',0,0,0),(12,12,'platid',-1,0,0,'ƽ̨',0,0,0),(34,34,'soldiers',-3,0,0,'��Ա(��������)',0,0,0),(20,20,'level',-1,0,0,'�ȼ�',0,0,0),(21,21,'viplevel',-1,0,0,'VIP�ȼ�',1,0,0),(22,22,'vipexp',-3,0,0,'VIP����',0,0,0),(24,24,'politics_exp',-3,0,0,'������ʩ����',0,0,0),(26,26,'farm_exp',-3,0,0,'ũҵ��ʩ����',0,0,0),(28,28,'business_exp',-3,0,0,'��ҵ��ʩ����',0,0,0),(30,30,'military_exp',-3,0,0,'������ʩ����',0,0,0),(203,203,'army_index',-3,5,0,'����',1,0,0),(4,4,'name',-1,22,0,'����',0,0,0),(13,13,'createtime',-3,0,0,'����ʱ��',0,0,0);
/*!40000 ALTER TABLE `st_city_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_hero_conf`
--

DROP TABLE IF EXISTS `st_hero_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `st_hero_conf` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_hero_conf`
--

LOCK TABLES `st_hero_conf` WRITE;
/*!40000 ALTER TABLE `st_hero_conf` DISABLE KEYS */;
INSERT INTO `st_hero_conf` VALUES (2,2,'id',-4,0,0,'Ӣ��ID',0,0,0),(3,3,'name',-1,22,0,'Ӣ������',0,0,0),(1,1,'index',-3,0,0,'����',0,0,0);
/*!40000 ALTER TABLE `st_hero_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `st_tower_conf`
--

DROP TABLE IF EXISTS `st_tower_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `st_tower_conf` (
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
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `st_tower_conf`
--

LOCK TABLES `st_tower_conf` WRITE;
/*!40000 ALTER TABLE `st_tower_conf` DISABLE KEYS */;
INSERT INTO `st_tower_conf` VALUES (1,1,'index',-3,0,0,'����',0,0,0),(2,2,'id',-3,0,0,'ID',0,0,0),(3,3,'cityid',-3,0,0,'�����ǳ�ID',0,0,0),(4,4,'city_index',-3,0,0,'�����ǳ�����',1,0,0),(5,5,'unit_index',-3,0,0,'��ʵ��������',1,0,0),(6,6,'posx',-2,0,0,'λ��',0,0,0),(7,7,'posy',-2,0,0,'λ��',0,0,0),(9,9,'level',-1,0,0,'�ȼ�',0,0,0),(10,10,'wear',-3,0,0,'�;�',0,0,0),(8,8,'type',-1,0,0,'����',0,0,0);
/*!40000 ALTER TABLE `st_tower_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `struct_data`
--

DROP TABLE IF EXISTS `struct_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `struct_data`
--

LOCK TABLES `struct_data` WRITE;
/*!40000 ALTER TABLE `struct_data` DISABLE KEYS */;
INSERT INTO `struct_data` VALUES (1,'st_actor_conf','actor','Actor',1,0,0,0,0,0,0,0,0),(2,'st_actor_item_conf','actor_item','Item',2,1,0,2,3,0,0,0,1),(3,'st_city_conf','city','City',0,1,1,2,0,1,0,5,0),(4,'st_army_conf','army','Army',0,1,1,1,0,2,1,300,0),(5,'st_tower_conf','tower','Tower',0,1,1,1,0,2,1,1000,0),(6,'st_hero_conf','hero','Hero',0,1,1,1,0,2,1,1000,0);
/*!40000 ALTER TABLE `struct_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `struct_serv_data`
--

DROP TABLE IF EXISTS `struct_serv_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `struct_serv_data`
--

LOCK TABLES `struct_serv_data` WRITE;
/*!40000 ALTER TABLE `struct_serv_data` DISABLE KEYS */;
INSERT INTO `struct_serv_data` VALUES (1,'item','ItemKind','g_itemkind','used','','','',1),(2,'platinfo','PlatInfo','g_platinfo','desc','','','',0),(3,'upgrade','UpgradeInfo','g_upgradeinfo','','','','',0),(4,'paycountry','PayCountry','g_paycountry','name','','','',0),(5,'paygoods','PayGoods','g_paygoods','name','','','',0);
/*!40000 ALTER TABLE `struct_serv_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-18 16:13:31
