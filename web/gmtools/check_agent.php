<?php
error_reporting(0);
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); 
header("Last-Modified: ".gmdate("D, d M Y H:i:s")." GMT"); 
header("Cache-Control: no-cache, must-revalidate"); 
header("Pramga: no-cache"); 
echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />";
if (!get_magic_quotes_gpc())
{
	$command=addslashes(@$_GET['c']);
	$host=addslashes(@$_GET['h']);
}
else
{
	$command=@$_GET['c'];
	$host=@$_GET['h'];
}
//$host='10.132.36.1';
$len = strlen( $command );
$sock = fsockopen ($host.":33900" );
if( !$sock )
{
	echo "No Agent";
}
else
{
	$arr=explode("|", $command );
	if( count($arr) < 3 )
	{
		echo "<img src='/images/stat9.jpg' />";
	}

	fputs( $sock, pack("s", $len).$command."\0" );

	if( $arr[1] == 0 )
	{
		$result = fgets( $sock );
		if( $result == 0 )
		{
			echo "<img src='/images/stat0.jpg' />";
		}
		elseif( $result == 1 )
		{
			echo "<img src='/images/stat1.jpg' />";
		}
		elseif( $result == 2 )
		{
			echo "<img src='/images/stat2.jpg' />";
		}
		elseif( $result == 3 )
		{
			echo "<img src='/images/stat3.jpg' />";
		}
		elseif( $result == 4 )
		{
			echo "<img src='/images/stat4.jpg' />";
		}
		elseif( $result == 5 )
		{
			echo "<img src='/images/stat5.jpg' />";
		}
		elseif( $result == 6 )
		{
			echo "<img src='/images/stat6.jpg' />";
		}

		$result = fgets( $sock );
		if( $result == 0 )
		{
			echo "<img src='/images/proc0.jpg' />";
		}
		elseif( $result == 1 )
		{
			echo "<img src='/images/proc1.jpg' />";
		}
		elseif( $result == 2 )
		{
			echo "<img src='/images/proc2.jpg' />";
		}
		elseif( $result == 3 )
		{
			echo "<img src='/images/proc3.jpg' />";
		}
		elseif( $result == 4 )
		{
			echo "<img src='/images/proc4.jpg' />";
		}

		$result = fgets( $sock );
		if( $result == 0 )
		{
			echo "";
		}
		else
		{
			echo "<font color=red>savesqlfile.sql</font>";
		}
	}
	else
	{
		$result = fgets( $sock );
		if( $result == 0 )
		{
			echo "�ɹ�<br>";
		}
		elseif( $result == -1 )
		{
			echo "�����Ѿ�����������<br>";
			$result = fgets( $sock );
			if( $result == 0 )
			{
				echo "��ǰ��������<br>";
			}
			elseif( $result == 1 )
			{
				echo "��ǰ����������������<br>";
			}
			elseif( $result == 2 )
			{
				echo "��ǰ�������رշ�����<br>";
			}
			elseif( $result == 3 )
			{
				echo "��ǰ��������ȡ��װ��<br>";
			}
			elseif( $result == 4 )
			{
				echo "��ǰ��������ѹ��װ��<br>";
			}
		}
		elseif( $result == -2 )
		{
			echo "����.proc�ļ���ʧ��<br>";
		}
	}
	fclose ($sock);
}


?>
