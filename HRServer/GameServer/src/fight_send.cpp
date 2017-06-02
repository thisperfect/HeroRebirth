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

extern MYSQL *myData;
extern MYSQL *myGame;
extern Actor *g_actors;
extern int g_maxactornum;

extern Fight *g_fight;
extern int g_fight_maxnum;

static int _fightroominfo_make( int fight_index, SLK_NetS_FightRoomInfo *pValue )
{
	FIGHT_CHECK_INDEX( fight_index );
	Fight *pFight = &g_fight[fight_index];
	pValue->m_fightid = pFight->id;
	pValue->m_pvpnum = pFight->pvpnum;
	pValue->m_attack_actornum = pFight->attack_actornum;
	pValue->m_defense_actornum = pFight->defense_actornum;
	for ( int tmpi = 0; tmpi < FIGHT_ACTORNUM; tmpi++ )
	{
		int index = pFight->attack_index[tmpi];
		if ( index >= 0 && index < g_maxactornum )
		{
			pValue->m_attack_actorinfo[tmpi].m_ready = pFight->attack_ready[tmpi];
			pValue->m_attack_actorinfo[tmpi].m_actorid = g_actors[index].actorid;
			pValue->m_attack_actorinfo[tmpi].m_level = g_actors[index].level;
			pValue->m_attack_actorinfo[tmpi].m_headid = g_actors[index].shape;
			strncpy( pValue->m_attack_actorinfo[tmpi].m_name, g_actors[index].name, NAME_SIZE );
			pValue->m_attack_actorinfo[tmpi].m_name_length = strlen( pValue->m_attack_actorinfo[tmpi].m_name );
		}
		index = pFight->defense_index[tmpi];
		if ( index >= 0 && index < g_maxactornum )
		{
			pValue->m_defense_actorinfo[tmpi].m_ready = pFight->attack_ready[tmpi];
			pValue->m_defense_actorinfo[tmpi].m_actorid = g_actors[index].actorid;
			pValue->m_defense_actorinfo[tmpi].m_level = g_actors[index].level;
			pValue->m_defense_actorinfo[tmpi].m_headid = g_actors[index].shape;
			strncpy( pValue->m_defense_actorinfo[tmpi].m_name, g_actors[index].name, NAME_SIZE );
			pValue->m_defense_actorinfo[tmpi].m_name_length = strlen( pValue->m_defense_actorinfo[tmpi].m_name );
		}
	}
	return 0;
}

// 发送战场房间信息
int fightroominfo_sendroom( int fight_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	SLK_NetS_FightRoomInfo pValue = { 0 };
	_fightroominfo_make( fight_index, &pValue );
	netsend_fightroominfo_S( fight_index, SENDTYPE_FIGHT, &pValue );
	return 0;
}

// 发送战场房间信息
int fightroominfo_sendactor( int actor_index, int fight_index )
{
	ACTOR_CHECK_INDEX( actor_index );
	FIGHT_CHECK_INDEX( fight_index );
	SLK_NetS_FightRoomInfo pValue = { 0 };
	_fightroominfo_make( fight_index, &pValue );
	netsend_fightroominfo_S( actor_index, SENDTYPE_ACTOR, &pValue );
	return 0;
}

// 发送离开战场
int fightroom_sendquit( int fight_index, int actor_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	ACTOR_CHECK_INDEX( actor_index );
	SLK_NetS_FightRoomQuit pValue = { 0 };
	pValue.m_fightid = g_fight[fight_index].id;
	pValue.m_actorid = g_actors[actor_index].actorid;
	netsend_fightroomquit_S( fight_index, SENDTYPE_FIGHT, &pValue );
	return 0;
}

// 发送进入英雄设置
int fightroom_sethero_sendroom( int fight_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	SLK_NetS_FightRoomSetHero pValue = { 0 };
	pValue.m_fightid = g_fight[fight_index].id;
	netsend_fightroomsethero_S( fight_index, SENDTYPE_FIGHT, &pValue );
	return 0;
}

// 发送进入英雄设置
int fightroom_sethero_sendactor( int fight_index, int actor_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	ACTOR_CHECK_INDEX( actor_index );
	SLK_NetS_FightRoomSetHero pValue = { 0 };
	pValue.m_fightid = g_fight[fight_index].id;
	netsend_fightroomsethero_S( actor_index, SENDTYPE_ACTOR, &pValue );
	return 0;
}

// 战斗开始属性
static int _fightroom_start_make( int fight_index, SLK_NetS_FightStart *pValue )
{
	FIGHT_CHECK_INDEX( fight_index );
	pValue->m_fightid = g_fight[fight_index].id;
	pValue->m_maxtime = g_fight[fight_index].maxtime;
	pValue->m_randseed = g_fight[fight_index].randseed;
	//SLK_HeroAttr m_attack_godattr;	//服务器发送开始-神邸属性
	//SLK_HeroAttr m_defense_godattr;	//服务器发送开始-神邸属性
	//short m_attack_godkind;	//服务器发送开始-神邸种类
	//short m_defense_godkind;	//服务器发送开始-神邸种类
	return 0;
}

// 发送战斗开始
int fightroom_start_sendroom( int fight_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	SLK_NetS_FightStart pValue = { 0 };
	_fightroom_start_make( fight_index, &pValue );
	for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
	{
		if ( g_fight[fight_index].attack_index[i] >= 0 )
		{
			pValue.m_side = fight_getside( g_fight[fight_index].attack_index[i] );
			netsend_fightroomstart_S( g_fight[fight_index].attack_index[i], SENDTYPE_ACTOR, &pValue );
		}
		if ( g_fight[fight_index].defense_index[i] >= 0 )
		{
			pValue.m_side = fight_getside( g_fight[fight_index].defense_index[i] );
			netsend_fightroomstart_S( g_fight[fight_index].defense_index[i], SENDTYPE_ACTOR, &pValue );
		}
	}
	return 0;
}

// 发送战斗开始
int fightroom_start_sendactor( int fight_index, int actor_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	ACTOR_CHECK_INDEX( actor_index );
	SLK_NetS_FightStart pValue = { 0 };
	_fightroom_start_make( fight_index, &pValue );
	pValue.m_side = fight_getside( actor_index );
	netsend_fightroomstart_S( actor_index, SENDTYPE_ACTOR, &pValue );
	return 0;
}

// 战斗回合属性
static int _fightroom_turns_make( int fight_index, SLK_NetS_FightTurns *pValue )
{
	pValue->m_turns = g_fight[fight_index].turns;
	for ( int tmpi = 0; tmpi < 10; tmpi++ )
	{
		if ( fight_command_queue_fetch( fight_index, &pValue->m_list[pValue->m_count] ) < 0 )
			break;
		pValue->m_count++;
	}
	return 0;
}

// 发送战斗回合
int fightroom_turns_sendroom( int fight_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	SLK_NetS_FightTurns pValue = { 0 };
	_fightroom_turns_make( fight_index, &pValue );
	netsend_fightturns_S( fight_index, SENDTYPE_FIGHT, &pValue );
	return 0;
}

// 发送战斗回合
int fightroom_turns_sendactor( int fight_index, int actor_index )
{
	FIGHT_CHECK_INDEX( fight_index );
	ACTOR_CHECK_INDEX( actor_index );
	SLK_NetS_FightTurns pValue = { 0 };
	_fightroom_turns_make( fight_index, &pValue );
	netsend_fightturns_S( actor_index, SENDTYPE_ACTOR, &pValue );
	return 0;
}
