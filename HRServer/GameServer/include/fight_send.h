#ifndef _FIGHT_SEND_H_
#define _FIGHT_SEND_H_

// ����ս��������Ϣ
int fightroominfo_sendroom( int fight_index );

// ����ս��������Ϣ
int fightroominfo_sendactor( int actor_index, int fight_index );

// �����뿪ս��
int fightroom_sendquit( int fight_index, int actor_index );

// ���ͽ���Ӣ������
int fightroom_sethero_sendroom( int fight_index );

// ���ͽ���Ӣ������
int fightroom_sethero_sendactor( int fight_index, int actor_index );

// ����ս����ʼ
int fightroom_start_sendroom( int fight_index );

// ����ս����ʼ
int fightroom_start_sendactor( int fight_index, int actor_index );

// ����ս���غ�
int fightroom_turns_sendroom( int fight_index );

// ����ս���غ�
int fightroom_turns_sendactor( int fight_index, int actor_index );
#endif
