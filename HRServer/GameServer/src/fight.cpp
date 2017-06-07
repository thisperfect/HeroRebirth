#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include <stdio.h>
#include <time.h>
#include <limits.h>
#include "db.h"
#include "award.h"
#include "utils.h"
#include "define.h"
#include "system.h"
#include "item.h"
#include "actor.h"
#include "actor_send.h"
#include "actor_notify.h"
#include "server_netsend_auto.h"
#include "fight.h"
#include "fight_send.h"

extern MYSQL *myData;
extern MYSQL *myGame;
extern Actor *g_actors;
extern int g_maxactornum;

Fight *g_fight = NULL;
int g_fight_maxnum = 0;
int g_fightid = 0;

int fight_reset( int fight_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	memset( &g_fight[fight_index], 0, sizeof(Fight) );
	for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
	{
		g_fight[fight_index].attack_index[i] = -1;
		g_fight[fight_index].defense_index[i] = -1;
	}
	return 0;
}

int fight_init()
{
	g_fight_maxnum = g_maxactornum/2;
	g_fight = (Fight*)malloc( sizeof(Fight) * ( g_fight_maxnum + 1 ) );
	memset( g_fight, 0, sizeof(Fight) * ( g_fight_maxnum + 1 ) );
	for ( int tmpi = 0; tmpi < g_fight_maxnum; tmpi++ )
	{
		for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
		{
			g_fight[tmpi].attack_index[i] = -1;
			g_fight[tmpi].defense_index[i] = -1;
		}
	}
	g_fightid++;
	printf_msg( "fight  maxcount=%d  memory=%0.2fMB\n", g_fight_maxnum, (sizeof(Fight) * ( g_fight_maxnum + 1 )) / 1024.0 / 1024.0 );
	return 0;
}

// ��ȡս������
int fight_getindex( int fightid )
{
	int fight_index = -1;
	for ( int tmpi = 0; tmpi < g_fight_maxnum; tmpi++ )
	{
		if ( g_fight[tmpi].id == fightid )
		{
			fight_index = tmpi;
			break;
		}
	}
	return fight_index;
}

// ��ȡ���������Ƿ�����
char fight_getside( int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	FIGHT_CHECK_INDEX( g_actors[actor_index].fight_index );
	int fight_index = g_actors[actor_index].fight_index;
	for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
	{
		if ( g_fight[fight_index].attack_index[i] == actor_index )
		{
			return 1;
		}
		if ( g_fight[fight_index].defense_index[i] == actor_index )
		{
			return -1;
		}
	}
	return 0;
}

// ս��״̬
int fight_changestate( int fight_index, char state )
{
	FIGHT_CHECK_INDEX( fight_index );
	g_fight[fight_index].state = state;
	g_fight[fight_index].turns = 0;
	if ( state == FIGHT_STATE_NORMAL )
	{
		fight_reset( fight_index );
	}
	return 0;
}

// ƥ��ս��
int fight_match( int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	if ( g_actors[actor_index].fight_index >= 0 )
	{
		fightroominfo_sendactor( actor_index, g_actors[actor_index].fight_index );
		if ( g_fight[g_actors[actor_index].fight_index].state == FIGHT_STATE_SETHERO )
		{
			fightroom_sethero_sendactor( g_actors[actor_index].fight_index, actor_index );
		}
		else if ( g_fight[g_actors[actor_index].fight_index].state == FIGHT_STATE_START )
		{
			fightroom_start_sendactor( g_actors[actor_index].fight_index, actor_index );
		}
		return -1;
	}
	// ����һ������������ս��
	int fight_index = -1;
	for ( int tmpi = 0; tmpi < g_fight_maxnum; tmpi++ )
	{
		if ( g_fight[tmpi].state != FIGHT_STATE_MATCH )
			continue;
		if ( g_fight[tmpi].attack_actornum >= g_fight[tmpi].pvpnum && 
			g_fight[tmpi].defense_actornum >= g_fight[tmpi].pvpnum )
			continue;
		fight_index = tmpi;
	}
	if ( fight_index < 0 )
	{ // û��ƥ��ģ���ô�Լ�����һ��
		fight_index = fight_create( actor_index, 1 );
	}
	else
	{ // ��������ս��
		fight_join( fight_index, actor_index );
	}

	if ( g_actors[actor_index].fight_index >= 0 )
	{
		// ֪ͨս������
		fightroominfo_sendroom( fight_index );

		// ����Ƿ�ƥ�����
		if ( g_fight[fight_index].attack_actornum >= g_fight[fight_index].pvpnum && 
			g_fight[fight_index].defense_actornum >= g_fight[fight_index].pvpnum )
		{
			// ֪ͨƥ����ϣ����벼�󻷽�
			fight_changestate( fight_index, FIGHT_STATE_SETHERO );
			fightroom_sethero_sendroom( fight_index );
		}
	}
	return 0;
}

