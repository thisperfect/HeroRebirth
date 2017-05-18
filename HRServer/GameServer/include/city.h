#ifndef _CITY_H_
#define _CITY_H_
#include "define.h"

// �ǳ���������
typedef enum
{
	CityLairdType_Player = 0,		//	��ҵĳǳ�
	CityLairdType_Robot = 2,		//  �����˳ǳ�
}CityLairdType;

// ������������ȡ���гǳ���Ϣ���ڴ�
int city_load();

// �������رգ����гǳ���Ϣ�浽���ݿ�
int city_save( FILE *fp );
int city_single_save( City *pCity, FILE *fp );

// ��ȡ����ǳ�����
City *city_indexptr( int city_index );

// ��ȡ�����ҵĳǳ�����
City *city_getptr( int actor_index );

// ��ȡ����ǳ�����
City *city_getptr_withcityid( int cityid );

// ��ȡ����ǳ�����
City *city_getptr_withactorid( int actorid );

// �������id�ҵ��ǳ�����
int city_getindex_withactorid( int actorid );

// ���ݳǳ�id�ҵ��ǳ�����
int city_getindex_withcityid( int cityid );

// ����һ���³ǳ�
int city_new( City *pCity );
#endif
