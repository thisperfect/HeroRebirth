#include <stdio.h>
#include <time.h>
#include "system_askinfo.h"
#include "actor.h"
#include "gameproc.h"
#include "utils.h"
#include "db.h"
#include "client.h"
#include "actor_notify.h"
#include "server_structsend_auto.h"
#include "system.h"
#include "actor_send.h"
#include "item.h"
#include "global.h"
#include "activity.h"
#include "script_auto.h"
#include "login.h"
#include "fight.h"

extern SConfig g_Config;
extern Global global;

extern Actor *g_actors;
extern int g_maxactornum;

// 客户端脚本直接发来的消息
int system_askinfo( int actor_index, int msgid, char *pstr, int *pvalue )
{
	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;
	switch ( msgid )
	{
	case ASKINFO_NORMAL:
		break;
	case ASKINFO_FIGHTMATCH: // 匹配战斗
		fight_match( actor_index );
		break;
	case ASKINFO_FIGHTROOMQUIT: // 退出匹配的战斗
		fight_quit( actor_index );
		break;
	default:
		break;
	}
	return 0;
}
