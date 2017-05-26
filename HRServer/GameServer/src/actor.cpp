#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include "db.h"
#include "netserver.h"

#ifndef WIN32
#include <sys/time.h>
#endif

#include "server_netsend_auto.h"
#include "auto_actor.h"
#include "utils.h"
#include "actor.h"
#include "actor_send.h"
#include "wqueue.h"
#include "define.h"
#include "client.h"
#include "account.h"
#include "item.h"
#include "system.h"
#include "global.h"
#include "actor_notify.h"
#include "award.h"
#include "script_auto.h"
#include "activity.h"

extern Global global;
extern SConfig g_Config;
extern int g_maxactornum;
extern int g_save_wait;
extern MYSQL *myGame;
extern MYSQL *myData;
extern int g_speed;

Actor *g_actors = NULL;
int g_actornum = 0;
int g_maxactorid = 0;

//-----------------------------------------------------------------------------
// actors_init
// ����˵��: ��ɫ���ݳ�ʼ��
//-----------------------------------------------------------------------------
int actors_init()
{
	MYSQL_RES		*res;
	MYSQL_ROW		row;
	char	szSQL[1024];

	sprintf( szSQL, "select max(actorid) from actor" );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s)\n", mysql_error( myGame ) );
		write_gamelog( "%s", szSQL );
		return -1;
	}
	res = mysql_store_result( myGame );

	if ( !((row = mysql_fetch_row( res ))) )
	{
		mysql_free_result( res );
		return -1;
	}
	if ( row[0] )
		g_maxactorid = atoi( row[0] ) + 1;
	else
		g_maxactorid = 1;

	mysql_free_result( res );

	// �趨���ܵ�����С�Ľ�ɫIDֵ
	if ( g_maxactorid < MINACTORID )
	{ // ֻҪ��һ�ξͿ����ˣ�֮�󶼻������
		g_maxactorid = MINACTORID;
	}

	g_actors = (Actor *)malloc( sizeof(Actor)*g_maxactornum );
	memset( g_actors, 0, sizeof(Actor)*g_maxactornum );
	printf_msg( "Actor  maxcount=%d  memory=%0.2fMB\n", g_maxactornum, (sizeof(Actor)*g_maxactornum) / 1024.0 / 1024.0 );

	// ������������0�������������
	sprintf( szSQL, "UPDATE `actor_list` SET `online`=0" );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s)\n", mysql_error( myGame ) );
		write_gamelog( "%s", szSQL );
	}
	return 0;
}

//-----------------------------------------------------------------------------
// actors_save_everyone
// ����˵��: �������߽�ɫ����
// ����˵������type==0 ���б��桿 ��type==1 �������桿
//-----------------------------------------------------------------------------
int actors_save_everyone( char type )
{
	int tmpi;
	for ( tmpi = 0; tmpi < g_maxactornum; tmpi++ )
	{
		if ( g_actors[tmpi].actorid > 0 )
		{
			if ( type == 0 )
				actor_send_save( tmpi );
			else
				actor_real_saveall( tmpi, NULL );
		}
	}
	return 0;
}

//-----------------------------------------------------------------------------
// actors_on_core
// ����˵��: ����������֮��Ĵ浵
//-----------------------------------------------------------------------------
void actors_on_core()
{
	int tmpi;
	FILE *fp;
	char szSaveSqlFile[MAX_PATH];

	sprintf( szSaveSqlFile, "savesqlfile.sql" );
	fp = fopen( szSaveSqlFile, "wb" );
	if ( fp == NULL )
		return;

	// ���н�ɫ����
	for ( tmpi = 0; tmpi < g_maxactornum; tmpi++ )
	{
		if ( g_actors[tmpi].actorid > 0 )
		{
			actor_real_saveall( tmpi, fp );
		}
	}
	// ���гǳر���
	//city_save( fp );

	if ( fp )
	{
		char szSQL[512] = { 0 };
		sprintf( szSQL, "replace into world_data ( id, value, strvalue) values('%d',unix_timestamp(now()),'');", WORLD_DATA_SAVEFILE_FLAG );
		fprintf( fp, "%s;\n", szSQL );
	}
	fclose( fp );
	return;
}