// ����һ��ս��
int fight_create( int actor_index, char pvpnum )
{
	ACTOR_CHECK_INDEX( actor_index );
	if ( pvpnum > FIGHT_ACTORNUM )
		pvpnum = FIGHT_ACTORNUM;
	else if ( pvpnum <= 0 )
		pvpnum = 1;

	int fight_index = -1;
	for ( int tmpi = 0; tmpi < g_fight_maxnum; tmpi++ )
	{
		if ( g_fight[tmpi].state == FIGHT_STATE_NORMAL )
		{
			fight_index = tmpi;
			break;
		}
	}
	if ( fight_index < 0 )
	{
		return -1;
	}
	fight_reset( fight_index );
	g_fight[fight_index].state = FIGHT_STATE_MATCH;
	g_fight[fight_index].id = g_fightid++;
	g_fight[fight_index].pvpnum = pvpnum;
	g_fight[fight_index].maxtime = 150;
	g_fight[fight_index].randseed = (int)time( NULL );
	g_fight[fight_index].attack_actornum += 1;
	g_fight[fight_index].attack_index[0] = actor_index;
	g_actors[actor_index].fight_index = fight_index;
	return fight_index;
}

// ����ս��
int fight_join( int fight_index, int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	FIGHT_CHECK_INDEX( fight_index );
	if ( g_fight[fight_index].state != FIGHT_STATE_MATCH )
		return -1;

	if ( g_fight[fight_index].attack_actornum <= g_fight[fight_index].defense_actornum )
	{ // ����������С�ڷ����������빥����
		for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
		{
			if ( g_fight[fight_index].attack_index[i] < 0 )
			{
				g_fight[fight_index].attack_index[i] = actor_index;
				g_fight[fight_index].attack_actornum += 1;
				g_actors[actor_index].fight_index = fight_index;
				break;
			}
		}
	}
	else
	{ // ������������
		for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
		{
			if ( g_fight[fight_index].defense_index[i] < 0 )
			{
				g_fight[fight_index].defense_index[i] = actor_index;
				g_fight[fight_index].defense_actornum += 1;
				g_actors[actor_index].fight_index = fight_index;
				break;
			}
		}
	}
	
	if ( g_actors[actor_index].fight_index < 0 )
		return -1;
	return 0;
}

// �뿪ս��
int fight_quit( int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	FIGHT_CHECK_INDEX( g_actors[actor_index].fight_index );
	int fight_index = g_actors[actor_index].fight_index;
	if ( g_fight[fight_index].state != FIGHT_STATE_MATCH )
	{
		return -1;
	}
	for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
	{
		if ( g_fight[fight_index].attack_index[i] == actor_index )
		{
			// ��֪ͨ����������뿪�������ñ���
			fightroom_sendquit( fight_index, actor_index );
			g_fight[fight_index].attack_index[i] = -1;
			g_fight[fight_index].attack_actornum -= 1;
			break;
		}
		if ( g_fight[fight_index].defense_index[i] == actor_index )
		{
			// ��֪ͨ����������뿪�������ñ���
			fightroom_sendquit( fight_index, actor_index );
			g_fight[fight_index].defense_index[i] = -1;
			g_fight[fight_index].defense_actornum -= 1;
			break;
		}
	}
	g_actors[actor_index].fight_index = -1;

	// ս��û�����ˣ��ر��ͷ����ս��
	if ( g_fight[fight_index].attack_actornum == 0 && g_fight[fight_index].defense_actornum == 0 )
	{
		fight_changestate( fight_index, FIGHT_STATE_NORMAL );
	}
	return 0;
}

