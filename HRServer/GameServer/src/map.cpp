#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "db.h"
#include "define.h"
#include "system.h"
#include "actor.h"
#include "server_netsend_auto.h"
#include "actor_send.h"
#include "map.h"
#include "global.h"
#include "mapunit.h"
#include "script_auto.h"

extern Global global;
extern SConfig g_Config;
extern MYSQL *myGame;
extern MYSQL *myData;

extern Actor *g_actors;
extern int g_maxactornum;

Map g_map;
int g_nUnitQueueNumLimit;		// �������еļ��ޣ��������ٷ���
int *g_pTmpEnterArmy;
int *g_pTmpLeaveArmy;

short g_last_cityposx = 0;
short g_last_cityposy = 0;

//-----------------------------------------------------------------------------
// map_init
// ����˵��: �����ͼ��ʼ��
//-----------------------------------------------------------------------------
int map_init()
{
	g_nUnitQueueNumLimit = 200;

	g_pTmpEnterArmy = (int *)malloc( sizeof(int)*g_nUnitQueueNumLimit );
	g_pTmpLeaveArmy = (int *)malloc( sizeof(int)*g_nUnitQueueNumLimit );

	g_map.m_nMaxWidth = MAP_W;
	g_map.m_nMaxHeight = MAP_H;

	// ��������
	g_map.m_nAreaXNum = (g_map.m_nMaxWidth - 1) / AREA_WIDTH + 1;
	g_map.m_nAreaYNum = (g_map.m_nMaxHeight - 1) / AREA_HEIGHT + 1;
	g_map.m_nAreaMaxCount = g_map.m_nAreaXNum*g_map.m_nAreaYNum;
	g_map.m_aArea = (Area*)malloc( sizeof(Area)*(g_map.m_nAreaMaxCount) );
	memset( g_map.m_aArea, 0, sizeof(Area)*(g_map.m_nAreaMaxCount) );
	for ( int tmpi = 0; tmpi < g_map.m_nAreaMaxCount; tmpi++ )
	{
		g_map.m_aArea[tmpi].unit_head = -1;
		g_map.m_aArea[tmpi].unit_tail = -1;
		area_initqueue( &g_map.m_aArea[tmpi] );
	}

	// �����������
	g_map.m_aTileData = (unsigned char **)malloc( sizeof(unsigned char *)* g_map.m_nMaxWidth );
	for ( int tmpi = 0; tmpi < g_map.m_nMaxWidth; tmpi++ )
	{
		g_map.m_aTileData[tmpi] = (unsigned char *)malloc( sizeof(unsigned char)* g_map.m_nMaxHeight );
		memset( g_map.m_aTileData[tmpi], 0, sizeof(unsigned char)*(g_map.m_nMaxHeight) );
	}
	
	// �����ͼ�ű�
	sc_OnWorldMapInit( g_map.m_nMaxWidth, g_map.m_nMaxHeight );

	return 0; 
}

// ��ͼ֡�߼�
void map_logic()
{
	for ( int tmpi = 0; tmpi < g_map.m_nAreaXNum*g_map.m_nAreaYNum; tmpi++ )
	{
		area_logic( tmpi );
	}
}

// �����ͼ������Ϣ
void map_sendinfo( int actor_index, short tposx, short tposy )
{
	SLK_NetS_WorldMapInfo info = { 0 };
	info.m_map_width = g_map.m_nMaxWidth;
	info.m_map_height = g_map.m_nMaxHeight;
	info.m_area_width = AREA_WIDTH;
	info.m_area_height = AREA_HEIGHT;
	info.m_map_area_xnum = g_map.m_nAreaXNum;
	info.m_map_area_ynum = g_map.m_nAreaYNum;
	info.m_target_posx = tposx;
	info.m_target_posy = tposy;
	
	netsend_worldmapinfo_S( actor_index, SENDTYPE_ACTOR, &info );
}

// �����ͼ������Ϣ-���
void map_sendinfo_global( int actor_index, short serverid, short tposx, short tposy )
{
	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return;

}

