#ifndef __DEFINE_H
#define __DEFINE_H
#include "utils.h"
#include "gamelog.h"
#include "client.h"
#include "auto_actor_item.h"
#include "server_struct_auto.h"
#include "server_structrecv_auto.h"
#include "global_netsend_auto.h"
#include "auto_data_item.h"
#include "auto_data_platinfo.h"
#include "auto_data_upgrade.h"

#define LOG_PATH	"./log/"

#ifndef NAME_SIZE
#define NAME_SIZE					22		// 玩家名字和物品名字长度
#endif
#define EPSINON 0.000001

// 最小的角色ID值
#define MINACTORID	130000

#define MOVECLICK_DELAY 12

#define MAX_ACTORLEVEL	100

#define CLIENT_PUSHKEY_MAX	256	// 推送秘钥长度

#define ACTOR_CHECK_INDEX(actor_index)		do{ if( actor_index < 0 || actor_index >= g_maxactornum ) return -1;}while(0)

// 闰年
#define IS_LEAP_YEAR(y)  (((y) % 4 == 0 && (y) % 100 != 0) || (y) % 400 == 0)

/* 配置文件 */
typedef struct _sconfig {
	int area_code;
	int server_code;
	unsigned long ipaddress;
	unsigned short port;
	unsigned long user_ipaddress;
	unsigned short user_port;
	char user_host[32];
	unsigned long global_ipaddress;
	unsigned short global_port;

	unsigned long ds_ipaddress;
	unsigned short ds_port;

	char datadb_host[64];
	char datadb_user[32];
	char datadb_pass[32];
	char datadb_database[32];

	char gamedb_host[64];
	char gamedb_user[32];
	char gamedb_pass[32];
	char gamedb_database[32];

	char logdb_host[64];
	char logdb_user[32];
	char logdb_pass[32];
	char logdb_database[32];

	char redis_host[64];
	short redis_port;

	char server_name[32];
	int server_start_date;
	int server_start_hour;
	int server_start_min;
	int max_connection;
	int max_clubcount;
	int server_exit_week;
	int server_exit_hour;
	int server_exit_min;
	char noprint;
	char showflag;
	char showcdkey;
	char showvip;
	char showmcard;
	char usegate;
	char usenetlog;

	char log_host[64];
	unsigned short log_port;
	char log_platform[16];

	union
	{
		int value; 
		struct
		{
			unsigned char m1;
			unsigned char m2;
			unsigned short m3;
		}ss;
	}minver;
} SConfig;

void sendtoclient( int actor_index, char *tmpbuf, int size );
void sendtoclient_team( int actor_index, char *tmpbuf, int size );
#endif
