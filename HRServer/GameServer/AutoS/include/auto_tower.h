#ifndef __TOWER_AUTO_H
#define __TOWER_AUTO_H
#include "define.h"

struct _tower {
//--Automatically generated
				int index;	//索引
				int id;	//ID
				int cityid;	//所属城池ID
				int city_index;	//所属城池索引
				int unit_index;	//现实对象索引
				short posx;	//位置
				short posy;	//位置
				char type;	//类型
				char level;	//等级
				int wear;	//耐久
};
typedef struct _tower Tower;

typedef Tower * (*LPCB_GETTOWER)( int index );
typedef int (*LPCB_LOADTOWER)( int index );
int tower_load_auto( LPCB_GETTOWER pCB_GetTower, LPCB_LOADTOWER pCB_LoadTower, char *pTab );
int tower_save_auto( Tower *pTower, char *pTab, FILE *fp );
int tower_batch_save_auto( Tower *pTower, int maxcount,  char *pTab, FILE *fp );

#endif
