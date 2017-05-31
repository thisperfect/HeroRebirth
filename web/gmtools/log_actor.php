<?php 
require_once 'db.inc.php';
require_once 'define.php';
error_reporting(1);
/*session方式*/
session_start();
header("content-Type: text/html; charset=utf8");
if(!session_is_registered("adminid") || $_SESSION["adminid"] <= 0 )
{
	exit("<script language='javascript'>window.location.href='login_ad.php';</script>");
}

$sysid=$_POST["sysid"];
$actorid=$_POST["actorid"];
$date=$_POST["date"];
$path=$_POST["path"];

$begintime=$date." ".$_POST["begintime"];
$endtime=$date." ".$_POST["endtime"];

$page = $_POST["page"];
if( $page <= 0 )
	$page = 1;
$page = $page-1;
$beginno = $page*2000;
$datestr = explode( "-", $date );
$tabname = "glog_".$datestr[0].$datestr[1].$datestr[2];

// 操作
$opnum = 1;
$array_op=array(0=>'0');
if ( isset($_POST["op"]) )
{
	$array_op = $_POST["op"];       //将所选的值组成的数组放入$array数组
	$opnum = count($array_op);
}
else
{
	$array_op[0]=0;
	$opnum = 1;
}


$hasactorid = 0;
if(isset($actorid) && $actorid > 0 )
{
	$hasactorid = 1;
}

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
		.TableObject {border-collapse: collapse; border-color: #000000; font-family: 宋体}
		.TableData {border-collapse: collapse; border-color: #000000; font-family: 宋体}
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

<script language="javascript">
 function sel(a){
  o=document.getElementsByName(a)
  for(i=0;i<o.length;i++)
  o[i].checked=event.srcElement.checked
 }
</script>

<body>
<?php

$g_itemkind = array(0=>'无');

function getdbdatalist( $db )
{
	Global $g_itemkind;
	$result = 0;
	$sql="select itemkind,name from item where used = 1 order by itemkind";
	$query = $db->query($sql);
	while($row = $db->fetch_row($query))
	{
		$g_itemkind[$row[0]] = $row[1];
	}
	return $result;
}
$db2 = new dbstuff;
$db2->connect( $data_dbh, $data_dbu, $data_dbp, $data_dbd, 0 );
getdbdatalist( $db2 );


echo"<table border='0' cellspacing='0' cellpadding='0' class='TableData' >";
echo"<tr class='TableHeader'>";
echo"<td class='Data DataRightAlign'>操作</td>";
echo"<td class='Data DataRightAlign'>途径</td>";
echo"<td class='Data DataRightAlign'>参数1</td>";
echo"<td class='Data DataRightAlign'>参数2</td>";
echo"<td class='Data DataRightAlign'>参数3</td>";
echo"<td class='Data DataRightAlign'>主城等级</td>";
echo"<td class='Data DataRightAlign'>操作时间</td>";

echo"</tr>";

$recno = 2;

$db = new dbstuff;
$db->connect( $dbh, $dbu, $dbp, $dbd, 0 );

$sql="SELECT * FROM server_list where id='$sysid'";
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
	$sysdbd=$row[7];
	$syslogdb=$row[11];
	
	echo "<tr class='Record_2'><th class='DataHeader'>$sysname [$actorid]</th><td></td><td></td><td></td><td></td><td></td><td></td></tr>";

	$db->connect( $sysdbh, $sysdbu, $sysdbp, $syslogdb, 0 );
	
	$wherestr = "";
	for( $tmpi = 0; $tmpi < $opnum; $tmpi++ )
	{
		if ( $array_op[$tmpi] > 0 )
		{
			if( $tmpi == 0 )
			{
				  $wherestr = "(";
					$wherestr = $wherestr."op='".$array_op[$tmpi]."' ";
			}
			else
				$wherestr = $wherestr." or op='".$array_op[$tmpi]."' ";
		}
	}
	if ( $wherestr != "" )
	{
		$wherestr = $wherestr.")";
	}
	
	if( $path > 0 )
	{
		if ( $wherestr != "" )
			$wherestr = $wherestr." and path='".$path."'";
		else
		  $wherestr = " path='".$path."'";
	}
		
	if( isset($_POST["actorid"]) && $_POST["actorid"] > 0 )
	{
		if ( $wherestr != "" )
			$wherestr = $wherestr." and actor1='".$actorid."'";
		else
		  $wherestr = " actor1='".$actorid."'";
	}
	
	$logcount=0;
	$sql="select op,path,object,objectnum,objectid,actor1,actor2,optime from ".$tabname." where ".$wherestr." and optime>='".$begintime."' and optime<='".$endtime."' limit $beginno,2000";
	echo "$sql";
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
		
		if ( $log_op_text[$op] == "" )
			echo"<td class='Data DataRightAlign'>$op</td>";
		else
			echo"<td class='Data DataRightAlign'>$log_op_text[$op]</td>";
		
		if ( $op == 26 )
		{
			echo"<td class='Data DataRightAlign'>$g_amtypename[$path]</td>";
		}
		else
		{
					if ( $log_path_text[$path] == "" )
						echo"<td class='Data DataRightAlign'>$path</td>";
					else
						echo"<td class='Data DataRightAlign'>$log_path_text[$path]</td>";
		}
		
		if ( $op == 5 )
		{
			echo"<td class='Data DataRightAlign'>$g_CityResName[$object]</td>";
		}
		else if ( $op == 3 || $op == 4 )
		{
			echo"<td class='Data DataRightAlign'>$g_itemkind[$object]</td>";
		}
		else if ( $op == 11 && $path != 15 )
		{
			echo"<td class='Data DataRightAlign'>$g_BuildingName[$object]</td>";
		}
		else if ( $op == 13 && $path != 14 )
		{
			echo"<td class='Data DataRightAlign'>$g_CorpsName[$object]</td>";
		}
		else if ( $op == 23 )
		{
			echo"<td class='Data DataRightAlign'>$g_QuestType[$object]</td>";
		}
		else	
		{
			echo"<td class='Data DataRightAlign'>$object</td>";
		}
		
		if ( $op == 29 )
		{
			echo"<td class='Data DataRightAlign'>$g_ArmyActionName[$objectnum]</td>";
		}
		else if ( $op == 13 && $path != 14 )
		{
			echo"<td class='Data DataRightAlign'>$g_CorpsLV[$objectnum]</td>";
		}
		else
		{
			echo"<td class='Data DataRightAlign'>$objectnum</td>";
		}
		
		if ( $op == 29 )
		{
			echo"<td class='Data DataRightAlign'>$g_UnitTypeName[$objectid]</td>";
		}
		else 
		{
			echo"<td class='Data DataRightAlign'>$objectid</td>";
		}
		echo"<td class='Data DataRightAlign'>$actor2</td>";
		echo"<td class='Data DataRightAlign'>$optime</td>";
	
		echo"</tr>";
		$logcount++;
	}
	$db->close();
		
}
echo"</table>";
echo "总计：$logcount";
echo "<br>";
echo "<br>";
echo "<br>";
echo "日志选项";
?>

