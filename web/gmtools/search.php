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
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script language="javascript">
 function sel(a){
  o=document.getElementsByName(a)
  for(i=0;i<o.length;i++)
  o[i].checked=event.srcElement.checked
 }
</script>
</head>

<body>
<a href="awardad.php" type=_blank>����</a>
<?php
echo "<form id='form1' name='form1' method='post' action='search_action.php'>";

$db = new dbstuff;
$pconnect = 0;
$remote_ip=$dbhost;
$dbu = $dbuser;
$dbp = $dbpw;
$dbd = $dbname;
$db->connect( $remote_ip, $dbu, $dbp, $dbd, 0 );

$sql="SELECT * FROM server_list where id > 100 order by id";
$query = $db->query($sql);

echo"<table border='0' cellspacing='0' cellpadding='0' class='TableData' >";
echo "<tr class='TableHeader'><th class='DataHeader'>ѡ��</th><th class='DataHeader'>������ID</th><th class='DataHeader'>����������</th><th class='DataHeader'>������IP</th></tr>";
$recno = 2;

while($row = $db->fetch_row($query))
{

	$sysid=$row[0];
	$sysname=$row[1];
	$sysip=$row[2];
	$sysport=$row[3];

	if( $recno == 1 )
		$recno = 2;
	else
		$recno = 1;

	echo"<tr class='Record_$recno'>";
	echo"<td class='Data DataRightAlign'><input name='favor[]' type='checkbox' value='$sysid' ></td>";
	echo"<td class='Data DataRightAlign'>$sysid</td>";
	echo"<td class='Data DataRightAlign'>$sysname</td>";
	echo"<td class='Data DataRightAlign'>$sysip:$sysport</td>";
	echo"</tr>";

}
echo"<tr class='TableHeader'>";
echo"<td class='Data DataRightAlign'><input type=checkbox onclick=sel('favor[]')></td>";
echo"<td class='Data DataRightAlign'>ȫѡ</td>";
echo"<td class='Data DataLeftAlign'> </td>";
echo"<td class='Data DataLeftAlign'> </td>";
echo"</table>";
$db->close();
?>             
<table  border='0' cellspacing='0' cellpadding='0' class='TableData' >
	<tr class="Record_1">
		<th class="DataOfPrimaryKey DataRightAlign">���ID</th>
		<td class="Data DataRightAlign">
		<input type="text" id="actorid" name="actorid" size="8" value=""/>
	    </td>
	</tr>
	<tr class="Record_2">
		<th class="DataOfPrimaryKey DataRightAlign">ʱ��</th>
		<td class="Data DataRightAlign">
		<input type="text" id="indata" name="indata" size="20" value="<?php echo date("Y-m-d"); ?>"/>
		<input type="text" id="intime" name="intime" size="20" value="00:00:00"/>-
		<input type="text" id="intime2" name="intime2" size="20" value="23:59:59"/>
	    </td>
	</tr>
	<tr class="Record_1">
		<th class="DataOfPrimaryKey DataRightAlign">ָ������</th>
		<td class="Data DataRightAlign">
		<input type="text" id="object" name="object" size="8" value=""/>
	    </td>
	</tr>
	<tr class="Record_2">
		<th class="DataOfPrimaryKey DataRightAlign">;��</th>
		<td class="Data DataRightAlign">
	    <select id="oppath" name="oppath" onChange="opselect(this)">
	      <option value="-1">�κ�;��</option>
	      <option value="0">��ͨ(ϵͳ)</option>
	      <option value="2">�鿨</option>
	      <option value="4">�̵�</option>
	      <option value="7">ÿ������</option>
	      <option value="8">�ű�����</option>
	      <option value="9">ˢ�ֽ���</option>
	      <option value="10">����</option>
	      <option value="11">ͨ��ʯ</option>
	      <option value="12">ÿ�չ���</option>
	      <option value="14">������</option>
	      <option value="15">�̳�</option>
	      <option value="16">������</option>
	      <option value="17">װ���ϳ�</option>
	      <option value="18">װ��ǿ��</option>
	      <option value="20">����ϳ�</option>
	      <option value="22">װ������</option>
	      <option value="23">װ������</option>
	      <option value="25">��ֵ</option>
	      <option value="26">����</option>
	      <option value="28">����</option>
	      <option value="30">����ǿ��</option>
	      <option value="31">ʹ����Ʒ</option>
	      <option value="32">ս������</option>
	      <option value="33">���ֿ�</option>
	      <option value="34">ǩ��</option>
	      <option value="35">è��</option>
	      <option value="37">��ħ</option>
	      <option value="38">����</option>
	      <option value="39">�׳�</option>
	      <option value="40">����ٻ�</option>
	      <option value="41">��鼼��</option>
	      <option value="42">������</option>
	      <option value="43">�������</option>
	      <option value="44">�ʼ�</option>
	      <option value="45">���ֽ�</option>
	      <option value="46">������½</option>
	      <option value="49">��ֵ����</option>
	      <option value="50">����</option>
	      <option value="84">�</option>
	      <option value="85">Ĥ��</option>
	      <option value="86">��Ȫ</option>
	    </select>
	    </td>
	</tr>
	<tr class="Record_1">
		<th class="DataOfPrimaryKey DataRightAlign">ѡ��</th>
		<td class="Data DataRightAlign">
		<input type=checkbox onclick=sel('op[]')>ȫѡ
		<input name='op[]' type='checkbox' value='4' > ����
		<input name='op[]' type='checkbox' value='1' > ��Ǯ
		<input name='op[]' type='checkbox' value='39' > ��ʯ
		<input name='op[]' type='checkbox' value='47' > ����
		<input name='op[]' type='checkbox' value='40' > ����
		<input name='op[]' type='checkbox' value='6' > ���
		<input name='op[]' type='checkbox' value='2' > ����Ʒ
		<input name='op[]' type='checkbox' value='3' > ʧ��Ʒ
		<input name='op[]' type='checkbox' value='5' > ��������
		<input name='op[]' type='checkbox' value='9' > ��ɫ����
		<input name='op[]' type='checkbox' value='15' > װ������
		<input name='op[]' type='checkbox' value='37' > �����
	    </td>
	</tr>
	<tr class="Record_2">
		<th class="DataOfPrimaryKey DataRightAlign">��������</th>
		<td class="Data DataRightAlign">
		����1��<input type="text" id="value_min1" name="value_min1" size="8" value="0"/>-
		<input type="text" id="value_max1" name="value_max1" size="8" value="0"/>
		����2��<input type="text" id="value_min2" name="value_min2" size="8" value="0"/>-
		<input type="text" id="value_max2" name="value_max2" size="8" value="0"/>
		����3��<input type="text" id="value_min3" name="value_min3" size="8" value="0"/>-
		<input type="text" id="value_max3" name="value_max3" size="8" value="0"/>
	    </td>
	</tr>
	<tr class="Record_2">
		<th class="DataOfPrimaryKey DataRightAlign">ҳ��</th>
		<td class="Data DataRightAlign">
		<input type="text" id="page" name="page" size="8" value="1"/>
	    </td>
	</tr>
	<tr class="Record_1">
		<th class="DataOfPrimaryKey DataRightAlign"> </th>
		<td class="Data DataRightAlign">
		<input type="submit" id="submit" name="submit" value="�ύ" />
	    </td>
	</tr>
</table>
</form>
</body>
</html>