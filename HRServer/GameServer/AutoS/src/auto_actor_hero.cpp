#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include "db.h"
#include "actor.h"
#include "auto_actor_hero.h"
extern MYSQL *myGame;
int actor_hero_load_auto( int actorid, int actor_index, LPCB_GETHERO pCB_GetHero, char *pTab )
{
	MYSQL_RES	*res;
	MYSQL_ROW	row;
	char	szSQL[8192] = {0};
	int offset = 0;
	Hero *pHero;

	sprintf( szSQL, "select `heroid`,`actorid`,`offset`,`kind`,`level`,`exp`,`color` from %s where heroid='%d'", pTab, actorid );
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
		pHero = pCB_GetHero( actor_index, atoi(row[2]) );
		if( pHero == NULL )
			continue;
		pHero->heroid = atoll(row[offset++]);
		pHero->actorid = atoi(row[offset++]);
		pHero->offset = atoi(row[offset++]);
		pHero->kind = atoi(row[offset++]);
		pHero->level = atoi(row[offset++]);
		pHero->exp = atoi(row[offset++]);
		pHero->color = atoi(row[offset++]);
	}
	mysql_free_result( res );
	return 0;
}
int actor_hero_save_auto( Hero *pHero, char *pTab, FILE *fp )
{
	char	szSQL[8192] = {0};
	char reconnect_flag = 0;
	if ( pHero == NULL )
		return -1;

	char sz64_heroid[21]={0};
RE_HERO_UPDATE:
	sprintf( szSQL, "REPLACE INTO %s (`heroid`,`actorid`,`offset`,`kind`,`level`,`exp`,`color`) Values('%s','%d','%d','%d','%d','%d','%d')",pTab,lltoa(pHero->heroid,sz64_heroid,10 ),pHero->actorid,pHero->offset,pHero->kind,pHero->level,pHero->exp,pHero->color);
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

