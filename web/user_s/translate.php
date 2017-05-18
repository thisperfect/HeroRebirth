<?php
require_once '../db.inc.php';
require_once 'HttpClient.php';
error_reporting(0);
header("content-type:text/html; charset=utf-8");

function wlogtranslate( $db, $msg )
{
	$sql="INSERT INTO errorlog (`msg`,`optime`) values('$msg',now())";
	$db->query($sql);
}

// �ٶȷ���
function baidu( $db, $text, $to, $serverid, $cityid, $timestamp )
{
		// �ٶȷ����ӦĿ������
	$baidu_tolang = array( 
	"ar"=>"ara", "de"=>"de", "en"=>"en", "es"=>"spa", "fr"=>"fra",
	"it"=>"it", "nl"=>"nl", "pl"=>"pl", "pt"=>"pt", "ru"=>"ru", "th"=>"th", "zh"=>"zh" );
	
	$from = "auto";
	$text = rawurldecode($text);
	$translateString = $text;
			
	// �Ȱ���Ϸ�ڲ������Ŀ������ת�����ٶȶ����Ŀ������
	$tolang = "en";
	if ( in_array( $to, $baidu_tolang ) )
	{ // ƥ�䵽��Ŀ������
		$tolang = $baidu_tolang[$to];
	}
	
	// �÷�����Ϣ��Ψһ��ʾ
	$key = md5( $to . $serverid . $cityid . $timestamp );
	
	// �ȼ�����ݿ����Ƿ���ڣ����ھ�ֱ����
	$sql="select str from baidu where baidu.key='$key'";
	$query = $db->query($sql);
	if($sth = $db->fetch_row($query))
	{
		$translateString = $sth[0];
		$db->free_result($query);
	}
	else
	{
		// ���ݲ����ڣ�ȥ�ٶ��÷���
		$url = "http://api.fanyi.baidu.com/api/trans/vip/translate";
		
		// ����
		//$translateAppid = "20161115000031885";
		//$translateKey = "6qFbK6QnQPQGN2RciFwN";	
		
		// ʷ��
		//$translateAppid = "20161117000032080";
		//$translateKey = "jDZTFHqPoCcDvAB4h9vj";
		
		// ������
		//$translateAppid = "20161220000034318";
		//$translateKey = "YqicwAqUw045XcaTovMI";
			
		// ���
		//$translateAppid = "20170114000035844";
		//$translateKey = "lsxfZu1WVRWq_CiguZU1";
		
		// ������
		$translateAppid = "20170114000035845";
		$translateKey = "RRzfwYHTJEd2lffzs5i1";
		
		// �����
		//$translateAppid = "20170114000035846";
		//$translateKey = "lrpFju8YAT8ZE3A_0lDG";
		
		// ���
		//$translateAppid = "20170114000035847";
		//$translateKey = "2AQB1_mCTk_3o3fH35p2";
		
		// �Ϸ�
		//$translateAppid = "20170114000035848";
		//$translateKey = "qTVWEtxcCe2KwdNoHPqd";
		
		// ֣��
		//$translateAppid = "20170114000035849";
		//$translateKey = "Ym8WsEsqpBmpVjxkU0lk";
		
		// ����
		//$translateAppid = "20170114000035850";
		//$translateKey = "ATmMCXwMLW37ge7MTfV_";
		
		// ����
		//$translateAppid = "20170114000035851";
		//$translateKey = "Zu1pj6fVAwg8FaDZkuHj";
		
		
		$salt = rand( 10000, 2147483647 );
		$sign = md5( $translateAppid . $text . $salt . $translateKey );
		$get = $url."?q=" . rawurlencode($text) . "&from=auto" ."&to=" . $tolang . "&appid=" . $translateAppid . "&salt=" . $salt ."&sign=" . $sign;
		$ret = HttpClient::quickGet( $get );
		$ret = json_decode($ret, true);
		
		// �д���
		$error = $ret["error_code"];
		if ( $error != null )
		{ // �д���
			
		}
		else
		{
			$error = "";
			$translateString = $ret["trans_result"][0]["dst"];  // ������
			$from = $ret["from"];
		}
		
		// ���뵽���ݿ��ﱸ��
		$sql = "REPLACE INTO `baidu` SET `key`='$key',`src`='$text',`str`='$translateString',`from`='$from',`to`='$tolang',`serverid`=$serverid,`cityid`=$cityid,`timestamp`=$timestamp,`error`='$error';";
		$query = $db->query($sql);
	}
	
	return "\"str\":\"$translateString\"";
}



