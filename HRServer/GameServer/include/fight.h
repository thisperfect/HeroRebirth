#ifndef _FIGHT_H_
#include "define.h"
#define FIGHT_COMMANDNUM	64	// ս���������3V3
#define FIGHT_ACTORNUM		3	// ս���������3V3

#define FIGHT_STATE_NORMAL	0 // ȱʡ
#define FIGHT_STATE_MATCH	1 // ƥ����
#define FIGHT_STATE_SETHERO	2 // �ȴ�����
#define FIGHT_STATE_START	3 // ��ʼ

// PVPʵʱս��
typedef struct _fight
{
	int id;								// ��֤Ψһ��
	char pvpnum;						// 1=1v1 2=2v2 3=3v3
	int maxtime;						// ս��ʱ��
	int randseed;						// �������
	char state;							// ��ǰ״̬
	int turns;							// �غ�
	int attack_index[FIGHT_ACTORNUM];	// ����������
	char attack_ready[FIGHT_ACTORNUM];	// ������ȷ�����
	char attack_actornum;				// ��������ǰ����

	int defense_index[FIGHT_ACTORNUM];	// ����������
	char defense_ready[FIGHT_ACTORNUM];	// ������ȷ�����
	char defense_actornum;				// ��������ǰ����

	SLK_NetS_FightCommand	command_queue[FIGHT_COMMANDNUM];	// ��������
	short					command_queue_head;					// ����ͷ
	short					command_queue_tail;					// ����β
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
