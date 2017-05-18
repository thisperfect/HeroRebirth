<?php
require_once 'lib/db.inc.php';

/**
 * 服务器信息
 *
 */
	 
class serverinfo {
		 
  /**
	 * 获取服务器列表
	 *
	 */
	static public function getlist( $pramers )
	{
		$list = array();
		$db = new dbstuff;
		$db->connect( DB_WEB_HOST, DB_WEB_USER, DB_WEB_PWD, DB_WEB_DBNAME, 0 );
		$sql="select id, ip, port, new, close, king_sevname, king_name, king_country from `gate_list` order by id asc;";
		$query = $db->query($sql);
		while ( $sth = $db->fetch_row($query) )
		{
			$sid = $sth[0];
			$host = $sth[1];
			$port = $sth[2];
			$new = $sth[3];
			$close = $sth[4];
			$king_sevname = $sth[5];
			$king_name = $sth[6];
			$king_country = $sth[7];
			
			$list[$sid]["sid"] = $sid;
			$list[$sid]["h"] = $host;
			$list[$sid]["p"] = $port;
			$list[$sid]["new"] = $new;
			$list[$sid]["cl"] = $close;
			$list[$sid]["ksn"] = $king_sevname;
			$list[$sid]["kn"] = $king_name;
			$list[$sid]["kc"] = $king_country;
		}
		$db->free_result($query);
		$db->close();
		return json_encode($list);
	}
	
}


?>
