#ifndef __ITEM_AUTO_H
#define __ITEM_AUTO_H
#include "define.h"

struct _actor_item {
//--Automatically generated
				i64 m_itemid;	//��Ʒid
				int actorid;	//��ɫID
				short offset;	//��Ʒ����λ��
				int m_kind;	//��Ʒ����
				short m_num;	//��Ʒ����
				short m_ability[4];	//����
				int m_value[4];	//����ֵ
				char m_color_level;	//��ɫ�ȼ�
};
typedef struct _actor_item Item;

typedef Item * (*LPCB_GETITEM)( int actorid, int offset );
int actor_item_load_auto( int actorid, int actor_index, LPCB_GETITEM pCB_GetItem, char *pTab );
int actor_item_save_auto( Item *pItem, char *pTab, FILE *fp );

#endif
