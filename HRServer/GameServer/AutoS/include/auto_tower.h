#ifndef __TOWER_AUTO_H
#define __TOWER_AUTO_H
#include "define.h"

struct _tower {
//--Automatically generated
				int index;	//����
				int id;	//ID
				int cityid;	//�����ǳ�ID
				int city_index;	//�����ǳ�����
				int unit_index;	//��ʵ��������
				short posx;	//λ��
				short posy;	//λ��
				char type;	//����
				char level;	//�ȼ�
				int wear;	//�;�
};
typedef struct _tower Tower;

typedef Tower * (*LPCB_GETTOWER)( int index );
typedef int (*LPCB_LOADTOWER)( int index );
int tower_load_auto( LPCB_GETTOWER pCB_GetTower, LPCB_LOADTOWER pCB_LoadTower, char *pTab );
int tower_save_auto( Tower *pTower, char *pTab, FILE *fp );
int tower_batch_save_auto( Tower *pTower, int maxcount,  char *pTab, FILE *fp );

#endif
