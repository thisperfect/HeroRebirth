CREATE TABLE `tower` (
  `index` int(11) NOT NULL DEFAULT '0' COMMENT '����',
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'ID',
  `cityid` int(11) NOT NULL DEFAULT '0' COMMENT '�����ǳ�ID',
  `posx` smallint(6) NOT NULL DEFAULT '0' COMMENT 'λ��',
  `posy` smallint(6) NOT NULL DEFAULT '0' COMMENT 'λ��',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '����',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '�ȼ�',
  `wear` int(11) NOT NULL DEFAULT '0' COMMENT '�;�',
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
