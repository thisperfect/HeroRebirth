#include "define.h"
#include "actor.h"
#include "actor_send.h"
#include "gameproc.h"
#include "server_netsend_auto.h"
#include "fight.h"

extern Actor *g_actors;
extern int g_actornum;
extern int g_maxactornum;

extern Fight *g_fight;
extern int g_fight_maxnum;

// 世界信息发送,信息立即发送
int world_sendmsg( int datasize, char *databuf )
{
	int tmpi;
	if ( datasize > 0 )
	{
		for ( tmpi = 0; tmpi < g_maxactornum; tmpi++ )
		{
			if ( g_actors[tmpi].actorid > 0 )
				sendtoclient( tmpi, databuf, datasize + sizeof(short) );
		}
	}
	return 0;
}

// 发送战场
int fight_sendmsg( int fight_index, int datasize, char *databuf )
{
	FIGHT_CHECK_INDEX( fight_index );
	for ( int i = 0; i < FIGHT_ACTORNUM; i++ )
	{
		if ( g_fight[fight_index].attack_index[i] >= 0 )
		{
			sendtoclient( g_fight[fight_index].attack_index[i], databuf, datasize + sizeof(short) );
		}
		if ( g_fight[fight_index].defense_index[i] >= 0 )
		{
			sendtoclient( g_fight[fight_index].defense_index[i], databuf, datasize + sizeof(short) );
		}
	}
	return 0;
}

int actor_senddata( int actor_index, char send_type, char *data, int datasize )
{
	switch( send_type )
	{
	case SENDTYPE_ACTOR:
		sendtoclient( actor_index, data, datasize+sizeof(short) );
		break;
	case SENDTYPE_WORLD:
		world_sendmsg( datasize, data );
		break;
	case SENDTYPE_FIGHT:
		fight_sendmsg( actor_index, datasize, data );
		break;
	}
	return 0;
}
