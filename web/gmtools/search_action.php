<?php 
require_once 'db.inc.php';
require_once 'define.php';
/*session��ʽ*/
session_start();
header("content-Type: text/html; charset=gbk");
if(!session_is_registered("adminid") || $_SESSION["adminid"] <= 0 )
{
	exit("<script language='javascript'>window.location.href='login_ad.php';</script>");
}

$actorid=$_POST["actorid"];
$indata=$_POST["indata"];
$oppath=$_POST["oppath"];

$intime=$indata." ".$_POST["intime"];
$intime2=$indata." ".$_POST["intime2"];

$value_min1=$_POST["value_min1"];
$value_max1=$_POST["value_max1"];
$value_min2=$_POST["value_min2"];
$value_max2=$_POST["value_max2"];
$value_min3=$_POST["value_min3"];
$value_max3=$_POST["value_max3"];

$page=$_POST["page"];
if( $page <= 0 )
	$page = 1;
$page = $page-1;
$beginno = $page*2000;
$datestr=explode( "-", $indata );
$tabname = "glog_".$datestr[0].$datestr[1].$datestr[2];

if ( isset($_POST["op"]) )
		$array_op = $_POST["op"];       //����ѡ��ֵ��ɵ��������$array����
else
{
	echo"û��ѡ�����";
	exit;
}
$opnum = count($array_op);

if ( isset($_POST["favor"]) )
		$array = $_POST["favor"];       //����ѡ��ֵ��ɵ��������$array����
else
{
	echo"û��ѡ�������";
	exit;
}
$num = count($array);           //����һ���ж����ѡ��

