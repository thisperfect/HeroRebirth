CREATE TABLE `hero` (
  `index` int(11) NOT NULL DEFAULT '0' COMMENT '����',
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'Ӣ��ID',
  `name` varbinary(22) NOT NULL DEFAULT '' COMMENT 'Ӣ������',
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