<form id='form1' name='form1' method='post' action='log_actor.php'>
<table  border='0' cellspacing='0' cellpadding='0' class='TableData' >
	
	<tr class="Record_2">
		<th class="DataOfPrimaryKey DataRightAlign">时间</th>
		<td class="Data DataRightAlign">
		<input type="hidden" id="sysid" name="sysid" size="20" value="<?php echo $sysid ?>"/>
		<input type="hidden" id="actorid" name="actorid" size="20" value="<?php echo $actorid ?>"/>
		<input type="text" id="date" name="date" size="20" value="<?php echo date("Y-m-d"); ?>"/>
		<input type="text" id="begintime" name="begintime" size="20" value="00:00:00"/>-
		<input type="text" id="endtime" name="endtime" size="20" value="23:59:59"/>
	  </td>
	</tr>
	
	<tr class="Record_1">
		<th class="DataOfPrimaryKey DataRightAlign">操作</th>
		<td class="Data DataRightAlign">
		<input type=checkbox onclick=sel('op[]')>全选
<?php
				$log_op_text_num = 0;
				foreach($log_op_text as $k=>$v)
				{
					echo "<input name='op[]' type='checkbox' value='".$k."' >".$v."</input> ";
					if ( $log_op_text_num > 10 )
					{
					 	echo "<br>";
					 	$log_op_text_num = 0;
					}
					$log_op_text_num = $log_op_text_num + 1;
				}
?>
		
	    </td>
	</tr>
	
	<tr class="Record_2">
		<th class="DataOfPrimaryKey DataRightAlign">途径</th>
		<td class="Data DataRightAlign">
	    <select id="path" name="path" onChange="opselect(this)">
<?php
				foreach($log_path_text as $k=>$v)
				{
					echo "<option value='".$k."'";
					echo ">[".$k."]".$v."</option>";
				}
?> 
	    </select>
	    </td>
	</tr>
	
	
	<tr class="Record_2">
		<th class="DataOfPrimaryKey DataRightAlign">页号</th>
		<td class="Data DataRightAlign">
		<input type="text" id="page" name="page" size="8" value="1"/>
	    </td>
	</tr>
	<tr class="Record_1">
		<th class="DataOfPrimaryKey DataRightAlign"> </th>
		<td class="Data DataRightAlign">
		<input type="submit" id="submit" name="submit" value="提交" />
	    </td>
	</tr>
</table>
</form>

</body>
</html>