CREATE TABLE `actor_item` (
  `itemid` bigint(20) NOT NULL DEFAULT '0' COMMENT '��Ʒid',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '��ɫID',
  `offset` smallint(6) NOT NULL DEFAULT '0' COMMENT '��Ʒ����λ��',
  `kind` int(11) NOT NULL DEFAULT '0' COMMENT '��Ʒ����',
  `num` smallint(6) NOT NULL DEFAULT '0' COMMENT '��Ʒ����',
  `ability0` smallint(6) NOT NULL DEFAULT '0' COMMENT '����',
  `ability1` smallint(6) NOT NULL DEFAULT '0' COMMENT '����',
  `ability2` smallint(6) NOT NULL DEFAULT '0' COMMENT '����',
  `ability3` smallint(6) NOT NULL DEFAULT '0' COMMENT '����',
  `value0` int(11) NOT NULL DEFAULT '0' COMMENT '����ֵ',
  `value1` int(11) NOT NULL DEFAULT '0' COMMENT '����ֵ',
  `value2` int(11) NOT NULL DEFAULT '0' COMMENT '����ֵ',
  `value3` int(11) NOT NULL DEFAULT '0' COMMENT '����ֵ',
  `color_level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '��ɫ�ȼ�',
  PRIMARY KEY (`itemid`)
  KEY (`actorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