// google����
function google( $db, $text, $to, $serverid, $cityid, $timestamp )
{
		// google�����ӦĿ������
		$google_tolang = array(
		"af"=>"af",
		"am"=>"am",
		"ar"=>"ar",
		"az"=>"az",
		"be"=>"be",
		"bg"=>"bg",
		"bn"=>"bn",
		"bs"=>"bs",
		"ca"=>"ca",
		"ceb"=>"ceb",
		"co"=>"co",
		"cs"=>"cs",
		"cy"=>"cy",
		"da"=>"da",
		"de"=>"de",
		"el"=>"el",
		"en"=>"en",
		"eo"=>"eo",
		"es"=>"es",
		"et"=>"et",
		"eu"=>"eu",
		"fa"=>"fa",
		"fi"=>"fi",
		"fr"=>"fr",
		"fy"=>"fy",
		"ga"=>"ga",
		"gd"=>"gd",
		"gl"=>"gl",
		"gu"=>"gu",
		"ha"=>"ha",
		"haw"=>"haw",
		"hi"=>"hi",
		"hmn"=>"hmn",
		"hr"=>"hr",
		"ht"=>"ht",
		"hu"=>"hu",
		"hy"=>"hy",
		"id"=>"id",
		"ig"=>"ig",
		"is"=>"is",
		"it"=>"it",
		"iw"=>"iw",
		"ja"=>"ja",
		"jw"=>"jw",
		"ka"=>"ka",
		"kk"=>"kk",
		"km"=>"km",
		"kn"=>"kn",
		"ko"=>"ko",
		"ku"=>"ku",
		"ky"=>"ky",
		"la"=>"la",
		"lb"=>"lb",
		"lo"=>"lo",
		"lt"=>"lt",
		"lv"=>"lv",
		"mg"=>"mg",
		"mi"=>"mi",
		"mk"=>"mk",
		"ml"=>"ml",
		"mn"=>"mn",
		"mr"=>"mr",
		"ms"=>"ms",
		"mt"=>"mt",
		"my"=>"my",
		"ne"=>"ne",
		"nl"=>"nl",
		"no"=>"no",
		"ny"=>"ny",
		"pa"=>"pa",
		"pl"=>"pl",
		"ps"=>"ps",
		"pt"=>"pt",
		"ro"=>"ro",
		"ru"=>"ru",
		"sd"=>"sd",
		"si"=>"si",
		"sk"=>"sk",
		"sl"=>"sl",
		"sm"=>"sm",
		"sn"=>"sn",
		"so"=>"so",
		"sq"=>"sq",
		"sr"=>"sr",
		"st"=>"st",
		"su"=>"su",
		"sv"=>"sv",
		"sw"=>"sw",
		"ta"=>"ta",
		"te"=>"te",
		"tg"=>"tg",
		"th"=>"th",
		"tl"=>"tl",
		"tr"=>"tr",
		"uk"=>"uk",
		"ur"=>"ur",
		"uz"=>"uz",
		"vi"=>"vi",
		"xh"=>"xh",
		"yi"=>"yi",
		"yo"=>"yo",
		"zh"=>"zh",
		"zh-TW"=>"zh-TW",
		"zu"=>"zu" );
	
	
	$from = "auto";
	$text = rawurldecode($text);
	$translateString = $text;
			
	// �Ȱ���Ϸ�ڲ������Ŀ������ת����google�����Ŀ������
	$tolang = "en";
	if ( in_array( $to, $google_tolang ) )
	{ // ƥ�䵽��Ŀ������
		$tolang = $google_tolang[$to];
	}
	
	// �÷�����Ϣ��Ψһ��ʾ
	$key = md5( $to . $serverid . $cityid . $timestamp );
	
	// �ȼ�����ݿ����Ƿ���ڣ����ھ�ֱ����
	$sql="select str from google where google.key='$key'";
	$query = $db->query($sql);
	if($sth = $db->fetch_row($query))
	{
		$translateString = $sth[0];
		$db->free_result($query);
	}
	else
	{
		// ���ݲ����ڣ�ȥgoogle�÷���
		$url = "https://translation.googleapis.com/language/translate/v2?";
		$key = "AIzaSyCIp7tgORQbDN0J2ebuMPigR_9C6loL3C8";
		$get = $url."key=".$key."&q=" . rawurlencode($text) . "&target=" . $tolang;
		$ret = HttpClient::quickGet( $get );
		$ret = json_decode($ret, true);
		
		// �д���
		$error = $ret["error"];
		$errorcode = "";
		if ( $error != null )
		{ // �д���
			$errorcode = $ret["error"]["code"];
		}
		else
		{
			$error = "";
			$translateString = $ret["data"]["translations"][0]["translatedText"];  // ������
			$from = $ret["data"]["translations"][0]["detectedSourceLanguage"];
		}
		
		// ���뵽���ݿ��ﱸ��
		$sql = "REPLACE INTO `google` SET `key`='$key',`src`='$text',`str`='$translateString',`from`='$from',`to`='$tolang',`serverid`=$serverid,`cityid`=$cityid,`timestamp`=$timestamp,`error`='$errorcode';";
		$query = $db->query($sql);
	}
	
	return "\"str\":\"$translateString\"";
}