// ����׼������
int fight_ready( int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	FIGHT_CHECK_INDEX( g_actors[actor_index].fight_index );
	int fight_index = g_actors[actor_index].fight_index;
	char *ready = NULL;
	for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
	{
		if ( g_fight[fight_index].attack_index[i] == actor_index )
		{
			ready = &g_fight[fight_index].attack_ready[i];
			break;
		}
		if ( g_fight[fight_index].defense_index[i] == actor_index )
		{
			ready = &g_fight[fight_index].defense_ready[i];
			break;
		}
	}
	if ( ready )
	{
		*ready = 1;
		// ֪ͨ��������׼����

		// ��������˶���׼���ã���ʽ��ʼս��
		if ( fight_ready_check( fight_index ) )
		{
			fight_start( fight_index );
		}
	}
	return 0;
}

// ȷ�������˶���׼����
int fight_ready_check( int fight_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	for ( int i = 0; i < g_fight[fight_index].pvpnum; i++ )
	{
		if ( g_fight[fight_index].attack_ready[i] == 0 )
		{
			return 0;
		}
		if ( g_fight[fight_index].defense_ready[i] == 0 )
		{
			return 0;
		}
	}
	return 1;
}

// ս����ʽ��ʼ
int fight_start( int fight_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	fight_changestate( fight_index, FIGHT_STATE_START );
	fightroom_start_sendroom( fight_index );
	return 0;
}

// ս���߼�1��3��
void fight_logic()
{
	for ( int tmpi = 0; tmpi < g_fight_maxnum; tmpi++ )
	{
		if ( g_fight[tmpi].state == FIGHT_STATE_SETHERO )
		{
			g_fight[tmpi].turns++;
			if ( g_fight[tmpi].turns >= 45 )
			{
				fight_start( tmpi );
			}
		}
		else if ( g_fight[tmpi].state == FIGHT_STATE_START )
		{
			fightroom_turns_sendroom( tmpi );
			g_fight[tmpi].turns++;
		}
	}
}

// ����һ���ͻ��˴�������ָ��
int fight_command( int actor_index, SLK_NetC_FightCommand *pValue )
{
	ACTOR_CHECK_INDEX( actor_index );
	FIGHT_CHECK_INDEX( g_actors[actor_index].fight_index );
	int fight_index = g_actors[actor_index].fight_index;
	// ���ǹ�����1���Ƿ�����-1
	char side = fight_getside( actor_index );
	SLK_NetS_FightCommand cmdinfo = { 0 };
	cmdinfo.m_side = side;
	cmdinfo.m_cmd = pValue->m_cmd;
	cmdinfo.m_kind = pValue->m_value;
	fight_command_queue_add( fight_index, &cmdinfo );
	return 0;
}

// ս��ָ����ӵ�����
int fight_command_queue_add( int fight_index, SLK_NetS_FightCommand *cmdinfo )
{
	FIGHT_CHECK_INDEX( fight_index );
	// ��ȡβ��
	int queue_tail = g_fight[fight_index].command_queue_tail + 1;
	if ( queue_tail >= FIGHT_COMMANDNUM )
	{
		queue_tail = 0;
	}

	// �������Ѿ�����
	if ( g_fight[fight_index].command_queue_head == queue_tail )
	{
		return -1;
	}

	// �����ݸ��ƽ���
	int index = g_fight[fight_index].command_queue_tail;
	if ( index >= 0 && index < FIGHT_COMMANDNUM )
	{
		memcpy( &g_fight[fight_index].command_queue[index], cmdinfo, sizeof(SLK_NetS_FightCommand) );
	}

	// β������
	g_fight[fight_index].command_queue_tail = queue_tail;
	return 0;
}

// ���г���
int fight_command_queue_fetch( int fight_index, SLK_NetS_FightCommand *outcmd )
{
	FIGHT_CHECK_INDEX( fight_index );
	if ( g_fight[fight_index].command_queue_tail == g_fight[fight_index].command_queue_head )
	{
		return -1;
	}

	// �Ӷ�����ȡ��һ��
	int index = g_fight[fight_index].command_queue_head;
	if ( index >= 0 && index < FIGHT_COMMANDNUM )
	{
		memcpy( outcmd, &g_fight[fight_index].command_queue[index], sizeof(SLK_NetS_FightCommand) );
	}

	// ͷ������
	g_fight[fight_index].command_queue_head++;
	if ( g_fight[fight_index].command_queue_head >= FIGHT_COMMANDNUM )
	{
		g_fight[fight_index].command_queue_head = 0;
	}
	return 0;
}
