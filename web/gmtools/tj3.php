<?php header("content-Type: text/html; charset=gbk");session_start(); ?>
<html>
<style type="text/css">
<!--
.c2 {
	font-family: "����";
	font-size: 14px;
	position: relative;
	width: 200px;
	float: left;
	height: 100px;
}
.c6 {
	font-family: "����";
	font-size: 14px;
	position: relative;
	width: 320px;
	float: left;
	height: 360px;
}
.c12 {
	font-family: "����";
	font-size: 14px;
	position: relative;
	width: 460px;
	float: left;
	height: 360px;
}
.d1 {
	font-family: "����";
	font-size: 14px;
	position: relative;
	width: 190px;
	float: left;
	height: 100px;
}
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
		.DataHeader_2 {text-decoration: bold; border-color: #000000; background-color: #e0e0e0;}
		.DataOfPrimaryKey {text-align: left; text-decoration: bold; border-color: #aaaaaa; background-color: #e0e0e0;}
		.DataOfUniqueKey {border-color: #aaaaaa;}
		.Data {border-color: #aaaaaa;}
		.DataRightAlign {text-align: right;}
		.DataLeftAlign {text-align: left;}
		.DataNull {color: #999999; border-color: #aaaaaa;}
	--></style>
<body>

<?php
require_once 'db.inc.php';
if(!session_is_registered("adminid") || $_SESSION["adminid"] <= 0 )
{
	exit("<script language='javascript'>window.location.href='login_ad.php';</script>");
}
else
{
	exit("<script language='javascript'>window.location.href='queryad.php';</script>");
}
// ��utf-8ת��Ϊgb
// $content = iconv("utf-8","gb2312//IGNORE",$content);

// ��gbת��Ϊutf-8
// $content = iconv("gb2312","utf-8//IGNORE",$content);

// 61907d35-37fe-4ef4-9057-80b9e83099f0134627

// SET NAMES gbk;

echo "<p>";

echo "<a href='queryad.php'>��ѯ<a>��";
echo "<a href='awardad.php'>����<a>��";

echo "</p>";

?>

</body>
</html>
