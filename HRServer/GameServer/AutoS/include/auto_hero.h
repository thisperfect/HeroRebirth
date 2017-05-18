#ifndef __HERO_AUTO_H
#define __HERO_AUTO_H
#include "define.h"

struct _hero {
//--Automatically generated
				int index;	//����
				i64 id;	//Ӣ��ID
				char name[22];	//Ӣ������
};
typedef struct _hero Hero;

typedef Hero * (*LPCB_GETHERO)( int index );
typedef int (*LPCB_LOADHERO)( int index );
int hero_load_auto( LPCB_GETHERO pCB_GetHero, LPCB_LOADHERO pCB_LoadHero, char *pTab );
int hero_save_auto( Hero *pHero, char *pTab, FILE *fp );
int hero_batch_save_auto( Hero *pHero, int maxcount,  char *pTab, FILE *fp );

#endif
