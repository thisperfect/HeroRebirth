CREATE TABLE `actor_hero` (
  `heroid` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Ӣ��ΨһID',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '������ɫID',
  `offset` smallint(6) NOT NULL DEFAULT '0' COMMENT '����',
  `kind` smallint(6) NOT NULL DEFAULT '0' COMMENT '����',
  `level` smallint(6) NOT NULL DEFAULT '0' COMMENT '�ȼ�',
  `exp` int(11) NOT NULL DEFAULT '0' COMMENT '����',
  `color` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Ʒ����ɫ',
  PRIMARY KEY (`heroid`)
  KEY (`actorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
