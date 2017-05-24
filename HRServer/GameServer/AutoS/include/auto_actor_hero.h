#ifndef __HERO_AUTO_H
#define __HERO_AUTO_H
#include "define.h"

struct _actor_hero {
//--Automatically generated
				i64 heroid;	//Ӣ��ΨһID
				int actorid;	//������ɫID
				short offset;	//����
				short kind;	//����
				short level;	//�ȼ�
				int exp;	//����
				char color;	//Ʒ����ɫ
};
typedef struct _actor_hero Hero;

typedef Hero * (*LPCB_GETHERO)( int actorid, int offset );
int actor_hero_load_auto( int actorid, int actor_index, LPCB_GETHERO pCB_GetHero, char *pTab );
int actor_hero_save_auto( Hero *pHero, char *pTab, FILE *fp );

#endif
