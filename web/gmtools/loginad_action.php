<?php
require_once 'db.inc.php';
session_start();
header("content-Type: text/html; charset=gbk");
$error_str = "��ȷ��";
$error_flag = 0;

$iplimit_list = array("114.242.12.95","123.118.215.231");

$ip = $_SERVER["REMOTE_ADDR"];
$agree = 0;
$ipcount = count($iplimit_list);
if ( $ipcount > 0 )
{
	for ( $i=0; $i < $ipcount; $i++ )
	{
		if ( $iplimit_list[$i] == $ip )
			{
				$agree = 1;
				break;
			}
	}
}
else
{
	$agree = 1;
}

$agree = 1;
if ($agree == 0)
{
	exit("<script language='javascript'>alert('IP������ɷ�Χ��');window.location.href='login_ad.php';</script>");
}

if (!get_magic_quotes_gpc())
{
	$name=addslashes($_POST['name']);
	$passwd=addslashes($_POST['passwd']);
}
else
{
	$name=$_POST['name'];
	$passwd=$_POST['passwd'];
}

$uid = 0;

$db = new dbstuff;
$pconnect = 0;
$db->connect( $dbh, $dbu, $dbp, $dbd, 0 );

$sql="SELECT level FROM gmuser where name='$name' and passwd=MD5('$passwd')";
$query = $db->query($sql);

if($row = $db->fetch_row($query))
{
	$uid=$row[0];
}
$db->close();

if( $uid <= 0 )
{
	$error_str = "���벻�Ϸ���";
	$error_flag = 1;
}

session_start();
session_unregister('adminname');
session_unregister('adminid');

// ��ȷ���½
if ( $error_flag == 0 )
{
	$uname = $name;
	$_SESSION["adminname"] = $uname;
	$_SESSION["adminid"] = $uid;
}
echo "<script>location.href='tj3.php';</script>";

// ��¼log
//@mysql_query("INSERT INTO `log` (`type`,`admin`,`success`,`optime`) VALUES( 0,'$name', $success, NOW())",$q);
?>