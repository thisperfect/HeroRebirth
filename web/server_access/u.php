<?php
require_once 'config.inc.php';
require_once 'lib/db.inc.php';

// ��utf-8ת��Ϊgb
// $content = iconv("utf-8","gb2312//IGNORE",$content);

// ��gbת��Ϊutf-8
// $content = iconv("gb2312","utf-8//IGNORE",$content);

function wloglogin( $db, $username, $msg )
{
	$myip = $_SERVER["REMOTE_ADDR"];
	$sql="INSERT INTO loginlog (username,ip,optime,msg) values('$username','$myip',now(),'$msg')";

	$db->query($sql);
}

// v1�û�����v2���룬v5DeviceID
function login( $v1, $v2, $v4, $v5, $db )
{
	wloglogin( $db, $v1, "login begin" );
	$uid = 0;
	$usertype = 0;
	$locktime = 0;
	$activeflag = 0;
	$result = -1;
	$szUserID = "";
	$token = "";

	$v1 = mysql_real_escape_string($v1);
	$v2 = mysql_real_escape_string($v2);
	
	// ���ٵ�½��ֱ�����豸����Ϊ��½Ψһ��ʾ
	if ( $v1 == "" && $v2 == "" && $v5 != "" )
	{
		$result = 0;
		$sql="select id,usertype,locktime,activeflag from `user` where name='$v5'";
		$query = $db->query($sql);
		if($sth = $db->fetch_row($query))
		{ // �ҵ�������û�
			$v1 = $v5;
			$uid = $sth[0];
			$usertype = $sth[1];
			$locktime = $sth[2];
			$activeflag = $sth[3];
			$db->free_result($query);
			wloglogin( $db, $v1, "login fast" );
		}
		else
		{ // û�ҵ�����û����Ͳ���һ��
			$thistime = time();
			
			$sql="select max(id) from user";
			$query = $db->query($sql);
			if($sth = $db->fetch_row($query))
			{
				$szUserID = $sth[0]+1;
			}
			$db->free_result($query);
			
			$sql="insert into user ( id, name, passwd, activeflag, create_time, regip, flashtime ) values('$szUserID','$v5','', '1', '$thistime', '$v4','$thistime') ";
			if(!( $db->query($sql) ))
			{
				$result = -1;
			}
			
			$uid = $szUserID;
			$v1 = $v5;
			return $result."\n".$usertype."\n"."0\n".$uid."\n".$v1."\n".$token."\n10000\n\n$v5\n";
		}
	}
	
	// �����˺������½
	if ( $v1 != "" && $v2 != ""  )
	{
		$sql="select id,usertype,locktime,activeflag,(passwd=MD5(CONCAT('$v2','freeskyuser'))),(token='$v2') from user where name='$v1'";
		$query = $db->query($sql);
		if($sth = $db->fetch_row($query))
		{
			$uid = $sth[0];
			$usertype = $sth[1];
			$locktime = $sth[2];
			$activeflag = $sth[3];
			$checkpass = $sth[4];
			$checktoken = $sth[5];
			$db->free_result($query);
	
			$result = 0;
			$token = '';
			if( $checkpass != 0 )
			{
				// ���������
				$result = 1;
				// ˢ��token
				$token = create_password( 32 );
				$thistime = time();
				$sql="UPDATE user SET token='$token',flashtime='$thistime' WHERE id='$uid'";
				$db->query($sql);
			}
			elseif( $checktoken != 0 )
			{
				// �����token
				$result = 1;
				$token = $v2;
			}
	
			if( $result == 0 )
			{
				$result = -2;
			}
			else if( $locktime != 0 )
			{
				$result = -3;	// �Ѿ�������
			}
			else if( $activeflag == 0 )
			{
				$result = -4;	// û�б�����
			}
			else
			{
				$result = 0;
			}
		}
		else
		{
			$result = -1;
		}
	}
	
	// ��¼��������
	/*if( $result == 0 )
	{
		$dateday = -1;
		$sql="select datediff(now(),firsttime) from retention where deviceid='$v5'";
		$query = $db->query($sql);
		if($sth = $db->fetch_row($query))
		{
			$dateday = $sth[0];
			$db->free_result($query);
			if( $dateday > 0 && $dateday < 31 )
			{
				if( $dateday < 10 )
				{
					$sql="update retention set day0$dateday=1 where deviceid='$v5'";
				}
				else
				{
					$sql="update retention set day$dateday=1 where deviceid='$v5'";
				}
				$query = $db->query($sql);
			}
		}
		else
		{
			$sql="insert into retention (deviceid,firsttime) values('$v5',now())";
			$query = $db->query($sql);
		}
	}*/
	// ��¼�����������
	return $result."\n".$usertype."\n"."0\n".$uid."\n".$v1."\n".$token."\n10000\n\n$v5\n";

}

function create_password( $pw_length )
{
	$randpwd = '';
	for ($i = 0; $i < $pw_length; $i++) 
	{
		if( mt_rand( 1, 3 ) == 1 )
			$randpwd .= chr(mt_rand(48, 57));
		elseif( mt_rand( 1, 3 ) == 2 )
			$randpwd .= chr(mt_rand(65, 90));
		else
			$randpwd .= chr(mt_rand(97, 122));
	}
	return $randpwd;
}

// userid,lockmin
function lockuser( $v1, $v2, $db )
{
	$locktime = 0;
	$result = 0;

	if( $v2 <= 0 )
		$locktime = 0;
	else
		$locktime = $v2*60 + time();

	$sql="update user set locktime='$locktime' where id='$v1'";
	if(!( $db->query($sql) ))
	{
		$result = -1;
	}
	$db->free_result($query);
	return $v1."\n".$result."\n";
}