// ��Ӷ���
int map_addobject( int type, short posx, short posy, char unittype )
{
	if ( posx < 0 || posy < 0 || posx >= g_map.m_nMaxWidth || posy >= g_map.m_nMaxHeight )
	{
		return -1;
	}

	switch ( type )
	{
	// ռ3*3����
	case -3:
		if ( posx <= 0 || posy <= 0 || posx >= g_map.m_nMaxWidth-1 || posy >= g_map.m_nMaxHeight-1 )
		{
			return -1;
		}
		if ( unittype > 0 )
		{
			g_map.m_aTileData[posx][posy]			= unittype;
			g_map.m_aTileData[posx - 1][posy]		= unittype;
			g_map.m_aTileData[posx - 1][posy - 1]	= unittype;
			g_map.m_aTileData[posx][posy - 1]		= unittype;
			g_map.m_aTileData[posx + 1][posy - 1]	= unittype;
			g_map.m_aTileData[posx + 1][posy]		= unittype;
			g_map.m_aTileData[posx + 1][posy + 1]	= unittype;
			g_map.m_aTileData[posx][posy + 1]		= unittype;
			g_map.m_aTileData[posx - 1][posy + 1]	= unittype;
		}
		break;
	// ռ2*2������
	case MAPUNIT_TYPE_CITY:
	case -2:
		if ( posy <= 0 || posx >= g_map.m_nMaxWidth - 1 )
		{
			return -1;
		}
		if ( g_map.m_aTileData[posx][posy]			> 0 ||
			g_map.m_aTileData[posx][posy - 1]		> 0 ||
			g_map.m_aTileData[posx + 1][posy - 1]	> 0 ||
			g_map.m_aTileData[posx + 1][posy]		> 0 )
		{
			return -1;
		}
		if ( unittype > 0 )
		{
			g_map.m_aTileData[posx][posy]			= unittype;
			g_map.m_aTileData[posx][posy - 1]		= unittype;
			g_map.m_aTileData[posx + 1][posy - 1]	= unittype;
			g_map.m_aTileData[posx + 1][posy]		= unittype;
		}
		break;

	// ռ1*1������
	case MAPUNIT_TYPE_ARMY:
	case -1:
		if ( g_map.m_aTileData[posx][posy] > 0 )
		{
			return -1;
		}
		if ( unittype > 0 )
		{
			g_map.m_aTileData[posx][posy] = unittype;
		}
		break;
	default:
		if ( g_map.m_aTileData[posx][posy] > 0 )
		{
			return -1;
		}
		if ( unittype > 0 )
		{
			g_map.m_aTileData[posx][posy] = unittype;
		}
		break;
	}
	return 0;
}

// �Ƴ�����
int map_delobject( int type, short posx, short posy )
{
	if ( posx < 0 || posy < 0 || posx >= g_map.m_nMaxWidth || posy >= g_map.m_nMaxHeight )
	{
		return -1;
	}

	switch ( type )
	{
		// ռ3*3����
	case -3:
		if ( posx <= 0 || posy <= 0 || posx >= g_map.m_nMaxWidth - 1 || posy >= g_map.m_nMaxHeight - 1 )
		{
			return -1;
		}
		g_map.m_aTileData[posx][posy]			= 0;
		g_map.m_aTileData[posx - 1][posy]		= 0;
		g_map.m_aTileData[posx - 1][posy - 1]	= 0;
		g_map.m_aTileData[posx][posy - 1]		= 0;
		g_map.m_aTileData[posx + 1][posy - 1]	= 0;
		g_map.m_aTileData[posx + 1][posy]		= 0;
		g_map.m_aTileData[posx + 1][posy + 1]	= 0;
		g_map.m_aTileData[posx][posy + 1]		= 0;
		g_map.m_aTileData[posx - 1][posy + 1]	= 0;
		break;

	// ռ2*2������
	case MAPUNIT_TYPE_CITY: 
	case -2:
		if ( posy <= 0 || posx >= g_map.m_nMaxWidth - 1 )
		{
			return -1;
		}
		g_map.m_aTileData[posx][posy]			= 0;
		g_map.m_aTileData[posx][posy - 1]		= 0;
		g_map.m_aTileData[posx + 1][posy - 1]	= 0;
		g_map.m_aTileData[posx + 1][posy]		= 0;
		break;

	// ռ1*1������
	case MAPUNIT_TYPE_ARMY:
	case -1:
		g_map.m_aTileData[posx][posy] = 0;
		break;
	default:
		break;
	}
	return 0;
}

// Ȧ���
int getCircleID( short posx, short posy )
{
	int a = posx / 65 + 1;
	int b = posy / 65 + 1;
	int circleid = min( min( 16 - a, a ), min( 16 - b, b ) );
	return circleid;
}

