#ifndef __ARMY_AUTO_H
#define __ARMY_AUTO_H
#include "define.h"

struct _army {
//--Automatically generated
				int index;	//��������
				int id;	//����ΨһID,�Ϸ�����֤
				int unit_index;	//��ʾ����
				char state;	//״̬
				int statetime;	//״̬ʱ���
				int stateduration;	//״̬����������
				int action;	//��Ϊ
				short from_type;	//�����Ķ�������
				int from_id;	//�����Ķ���ID
				int from_index;	//�����Ķ�������
				short from_posx;	//�����Ķ�������
				short from_posy;	//�����Ķ�������
				short to_type;	//Ŀ�Ķ�������
				int to_id;	//Ŀ�Ķ���ID
				int to_index;	//Ŀ�Ķ�������
				short to_posx;	//Ŀ�Ķ�������
				short to_posy;	//Ŀ�Ķ�������
				short posx;	//��ǰ����
				short posy;	//��ǰ����
				short walk_len;	//�Ѿ��ƶ�����
				SLK_WalkPath walk_path;	//�����ƶ�·��
				char name[22];	//�Զ�������
				int soldiers;	//����
				int wounded;	//��Ա
				char body;	//����
				char morale;	//ʿ��
				short attack;	//����
				short defense;	//����
				short attack_speed;	//�����ٶ�
				short move_speed;	//�ƶ��ٶ�
				short attrpoint;	//δ�������
				short level;	//ս���ȼ�
				char exp;	//ս������
				short equip[6];	//ӵ��װ��
				short skillid[4];	//ӵ�м���
				int food;	//Я����ʳ
				int money;	//Я����Ǯ
				short itemkind[4];	//Я����Ʒ����
				int itemnum[4];	//Я����Ʒ����
				int sec;	//�����
};
typedef struct _army Army;

typedef Army * (*LPCB_GETARMY)( int index );
typedef int (*LPCB_LOADARMY)( int index );
int army_load_auto( LPCB_GETARMY pCB_GetArmy, LPCB_LOADARMY pCB_LoadArmy, char *pTab );
int army_save_auto( Army *pArmy, char *pTab, FILE *fp );
int army_batch_save_auto( Army *pArmy, int maxcount,  char *pTab, FILE *fp );

#endif
