#ifndef __MAP_H_
#define __MAP_H_

#include "area.h"
#define MAP_SIZEOFFSET 4

#define MAP_W	960
#define MAP_H	960

// �����ͼ
typedef struct _map
{
	int				m_nMaxWidth;	// ��ͼ�Ŀ��(���鵥λ)
	int				m_nMaxHeight;	// ��ͼ�ĸ߶�(���鵥λ)
	short			m_nAreaXNum;
	short			m_nAreaYNum;
	int				m_nAreaMaxCount;
	Area			*m_aArea;
	unsigned char	**m_aTileData;		// ÿ�����ӵ�����
}Map;

typedef struct _pos
{
	short x;
	short y;
}Pos;

int map_init();
void map_logic();
void map_sendinfo( int actor_index, short tposx, short tposy );
void map_sendinfo_global( int actor_index, short serverid, short tposx, short tposy );
void map_sendthumbinfo( int actor_index );

// ��Ӷ���
int map_addobject( int type, short posx, short posy, char unittype );

// �Ƴ�����
int map_delobject( int type, short posx, short posy );

// ���һ����ָ���ص�����Ŀ�Ǩ�ǿհ׵� ��������
int map_getcanmovenearest( short *pPosx, short *pPosy );

// ���һ���հ׵�
int map_getrandpos( int type, short *pPosx, short *pPosy );

// ����ָ����ķ�Χ��ȡһ�����������
int map_getrandpos_withrange( int type, short posx, short posy, int range, short *pPosx, short *pPosy );

// �����ҳǳ�λ��
int map_getrandcitypos( short *pPosx, short *pPosy );

// ��ͼ�������
short map_swamp_distance( short f_posx, short f_posy, short t_posx, short t_posy, short distance );

// dump��ͼ����
void map_tile_dump();
#endif