// �ж�����ص��Ƿ���Ǩ��
int map_canmove( short posX, short posY )
{
	if( posX < 0 || posY < 0 || posX >= g_map.m_nMaxWidth || posY >= g_map.m_nMaxWidth || posY - 1 <= 0 || posX + 1 >= g_map.m_nMaxWidth  )
	{
		return 0;
	}

	// ��������
	if ( g_map.m_aTileData[posX][posY]			== 0 &&
		g_map.m_aTileData[posX][posY-1]			== 0 &&
		g_map.m_aTileData[posX+1][posY-1]		== 0 &&
		g_map.m_aTileData[posX+1][posY]		== 0 )
	{
		return 1;
	}

	return 0;
}

// ���һ����ָ���ص�����Ŀ�Ǩ�ǿհ׵� ��������
int map_getcanmovenearest( short *pPosx, short *pPosy )
{
	if( *pPosx < 0 || *pPosy < 0 || *pPosx >= g_map.m_nMaxWidth || *pPosy >= g_map.m_nMaxWidth )
	{
		return -1;
	}

	/* ����������˵���һȦ�������Ͽ�ʼ*/
	// ����
	short stepX = 3;
	short stepY = 4;

	// ������������
	short stepXForward = 1;
	short stepYForward = -1;

	// ���
	short posX = *pPosx - 1;
	short posY = *pPosy + 2;
	// ��������
	if ( map_canmove( posX, posY ) )
	{
		*pPosx = posX;
		*pPosy = posY;
		return 0;
	}

	// ���գ�������1000������
	short count = 0;

	while( count < 1000 )
	{
		// ����X����
		for( int i = 0; i < stepX; i++ )
		{
			posX += stepXForward;
			if ( map_canmove( posX, posY ) )
			{
				*pPosx = posX;
				*pPosy = posY;
				return 0;
			}
		}
		stepXForward *= -1;

		// ����Y����
		for( int i = 0; i < stepY; i++ )
		{
			posY += stepYForward;
			if ( map_canmove( posX, posY ) )
			{
				*pPosx = posX;
				*pPosy = posY;
				return 0;
			}
		}
		stepYForward *= -1;

		// ѭ��һ������һ�β���
		stepX++;
		stepY++;

		// ��ֹ��ѭ��
		count += 1;
	}

	return -1;
}

