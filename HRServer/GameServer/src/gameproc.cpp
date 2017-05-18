#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include <stdio.h>
#include <string.h>
#include <setjmp.h>

#include "db.h"
#include "dbredis.h"
#include "account.h"
#include "gameproc.h"
#include "actor.h"
#include "script.h"
#include "utils.h"
#include "gamelog.h"
#include "define.h"
#include "client.h"
#include "server_process_auto.h"
#include "login.h"
#include "timegmcmd.h"
#include "wqueue.h"
#include "server_netrecv_auto.h"
#include "actor_notify.h"
#include "system.h"
#include "item.h"
#include "global.h"
#include "map.h"
#include "mapunit.h"
#include "gmcmd.h"
#include "award.h"
#include "global_netprocess.h"
#include "script_auto.h"
#include "activity.h"
#include "script_auto.h"
#include "global_cmdqueue.h"
#include "city.h"

#ifndef WIN32 // ��Щͷ�ļ�������ulimit���õ�
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/resource.h>
#endif

extern MYSQL *myGame;
SConfig g_Config;

int g_speed = 0;
int g_sec = 0;	// ����

int g_mysql_wait = 0;
int g_save_wait = 0;

int g_last_cmd = 0;

int g_maxactornum = 512;
int g_frame_count;
extern int g_nReadQueueHead;
extern int g_nReadQueueTail;
extern Actor *g_actors;
extern char g_user_queue_logic;

#ifndef WIN32
extern int linuxmsg_recv();
#endif

extern int serv_setstat( int stat );

