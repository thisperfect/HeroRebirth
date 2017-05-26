#ifndef _FIGHT_H_

#define FIGHT_ACTORNUM	3 // ս���������3V3

#define FIGHT_STATE_NORMAL	0 // ȱʡ
#define FIGHT_STATE_WAIT	1 // �ȴ�
#define FIGHT_STATE_START	2 // ��ʼ

// PVPʵʱս��
typedef struct _fight
{
	int id;								// ��֤Ψһ��
	char state;							// ��ǰ״̬
	int turns;							// �غ�
	int attack_index[FIGHT_ACTORNUM];	// ����������
	char attack_ready[FIGHT_ACTORNUM];	// ������ȷ�����
	char attack_actornum;				// ��������ǰ����

	int defense_index[FIGHT_ACTORNUM];	// ����������
	char defense_ready[FIGHT_ACTORNUM];	// ������ȷ�����
	char defense_actornum;				// ��������ǰ����

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
