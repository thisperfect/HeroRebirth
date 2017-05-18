#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include "db.h"
#include "actor.h"
#include "auto_tower.h"
extern MYSQL *myGame;
extern char g_batchsql[BATCHSQL_MAXSIZE];

int g_tower_maxindex = 0;

int tower_load_auto( LPCB_GETTOWER pCB_GetTower, LPCB_LOADTOWER pCB_LoadTower, char *pTab )
{
	MYSQL_RES	*res;
	MYSQL_ROW	row;
	char	szSQL[8192] = {0};
	int offset = 0;
	Tower *pTower;
	int index = 0;

	sprintf( szSQL, "select `index`,`id`,`cityid`,`posx`,`posy`,`type`,`level`,`wear` from %s ", pTab );
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
		pTower = pCB_GetTower( index );
		if( pTower == NULL )
			continue;
		pTower->index = atoi(row[offset++]);
		pTower->id = atoi(row[offset++]);
		pTower->cityid = atoi(row[offset++]);
		pTower->posx = atoi(row[offset++]);
		pTower->posy = atoi(row[offset++]);
		pTower->type = atoi(row[offset++]);
		pTower->level = atoi(row[offset++]);
		pTower->wear = atoi(row[offset++]);
		if( pCB_LoadTower )
			pCB_LoadTower( pTower->index );
		index += 1;
	}
	g_tower_maxindex = index;
	mysql_free_result( res );
	return 0;
}
int tower_save_auto( Tower *pTower, char *pTab, FILE *fp )
{
	char	szSQL[8192] = {0};
	char reconnect_flag = 0;
	if ( pTower == NULL )
		return -1;

RE_TOWER_UPDATE:
	sprintf( szSQL, "REPLACE INTO %s (`index`,`id`,`cityid`,`posx`,`posy`,`type`,`level`,`wear`) Values('%d','%d','%d','%d','%d','%d','%d','%d')",pTab,pTower->index,pTower->id,pTower->cityid,pTower->posx,pTower->posy,pTower->type,pTower->level,pTower->wear);
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
			goto RE_TOWER_UPDATE;
		}
		return -1;
	}
	return 0;
}

int tower_batch_save_auto( Tower *pTower, int maxcount, char *pTab, FILE *fp )
{
	char	szSQL[8192] = {0};
	if ( pTower == NULL )
		return -1;

	char reconnect_flag = 0;
RE_TOWER_TRUNCATE:
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
				goto RE_TOWER_TRUNCATE;
			}
		}
	}

	int count = 0;
	memset( g_batchsql, 0, sizeof(char)*BATCHSQL_MAXSIZE );
	for ( int index = 0; index < maxcount; index++ )
	{
		if ( pTower[index].id <= 0 )
			continue;
		if ( count == 0 )
		{
			sprintf( g_batchsql, "REPLACE INTO %s (`index`,`id`,`cityid`,`posx`,`posy`,`type`,`level`,`wear`) Values('%d','%d','%d','%d','%d','%d','%d','%d')",pTab,pTower[index].index,pTower[index].id,pTower[index].cityid,pTower[index].posx,pTower[index].posy,pTower[index].type,pTower[index].level,pTower[index].wear);
		}
		else
		{
			sprintf( szSQL, ",('%d','%d','%d','%d','%d','%d','%d','%d')",pTower[index].index,pTower[index].id,pTower[index].cityid,pTower[index].posx,pTower[index].posy,pTower[index].type,pTower[index].level,pTower[index].wear);
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
