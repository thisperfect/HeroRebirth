#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include "db.h"
#include "global.h"
#include "actor.h"
#include "city.h"
#include "mapunit.h"
#include "map.h"

extern SConfig g_Config;
extern MYSQL *myGame;
extern MYSQL *myData;
extern Global global;

extern MapUnit *g_mapunit;
extern int g_mapunit_maxcount;
extern Map g_map;

extern Actor *g_actors;
extern int g_maxactornum;

extern int g_city_maxindex;
City *g_city = NULL;
int g_city_maxcount = 0;
char g_city_allinited = 0;

// �ǳ���������
int city_reset()
{
	memset( g_city, 0, sizeof(City)*g_city_maxcount );
	for ( int tmpi = 0; tmpi < g_city_maxcount; tmpi++ )
	{
		g_city[tmpi].city_index = -1;
		g_city[tmpi].unit_index = -1;
		g_city[tmpi].actor_index = -1;
	}
	return 0;
}

// �ǳض�����ϵĻص�
int city_loadcb( int city_index )
{
	if ( city_index < 0 || city_index >= g_city_maxcount )
		return -1;

	// ��ӵ���ͼ��ʾ��Ԫ
	g_city[city_index].unit_index = mapunit_add( MAPUNIT_TYPE_CITY, city_index );
	// ռ�ؿ���Ϣ��ӵ������ͼ
	map_addobject( MAPUNIT_TYPE_CITY, g_city[city_index].posx, g_city[city_index].posy, MAPUNIT_TYPE_CITY );
	return 0;
}

// ������������ȡ���гǳ���Ϣ���ڴ�
int city_load()
{
	g_city_maxcount = g_Config.max_citycount;
	printf_msg( "City  maxcount=%d  memory=%0.2fMB(memory=%0.2fKB)\n", g_city_maxcount, (sizeof(City)* g_city_maxcount) / 1024.0 / 1024.0, sizeof(City) / 1024.0 );
	city_load_auto( city_indexptr, city_loadcb, "city");
	g_city_allinited = 1;
	return 0;
}

// �������رգ����гǳ���Ϣ�浽���ݿ�
int city_save( FILE *fp )
{
	city_batch_save_auto( g_city, g_city_maxcount, "city", fp );
	return 0;
}

int city_single_save( City *pCity, FILE *fp )
{
	city_save_auto( pCity, "city", fp );
	return 0;
}

// ����һ��������Ϣ�������ز����id
int city_insert( City *pCity )
{
	if ( pCity == NULL )
		return -1;
	char szSQL[8192];
	char reconnect_flag = 0;
RE_CITY_INSERT:
	sprintf( szSQL, "INSERT INTO `city` SET `actorid`='%d'", pCity->actorid );
	if ( mysql_query( myGame, szSQL ) )
	{
		printf_msg( "Query failed (%s)\n", mysql_error( myGame ) );
		write_gamelog( "%s", szSQL );
		if ( reconnect_flag )
			return -1;
		if ( mysql_ping( myGame ) != 0 )
		{
			db_reconnect_game();
			reconnect_flag = 1;
			goto RE_CITY_INSERT;
		}
		return -1;
	}
	return (int)mysql_insert_id( myGame );
}

// ��ȡ�����ҵĳǳ�����
City *city_indexptr( int city_index )
{
	if ( city_index < 0 || city_index >= g_city_maxcount )
		return NULL;
	return &g_city[city_index];
}

// ��ȡ�����ҵĳǳ�����
City *city_getptr( int actor_index )
{
	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return NULL;
	int city_index = g_actors[actor_index].city_index;
	if ( city_index < 0 || city_index >= g_city_maxcount )
		return NULL;
	return &g_city[city_index];
}

// ��ȡ����ǳ�����
City *city_getptr_withcityid( int cityid )
{
	int city_index = city_getindex_withcityid( cityid );
	if ( city_index < 0 || city_index >= g_city_maxcount )
		return NULL;
	return &g_city[city_index];
}

// ��ȡ����ǳ�����
City *city_getptr_withactorid( int actorid )
{
	int city_index = city_getindex_withactorid( actorid );
	if ( city_index < 0 || city_index >= g_city_maxcount )
		return NULL;
	return &g_city[city_index];
}

// �������id�ҵ��ǳ�����
int city_getindex_withactorid( int actorid )
{
	int city_index = -1;
	for ( int tmpi = 0; tmpi < g_city_maxindex/*ע�⣺ʹ������λ�ã�Ϊ��Ч��*/; tmpi++ )
	{
		if ( g_city[tmpi].actorid < MINACTORID )
			continue;
		if ( g_city[tmpi].actorid == actorid )
		{
			city_index = tmpi;
			break;
		}
	}
	return city_index;
}

// ���ݳǳ�id�ҵ��ǳ�����
int city_getindex_withcityid( int cityid )
{
	if ( cityid <= 0 )
	{
		return -1;
	}
	int city_index = -1;
	for ( int tmpi = 0; tmpi < g_city_maxindex/*ע�⣺ʹ������λ�ã�Ϊ��Ч��*/; tmpi++ )
	{
		if ( g_city[tmpi].cityid == cityid )
		{
			city_index = tmpi;
			break;
		}
	}
	return city_index;
}

// ����һ���³���
int city_new( City *pCity )
{
	if ( pCity == NULL )
		return -1;
	int city_index = -1;
	for ( city_index = 1; city_index < g_city_maxcount; city_index++ )
	{
		if ( g_city[city_index].cityid <= 0 )
		{
			memcpy( &g_city[city_index], pCity, sizeof(City) );
			g_city[city_index].cityid = city_insert( &g_city[city_index] );
			g_city[city_index].city_index = city_index;
			g_city[city_index].actor_index = -1;
			g_city[city_index].unit_index = -1;
			break;
		}
	}

	// û�����ɹ�
	if ( city_index >= g_city_maxcount )
		return -1;

	// Ϊ�˱�����Ч�ʣ�������������
	if ( city_index >= g_city_maxindex )
	{
		g_city_maxindex = city_index + 1;
	}

	// �浵
	city_single_save( &g_city[city_index], NULL );
	return city_index;
}