// ���һ���հ׵�
int map_getrandpos( int type, short *pPosx, short *pPosy )
{
	*pPosx = rand() % (g_map.m_nMaxWidth - MAP_SIZEOFFSET) + 1;
	*pPosy = rand() % (g_map.m_nMaxHeight - MAP_SIZEOFFSET) + 1;

	switch ( type )
	{
		// ռ3*3����
	case -3:
		if ( g_map.m_aTileData[*pPosx][*pPosy]			== 0 &&
			g_map.m_aTileData[*pPosx - 1][*pPosy]		== 0 &&
			g_map.m_aTileData[*pPosx - 1][*pPosy - 1]	== 0 &&
			g_map.m_aTileData[*pPosx][*pPosy - 1]		== 0 &&
			g_map.m_aTileData[*pPosx + 1][*pPosy - 1]	== 0 &&
			g_map.m_aTileData[*pPosx + 1][*pPosy]		== 0 &&
			g_map.m_aTileData[*pPosx + 1][*pPosy + 1]	== 0 &&
			g_map.m_aTileData[*pPosx][*pPosy + 1]		== 0 &&
			g_map.m_aTileData[*pPosx - 1][*pPosy + 1]	== 0 )
		{
			return 0;
		}
		else
		{
			while ( g_map.m_aTileData[*pPosx][*pPosy]		> 0 ||
				g_map.m_aTileData[*pPosx - 1][*pPosy]		> 0 ||
				g_map.m_aTileData[*pPosx - 1][*pPosy - 1]	> 0 ||
				g_map.m_aTileData[*pPosx][*pPosy - 1]		> 0 ||
				g_map.m_aTileData[*pPosx + 1][*pPosy - 1]	> 0 ||
				g_map.m_aTileData[*pPosx + 1][*pPosy]		> 0 ||
				g_map.m_aTileData[*pPosx + 1][*pPosy + 1]	> 0 ||
				g_map.m_aTileData[*pPosx][*pPosy + 1]		> 0 ||
				g_map.m_aTileData[*pPosx - 1][*pPosy + 1]	> 0 )
			{
				*pPosx = rand() % (g_map.m_nMaxWidth - MAP_SIZEOFFSET) + 1;
				*pPosy = rand() % (g_map.m_nMaxHeight - MAP_SIZEOFFSET) + 1;
			}
			return 0;
		}
	// ռ2*2������
	case MAPUNIT_TYPE_CITY:
	case -2:
		if ( g_map.m_aTileData[*pPosx][*pPosy]			== 0 &&
			g_map.m_aTileData[*pPosx][*pPosy - 1]		== 0 &&
			g_map.m_aTileData[*pPosx + 1][*pPosy - 1]	== 0 &&
			g_map.m_aTileData[*pPosx + 1][*pPosy]		== 0 && 
			!(*pPosx >= 455 && *pPosx <= 505 && *pPosy >= 455 && *pPosy <= 505) )
		{
			return 0;
		}
		else
		{
			while ( g_map.m_aTileData[*pPosx][*pPosy]		> 0 ||
				g_map.m_aTileData[*pPosx][*pPosy - 1]		> 0 ||
				g_map.m_aTileData[*pPosx + 1][*pPosy - 1]	> 0 ||
				g_map.m_aTileData[*pPosx + 1][*pPosy]		> 0 || 
			(*pPosx >= 455 && *pPosx <= 505 && *pPosy >= 455 && *pPosy <= 505) )
			{
				*pPosx = rand() % (g_map.m_nMaxWidth - MAP_SIZEOFFSET) + 1;
				*pPosy = rand() % (g_map.m_nMaxHeight - MAP_SIZEOFFSET) + 1;
			}
			return 0;
		}
		break;

	// ռ1*1������
	case MAPUNIT_TYPE_ARMY:
	case -1:
		if ( g_map.m_aTileData[*pPosx][*pPosy] == 0 &&
			!(*pPosx >= 477 && *pPosx <= 483 && *pPosy >= 477 && *pPosy <= 483) )
		{
			return 0;
		}
		else
		{
			while ( g_map.m_aTileData[*pPosx][*pPosy] > 0 ||
				(*pPosx >= 477 && *pPosx <= 483 && *pPosy >= 477 && *pPosy <= 483) )
			{
				*pPosx = rand() % (g_map.m_nMaxWidth - MAP_SIZEOFFSET) + 1;
				*pPosy = rand() % (g_map.m_nMaxHeight - MAP_SIZEOFFSET) + 1;
			}
			return 0;
		}
		break;
	default:
		break;
	}

	return -1;
}

// ����ָ����ķ�Χ��ȡһ�����������
int map_getrandpos_withrange( int type, short posx, short posy, int range, short *pPosx, short *pPosy )
{
	short findlistx[256] = { 0 };
	short findlisty[256] = { 0 };
	short offset = 0;
	for ( int tmpi = -range; tmpi <= range; tmpi++ )
	{
		for ( int tmpj = -range; tmpj <= range; tmpj++ )
		{
			short x = posx + tmpi;
			short y = posy + tmpj;
			if ( x <= 0 || y <= 0 || x >= g_map.m_nMaxWidth || y >= g_map.m_nMaxHeight )
				continue;
			if ( g_map.m_aTileData[x][y] > 0 )
				continue;
			if ( map_addobject( type, x, y, -1 ) < 0 )
				continue;
			// �ҵ����еĿ����
			findlistx[offset] = x;
			findlisty[offset] = y;
			offset += 1;
			if ( offset >= 256 )
				break;
		}
		if ( offset >= 256 )
			break;
	}

	if ( offset > 0 )
	{
		int index = rand() % offset;
		*pPosx = findlistx[index];
		*pPosy = findlisty[index];
	}
	else
	{
		*pPosx = -1;
		*pPosy = -1;
	}
	return 0;
}