//-----------------------------------------------------------------------------
// actor_save
// ����˵��: ��ɫ��������
//-----------------------------------------------------------------------------
int actor_save( int actor_index, int savecity, FILE *fp )
{
	// ��ɫ������Ϣ����
	actor_save_auto( &g_actors[actor_index], "actor", fp );

	// ��ɫ�б���Ϣ����
	actor_update_list( actor_index );

	// �������
	item_save( actor_index, fp );

	return 0;
}

//-----------------------------------------------------------------------------
// actor_real_saveall
// ����˵��: ��ɫ����������ʼ����
//-----------------------------------------------------------------------------
int actor_real_saveall( int actor_index, FILE *fp )
{
	// �����ɫ����(��)
	actor_save( actor_index, 0, fp );
	g_actors[actor_index].savetime = 0;
	g_save_wait = 1;
	return 0;
}

//-----------------------------------------------------------------------------
// actor_send_save
// ����˵��: ���ͱ�����Ϣ������
//-----------------------------------------------------------------------------
int actor_send_save( int actor_index )
{
	if ( g_save_wait )
	{
		if ( add_wqueue( actor_index, WCMD_SAVE, NULL, 0, 0, 1 ) < 0 )
		{
			write_gamelog( "add_wqueue full" );
			return actor_real_saveall( actor_index, NULL );
		}
		return 0;
	}
	else
	{
		return actor_real_saveall( actor_index, NULL );
	}
}

//-----------------------------------------------------------------------------
// actor_send_remove
// ����˵��: ����������Ϣ������
//-----------------------------------------------------------------------------
int actor_send_remove( int actor_index )
{
	if ( g_actors[actor_index].isexit == 2 )
		return -1;
	g_actors[actor_index].isexit = 2;
	if ( g_save_wait )
	{
		if ( add_wqueue( actor_index, WCMD_LEAVE, NULL, 0, 0, 1 ) < 0 )
		{
			write_gamelog( "add_wqueue full" );
			return actor_remove( actor_index );
		}
		return 0;
	}
	else
	{
		return actor_remove( actor_index );
	}
}

//-----------------------------------------------------------------------------
// actor_remove
// ����˵��: ��ɫ�����Ͽ��ͻ���
//-----------------------------------------------------------------------------
int actor_remove( int actor_index )
{
	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;
	if ( g_actors[actor_index].actorid <= 0 )
		return -1;
	if ( g_actors[actor_index].isexit == 0 )
		return -1;

	// ��ɫ��������״̬
	actor_update_online( g_actors[actor_index].actorid, 0 );

	// �ǳ�log
	account_out( actor_index, 0 );

	// �����ɫ����(��)
	actor_save( actor_index, 1, NULL );

	// ����actor_indexλ�õ�����
	memset( &(g_actors[actor_index]), 0, sizeof(Actor) );

	// �ܽ�ɫ���Լ�
	g_actornum--;

	// �ر����socket
	net_closesock_direct( actor_index );
	g_save_wait = 1;
	return 0;
}

//-----------------------------------------------------------------------------
// actor_update_list
// ����˵��: ���½�ɫ�б�����
//-----------------------------------------------------------------------------
int actor_update_list( int actor_index )
{
	char szSQL[1024];
	int actorid;
	char ActorName[64];

	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;
	actorid = g_actors[actor_index].actorid;

	// �����¼��actor
	db_escape( (const char *)g_actors[actor_index].name, ActorName, 0 );
	sprintf( szSQL, "update actor_list set name='%s',level='%d',logout_time='%d' where actorid='%d'", ActorName, g_actors[actor_index].level, (int)time( NULL ), actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s) [%s](%d)\n", mysql_error( myGame ), __FUNCTION__, __LINE__ );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -3;
	}
	return 0;
}