$hasactorid = 0;
if(isset($actorid) && $actorid > 0 )
{
	$hasactorid = 1;
}
$op_text=array(1=>'��ʧ��Ǯ',2=>'�õ���Ʒ',3=>'ʧȥ��Ʒ',4=>'����仯',5=>'���ܱ仯',6=>'���',9=>'����',15=>'װ������',37=>'�����',39=>'��ʧ��ʯ',40=>'��ʧ����',47=>'����');
$path_text=array(0=>'��ͨ',2=>'���鿨',3=>'��ɫ����',4=>'�����̵�',5=>'����',6=>'����',7=>'ÿ������',8=>'�ű�(����boss)',9=>'ˢ�ֽ���',10=>'����',11=>'����ͨ��',12=>'�����Ǯ������ʯ',13=>'GM',
								14=>'ϵͳ����',15=>'�Ӷᣬ������',16=>'������',17=>'��Լʯ�ϳ�',18=>'װ������',19=>'����',20=>'����ϳ�',22=>'��Լʯ�׼�',23=>'װ��ǿ��',24=>'Ұ��ս��',25=>'��ֵ',26=>'��������',
								27=>'�л���ʾ����',29=>'��������',30=>'����ǿ��',31=>'ʹ����Ʒ',32=>'ս������',33=>'���ֿ�',34=>'ǩ��',38=>'��ħˢ��',39=>'�׳�',40=>'�����Ƭ�ٻ�',41=>'�����������',42=>'������',
								43=>'�������ս��',44=>'�ʼ�',45=>'���ֽ�',46=>'������½',49=>'��ֵ����',50=>'��������',68=>'��������',84=>'�',85=>'Ĥ��',86=>'��Ȫ');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<style type="text/css"><!--
		body {font-family: Arial,Helvetica,sans-serif; font-size: 12px;}
		h1 {font-size: 18px; text-decoration: bold;}
		h2 {font-size: 16px; text-decoration: bold;}
		h3 {font-size: 14px; text-decoration: bold;}
		th {font-size: 12px; border-style: solid; border-width: 1px; text-decoration: bold; padding: 1px;}
		td {font-size: 12px; border-style: solid; border-width: 1px; padding: 1px;}
		code {font-size: 12px; white-space: pre;}
		.TableObject {border-collapse: collapse; border-color: #000000; font-family: ����}
		.TableData {border-collapse: collapse; border-color: #000000; font-family: ����}
		.TableHeader {border-color: #000000; text-decoration: bold; background-color: #e0e0e0;}
		.ObjectHeader {padding-left: 5px; text-align: left; border-color: #000000; text-decoration: bold;}
		.ObjectOfPrimaryKey {text-align: left; border-color: #aaaaaa; text-decoration: bold; background-color: #e0e0e0;}
		.ObjectOfUniqueKey {text-align: left; border-color: #aaaaaa; background-color: #e0e0e0;}
		.Object {text-align: left; border-color: #aaaaaa;}
		.Record_1 {}
		.Record_2 {background-color: #f0f0f0;}
		.DataHeader {padding-left: 5px; text-align: left; text-decoration: bold; border-color: #000000; background-color: #e0e0e0;}
		.DataOfPrimaryKey {text-align: left; text-decoration: bold; border-color: #aaaaaa; background-color: #e0e0e0;}
		.DataOfUniqueKey {border-color: #aaaaaa;}
		.Data {border-color: #aaaaaa;}
		.DataRightAlign {text-align: right;}
		.DataNull {color: #999999; border-color: #aaaaaa;}
	--></style>
</head>

<body>
<?php
echo"<table border='0' cellspacing='0' cellpadding='0' class='TableData' >";
echo"<tr class='TableHeader'>";

echo"<td class='Data DataRightAlign'>��ɫID</td>";
echo"<td class='Data DataRightAlign'>����</td>";
echo"<td class='Data DataRightAlign'>;��</td>";
echo"<td class='Data DataRightAlign'>����1(����)</td>";
echo"<td class='Data DataRightAlign'>����2(����)</td>";
echo"<td class='Data DataRightAlign'>����3(��ʶ)</td>";
echo"<td class='Data DataRightAlign'>������ɫ</td>";
echo"<td class='Data DataRightAlign'>����ʱ��</td>";

echo"</tr>";

$recno = 2;

for ( $i = 0; $i < $num; $i++ )
{
	if(isset($array[$i]))
	{
		$db = new dbstuff;
		$pconnect = 0;
		$dbh=$dbhost;
		$dbu = $dbuser;
		$dbp = $dbpw;
		$dbd = $dbname;
		$db->connect( $dbh, $dbu, $dbp, $dbd, 0 );

		$sql="SELECT * FROM server_list where id='$array[$i]'";
		$query = $db->query($sql);
		if($row = $db->fetch_row($query))
		{
		
			$db->close();

			$sysid=$row[0];
			$sysname=$row[1];
			$sysip=$row[2];
			$sysport=$row[3];
			$sysdbh=$row[4];
			$sysdbu=$row[5];
			$sysdbp=$row[6];
			$sysdbd=$row[11];
			
			echo "<tr class='Record_2'><th class='DataHeader'>$sysname</th><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>";

			$db->connect( $sysdbh, $sysdbu, $sysdbp, $sysdbd, 0 );

			$wherestr = "(";
			for( $tmpi = 0; $tmpi < $opnum; $tmpi++ )
			{
				if( $tmpi == 0 )
					$wherestr = $wherestr."op='".$array_op[$tmpi]."' ";
				else
					$wherestr = $wherestr." or op='".$array_op[$tmpi]."' ";
			}
			$wherestr = $wherestr.")";
			if( $oppath >= 0 )
				$wherestr = $wherestr." and path='".$oppath."'";
			if( isset($_POST["actorid"]) && $_POST["actorid"] > 0 )
				$wherestr = $wherestr." and actor1='".$actorid."'";

			if( $value_min1 != 0 || $value_max1 != 0 )
				$wherestr = $wherestr." and object>='".$value_min1."' and object<='".$value_max1."'";
			if( $value_min2 != 0 || $value_max2 != 0 )
				$wherestr = $wherestr." and objectnum>='".$value_min2."' and objectnum<='".$value_max2."'";
			if( $value_min3 != 0 || $value_max3 != 0 )
				$wherestr = $wherestr." and objectid>='".$value_min3."' and objectid<='".$value_max3."'";

			if ( isset($_POST["object"]) && $_POST["object"] != 0)
				$sql="select op,path,object,objectnum,objectid,actor1,actor2,optime from ".$tabname." where ".$wherestr."  and object='".$_POST["object"]."' and optime>='".$intime."' and optime<='".$intime2."' limit $beginno,2000";
			else
				$sql="select op,path,object,objectnum,objectid,actor1,actor2,optime from ".$tabname." where ".$wherestr." and optime>='".$intime."' and optime<='".$intime2."' limit $beginno,2000";
			$query = $db->query($sql);
			while($row = $db->fetch_row($query))
			{
				$op=$row[0];
				$path=$row[1];
				$object=$row[2];
				$objectnum=$row[3];
				$objectid=$row[4];
				$actor1=$row[5];
				$actor2=$row[6];
				$optime=$row[7];

				if( $recno == 1 )
					$recno = 2;
				else
					$recno = 1;
				echo"<tr class='Record_$recno'>";
			
				echo"<td class='Data DataRightAlign'>$actor1</td>";
				echo"<td class='Data DataRightAlign'>$op_text[$op]</td>";
				if ( $path_text[$path] == "" )
					echo"<td class='Data DataRightAlign'>$path</td>";
				else
					echo"<td class='Data DataRightAlign'>$path_text[$path]</td>";
				echo"<td class='Data DataRightAlign'>$object</td>";
				echo"<td class='Data DataRightAlign'>$objectnum</td>";
				echo"<td class='Data DataRightAlign'>$objectid</td>";
				echo"<td class='Data DataRightAlign'>$actor2</td>";
				echo"<td class='Data DataRightAlign'>$optime</td>";
			
				echo"</tr>";

			}
			$db->close();
		}
		else
		{
			$db->close();
		}
	}
}
// ��¼log
echo"</table>";

?>

</body>
</html>