// �����ҳǳ�λ��
int map_getrandcitypos( short *pPosx, short *pPosy )
{
	if ( g_last_cityposx <= 0  )
		g_last_cityposx = world_data_get( 5, NULL );
	if ( g_last_cityposy <= 0  )
		g_last_cityposy = world_data_get( 6, NULL );
	if ( g_last_cityposx <= 0 )
		g_last_cityposx = 200;
	if ( g_last_cityposy <= 0 )
		g_last_cityposy = 200;
	if ( g_last_cityposx >= MAP_W )
		g_last_cityposx = 800;
	if ( g_last_cityposy >= MAP_H )
		g_last_cityposy = 800;
	*pPosx = g_last_cityposx;
	*pPosy = g_last_cityposy;
	if ( g_map.m_aTileData[*pPosx][*pPosy] == 0 &&
		g_map.m_aTileData[*pPosx][*pPosy - 1] == 0 &&
		g_map.m_aTileData[*pPosx + 1][*pPosy - 1] == 0 &&
		g_map.m_aTileData[*pPosx + 1][*pPosy] == 0 )
	{
		return 0;
	}
	else
	{
		int loops = 0;
		int loopscount = 0;
		while ( g_map.m_aTileData[*pPosx][*pPosy] > 0 ||
			g_map.m_aTileData[*pPosx][*pPosy - 1] > 0 ||
			g_map.m_aTileData[*pPosx + 1][*pPosy - 1] > 0 ||
			g_map.m_aTileData[*pPosx + 1][*pPosy] > 0 ||
			getCircleID( *pPosx, *pPosy ) > 5 || 
			( *pPosx >= 455 && *pPosx <= 505 && *pPosy >= 455 && *pPosy <= 505 ) )
		{
			short roundmin = g_last_cityposx - 32;
			short roundmax = g_last_cityposx + 32;
			if ( roundmin < 16 )
				roundmin = 16;
			if ( roundmax > g_map.m_nMaxWidth - 16 )
				roundmax = g_map.m_nMaxWidth - 16;
			*pPosx = random( roundmin, roundmax );


			roundmin = g_last_cityposy - 32;
			roundmax = g_last_cityposy + 32;
			if ( roundmin < 16 )
				roundmin = 16;
			if ( roundmax > g_map.m_nMaxHeight - 16 )
				roundmax = g_map.m_nMaxHeight - 16;
			*pPosy = random( roundmin, roundmax );

			loopscount += 1;
			if ( loopscount > 921600 )
			{
				return -1;
			}
			loops += 1;
			if ( loops > 1024 )
			{ // ûλ���ˣ���ô��һ��λ�ã����¿�ʼ
				g_last_cityposx = random( 200, 400 );
				g_last_cityposy = random( 700, MAP_H );
				loops = 0;
			}
		}
		g_last_cityposx = *pPosx;
		g_last_cityposy = *pPosy;
		world_data_set( WORLD_DATA_LAST_CITYPOSX, g_last_cityposx, NULL, NULL );
		world_data_set( WORLD_DATA_LAST_CITYPOSY, g_last_cityposy, NULL, NULL );
		return 0;
	}
	return -1;
}

bool ptInLine( Pos point, Pos lineStartPoint, Pos lineEndPoint, double fTolerance )
{
	double L, R, S;
	bool bResult = false;

	L = sqrt( (double)((lineEndPoint.x - lineStartPoint.x)*(lineEndPoint.x - lineStartPoint.x) + (lineEndPoint.y - lineStartPoint.y)*(lineEndPoint.y - lineStartPoint.y)) );
	if ( L != 0 )
	{
		R = ((lineStartPoint.y - point.y)*(lineStartPoint.y - lineEndPoint.y) - (lineStartPoint.x - point.x)*(lineEndPoint.x - lineStartPoint.x)) / (L*L);
		S = ((lineStartPoint.y - point.y)*(lineEndPoint.x - lineStartPoint.x) - (lineStartPoint.x - point.x)*(lineEndPoint.y - lineStartPoint.y)) / (L*L);
		if ( R > 0 && R < 1 )
		{
			if ( abs( (int)(S*L) ) <= fTolerance )
				bResult = true;
		}
	}

	return bResult;
}