//-----------------------------------------------------------------------------
// actor_update_online
// ����˵��: �������ݿ��н�ɫ�������
//-----------------------------------------------------------------------------
int actor_update_online( int actorid, char isonline )
{
	char szSQL[256];
	sprintf( szSQL, "UPDATE actor_list SET online='%d' WHERE actorid=%d", isonline, actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s)\n", mysql_error( myGame ) );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -1;
	}
	return 0;
}

//-----------------------------------------------------------------------------
// actor_del
// ����˵��: ����ͻ���
//-----------------------------------------------------------------------------
int actor_del( int client_index )
{
	if ( client_index < 0 )
		return -1;
	if ( g_actors[client_index].actorid != 0 )
	{
		if ( g_actors[client_index].isexit == 0 )
			g_actors[client_index].isexit = 1;
		return 0;
	}
	// �˳���־
	return 0;
}

//-----------------------------------------------------------------------------
// actor_delete
// ����˵��: ������ɾ����ɫ
//-----------------------------------------------------------------------------
int actor_delete( i64 userid, int actorid )
{
	char	szSQL[1024];
	char szUserID[21];
	lltoa( userid, szUserID, 10 );

	// ����ý�ɫ����
	if ( actor_getindex_withid( actorid ) >= 0 )
	{
		return -1;
	}

	// �������ݿ�
	sprintf( szSQL, "update actor_list set offset='-1' where userid='%s' and actorid='%d'", szUserID, actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s) [%s](%d)\n", mysql_error( myGame ), __FUNCTION__, __LINE__ );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -1;
	}
	return 0;
}

//-----------------------------------------------------------------------------
// actor_delete_stoptime
// ����˵��: ����ɾ�����ʱ��
//-----------------------------------------------------------------------------
int actor_delete_stoptime( i64 userid, int actorid )
{
	MYSQL_RES		*res;
	MYSQL_ROW		row;
	char	szSQL[1024];

	int timedate = 0; // ��ǰʱ��
	char szUserID[21];
	int level = 0;
	lltoa( userid, szUserID, 10 );

	sprintf( szSQL, "select level from actor_list where userid='%s' and actorid='%d'", szUserID, actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s) [%s](%d)\n", mysql_error( myGame ), __FUNCTION__, __LINE__ );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -1;
	}
	res = mysql_store_result( myGame );
	if ( (row = mysql_fetch_row( res )) )
	{
		level = atoi( row[0] );
	}
	else
	{
		mysql_free_result( res );
		return -1;
	}
	mysql_free_result( res );

	if ( actor_getindex_withid( actorid ) >= 0 )
	{
		return -1;
	}

#ifdef _DEBUG
	return actor_delete( userid, actorid );
#else
	if ( level < 20 )
		return actor_delete( userid, actorid );
	else if ( level < 30 )
		timedate = (int)time( NULL ) + (60 * 10); // 30��10����
	else if ( level < 50 )
		timedate = (int)time( NULL ) + (60 * 60 * 1); // 50��1Сʱ
	else if ( level < 60 )
		timedate = (int)time( NULL ) + (60 * 60 * 2); // 60��2Сʱ
	else if ( level < 70 )
		timedate = (int)time( NULL ) + (60 * 60 * 3); // 70��3Сʱ
	else if ( level < 80 )
		timedate = (int)time( NULL ) + (60 * 60 * 4); // 80��6Сʱ
	else if ( level < 150 )
		timedate = (int)time( NULL ) + (60 * 60 * 24 * 1); // 80������1��
#endif

	sprintf( szSQL, "update actor_list set delete_stoptime='%d' where userid='%s' and actorid='%d'", timedate, szUserID, actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s)\n", mysql_error( myGame ) );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -1;
	}

	// ����ɾ��ʱ��
	return timedate;
}

//-----------------------------------------------------------------------------
// actor_delete_cancel
// ����˵��: ����ɾ��
//-----------------------------------------------------------------------------
int actor_delete_cancel( int actorid )
{
	char szSQL[1024];
	sprintf( szSQL, "UPDATE actor_list SET delete_stoptime=0 WHERE actorid=%d", actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s)\n", mysql_error( myGame ) );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -1;
	}
	if ( mysql_affected_rows( myGame ) == 0 )
	{
		// ���û�и��µ���һ��,��˵��ûɾ����
		return -1;
	}
	return 0;
}

