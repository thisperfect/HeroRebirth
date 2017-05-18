CREATE TABLE `tower` (
  `index` int(11) NOT NULL DEFAULT '0' COMMENT '索引',
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'ID',
  `cityid` int(11) NOT NULL DEFAULT '0' COMMENT '所属城池ID',
  `posx` smallint(6) NOT NULL DEFAULT '0' COMMENT '位置',
  `posy` smallint(6) NOT NULL DEFAULT '0' COMMENT '位置',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '等级',
  `wear` int(11) NOT NULL DEFAULT '0' COMMENT '耐久',
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
