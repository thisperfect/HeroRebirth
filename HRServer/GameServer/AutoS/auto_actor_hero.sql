CREATE TABLE `actor_hero` (
  `heroid` bigint(20) NOT NULL DEFAULT '0' COMMENT '英雄唯一ID',
  `actorid` int(11) NOT NULL DEFAULT '0' COMMENT '所属角色ID',
  `offset` smallint(6) NOT NULL DEFAULT '0' COMMENT '索引',
  `kind` smallint(6) NOT NULL DEFAULT '0' COMMENT '种类',
  `level` smallint(6) NOT NULL DEFAULT '0' COMMENT '等级',
  `exp` int(11) NOT NULL DEFAULT '0' COMMENT '经验',
  `color` tinyint(4) NOT NULL DEFAULT '0' COMMENT '品质颜色',
  PRIMARY KEY (`heroid`)
  KEY (`actorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