//-----------------------------------------------------------------------------
// actors_logic
// ����˵��: ���н�ɫ�߼� 5֡һ��
//-----------------------------------------------------------------------------
void actors_logic()
{
	int tmpi;
	for ( tmpi = 0; tmpi < g_maxactornum; tmpi++ )
	{
		if ( g_actors[tmpi].actorid > 0 )
		{
			if ( client_isexited( tmpi ) && g_actors[tmpi].isexit <= 0 )
				g_actors[tmpi].isexit = 1;
			actor_logic( tmpi );
		}
		// �˳���־
		else if ( client_isexited( tmpi ) )
		{
			net_closesock_direct( tmpi );
		}
	}
}

//-----------------------------------------------------------------------------
// actor_logic
// ����˵��: ��ɫ�߼� 5֡һ��
//-----------------------------------------------------------------------------
void actor_logic( int actor_index )
{
	if ( g_actors[actor_index].actorid == 0 )
		return;
	if ( g_actors[actor_index].isexit == 2 )
		return;
	if ( g_actors[actor_index].talkspeed_frame > 0 )
	{
		g_actors[actor_index].talkspeed_frame -= 1;
	}

	actor_notify_value( actor_index, NOTIFY_NORMAL, 1, &g_speed, NULL );
	// ��GM�⣬���Ƽ���
	//if ( g_actors[actor_index].admin < 90 && g_actors[actor_index].checkspeed_time == 0 )
	//{
	//	if ( g_actors[actor_index].checkspeed_frame > 0 )
	//		g_actors[actor_index].checkspeed_frame--;
	//	if ( g_actors[actor_index].checkspeed_frame <= 0 )
	//	{
	//		SLK_NetS_Heart Value = {};
	//		int timestamp = 3 + rand() % 4;
	//		Value.m_value[0] = timestamp * 35;	// ��5֡�����
	//		netsend_heart_S( actor_index, SENDTYPE_ACTOR, &Value );
	//		g_actors[actor_index].checkspeed_time = (int)time( NULL ) + timestamp;
	//	}
	//}

	if ( g_actors[actor_index].isexit == 1 /*&&
		(g_actors[actor_index].stat != ACTOR_STAT_FIGHT || g_actors[actor_index].fight_index < 0)*/ )
	{
		actor_send_remove( actor_index );
		return;
	}
}

//-----------------------------------------------------------------------------
// actor_change_index
// ����˵��: �ص�½������ת��
//-----------------------------------------------------------------------------
int actor_change_index( int old_index, int new_index )
{
	ACTOR_CHECK_INDEX( old_index );
	ACTOR_CHECK_INDEX( new_index );
	memcpy( &g_actors[new_index], &g_actors[old_index], sizeof(Actor) );
	g_actors[new_index].isexit = 0;

	// ��վɽ�ɫ
	memset( &(g_actors[old_index]), 0, sizeof(Actor) );
	g_actors[old_index].view_areaindex = -1;
	return 0;
}

//-----------------------------------------------------------------------------
// actor_entergame
// ����˵��: ��ҽ�����Ϸ
//-----------------------------------------------------------------------------
int actor_entergame( int client_index, int actorid )
{
	// �Ѿ�������Ϸ�Ĳ����ٴν���
	if ( client_getstat( client_index ) >= CLIENT_STAT_ENTERGAME )
		return -1;

	// ��֤һ�������ɫid�ǲ������ڵ�½������û�
	if ( actor_verifyid( client_getuserid( client_index ), actorid ) < 0 )
		return -1;

	// �����ж�����Ƿ�����Ϸ��
	int actor_index = actor_getindex_withid( actorid );
	if ( actor_index < 0 )
	{
		actor_enterworld( client_index, actorid, -1 );
	}
	else
	{
		actor_enterworld( client_index, actorid, actor_index );
	}
	client_setstat( client_index, CLIENT_STAT_ENTERGAME );
	return 0;
}

