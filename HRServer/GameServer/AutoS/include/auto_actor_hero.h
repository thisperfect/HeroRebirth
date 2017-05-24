#ifndef __HERO_AUTO_H
#define __HERO_AUTO_H
#include "define.h"

struct _actor_hero {
//--Automatically generated
				i64 heroid;	//英雄唯一ID
				int actorid;	//所属角色ID
				short offset;	//索引
				short kind;	//种类
				short level;	//等级
				int exp;	//经验
				char color;	//品质颜色
};
typedef struct _actor_hero Hero;

typedef Hero * (*LPCB_GETHERO)( int actorid, int offset );
int actor_hero_load_auto( int actorid, int actor_index, LPCB_GETHERO pCB_GetHero, char *pTab );
int actor_hero_save_auto( Hero *pHero, char *pTab, FILE *fp );

#endif