// �һ���
function award( $actorid, $serverid, $szUserID, $ip, $cardnumber, $cdkey, $sys, $channel, $db )
{
	// n|3
	$cardlen = strlen( $cardnumber );
	if( $cardlen < 5 )
	{
		return "0\n0\n-1\n"; // ����λ������
	}
	$nolen = $cardlen-3;
	$cardid = substr( $cardnumber, 0, $nolen );
	$cardpsw = substr( $cardnumber, $nolen );
	
	$cdkey_index = -1;
	$limit_sys = 0;
	$limit_channel = 0;
	$awardgroup = 0;
	$overduetime = 0;
	$userid = 0;
	
	// ��ѯ�һ�����Ϣ
	$result = 0;
	$sql="SELECT cdkey_index, limit_sys, limit_channel, awardgroup, overduetime, userid from card where id='$cardid' and passwd='$cardpsw'";
	$query = $db->query($sql);
	if($sth = $db->fetch_row($query))
	{
		$cdkey_index = $sth[0];
		$limit_sys = $sth[1];
		$limit_channel = $sth[2];
		$awardgroup = $sth[3];
		$overduetime = $sth[4];
		$userid = $sth[5];
	}
	else
	{
		$result = -2; // �һ��벻��ȷ
	}
	$db->free_result($query);
	
	// �һ��벻��ȷ
	if( $result < 0 )
	{
		return "0\n0\n$result\n";
	}
	
	// �����ж�$cdkey_index�Ƿ����ʹ�� ͨ��cdkey "00000000000000000000000000000000"
	if( $cdkey_index >= 0 && $cdkey_index < 128 )
	{
		$pos_disable = substr( $cdkey, $cdkey_index, 1 );
		if( $pos_disable == "1" )
		{
			$result = -3; // ������Ѿ�ʹ�ù������͵Ŀ���
			return $cdkey_index."\n0\n$result\n";
		}
	}
	
	// ���ſ��Ƿ��������ʹ��
	if ( $userid > 0 )
	{
			$result = -4; // ���ſ��Ѿ���ʹ�ù���
			return $cdkey_index."\n0\n$result\n";
	}
	
	// ϵͳ���
	if ( $limit_sys == 1 && $limit_sys != $sys )
	{
			$result = -5; // ���ſ�ֻ����iosƽ̨ʹ��
			return $cdkey_index."\n0\n$result\n";
	}
	if ( $limit_sys == 2 && $limit_sys != $sys )
	{
			$result = -6; // ���ſ�ֻ����androidƽ̨ʹ��
			return $cdkey_index."\n0\n$result\n";
	}
	
	// �������
	if ( $limit_channel > 0 && $limit_channel != $channel )
	{
			$result = -7; // ���ſ�ֻ��ָ�������û�ʹ��
			return $cdkey_index."\n0\n$result\n";
	}
	
	// ���ڼ��
	if ( $overduetime > 0 && time() >= $overduetime )
	{
			$result = -8; // ���ſ��Ѿ�����
			return $cdkey_index."\n0\n$result\n";
	}
	
	// ����ʹ����
	if ( $cardid > 100 )
	{
		$sql="UPDATE card set userid='$szUserID',serverid='$serverid',actorid='$actorid',usedtime=now() where id='$cardid'";
		if(!( $db->query($sql) ))
		{
			$result = -2; // �һ��벻��ȷ
		}
	}
	
	if( $result < 0 )
	{
		return $cdkey_index."\n0\n$result\n";
	}
	
	return $cdkey_index."\n".$awardgroup."\n".$result."\n".$cardnumber;
}

if (!get_magic_quotes_gpc())
{
	$command=addslashes(@$_GET['c']);
	$client_index=addslashes(@$_GET['i']);
	$authid=addslashes(@$_GET['a']);
	$v1=addslashes(@$_GET['v1']);
	$v2=addslashes(@$_GET['v2']);
	$v3=addslashes(@$_GET['v3']);
	$v4=addslashes(@$_GET['v4']);
	$v5=addslashes(@$_GET['v5']);
	$v6=addslashes(@$_GET['v6']);
	$v7=addslashes(@$_GET['v7']);
	$v8=addslashes(@$_GET['v8']);
}
else
{
	$command=@$_GET['c'];
	$client_index=@$_GET['i'];
	$authid=@$_GET['a'];
	$v1=@$_GET['v1'];
	$v2=@$_GET['v2'];
	$v3=@$_GET['v3'];
	$v4=@$_GET['v4'];
	$v5=@$_GET['v5'];
	$v6=@$_GET['v6'];
	$v7=@$_GET['v7'];
	$v8=@$_GET['v8'];
}

$result = 0;
$dbisopen = 0;
if( $result == 0 )
{
	#�����ݿ�
	$db = new dbstuff;
	$pconnect = 0;
	$db->connect($dbhost, $dbuser, $dbpw, $dbname, $pconnect);
	$dbhost = $dbuser = $dbpw = $dbname = $pconnect = NULL;
	$dbisopen = 1;
}
$uid = 0;
$usertype = 0;
$locktime = 0;
$activeflag = 0;
$msg = "-1\n";

if( $result == 0 )
{
	if( $command == 1 )
	{ // ��½
			$msg = login( $v1, $v2, $v4, $v5, $db );
	}
	else if( $command == 2 )
	{ // �һ���
			$msg = award( $v1, $v2, $v3, $v4, $v5, $v6, $v7, $v8, $db );
	}
	else if( $command == 3 )
	{ // ���˻�
			$msg = lockuser( $v1, $v2, $db );
	}
}

if( $dbisopen )
{
	$db->close();
}
print $client_index."\n".$authid."\n".$msg;
?>