//-----------------------------------------------------------------------------
// actor_enterworld
// ����˵��: ��ɫ������Ϸ����
//-----------------------------------------------------------------------------
int actor_enterworld( int client_index, int actorid, int actor_index )
{
	ACTOR_CHECK_INDEX( client_index );
	SLK_NetS_EnterInfo Value = {};
	// �������Ѿ�����
	if ( actor_index >= 0 )
	{
		// ������Ӧ����ת�����߾����
		if ( actor_index != client_index )
		{
			account_out( actor_index, 1 );
			actor_change_index( actor_index, client_index );
			net_closesock_direct( actor_index );
		}
		// ����������
		actor_index = client_index;

	}
	else
	{
		// ��ȡһ�����еĽ�ɫ����
		actor_index = client_index;

		if ( actor_load( actor_index, actorid ) < 0 )
			return -1;

		// ��ɫ��������
		g_actornum++;
		actor_update_online( actorid, 1 );
		write_gamelog( "[������Ϸ(actor_enterworld)][%s]", g_actors[actor_index].name );
	}	

	// ����log
	g_actors[actor_index].accountid = account_in( actor_index, 0 );
	g_actors[actor_index].cdkeywait = 0;

	// ��ɫ��Ϣ
	actor_getinfo( actor_index );

	// ���ͽ�����Ϸ
	Value.m_actorid = g_actors[actor_index].actorid;
	Value.m_serverid = g_Config.server_code;
	Value.m_servertime = (int)time( NULL );
	Value.m_createtime = g_actors[actor_index].createtime;
	Value.m_data_int = 0;
	Value.m_data_short = 0;
	Value.m_data_char = 0;
	netsend_enterinfo_S( client_index, SENDTYPE_ACTOR, &Value );

	// ������Ϣ����֮��ſ�����ҽ��볡��

	// �����ǽ��볡�����ͼ��ɵ���Ϣ
	return 0;
}

//-----------------------------------------------------------------------------
// actor_entercity
// ����˵��: ��ɫ����ǳغ��͵���Ϣ
//-----------------------------------------------------------------------------
int actor_entercity( int actor_index )
{
	// ��ɫ������Ϣ
	actor_configinfo( actor_index );

	// ��Ʒ�б�
	item_list( actor_index );
	item_equip_list( actor_index );

	// ���߽���-��ɫID
	gift_check( actor_index );

	// ���߽���-�û�ID
	gift_uid_check( actor_index );

	sc_OnActorIn( actor_index );
	return 0;
}

//-----------------------------------------------------------------------------
// actor_load
// ����˵��: ��ɫ������Ϸ���ȡ����
//-----------------------------------------------------------------------------
int actor_load( int actor_index, int actorid )
{
	ACTOR_CHECK_INDEX( actor_index );
	g_actors[actor_index].actorid = actorid;
	g_actors[actor_index].userid = client_getuserid( actor_index );

	/* ��ȡ�����Ϣ */
	actor_load_auto( actorid, &g_actors[actor_index], "actor" );
	g_actors[actor_index].admin = client_getusertype( actor_index );
	memcpy( g_actors[actor_index].lastip, client_getip( actor_index ), 15 );

	/* ��ʼ��һЩ����Ҫ�浵������ */
	g_actors[actor_index].view_areaindex = -1;

	/* ����ϵͳ���ݶ�ȡ */

	// ��������
	item_load( actor_index );

	return 0;
}

//-----------------------------------------------------------------------------
// actor_load
// ����˵��: ��һ�ν�����ϷҪ��ʼ����ɫ��Ϣ
//-----------------------------------------------------------------------------
int actor_new( int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	/// ���еķ��ַ������͵�varbin�����������ʼ��Ϊ0
	// ����֮��ӵ�varbin�ֶα�������һ����ʼ��

	// ��ʼ��Ϣ
	g_actors[actor_index].level = 1;
	g_actors[actor_index].token = 0;
	//item_getitem( actor_index, 2041, 1, -1, PATH_SYSTEM );
	//item_getitem( actor_index, 2071, 1, -1, PATH_SYSTEM );
	//item_getitem( actor_index, 745, 1, -1, PATH_SYSTEM );
	//item_getitem( actor_index, 248, 2, -1, PATH_SYSTEM );
	return 0;
}

