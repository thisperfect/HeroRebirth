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
	return 0;
}

// 获取战场索引
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

// 获取攻击方还是防御方
char fight_getside( int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	FIGHT_CHECK_INDEX( g_actors[actor_index].fight_index );
	int fight_index = g_actors[actor_index].fight_index;
	for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
	{
		if ( g_fight[fight_index].attack_index[i] == actor_index )
		{
			return 0;
		}
		if ( g_fight[fight_index].defense_index[i] == actor_index )
		{
			return 1;
		}
	}
	return -1;
}

// 战场状态
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

// 匹配战场
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
	// 查找一个符合条件的战场
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
	{ // 没有匹配的，那么自己创建一个
		fight_index = fight_create( actor_index, 1 );
	}
	else
	{ // 加入已有战场
		fight_join( fight_index, actor_index );
	}

	if ( g_actors[actor_index].fight_index >= 0 )
	{
		// 通知战场房间
		fightroominfo_sendroom( fight_index );

		// 检查是否匹配完毕
		if ( g_fight[fight_index].attack_actornum >= g_fight[fight_index].pvpnum && 
			g_fight[fight_index].defense_actornum >= g_fight[fight_index].pvpnum )
		{
			// 通知匹配完毕，进入布阵环节
			fight_changestate( fight_index, FIGHT_STATE_SETHERO );
			fightroom_sethero_sendroom( fight_index );
		}
	}
	return 0;
}

// 创建一个战场
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
	g_fight[fight_index].attack_actornum += 1;
	g_fight[fight_index].attack_index[0] = actor_index;
	g_actors[actor_index].fight_index = fight_index;
	return fight_index;
}

// 加入战场
int fight_join( int fight_index, int actor_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	FIGHT_CHECK_INDEX( fight_index );
	if ( g_fight[fight_index].state != FIGHT_STATE_MATCH )
		return -1;

	if ( g_fight[fight_index].attack_actornum <= g_fight[fight_index].defense_actornum )
	{ // 攻击方人数小于防御方，加入攻击方
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
	{ // 否则加入防御方
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

// 离开战场
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
			// 先通知房间这个人离开，后设置变量
			fightroom_sendquit( fight_index, actor_index );
			g_fight[fight_index].attack_index[i] = -1;
			g_fight[fight_index].attack_actornum -= 1;
			break;
		}
		if ( g_fight[fight_index].defense_index[i] == actor_index )
		{
			// 先通知房间这个人离开，后设置变量
			fightroom_sendquit( fight_index, actor_index );
			g_fight[fight_index].defense_index[i] = -1;
			g_fight[fight_index].defense_actornum -= 1;
			break;
		}
	}
	g_actors[actor_index].fight_index = -1;

	// 战场没有人了，关闭释放这个战场
	if ( g_fight[fight_index].attack_actornum == 0 && g_fight[fight_index].defense_actornum == 0 )
	{
		fight_changestate( fight_index, FIGHT_STATE_NORMAL );
	}
	return 0;
}

// 布阵准备好了
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
		// 通知所有人我准备好

		// 如果所有人都已准备好，正式开始战斗
		if ( fight_ready_check( fight_index ) )
		{
			fight_start( fight_index );
		}
	}
	return 0;
}

// 确认所有人都已准备好
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

// 战斗正式开始
int fight_start( int fight_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	fight_changestate( fight_index, FIGHT_STATE_START );
	fightroom_start_sendroom( fight_index );
	return 0;
}

// 战场逻辑10帧一次，1秒3次
void fight_logic()
{
	for ( int tmpi = 0; tmpi < g_fight_maxnum; tmpi++ )
	{
		if ( g_fight[tmpi].state == FIGHT_STATE_SETHERO )
		{
			g_fight[tmpi].turns++;
			if ( g_fight[tmpi].turns >= 90 )
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