// ��ͼ�������
short map_swamp_distance( short f_posx, short f_posy, short t_posx, short t_posy, short distance )
{
	// �������Ŀ�ĵ㶼������
	if ( f_posx >= 455 && f_posx <= 505 && f_posy >= 455 && f_posy <= 505 &&
		t_posx >= 455 && t_posx <= 505 && t_posy >= 455 && t_posy <= 505 )
	{
		return distance;
	}

	Pos line1 = { 0 }; line1.x = 455;
	Pos line2 = { 0 }; line2.x = 505;
	Pos line3 = { 0 }; line3.y = 455;
	Pos line4 = { 0 }; line4.y = 505;
	Pos pos[4] = { 0 };
	int count = 0;

	if ( f_posx == t_posx )
	{
		line1.y = f_posy;
		line2.y = f_posy;
	}
	else
	{
		line1.y = (int)(((t_posy - f_posy) / (float)(t_posx - f_posx))*(line1.x - f_posx)) + f_posy;
		line2.y = (int)(((t_posy - f_posy) / (float)(t_posx - f_posx))*(line2.x - f_posx)) + f_posy;
	}

	if ( f_posy == t_posy )
	{
		line3.x = f_posx;
		line4.x = f_posx;
	}
	else
	{
		line3.x = (int)((line3.y - f_posy)*(t_posx - f_posx) / (float)(t_posy - f_posy)) + f_posx;
		line4.x = (int)((line4.y - f_posy)*(t_posx - f_posx) / (float)(t_posy - f_posy)) + f_posx;
	}

	if ( line1.y >= 455 && line1.y <= 505 )
	{
		pos[count].x = line1.x;
		pos[count].y = line1.y;
		count += 1;
	}
	if ( line2.y >= 455 && line2.y <= 505 )
	{
		pos[count].x = line2.x;
		pos[count].y = line2.y;
		count += 1;
	}
	if ( line3.x >= 455 && line3.x <= 505 )
	{
		pos[count].x = line3.x;
		pos[count].y = line3.y;
		count += 1;
	}
	if ( line4.x >= 455 && line4.x <= 505 )
	{
		pos[count].x = line4.x;
		pos[count].y = line4.y;
		count += 1;
	}

	if ( count == 2 )
	{
		// ���������������
		if ( f_posx >= 455 && f_posx <= 505 && f_posy >= 455 && f_posy <= 505 )
		{ // ��ôĿ�ĵ�϶�������
			short dis0 = (short)sqrt( pow( (float)(pos[0].x - f_posx), 2 ) + pow( (float)(pos[0].y - f_posy), 2 ) );
			short dis1 = (short)sqrt( pow( (float)(pos[0].x - t_posx), 2 ) + pow( (float)(pos[0].y - t_posy), 2 ) );
			if ( dis0 < distance && dis1 < distance )
			{
				return dis0;
			}
			else
			{
				short len = (short)sqrt( pow( (float)(pos[1].x - f_posx), 2 ) + pow( (float)(pos[1].y - f_posy), 2 ) );
				return len;
			}
		}
		// ���Ŀ�ĵ�������
		else if ( t_posx >= 455 && t_posx <= 505 && t_posy >= 455 && t_posy <= 505 )
		{ // ��ô��������㵱������
			short dis0 = (short)sqrt( pow( (float)(pos[0].x - f_posx), 2 ) + pow( (float)(pos[0].y - f_posy), 2 ) );
			short dis1 = (short)sqrt( pow( (float)(pos[0].x - t_posx), 2 ) + pow( (float)(pos[0].y - t_posy), 2 ) );
			if ( dis0 < distance && dis1 < distance )
			{
				return dis1;
			}
			else
			{
				short len = (short)sqrt( pow( (float)(pos[1].x - t_posx), 2 ) + pow( (float)(pos[1].y - t_posy), 2 ) );
				return len;
			}
		}
		else
		{ // ����������
			Pos lineStartPoint; lineStartPoint.x = f_posx; lineStartPoint.y = f_posy;
			Pos lineEndPoint; lineEndPoint.x = t_posx; lineEndPoint.y = t_posy;

			if ( ptInLine( pos[0], lineStartPoint, lineEndPoint, 0 ) )
			{
				// ����
				short len = (short)sqrt( pow( (float)(pos[0].x - pos[1].x), 2 ) + pow( (float)(pos[0].y - pos[1].y), 2 ) );
				return len;
			}
		}
	}
	return 0;
}

// dump��ͼ����
void map_tile_dump()
{
	FILE *fp = fopen( "./map_tile.txt", "wb" );
	if ( !fp )
		return;
	for ( short posy = 0; posy < g_map.m_nMaxHeight; posy++ )
	{
		for ( short posx = 0; posx < g_map.m_nMaxWidth; posx++ )
		{
			fprintf( fp, "%d\t", g_map.m_aTileData[posx][posy] );
		}
		fprintf( fp, "\n" );
	}
	fclose( fp );
}