//-----------------------------------------------------------------------------
// actor_create
// ����˵��: ������ɫ
//-----------------------------------------------------------------------------
int actor_create( int client_index, int aclass, char *szActorName )
{
	int result = 0;
	i64 userid;
	int platid;
	char *username;
	if ( aclass < 0 )
		return -1;
	client_setwait( client_index, 0 );

	SLK_ListInfo ListInfo = { 0 };
	/* ��ȡ������ɫ����������ݿ�����Ϣ */
	userid = client_getuserid( client_index );
	platid = client_getplatid( client_index );
	username = client_getusername( client_index );
	strcpy( ListInfo.m_name, szActorName );
	ListInfo.m_aclass = aclass;
	ListInfo.m_offset = 0;
	result = actor_db_create( client_index, platid, userid, username, &ListInfo );
	if ( result > 0 )
		result = 0;
	/* ���͵��ͻ��˴����Ƿ�ɹ� */
	SLK_NetS_Create Value = { 0 };
	Value.m_actorid = ListInfo.m_actorid;
	Value.m_result = result;
	Value.m_createtime = (int)time(NULL);
	netsend_create_S( client_index, SENDTYPE_ACTOR, &Value );

	/* ����ģʽ�ɹ�ֱ�ӽ�����Ϸ */

	return 0;
}

//-----------------------------------------------------------------------------
// actor_db_create
// ����˵��: ������ɫ,���ݿ�
//-----------------------------------------------------------------------------
int actor_db_create( int client_index, int platid, i64 userid, char *username, SLK_ListInfo *pListInfo )
{
	char szSQL[1024];
	int actorid;
	char ActorName[64];
	int thistime;
	char szUserID[21];
	char szText_devdata[1024] = {0};
	thistime = (int)time( NULL );
	lltoa( userid, szUserID, 10 );

	// ��ý�ɫID
	actorid = g_maxactorid++;

	// ������ɫ��ʼ����
	snprintf( pListInfo->m_name, NAME_SIZE, "Laird%d", actorid );
	pListInfo->m_name[NAME_SIZE - 1] = 0;

	// �����¼�� actor_list
	db_escape( (const char *)pListInfo->m_name, ActorName, 0 );
	db_escape( (const char *)client_getdevdata( client_index ), szText_devdata, 0 );
	sprintf( szSQL, "insert into actor_list (actorid,platid,userid,username,offset,create_time,name,aclass,channelid,os,devdata) values('%d','%d','%s','%s','%d','%d','%s','%d','%d','%d','%s')",
					actorid, platid, szUserID, username, 0, thistime, ActorName, pListInfo->m_aclass, client_getchannelid( client_index ), client_getos( client_index ), szText_devdata );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s) [%s](%d)\n", mysql_error( myGame ), __FUNCTION__, __LINE__ );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
		{
			db_reconnect_game();
			return -1;
		}
		return -3;// �����ǽ�ɫ������
	}

	// �����¼�� actor
	sprintf( szSQL, "insert into actor (actorid,name,aclass,lastip,createtime) values('%d','%s','%d','%s','%d')",
					actorid, ActorName, pListInfo->m_aclass, client_getip( client_index ), thistime );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s) [%s](%d)\n", mysql_error( myGame ), __FUNCTION__, __LINE__ );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -4;	// ������id����ͬ����
	}

	pListInfo->m_actorid = actorid;
	return actorid;
}

// ��ɫ���¿�ʼ
int actor_restart( int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	actor_del( actor_index );

	// offset = -1 �����Ѿ�����
	char szSQL[1024];
	char szUserID[21];
	lltoa( client_getuserid( actor_index ), szUserID, 10 );
	sprintf( szSQL, "update actor_list set offset='-1' where userid='%s' and actorid='%d'", szUserID, g_actors[actor_index].actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s) [%s](%d)\n", mysql_error( myGame ), __FUNCTION__, __LINE__ );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -1;
	}
	return 0;
}

