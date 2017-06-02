#ifndef _FIGHT_H_
#include "define.h"
#define FIGHT_COMMANDNUM	64	// 战场玩家人数3V3
#define FIGHT_ACTORNUM		3	// 战场玩家人数3V3

#define FIGHT_STATE_NORMAL	0 // 缺省
#define FIGHT_STATE_MATCH	1 // 匹配中
#define FIGHT_STATE_SETHERO	2 // 等待布阵
#define FIGHT_STATE_START	3 // 开始

// PVP实时战场
typedef struct _fight
{
	int id;								// 保证唯一性
	char pvpnum;						// 1=1v1 2=2v2 3=3v3
	int maxtime;						// 战斗时长
	int randseed;						// 随机种子
	char state;							// 当前状态
	int turns;							// 回合
	int attack_index[FIGHT_ACTORNUM];	// 攻击方索引
	char attack_ready[FIGHT_ACTORNUM];	// 攻击方确认完毕
	char attack_actornum;				// 攻击方当前人数

	int defense_index[FIGHT_ACTORNUM];	// 防御方索引
	char defense_ready[FIGHT_ACTORNUM];	// 防御方确认完毕
	char defense_actornum;				// 防御方当前人数

	SLK_NetS_FightCommand	command_queue[FIGHT_COMMANDNUM];	// 操作队列
	short					command_queue_head;					// 队列头
	short					command_queue_tail;					// 队列尾
}Fight;

int fight_init();
int fight_match( int actor_index );
int fight_create( int actor_index, char pvpnum );
int fight_join( int fight_index, int actor_index );
int fight_quit( int actor_index );
int fight_ready( int actor_index );
int fight_ready_check( int fight_index );
int fight_start( int fight_index );
void fight_logic();
char fight_getside( int actor_index );
int fight_command( int actor_index, SLK_NetC_FightCommand *pValue );
int fight_command_queue_add( int fight_index, SLK_NetS_FightCommand *cmdinfo );
int fight_command_queue_fetch( int fight_index, SLK_NetS_FightCommand *outcmd );
#endif // !_FIGHT_H_