int process_init( int max_connection )
{
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
#ifndef WIN32
	struct rlimit out_data={0};
	if ( getrlimit( RLIMIT_CORE, &out_data ) == 0 )
	{
		if ( out_data.rlim_cur != -1 )
		{
			out_data.rlim_cur = -1;
			out_data.rlim_max = -1;
			if ( setrlimit( RLIMIT_CORE, &out_data ) != 0 )
			{
				printf_msg( "setrlimit( RLIMIT_CORE, &out_data ) Error!" );
				return -1;
			}
		}
	}
	else
	{
		printf_msg( "getrlimit( RLIMIT_CORE, &out_data ) Error!" );
		return -1;
	}

	if ( getrlimit( RLIMIT_NOFILE, &out_data ) == 0 )
	{
		if ( out_data.rlim_cur < max_connection )
		{
			out_data.rlim_cur = 8196;
			out_data.rlim_max = 8196;
			if ( setrlimit( RLIMIT_NOFILE, &out_data ) != 0 )
			{
				printf_msg( "setrlimit( RLIMIT_NOFILE, &out_data ) Error!" );
				return -1;
			}
		}
	}
	else
	{
		printf_msg( "getrlimit( RLIMIT_NOFILE, &out_data ) Error!" );
		return -1;
	}

	// �ٴμ��
	if ( getrlimit( RLIMIT_CORE, &out_data ) == 0 )
	{
		if ( out_data.rlim_cur != -1 )
		{
			printf_msg( "getrlimit( RLIMIT_CORE, &out_data ) too small!" );
			return -1;
		}
	}
	else
	{
		printf_msg( "getrlimit( RLIMIT_CORE, &out_data ) Error!" );
		return -1;
	}

	if ( getrlimit( RLIMIT_NOFILE, &out_data ) == 0 )
	{
		if ( out_data.rlim_cur < max_connection )
		{
			printf_msg( "getrlimit( RLIMIT_NOFILE, &out_data ) too small!" );
			return -1;
		}
	}
	else
	{
		printf_msg( "getrlimit( RLIMIT_NOFILE, &out_data ) Error!" );
		return -1;
	}
#endif
	g_frame_count = 0;
	g_maxactornum = max_connection;

	serv_setstat( 2 );
	// ���г�ʼ��
	init_wqueue();

	// ִ�ж��г�ʼ��
	if ( exec_queue_init() < 0 )
	{
		printf_msg( "ExecQueue Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 3 );

	// ���ݿ��ʼ��
	if ( db_init() >= 0 )
		printf_msg( "Mysql Module ready!" );
	else
	{
		printf_msg( "Mysql Module Error!" );
		return -1;
	}
	serv_setstat( 4 );

	if ( dbredis_init() >= 0 )
		printf_msg( "Redis Module ready!" );
	else
	{
		printf_msg( "Redis Module Error!" );
		return -1;
	}
	serv_setstat( 5 );

	// �ű���ʼ��
	if ( lua_init( 0 ) >= 0 )
		printf_msg( "Lua Module ready!" );
	else
	{
		printf_msg( "Lua Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 6 );

	// account��ʼ��
	if ( account_init() >= 0 )
		printf_msg( "Account Module ready!" );
	else
	{
		printf_msg( "Account Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 6 );

	// ȫ�����ݳ�ʼ��
	if ( global_init() >= 0 )
		printf_msg( "Global Module ready!" );
	else
	{
		printf_msg( "Global Module Error!" );
		return -1;
	}
	serv_setstat( 5 );

	// ƽ̨��Ϣ��ʼ��
	if ( platinfo_init_auto() >= 0 )
		printf_msg( "Plat Module ready!" );
	else
	{
		printf_msg( "Plat Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 7 );

	//// ��Ʒ��ʼ��
	//if ( paygoods_init() >= 0 )
	//	printf_msg( "PayGoods Module ready!" );
	//else
	//{
	//	printf_msg( "PayGoods Module Error!" );
	//	return -1;
	//}
	//LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	//paycountry_init();
	//serv_setstat( 10 );

	//// ֧���̵��ʼ��
	//if ( paystore_init() >= 0 )
	//	printf_msg( "PayStore Module ready!" );
	//else
	//{
	//	printf_msg( "PayStore Module Error!" );
	//	return -1;
	//}
	//LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	//serv_setstat( 11 );

	// ��ɫ���ݳ�ʼ��
	if ( actors_init() >= 0 )
		printf_msg( "Actor Module ready!" );
	else
	{
		printf_msg( "Actor Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 13 );

	// ��½�߳�����
	if ( login_init() >= 0 )
		printf_msg( "Login Module ready!" );
	else
	{
		printf_msg( "Login Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 14 );

	// GMTOOLS
	if( gm_init() < 0 )
	{
		printf_msg( "GM Module Error!" );
		return -1;
	}
	LOGI("%s-%d",__FUNCTION__,__LINE__);
	global_process_init();
	serv_setstat( 15 );

	// �������ݳ�ʼ��
	if ( itemkind_init() < 0 )
	{
		printf_msg( "ItemKind Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 17 );

	// ���������ݳ�ʼ��
	if ( awardgroup_init() < 0 )
	{
		printf_msg( "AwardGroup Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 19 );

	// �������ݳ�ʼ��
	if ( upgradeinfo_init_auto() < 0 )
	{
		printf_msg( "upgradeinfo_init_auto Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 19 );


	activity_init();
	time_gmcmd_init();
	db_closedata();
	sc_Script_Init();
	//pushwork_init();
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 48 );

	// �����ͼ��ʼ�����ϸ�˳��Ҫ�󣬲�����ı䣩
	if ( map_init() < 0 )
	{
		printf_msg( "WorldMap Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 101 );

	// �������е�ͼ��ʾ��Ԫ�ṹ���ڳǳغͳ�������֮ǰ��ʼ�����ϸ�˳��Ҫ�󣬲�����ı䣩
	if ( mapunit_init() < 0 )
	{
		printf_msg( "MapUnit Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 102 );

	// �������г��У��ϸ�˳��Ҫ�󣬲�����ı䣩
	if ( city_load() < 0 )
	{
		printf_msg( "CityLoad Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 107 );

	// ˢ��ͼ
	sc_OnWorldMapBrush();
	serv_setstat( 117 );
	
	// ���ݿ���߳�����
	if ( dbwork_start() >= 0 )
		printf_msg( "dbwork Module ready!" );
	else
	{
		printf_msg( "dbwork Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 119 );

	
	// ȫ������
	if ( world_data_init() < 0 )
	{
		printf_msg( "TalkCacheLoad Module Error!" );
		return -1;
	}
	LOGI( "%s-%d", __FUNCTION__, __LINE__ );
	serv_setstat( 122 );
	return 0;
}

// �������ر�
void process_close()
{
	int tmpi;
	// �ر�ÿ���ͻ���
	for ( tmpi = 0; tmpi < g_maxactornum; tmpi++ )
	{
		actor_remove( tmpi );
		printf_msg( "actor_save %d/%d\r", tmpi + 1, g_maxactornum );
	}
	printf_msg( "\n" );


	// ����һ��������
	mysql_query( myGame, "START TRANSACTION" );

	// ���гǳر���
	city_save( NULL );
	printf_msg( "\n" );

	//// �������˱���
	//club_save( NULL );
	//printf_msg( "\n" );


	// �ύ
	mysql_query( myGame, "COMMIT;" );

	dbwork_stop();
	db_closegame();
	dbredis_close();
	lua_exit();
	/*pushwork_destory();*/
}

// ����-1,��ʾ����ֱ��������client
int process_onclose( int client_index )
{
	return actor_del( client_index );
}

int process_error( int client_index, int err )
{
	return 0;
}

int actors_save_everyone( char type );
int process_ondestory()
{
	// ���н�ɫ���ݱ���
	actors_save_everyone( 1 );
	return 0;
}
int Clear_Welcome();
int process_logic_wait_in();
int process_logic_wait_out();

int g_nExitHour = -1;
int g_nExitMin = -1;
int g_nExitNotify = 0;
time_t g_tExitTime = 0;
void process_exitlogic()
{
	static int s_count = 0;
	time_t t;
	char szMsg[MAX_PATH];
	int min = -1;

	if ( g_tExitTime <= 0 || g_nExitHour < 0 || g_nExitHour > 23 || g_nExitMin < 0 || g_nExitMin > 59 )
		return;
	time( &t );

	if ( g_tExitTime - t <= 0 )	// ����
		min = 0;
	else if ( g_tExitTime - t <= 60 )	// 1����
		min = 1;
	else if ( g_tExitTime - t <= 180 )	// 3����
		min = 3;
	else if ( g_tExitTime - t <= 300 )	// 5����
		min = 5;
	else if ( g_tExitTime - t <= 600 )	// 10����
		min = 10;
	else if ( g_tExitTime - t <= 14400 )	// 4Сʱ����(240����)
		min = -2;

	if ( min > 0 )
	{
		sprintf( szMsg, "�װ�������������Ǻã�������ά����Ҫ��������������%d������ͣ����Ϊ�������⣬�뾡�����ߣ�ף����Ϸ��죡", min );
		//system_talk( szMsg, TALK_CHANNEL_SYSTEM );
	}
	else if ( min == 0 )
	{
		g_nExitHour = -1;
		g_nExitMin = -1;
		g_tExitTime = 0;
		server_exit();
	}
	else if ( min == -2 )
	{
		if ( g_nExitNotify && (s_count % 60) == 0 )
		{
			sprintf( szMsg, "�װ�������������Ǻã���������ά������Ҫ������������%d��%d������ͣ����", g_nExitHour, g_nExitMin );
			//system_talk( szMsg, TALK_CHANNEL_SYSTEM );
		}
		s_count++;
	}
}

// 0~6 0~23 0~60 0~1
int process_set_exit( int weekday, int hour, int min, int isnotify )
{
	time_t t;
	struct tm *newtime;
	int weekdiff;

	if ( hour < 0 || min < 0 || hour > 23 || min > 59 )
	{
		g_nExitHour = -1;
		g_nExitMin = -1;
		g_tExitTime = 0;
		return -1;
	}

	time( &t );
	newtime = localtime( &t );

	if ( weekday < 0 || weekday > 6 )	// ����
	{
		g_tExitTime = t + (hour - newtime->tm_hour) * 60 * 60 + (min - newtime->tm_min) * 60;
		if ( g_tExitTime < t )
			g_tExitTime += 24 * 60 * 60;
	}
	else
	{
		weekdiff = weekday - newtime->tm_wday;
		if ( weekdiff <= 0 )
			weekdiff += 7;
		g_tExitTime = t + (hour - newtime->tm_hour) * 60 * 60 + (min - newtime->tm_min) * 60 + weekdiff * 24 * 60 * 60;
	}

	g_nExitHour = hour;
	g_nExitMin = min;
	g_nExitNotify = isnotify;

	return 0;
}

// ������Ҫ����ִ�е�������Էŵ�������
// ���СʱΪ-1����ʾ�״�ִ�У��������ο��Թ�
int process_oclock_process( int hour )
{
	if ( hour == 2 )
	{	
	}
	else if ( hour == 3 )
	{
	}
	else if ( hour == 4 )
	{	
	}
	else if ( hour == 6 )
	{
	}
	sc_OnClockProcess( hour );
	return 0;
}

static int nextclock_timestump = 0;
static int nexclock_hour = -1;
// �����ж���������������Ҫ������¼�������������
int process_oclock_check()
{
	time_t t;
	time( &t );

	// ��ǰʱ���Ѿ������¸�ʱ�ӵ�ʱ����
	if ( t > nextclock_timestump )
	{
		process_oclock_process( nexclock_hour );
		// ��ʱ���������һ��Сʱ
		t += 3600;
		// ��ȡʱ��
		struct tm *newtime;
		newtime = localtime( &t );
		// �����µ�����
		struct tm BeginTm = { 0 };
		BeginTm.tm_year = newtime->tm_year;
		BeginTm.tm_mon = newtime->tm_mon;
		BeginTm.tm_mday = newtime->tm_mday;
		BeginTm.tm_hour = newtime->tm_hour;
		BeginTm.tm_min = 0;
		BeginTm.tm_sec = 0;
		// ��������ʱ���
		nextclock_timestump = (int)mktime( &BeginTm );
		nexclock_hour = newtime->tm_hour;
	}
	return 0;
}

// ÿ��ִ��30��,Ŀǰ������30֡�߼�
int process_logic()
{
	int tick = 0;
	g_speed++;

	// ÿִ֡�е��ӳٶ��в���
	for ( int tmpi = 0; tmpi < 16; tmpi++ )
	{
		if ( exec_queue_fetch() < 0 )
			break;
	}

	// 1/10�������һ��mysql����
	if ( g_speed % 6 == 0 )
	{
		process_logic_wait_in();
	}

	// 1/6�������һ��д����
	if ( g_speed % 10 == 1 )
	{
		process_logic_wait_out();
	}

	// 10��һ�οͻ����߼�
	if ( g_speed % 300 == 0 )
	{
		client_logic();
	}

	// 5֡һ���߼�
	if ( g_speed % 5 == 0 )
	{
		actors_logic(); // ִ�����еĽ�ɫlogic
		map_logic(); // �����ͼ���߼�,��Ҫ��������
	}

	//	1����һ���߼�
	tick = g_speed % 30;
	if ( tick == 0 )
	{
		g_sec++;		// ����ɵ���������������������
		dbwork_fetchcomplete();
		globalcmd_fetch();
#ifndef WIN32
		linuxmsg_recv();
#endif
	}
	else if ( tick == 1 )
	{
		
	}
	else if ( tick == 2 )
	{
		
	}
	
	// 1����һ���߼�
	tick = g_speed % 1800;
	if ( tick == 0 )
	{
		//db_opendata();
		//upgradeinfo_reload_auto();
		//itemkind_reload_auto();
		//db_closedata();
		wcount(); // ��¼����
		sc_Script_Timer();
		process_exitlogic();
		process_oclock_check();
		time_gmcmd_logic();
		activity_logic();
	}
	else if ( tick == 10 )
	{
	}
	
	if ( g_speed > 108000 )
	{
		tick = g_speed % 108000;
		if ( tick == 0 )
		{ // ÿСʱһ���߼�
			sc_Script_Hour();
		}
		else if ( tick == 20 )
		{

		}
	}
	g_frame_count++;
	return 0;
}

int process_client( int client_index, char *tmpbuf, int readsize, int exec_code )
{
	short cmd;
	char *ptr;
	int tmpsize;
	int packsize;
	int allsize;
	char clientstat;

	//if( readsize < sizeof(short) )
	//	return -1;
	//ptr = tmpbuf; 
	//cmd = *((short *)ptr); ptr+=sizeof(short);
	//tmpsize = readsize - sizeof(short);

	ptr = tmpbuf;
	allsize = 0;

	g_last_cmd = -100;

	if ( client_getwait( client_index ) )
	{
		write_gamelog( "need wait:%d", client_index );
		return -1;
	}

	clientstat = client_getstat( client_index );
	while ( allsize < readsize )
	{
		packsize = *((short *)ptr); ptr += sizeof(short);
		if ( packsize <= 0 || packsize>1024 )
			break;
		cmd = *((short *)ptr); ptr += sizeof(short);
		tmpsize = packsize - sizeof(short);
		g_last_cmd = cmd;
		if ( client_index >= 0 && clientstat < CLIENT_STAT_LOGIN )
		{
			// �������δ��¼( �������Ե��õ�¼����ָ�� )
			if ( cmd != CMDC_LOGIN )
			{
				write_gamelog( "wrong command(no login):%d ip:%s", cmd, client_getip(client_index) );
				net_closesock_direct( client_index );
				return -1;
			}
		}
		else if ( clientstat == CLIENT_STAT_LOGIN )
		{
			// ����ҽ�����¼��δ������Ϸ(���Դ�����ɫ�������н�ɫ�����Խ�����Ϸ) ����ЩЭ��һ���ߵ�
			if ( cmd != CMDC_CREATE && cmd != CMDC_LIST && cmd != CMDC_DELETE && cmd != CMDC_ENTERGAME /*&& cmd != CMDC_HEARTBEAT*/ )
			{
				net_closesock_direct( client_index );
				return -1;
			}
		}
		else if ( clientstat == CLIENT_STAT_VER_ERR )
		{
			return -1;
		}
		if ( proc_command_S( client_index, cmd, ptr, tmpsize, exec_code ) < 0 )
		{
			if ( clientstat == CLIENT_STAT_LOGIN )
			{
				SClientInfo ClientInfo;
				char szUserID[21];
				client_getuserinfo( client_index, &ClientInfo );
				lltoa( ClientInfo.userid, szUserID, 10 );
				write_gamelog( "wrong command:%d userid:%s ip:%s", cmd, szUserID, client_getip(client_index) );
				net_closesock_direct( client_index );
			}
			else if ( clientstat == CLIENT_STAT_ENTERGAME )
			{
				write_gamelog( "wrong command:%d ip:%s", cmd, client_getip(client_index) );
				actor_remove( client_index );
			}
			else
			{
				write_gamelog( "wrong command:%d ip:%s", cmd, client_getip(client_index) );
				net_closesock_direct( client_index );
			}
			return -1;
		}
		ptr += tmpsize;
		allsize += packsize + sizeof(short);
	}
	return 0;
}

//-----------------------------------------------------------------------------
// process_logic_wait_in
// ����˵��: ��ɫ������Ϸ�Ķ���
//-----------------------------------------------------------------------------
int process_logic_wait_in()
{
	int client_index;
	short cmd;
	char tmpbuf[MAX_CMDPACKAGE_SIZE];
	int size;
	int exec_code;

	g_mysql_wait = 1;
	if ( fetch_wqueue( &client_index, &cmd, tmpbuf, &size, &exec_code, 0 ) == 0 )
	{
		//		if( cmd != WCMD_LEAVE && client_get_exec_code( client_index ) != exec_code )
#ifndef _USEGATE
		if ( client_get_exec_code( client_index ) != exec_code )
			return 0;
#endif
		// ��ʼ����һ��
		switch ( cmd )
		{
		case WCMD_ENTERGAME:
			return netrecv_entergame_S( client_index, tmpbuf, size );
			break;
		case WCMD_CREATE:
			return netrecv_create_S( client_index, tmpbuf, size );
			break;
		case WCMD_LIST:
			return netrecv_list_S( client_index, tmpbuf, size );
			break;
		}
	}
	// �����ǿյģ������κδ���
	return 0;
}

//-----------------------------------------------------------------------------
// process_logic_wait_out
// ����˵��: ��ɫ�˳���Ϸ���������ݵĶ���
//-----------------------------------------------------------------------------
int process_logic_wait_out()
{
	int client_index;
	short cmd;
	char tmpbuf[MAX_CMDPACKAGE_SIZE];
	int size;
	int exec_code;

	g_save_wait = 1;
	if ( fetch_wqueue( &client_index, &cmd, tmpbuf, &size, &exec_code, 1 ) == 0 )
	{
		// ��ʼ����һ��
		switch ( cmd )
		{
		case WCMD_LEAVE:
			return actor_remove( client_index );
			break;
		case WCMD_SAVE:
			return actor_real_saveall( client_index, NULL );
			break;
		}
	}

	// �����ǿյģ������κδ���
	return 0;
}

int process_dbreload()
{
	db_opendata();

	global_reload();
	awardgroup_reload();
	platinfo_reload_auto();
	itemkind_reload();

	db_closedata();
	return 0;
}