// ��ɫ���¿�ʼ
int actor_restart_notonline( int actorid )
{
	// offset = -1 �����Ѿ�����
	char szSQL[1024];
	sprintf( szSQL, "update actor_list set offset='-1' where actorid='%d'", actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s) [%s](%d)\n", mysql_error( myGame ), __FUNCTION__, __LINE__ );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -1;
	}
	return 0;
}

// ����
int actor_kick( int actorid, int kicktime )
{
	/*int actor_index = actor_getindex_withid( actorid );
	int city_index = city_getindex_withactorid( actorid );
	if ( city_index < 0 || city_index >= g_city_maxcount )
	{
		return -1;
	}
	City *pCity = &g_city[city_index];
	int locktime = 0;
	if ( kicktime > 0 )
	{
		locktime = kicktime*60 + (int)time( NULL );

		pCity->buff_id[1] = 1;
		pCity->buff_duration[1] = kicktime * 60;
		city_attr_reset( pCity );
		mapunit_update( MAPUNIT_TYPE_CITY, -1, pCity->unit_index );
	}
	else if ( kicktime == 0 )
	{
		locktime = 0;

		pCity->buff_id[1] = 1;
		pCity->buff_duration[1] = 3600;
		city_attr_reset( pCity );
		mapunit_update( MAPUNIT_TYPE_CITY, -1, pCity->unit_index );
	}
	else if ( kicktime < 0 )
	{
		locktime = -1;

		pCity->buff_id[1] = 1;
		pCity->buff_duration[1] = 31536000;
		city_attr_reset( pCity );
		mapunit_update( MAPUNIT_TYPE_CITY, -1, pCity->unit_index );
	}

	char szSQL[256];
	sprintf( szSQL, "UPDATE actor_list SET lock_time='%d' WHERE actorid=%d", locktime, actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s)\n", mysql_error( myGame ) );
		write_gamelog( "%s", szSQL );
		if ( mysql_ping( myGame ) != 0 )
			db_reconnect_game();
		return -1;
	}
	if ( actor_index >= 0 )
	{
		actor_send_remove( actor_index );
	}*/
	return 0;
}

// ����
int actor_forbidtalk( int actor_index, int forbidtime )
{
	ACTOR_CHECK_INDEX( actor_index );
	if ( forbidtime > 0 )
	{
		g_actors[actor_index].forbidtime = forbidtime*60 + (int)time( NULL );
	}
	else if ( forbidtime == 0 )
	{
		g_actors[actor_index].forbidtime = 0;
	}
	else if ( forbidtime < 0 )
	{
		g_actors[actor_index].forbidtime = -1;
	}
	return 0;
}

// ����һ����ʱ֪ͨ����Ϣ
int actor_subscribecmd_add( int actor_index, short cmd )
{
	ACTOR_CHECK_INDEX( actor_index );
	for ( int tmpi = 0; tmpi < 8; tmpi++ )
	{
		if ( g_actors[actor_index].subscribe_cmd[tmpi] <= 0 )
		{
			g_actors[actor_index].subscribe_cmd[tmpi] = cmd;
			break;
		}
	}
	return 0;
}

// ɾ��һ����ʱ֪ͨ����Ϣ
int actor_subscribecmd_del( int actor_index, short cmd )
{
	ACTOR_CHECK_INDEX( actor_index );
	for ( int tmpi = 0; tmpi < 8; tmpi++ )
	{
		if ( g_actors[actor_index].subscribe_cmd[tmpi] == cmd )
		{
			g_actors[actor_index].subscribe_cmd[tmpi] = 0;
		}
	}
	return 0;
}

// ����Ƿ���ڼ�ʱ֪ͨ����Ϣ
int actor_subscribecmd_check( int actor_index, short cmd )
{
	ACTOR_CHECK_INDEX( actor_index );
	for ( int tmpi = 0; tmpi < 8; tmpi++ )
	{
		if ( g_actors[actor_index].subscribe_cmd[tmpi] == cmd )
		{
			return 1;
		}
	}
	return 0;
}

