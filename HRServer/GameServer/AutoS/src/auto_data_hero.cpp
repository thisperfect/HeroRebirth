extern "C" {
	#include "lua.h"
	#include "lualib.h"
	#include "lauxlib.h"
}
#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include "db.h"
#include "auto_data_hero.h"
extern MYSQL *myData;
extern lua_State* servL;
Hero *g_hero = NULL;
int g_hero_maxnum = 0;

int hero_init_auto()
{
	MYSQL_RES	*res;
	MYSQL_ROW	row;
	char	szSQL[2048] = {0};
	int offset = 0;

	sprintf( szSQL, "select max(kind) from hero;" );
	if( mysql_query( myData, szSQL ) )
	{
		printf( "Query failed (%s)\n", mysql_error(myData) );
		write_gamelog( "%s", szSQL );
		return -1;
	}
	res = mysql_store_result( myData );
	if( ( row = mysql_fetch_row( res ) ) )
	{
		if ( row[0] )
			g_hero_maxnum = atoi( row[0] ) + 1;
		else
			g_hero_maxnum = 0;
	}
	else
	{
		mysql_free_result( res );
		return -1;
	}
	mysql_free_result( res );

	g_hero = (Hero *)malloc( sizeof(Hero)*g_hero_maxnum );
	memset( g_hero, 0, sizeof(Hero)*g_hero_maxnum );

	sprintf( szSQL, "select `kind`,`name`,`color`,`job`,`level_init`,`star_init`,`star_max`,`life`,`attack`,`defence`,`precision`,`dodge`,`crit`,`crit_resist`,`crit_damage`,`crit_damage_resist`,`speed_attack`,`speed_move`,`ignore_defence`,`damage_increase`,`damage_reduce`,`skillid0`,`skillid1`,`skillid2`,`skillid3` from hero;" );
	if( mysql_query( myData, szSQL ) )
	{
		printf( "Query failed (%s)\n", mysql_error(myData) );
		write_gamelog( "%s", szSQL );
		return -1;
	}
	res = mysql_store_result( myData );
	while( ( row = mysql_fetch_row( res ) ) )
	{
		offset = 0;
		int kind = atoi( row[0] );
		if ( kind < 0 || kind >= g_hero_maxnum  )
			continue;
		g_hero[kind].kind = atoi(row[offset++]);
		memcpy( g_hero[kind].name, row[offset++], 255 ); g_hero[kind].name[254]=0;
		g_hero[kind].color = atoi(row[offset++]);
		g_hero[kind].job = atoi(row[offset++]);
		g_hero[kind].level_init = atoi(row[offset++]);
		g_hero[kind].star_init = atoi(row[offset++]);
		g_hero[kind].star_max = atoi(row[offset++]);
		g_hero[kind].life = atoi(row[offset++]);
		g_hero[kind].attack = atoi(row[offset++]);
		g_hero[kind].defence = atoi(row[offset++]);
		g_hero[kind].precision = atoi(row[offset++]);
		g_hero[kind].dodge = atoi(row[offset++]);
		g_hero[kind].crit = atoi(row[offset++]);
		g_hero[kind].crit_resist = atoi(row[offset++]);
		g_hero[kind].crit_damage = atoi(row[offset++]);
		g_hero[kind].crit_damage_resist = atoi(row[offset++]);
		g_hero[kind].speed_attack = atoi(row[offset++]);
		g_hero[kind].speed_move = atoi(row[offset++]);
		g_hero[kind].ignore_defence = atoi(row[offset++]);
		g_hero[kind].damage_increase = atoi(row[offset++]);
		g_hero[kind].damage_reduce = atoi(row[offset++]);
		g_hero[kind].skillid[0] = atoi(row[offset++]);
		g_hero[kind].skillid[1] = atoi(row[offset++]);
		g_hero[kind].skillid[2] = atoi(row[offset++]);
		g_hero[kind].skillid[3] = atoi(row[offset++]);
	}
	mysql_free_result( res );
	hero_luatable_auto();
	return 0;
}

int hero_reload_auto()
{
	if ( g_hero )
	{
		free( g_hero );
		g_hero = NULL;
	}
	g_hero_maxnum = 0;
	hero_init_auto();
	return 0;
}

int hero_luatable_auto()
{
	lua_newtable( servL );
	for ( int kind = 0; kind < g_hero_maxnum; kind++ )
	{
		lua_pushinteger( servL, kind );
		lua_newtable( servL );

		lua_pushstring( servL, "kind" );
		lua_pushinteger( servL, g_hero[kind].kind );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "name" );
		lua_pushstring( servL, g_hero[kind].name );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "color" );
		lua_pushinteger( servL, g_hero[kind].color );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "job" );
		lua_pushinteger( servL, g_hero[kind].job );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "level_init" );
		lua_pushinteger( servL, g_hero[kind].level_init );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "star_init" );
		lua_pushinteger( servL, g_hero[kind].star_init );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "star_max" );
		lua_pushinteger( servL, g_hero[kind].star_max );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "life" );
		lua_pushinteger( servL, g_hero[kind].life );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "attack" );
		lua_pushinteger( servL, g_hero[kind].attack );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "defence" );
		lua_pushinteger( servL, g_hero[kind].defence );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "precision" );
		lua_pushinteger( servL, g_hero[kind].precision );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "dodge" );
		lua_pushinteger( servL, g_hero[kind].dodge );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "crit" );
		lua_pushinteger( servL, g_hero[kind].crit );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "crit_resist" );
		lua_pushinteger( servL, g_hero[kind].crit_resist );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "crit_damage" );
		lua_pushinteger( servL, g_hero[kind].crit_damage );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "crit_damage_resist" );
		lua_pushinteger( servL, g_hero[kind].crit_damage_resist );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "speed_attack" );
		lua_pushinteger( servL, g_hero[kind].speed_attack );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "speed_move" );
		lua_pushinteger( servL, g_hero[kind].speed_move );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "ignore_defence" );
		lua_pushinteger( servL, g_hero[kind].ignore_defence );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "damage_increase" );
		lua_pushinteger( servL, g_hero[kind].damage_increase );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "damage_reduce" );
		lua_pushinteger( servL, g_hero[kind].damage_reduce );
		lua_rawset( servL, -3 );

		lua_pushstring( servL, "skillid" );
		lua_newtable( servL );
		for ( int i = 0; i < 4; i++ )
		{
			lua_pushinteger( servL, i );
			lua_pushinteger( servL, g_hero[kind].skillid[i] );
			lua_rawset( servL, -3 );
		}
		lua_rawset( servL, -3 );

		lua_rawset( servL, 1 );
	}
	lua_setglobal( servL, "g_hero" );

	lua_pushinteger( servL, g_hero_maxnum );
	lua_setglobal( servL, "g_hero_maxnum" );
	return 0;
}