// ΢��bing����
function getToken($azure_key)
{
    $url = 'https://api.cognitive.microsoft.com/sts/v1.0/issueToken';
    $ch = curl_init();
    $data_string = json_encode('{body}');
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Content-Type: application/json',
            'Content-Length: ' . strlen($data_string),
            'Ocp-Apim-Subscription-Key: ' . $azure_key
        )
    );
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HEADER, false);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    $strResponse = curl_exec($ch);
    curl_close($ch);
    return $strResponse;
}
function curlRequest($url, $authHeader)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, array($authHeader, "Content-Type: text/xml"));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, False);
    $curlResponse = curl_exec($ch);
    curl_close($ch);
    return $curlResponse;
}
function bing( $db, $text, $to, $serverid, $cityid, $timestamp )
{
	$bing_tolang = array(
				"af"=>"af",	// �ϷǺ�����
				"ar"=>"ar",	// ��������
				"bn"=>"bn",	// �ϼ�����
				"bs"=>"bs-Latn",	// ��˹������
				"bg"=>"bg",	// ����������
				"ca"=>"ca",	// ��̩¡��
				"cn"=>"zh-CHS",	// ��������
				"zh-cn"=>"zh-CHS",	// ��������
				"zh-CN"=>"zh-CHS",	// ��������
				"zh"=>"zh-CHS",	// ��������
				"zh-TW"=>"zh-CHT",	// ��������
				"zh-TW"=>"yue",	// ����(����)
				"hr"=>"hr",	// ���޵�����
				"cs"=>"cs",	// �ݿ���
				"da"=>"da",	// ������
				"nl"=>"nl",	// ������
				"en"=>"en",	// Ӣ��
				"et"=>"et",	// ��ɳ������
				"fj"=>"fj",	// 쳼�
				"fil"=>"fil",	// ���ɱ���
				"fi"=>"fi",	// ������
				"fr"=>"fr",	// ����
				"de"=>"de",	// ����
				"el"=>"el",	// ϣ����
				"ht"=>"ht",	// ���ؿ���¶���
				"he"=>"he",	// ϣ������
				"hi"=>"hi",	// ӡ����
				"mww"=>"mww",	// ������
				"hu"=>"hu",	// ��������
				"id"=>"id",	// ӡ����������
				"it"=>"it",	// �������
				"ja"=>"ja",	// ����
				"sw"=>"sw",	// ˹��ϣ����
				"tlh"=>"tlh",	// ���ֹ���
				"tlh-Qaak"=>"tlh-Qaak",	// ���ֹ��� (pIqaD)
				"ko"=>"ko",	// ������
				"kr"=>"ko",	// ����
				"lv"=>"lv",	// ����ά����
				"lt"=>"lt",	// ��������
				"mg"=>"mg",	// �����ʲ��
				"ms"=>"ms",	// ������
				"mt"=>"mt",	// �������
				"yua"=>"yua",	// �ȿ�̹������
				"no"=>"no",	// Ų����
				"otq"=>"otq",	// �������ް�������
				"fa"=>"fa",	// ��˹��
				"pl"=>"pl",	// ������
				"pt"=>"pt",	// ��������
				"ro"=>"ro",	// ����������
				"ru"=>"ru",	// ����
				"sm"=>"sm",	// ��Ħ����
				"sr-Cyrl"=>"sr-Cyrl",	// ����ά���� (�������)
				"sr-Latn"=>"sr-Latn",	// ����ά���� (������)
				"sk"=>"sk",	// ˹�工����
				"sl"=>"sl",	// ˹����������
				"es"=>"es",	// ��������
				"sv"=>"sv",	// �����
				"ty"=>"ty",	// ��ϣ����
				"th"=>"th",	// ̩��
				"to"=>"to",	// ������
				"tr"=>"tr",	// ��������
				"uk"=>"uk",	// �ڿ�����
				"ur"=>"ur",	// �ڶ�����
				"vi"=>"vi",	// Խ����
				"cy"=>"cy"	// ����ʿ�� 
				);
	
	$text = rawurldecode($text);
	$translateString = $text;
			
	// �Ȱ���Ϸ�ڲ������Ŀ������ת����bing�����Ŀ������
	$tolang = "en";
	if ( $to == "zh" )
	{
		$tolang = "zh-CHS";
	}
	else if ( $to == "zh-TW" )
	{
		$tolang = "zh-CHT";
	}
	else
	{
			if ( in_array( $to, $bing_tolang ) )
			{ // ƥ�䵽��Ŀ������
				$tolang = $bing_tolang[$to];
			}
	}
	
	// �÷�����Ϣ��Ψһ��ʾ
	$key = md5( $to . $serverid . $cityid . $timestamp );
	
	// �ȼ�����ݿ����Ƿ���ڣ����ھ�ֱ����
	$sql="select str from bing where bing.key='$key'";
	$query = $db->query($sql);
	if($sth = $db->fetch_row($query))
	{
		$translateString = $sth[0];
		$db->free_result($query);
	}
	else
	{
		// ���ݲ����ڣ�ȥbing�÷���
		$azure_key = "2322b9d2e82d4de7b9b6adbda30a325b";
		$accessToken = getToken($azure_key);
		$params = "text=" . urlencode($text) . "&to=" . $tolang . "&appId=Bearer+" . $accessToken;
		$translateUrl = "http://api.microsofttranslator.com/v2/Http.svc/Translate?$params";
		$curlResponse = curlRequest($translateUrl, $authHeader);
		$xmlObj = simplexml_load_string($curlResponse);
		foreach ((array)$xmlObj[0] as $val) {
		    $translateString = $val;
		}
		
		// ���뵽���ݿ��ﱸ��
		$sql = "REPLACE INTO `bing` SET `key`='$key',`src`='$text',`str`='$translateString',`from`='auto',`to`='$tolang',`serverid`=$serverid,`cityid`=$cityid,`timestamp`=$timestamp,`error`='-1';";
		$query = $db->query($sql);
	}
	
	return "\"str\":\"$translateString\"";
}

if (!get_magic_quotes_gpc())
{
	$command=addslashes(@$_GET['c']);
	$text=addslashes(@$_GET['text']);
	$to=addslashes(@$_GET['to']);
	$serverid=addslashes(@$_GET['sid']);
	$cityid=addslashes(@$_GET['cid']);
	$timestamp=addslashes(@$_GET['stamp']);
	$ext=addslashes(@$_GET['ext']);
}
else
{
	$command=@$_GET['c'];
	$text=@$_GET['text'];
	$to=@$_GET['to'];
	$serverid=@$_GET['sid'];
	$cityid=@$_GET['cid'];
	$timestamp=@$_GET['stamp'];
	$ext=@$_GET['ext'];
}

$db = new dbstuff;
$pconnect = 0;
$db->connect( $translate_dbhost, $translate_dbuser, $translate_dbpw, $translate_dbname, 0 );
$db->query("SET NAMES UTF8");

$msg = baidu( $db, $text, $to, $serverid, $cityid, $timestamp );
//$msg = google( $db, $text, $to, $serverid, $cityid, $timestamp );
//$msg = bing( $db, $text, $to, $serverid, $cityid, $timestamp );
echo "{ \"cmd\":\"$command\", $msg, \"ext\":\"$ext\" }";
?>
