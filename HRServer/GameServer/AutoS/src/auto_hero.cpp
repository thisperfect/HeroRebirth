#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include "db.h"
#include "actor.h"
#include "auto_hero.h"
extern MYSQL *myGame;
extern char g_batchsql[BATCHSQL_MAXSIZE];

int g_hero_maxindex = 0;

int hero_load_auto( LPCB_GETHERO pCB_GetHero, LPCB_LOADHERO pCB_LoadHero, char *pTab )
{
	MYSQL_RES	*res;
	MYSQL_ROW	row;
	char	szSQL[8192] = {0};
	int offset = 0;
	Hero *pHero;
	int index = 0;

	sprintf( szSQL, "select `index`,`id`,`name` from %s ", pTab );
	if( mysql_query( myGame, szSQL ) )
	{
		printf( "Query failed (%s)\n", mysql_error(myGame) );
		write_gamelog( "%s", szSQL );
		if( mysql_ping(myGame) != 0 )
			db_reconnect_game();
		return -1;
	}
	res = mysql_store_result( myGame );

	while( ( row = mysql_fetch_row( res ) ) )
	{
		offset = 0;
		pHero = pCB_GetHero( index );
		if( pHero == NULL )
			continue;
		pHero->index = atoi(row[offset++]);
		pHero->id = atoll(row[offset++]);
		memcpy( pHero->name, row[offset++], 22 ); pHero->name[21]=0;
		if( pCB_LoadHero )
			pCB_LoadHero( pHero->index );
		index += 1;
	}
	g_hero_maxindex = index;
	mysql_free_result( res );
	return 0;
}
int hero_save_auto( Hero *pHero, char *pTab, FILE *fp )
{
	char	szSQL[8192] = {0};
	char reconnect_flag = 0;
	if ( pHero == NULL )
		return -1;

	char sz64_id[21]={0};
	char szText_name[MAX_PATH]={0};
RE_HERO_UPDATE:
	sprintf( szSQL, "REPLACE INTO %s (`index`,`id`,`name`) Values('%d','%s','%s')",pTab,pHero->index,lltoa(pHero->id,sz64_id,10 ),db_escape((const char *)pHero->name,szText_name,0));
	if( fp )
	{
		fprintf( fp, "%s;\n", szSQL );
	}
	else if( mysql_query( myGame, szSQL ) )
	{
		printf( "Query failed (%s)\n", mysql_error(myGame) );
		write_gamelog( "%s", szSQL );
		if( reconnect_flag )
			return -1;
		if( mysql_ping(myGame) != 0 )
		{
			db_reconnect_game();
			reconnect_flag = 1;
			goto RE_HERO_UPDATE;
		}
		return -1;
	}
	return 0;
}

int hero_batch_save_auto( Hero *pHero, int maxcount, char *pTab, FILE *fp )
{
	char	szSQL[8192] = {0};
	if ( pHero == NULL )
		return -1;

	char reconnect_flag = 0;
RE_HERO_TRUNCATE:
	sprintf( szSQL, "TRUNCATE `%s`", pTab );
	if( fp )
	{
		fprintf( fp, "%s;\n", szSQL );
	}
	else if( mysql_query( myGame, szSQL ) )
	{
		printf( "Query failed (%s)\n", mysql_error(myGame) );
		write_gamelog( "%s", szSQL );
		if( reconnect_flag == 0 )
		{
			if( mysql_ping(myGame) != 0 )
			{
				db_reconnect_game();
				reconnect_flag = 1;
				goto RE_HERO_TRUNCATE;
			}
		}
	}

	char sz64_id[21]={0};
	char szText_name[MAX_PATH]={0};
	int count = 0;
	memset( g_batchsql, 0, sizeof(char)*BATCHSQL_MAXSIZE );
	for ( int index = 0; index < maxcount; index++ )
	{
		if ( pHero[index].id <= 0 )
			continue;
		if ( count == 0 )
		{
			sprintf( g_batchsql, "REPLACE INTO %s (`index`,`id`,`name`) Values('%d','%s','%s')",pTab,pHero[index].index,lltoa(pHero[index].id,sz64_id,10 ),db_escape((const char *)pHero[index].name,szText_name,0));
		}
		else
		{
			sprintf( szSQL, ",('%d','%s','%s')",pHero[index].index,lltoa(pHero[index].id,sz64_id,10 ),db_escape((const char *)pHero[index].name,szText_name,0));
			strcat( g_batchsql, szSQL );
		}
		count += 1;
		if ( count > 1000 )
		{
			count = 0;
			db_query( fp, g_batchsql );
			memset( g_batchsql, 0, sizeof(char)*BATCHSQL_MAXSIZE );
		}
	}
	if ( count > 0 )
	{
		count = 0;
		db_query( fp, g_batchsql );
		memset( g_batchsql, 0, sizeof(char)*BATCHSQL_MAXSIZE );
	}
	return 0;
}
