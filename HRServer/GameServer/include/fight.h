#ifndef _FIGHT_H_

#define FIGHT_ACTORNUM	3 // 战场玩家人数3V3

#define FIGHT_STATE_NORMAL	0 // 缺省
#define FIGHT_STATE_WAIT	1 // 等待
#define FIGHT_STATE_START	2 // 开始

// PVP实时战场
typedef struct _fight
{
	int id;								// 保证唯一性
	char state;							// 当前状态
	int turns;							// 回合
	int attack_index[FIGHT_ACTORNUM];	// 攻击方索引
	char attack_ready[FIGHT_ACTORNUM];	// 攻击方确认完毕
	char attack_actornum;				// 攻击方当前人数

	int defense_index[FIGHT_ACTORNUM];	// 防御方索引
	char defense_ready[FIGHT_ACTORNUM];	// 防御方确认完毕
	char defense_actornum;				// 防御方当前人数

}Fight;

int fight_init();
int fight_create( int actor_index );
void fight_logic();
int fight_join( int fightid, char side, int actor_index );
int fight_quit( int actor_index );
int fight_ready( int actor_index );
int fight_ready_check( int fight_index );
int fight_start( int fight_index );
#endif // !_FIGHT_H_
