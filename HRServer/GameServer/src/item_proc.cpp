#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include <mysql.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "db.h"
#include "define.h"
#include "actor.h"
#include "gameproc.h"
#include "item.h"
#include "actor_notify.h"
#include "actor_send.h"
#include "server_netsend_auto.h"
#include "script_auto.h"
#include "global.h"

extern MYSQL *myData;
extern MYSQL *myGame;
extern Global global;

extern Actor *g_actors;
extern int g_maxactornum;

extern ItemKind *g_itemkind;
extern int g_itemkind_maxnum;

//-----------------------------------------------------------------------------
// ����˵��: ���ߵ�ʹ��
// ����    : actor_index - 
//           hero_index	- Ӣ��index
//           target_index	- Ŀ��index
//-----------------------------------------------------------------------------
int item_use( int actor_index, short itemindex, short itemnum, int hero_index, int target_index, int ask )
{
	Actor *pActor = NULL;
	int item_kind = 0;
	short item_level = 0;
	short item_type = 0;
	short true_usenum = 0;
	short tmp_ability = 0;
	int eff_result = 0;

	if ( itemindex < 0 || itemindex >= MAX_ACTOR_ITEMNUM )
		return -1;
	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;
	if ( target_index < 0 || target_index >= g_maxactornum )
	{
		target_index = actor_index;
	}

	// �����Ʒitemkind
	item_kind = g_actors[actor_index].item[itemindex].m_kind;
	if ( g_actors[actor_index].item[itemindex].m_kind <= 0 )
		return -1;

	// ��ȡ��Ʒ����
	item_type = item_gettype( item_kind );

	//// ��ȡ��ʹ����Ʒ�Ľ�ɫ������
	//if ( hero_index < 0 || hero_index >= HERO_MAXCOUNT )
	//{ // ����
	//	pActor = &g_actors[target_index];
	//}
	//else 
	//{ // Ӣ��
	//	pHeroAttr = &g_actors[target_index].hero[hero_index];
	//}

	// ���ȼ�
	item_level = item_getlevel( item_kind );
	if ( item_level < 0 )
	{ // ���ǵȼ�
		//if ( city_mainlevel( city_getptr( actor_index ) ) < -item_level )
		//	return -1;
	}
	else if ( item_level > 0 )
	{ // ��ɫ�ȼ�
		if ( pActor->level < item_level )
			return -1;
	}

	if ( itemnum == 0 ) // ȫ��
		true_usenum = g_actors[actor_index].item[itemindex].m_num;
	else if ( itemnum > 0 )
		true_usenum = itemnum;
	else
		return -1;

	// ʹ��������Ʒ����Ʒ��ʵʹ������
	if ( g_actors[actor_index].item[itemindex].m_num < true_usenum )
	{
		true_usenum = g_actors[actor_index].item[itemindex].m_num;
	}
	if ( true_usenum <= 0 )
		return -1;
	// ��������Ʒ�Ƿ��ǽ�ֹһ��ʹ�ö����
	if ( true_usenum > 1 )
	{
		if ( item_getsituation( item_kind ) & ITEM_SITUATION_NOUSEMORE )
			return -1;
	}

	// ��ͨ��Ʒ�������ͽ��в�ͬ��ʹ�÷�ʽ
	if ( item_type == ITEM_TYPE_NORMAL )
	{ // ��ͨʹ�������
		int ability1 = item_get_base_ability( g_actors[actor_index].item[itemindex].m_kind, 0 );
		int value1 = item_get_base_value( g_actors[actor_index].item[itemindex].m_kind, 0 );
	}
	else if ( item_type == ITEM_TYPE_NORMAL_USE )
	{ // ���ʹ�������
		int ability1 = item_get_base_ability( g_actors[actor_index].item[itemindex].m_kind, 0 );
		int value1 = item_get_base_value( g_actors[actor_index].item[itemindex].m_kind, 0 );
		if ( ability1 == ITEM_ABILITY_AWARDGROUP )
		{ // �����
			//awardgroup_withindex( actor_index, value1, PATH_ITEMUSE, NULL );
			AwardGetInfo getinfo = { 0 };
			for ( int tmpi = 0; tmpi < true_usenum; tmpi++ )
			{
				awardgroup_random( value1, 0, &getinfo );
			}
			for ( int tmpi = 0; tmpi < getinfo.count; tmpi++ )
			{
				award_getaward( actor_index, getinfo.kind[tmpi], getinfo.num[tmpi], getinfo.color[tmpi], PATH_ITEMUSE, NULL );
			}
		}
	}
	else
		return item_sendnotuse( actor_index, itemindex, -2 );

	// ��ȥ����
	g_actors[actor_index].item[itemindex].m_num -= true_usenum;

	// ��¼��Ʒʹ����־
	wlog( 0, LOGOP_ITEMLOST, PATH_ITEMUSE, g_actors[actor_index].item[itemindex].m_kind, true_usenum, g_actors[actor_index].item[itemindex].m_itemid, g_actors[actor_index].actorid, 0 );

	// �������Ϊ0����ô��ɾ��
	if ( g_actors[actor_index].item[itemindex].m_num <= 0 )
	{
		item_deletebox( actor_index, itemindex, 0 );
		memset( &g_actors[actor_index].item[itemindex], 0, sizeof(Item) );
	}

	// ����ʹ����Ʒ���
	SLK_NetS_ItemUse Value = {};
	Value.m_itemoffset = itemindex;
	Value.m_usenum = true_usenum;
	Value.m_effres = eff_result;
	netsend_itemuse_S( actor_index, SENDTYPE_ACTOR, &Value );
	return eff_result;
}

//-----------------------------------------------------------------------------
// ����˵��: ֱ�ӻ�Ǯ���ߵ�ʹ��
// ����    : actor_index - 
//           hero_index	- Ӣ��index
//           target_index	- Ŀ��index
//-----------------------------------------------------------------------------
int item_use_withtoken( int actor_index, short itemkind, short itemnum, int hero_index, int target_index, int ask )
{
	Actor *pActor = NULL;
	short item_level = 0;
	short item_type = 0;

	if ( itemkind <= 0 )
		return -1;
	if ( itemnum <= 0 )
		return -1;
	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;

	// ��ȡ��Ʒ����
	item_type = item_gettype( itemkind );

	pActor = &g_actors[actor_index];

	// ���ȼ�
	item_level = item_getlevel( itemkind );
	if ( item_level < 0 )
	{ // ���ǵȼ�
		//if ( city_mainlevel( city_getptr( actor_index ) ) < -item_level )
		//	return -1;
	}
	else if ( item_level > 0 )
	{ // ��ɫ�ȼ�
		if ( pActor->level < item_level )
			return -1;
	}

	int abilitytype = item_get_base_ability( itemkind, 0 );
	int token = item_getprice( itemkind );
	

	if ( token <= 0 )
		return -1;

	if ( g_actors[actor_index].token < token * itemnum )
	{
		return -1;
	}

	if ( item_type == ITEM_TYPE_NORMAL_USE )
	{ // ���ʹ�������
		int ability1 = item_get_base_ability( itemkind, 0 );
		int value1 = item_get_base_value( itemkind, 0 );
		
	}
	else
	{
		return -1;
	}

	// ������ʯ
	actor_change_token( actor_index, -token * itemnum, PATH_ITEMUSE, itemkind );
	// ��¼��Ʒʹ����־
	wlog( 0, LOGOP_ITEMLOST, PATH_TOKENITEMUSE, itemkind, 1, 0, g_actors[actor_index].actorid, 0 );

	// ����ʹ�õ�����Ϣ
	int Value[3] = {0};
	Value[1] = itemkind;
	Value[2] = itemnum;
	actor_notify_value( actor_index, NOTIFY_ITEM, 3, Value, NULL );
	return 0;
}

//-----------------------------------------------------------------------------
// ����˵��: װ������װ�����������ǰһ��װ��ж����ǰһ��װ��
// ����    : actor_index - 
//           item_offset	- Դ����λ��
//-----------------------------------------------------------------------------
int item_equipup( int actor_index, short item_offset )
{
	//Item *pEquip = NULL;
	//Item *pItem = NULL;
	//Item tmpItem;
	//short equip_target = -1;
	//int eff_result = 0;
	//char is_send = FALSE;

	//// �Ϸ��Լ��
	//if ( actor_index < 0 || actor_index >= g_maxactornum )
	//	return -1;

	//// ��ɫװ��
	//if ( item_offset >= ITEM_OFFSETBASE && item_offset < ITEM_OFFSETBASE + MAX_ACTOR_ITEMNUM )
	//{
	//	pItem = &g_actors[actor_index].item[item_offset - ITEM_OFFSETBASE];
	//}
	//else
	//{
	//	return -1;
	//}

	//// װ�����;���װ������λ��
	//equip_target = item_gettype( pItem->m_kind ) - 1;
	//if ( equip_target < 0 || equip_target >= MAX_ACTOR_EQUIPNUM )
	//	return -1;

	//// �ȼ����
	//short item_level = item_getlevel( pItem->m_kind );
	//if ( g_actors[actor_index].level < item_level )
	//{
	//	// �ȼ�����װ��
	//	return -1;
	//}

	//// װ����
	//pEquip = &g_actors[actor_index].equip[equip_target];


	//// ������������װ�����ĵ���
	//memcpy( &tmpItem, pItem, sizeof(Item) );
	//memcpy( pItem, pEquip, sizeof(Item) );
	//memcpy( pEquip, &tmpItem, sizeof(Item) );
	//pItem->offset = item_offset;
	//pEquip->offset = equip_target;
	//
	//SLK_NetS_ItemUse Value = {};
	//Value.m_itemoffset = item_offset;
	//Value.m_usenum = equip_target;
	//Value.m_effres = 100; // ����Ϊװ��װ��,�����ǵ�������
	//netsend_itemuse_S( actor_index, SENDTYPE_ACTOR, &Value );
	return 0;
}

//// ж���ϵ�װ��
//int item_equipdown( int actor_index, short equip_offset )
//{
//	if ( actor_index < 0 || actor_index >= g_maxactornum )
//		return -1;
//
//	Item * pEquip = NULL;
//	
//	// ��ɫװ��
//	if ( equip_offset >= EQUIP_OFFSETBASE && equip_offset < EQUIP_OFFSETBASE + MAX_ACTOR_EQUIPNUM )
//	{
//		//�ж��Ƿ��ǺϷ��� ��ɫװ����Χ
//		pEquip = &g_actors[actor_index].equip[equip_offset - EQUIP_OFFSETBASE];
//	}
//	else
//	{
//		return -1;
//	}
//
//	if ( pEquip == NULL || pEquip->m_kind <= 0 )
//	{
//		return -1;
//	}
//
//	//��һ�������� �հ�λ�÷Ž�ȥ
//	Item * pItem = NULL;
//	short item_offset = 0;
//	for ( int tmpi = 0; tmpi < MAX_ACTOR_ITEMNUM; tmpi++ )
//	{
//		if ( g_actors[actor_index].item[tmpi].m_kind <= 0 )
//		{
//			pItem = &g_actors[actor_index].item[tmpi];
//			item_offset = ITEM_OFFSETBASE + tmpi;
//			break;
//		}
//	}
//	if ( pItem == NULL )
//	{
//		return -1;
//	}
//
//	memcpy( pItem, pEquip, sizeof( Item ) );
//	pEquip->m_kind = 0;
//	pItem->offset = item_offset;
//
//	SLK_NetS_ItemUse Value = {};
//	Value.m_itemoffset = pItem->offset; // ���ڵ�װ��λ��
//	Value.m_usenum = pEquip->offset; // ֮ǰ��λ��
//	Value.m_effres = 101; // ����Ϊװ��ж��
//	netsend_itemuse_S( actor_index, SENDTYPE_ACTOR, &Value );
//
//	// ��������
//	city_attr_reset( city_getptr( actor_index ) );
//	return 0;
//}
//-----------------------------------------------------------------------------
// ����˵��: ���õ��ߵ�����( ж��װ�����߽������߸� )
// ����    : actor_index - 
//           item_resource	- Դλ��
//           item_target	- Ŀ��λ��
//-----------------------------------------------------------------------------
int item_put( int actor_index, short item_resource, short item_target )
{
	Item tmpItem;
	short item_type;

	short res_num = -1;
	short target_num = -1;

	Item * pSrc = NULL;
	Item * pDes = NULL;

	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;
	if ( item_target < 0 || item_target >= MAX_ACTOR_ITEMNUM )
	{
		actor_system_message( actor_index, 75 ); // ��������
		return -1;
	}

	// ��鱳����������
	int max_itemnum = MAX_DEFAULT_ITEMNUM + g_actors[actor_index].itemext;
	if ( max_itemnum > MAX_ACTOR_ITEMNUM )
		max_itemnum = MAX_ACTOR_ITEMNUM;

	// Դλ����װ��������ô��������еĲ�������ж��װ��
	if ( item_resource >= EQUIP_OFFSETBASE && item_resource <= EQUIP_OFFSETBASE + MAX_ACTOR_EQUIPNUM )
	{
		// Ŀ��ֻ���Ǳ���
		if ( item_target >= 0 && item_target < max_itemnum )
		{
			// Դ-װ������װ��
			pSrc = item_getptr( actor_index, item_resource );
			if ( pSrc == NULL )
				goto SENDITEMPUT;

			// ��ȷ��һ���ǲ���װ��
			item_type = item_gettype( pSrc->m_kind );
			if ( item_type < ITEM_TYPE_EQUIP1 || item_type > ITEM_TYPE_EQUIP10 )
				goto SENDITEMPUT;

			// Ŀ��-������ĵ���
			pDes = &g_actors[actor_index].item[item_target];

			// ���Ŀ��λ���е��ߣ����ܽ��н�����Ҳ����˵ж�²��ܶ���
			if ( pDes->m_kind > 0 )
				goto SENDITEMPUT;

			memcpy( &tmpItem, pSrc, sizeof(Item) );
			memcpy( pSrc, pDes, sizeof(Item) );
			memcpy( pDes, &tmpItem, sizeof(Item) );

			res_num = pSrc->m_num;
			target_num = pDes->m_num;
		}
		else
		{
			actor_system_message( actor_index, 75 ); // ��������
			return -1;
		}

	}
	// Դ��Ʒ�� ������Ʒ
	else if ( item_resource >= 0 && item_resource < MAX_ACTOR_ITEMNUM && g_actors[actor_index].item[item_resource].m_kind > 0 )
	{
		pSrc = &g_actors[actor_index].item[item_resource]; // Դ�Ǳ�����Ʒ

		if ( item_target >= 0 && item_target < max_itemnum )
			pDes = &g_actors[actor_index].item[item_target]; // Ŀ���Ǳ�����Ʒ

		if ( pSrc == NULL || pDes == NULL )
			return -1;

		if ( pSrc->m_kind != pDes->m_kind )
		{ 
			// ����ͬһ����Ʒ���ͽ���
			memcpy( &tmpItem, pSrc, sizeof(Item) );
			memcpy( pSrc, pDes, sizeof(Item) );
			memcpy( pDes, &tmpItem, sizeof(Item) );

			res_num = pSrc->m_num;
			target_num = pDes->m_num;
		}
		else
		{
			// �����ͬ������Ʒ,����Ӷѵ��Ĺ���
			int diff = 0;
			int kind = pSrc->m_kind;
			if ( g_itemkind[kind].m_overlap <= 1 )
			{// ��overlap <= 1 ʱ����ʾ���ܶѵ�������Ʒ���м򵥵Ľ������ɡ�
				memcpy( &tmpItem, pSrc, sizeof(Item) );
				memcpy( pSrc, pDes, sizeof(Item) );
				memcpy( pDes, &tmpItem, sizeof(Item) );

				res_num = pSrc->m_num;
				target_num = pDes->m_num;
			}
			else
			{
				kind = pSrc->m_kind;
				diff = g_itemkind[kind].m_overlap - pDes->m_num; // ���
				if ( diff < pSrc->m_num )
				{ // ԭ��Ʒ��֧��Ŀ����Ʒ�Ĳ��
					res_num = pSrc->m_num - diff;
					target_num = pDes->m_num + diff;
					pSrc->m_num = res_num;
					pDes->m_num = target_num;
				}
				else
				{ // Ҫɾ��һ����Ʒ��
					diff = pSrc->m_num;
					res_num = pSrc->m_num - diff;
					target_num = pDes->m_num + diff;
					pSrc->m_num = res_num;
					pDes->m_num = target_num;
					item_deletebox( actor_index, item_resource, 0 );
				}
			}
		}
	}
	else
	{
		res_num = -1;
		target_num = -1;
	}

SENDITEMPUT:
	SLK_NetS_ItemPut Value = {};
	Value.m_res_offset = item_resource;
	Value.m_res_num = res_num;
	Value.m_target_offset = item_target;
	Value.m_target_num = target_num;
	netsend_itemput_S( actor_index, SENDTYPE_ACTOR, &Value );

	//if ( eff_result & EFF_SULT_CHANGED )
	//	equip_info_all( actor_index, member );

	return 0;
}

//-----------------------------------------------------------------------------
// ����˵��: ��������
// ����    : actor_index - 
//           itemindex	- λ��
//           dropcount	- ����
//-----------------------------------------------------------------------------
int item_drop( int actor_index, short itemindex, short dropcount )
{
	Item * pitem = NULL;
	int itemtype;
	int price;

	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;

	if ( itemindex >= 0 && itemindex < MAX_ACTOR_ITEMNUM )
		pitem = &g_actors[actor_index].item[itemindex];
	else
		return -1;

	itemtype = item_gettype( pitem->m_kind );
	// ������߲��ɶ���
	//if ( itemtype == ITEM_TYPE_QUEST )
	//{
	//	return -1;
	//}

	if ( dropcount > pitem->m_num )
	{
		dropcount = pitem->m_num;
	}
	price =  item_getprice( pitem->m_kind );
	if ( price <= 0 )
		price = 1;
	price *= dropcount;

	// ��¼log
	wlog( 0, LOGOP_ITEMLOST, PATH_SELL, pitem->m_kind, dropcount, pitem->m_num, g_actors[actor_index].actorid, 0 );

	pitem->m_num -= dropcount;
	// �������Ϊ0����ô��ɾ��
	if ( pitem->m_num <= 0 )
	{
		item_deletebox( actor_index, itemindex, 0 );
		memset( &g_actors[actor_index].item[itemindex], 0, sizeof(Item) );
	}
	// ���ͽ�ɫʧȥ��Ʒ
	item_sendlost( actor_index, -1, itemindex, dropcount, PATH_SELL );
	return 0;
}

// ������ʹ�ã��ж�˳��
static unsigned int item_get_order( int item_type, short item_level )
{
	unsigned int rt = 0;
	int order_rule[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8 };
	int order_count;
	int tmpi;

	if ( item_type < 0 )
		return 0xffffffff; // ���û��,�Ǹ��ո���,�򷵻������

	order_count = sizeof(order_rule) / sizeof(order_rule[0]);
	for ( tmpi = 0; tmpi < order_count; tmpi++ )
	{
		if ( item_type == order_rule[tmpi] )
		{
			rt = tmpi;
			break;
		}
	}
	if ( tmpi >= order_count )
	{
		rt = order_count + 1 + item_type;
	}
	return (rt << 16) | item_level;
}

// �������ߺϲ�
static int item_find_nextkind( Item *pItem, int itemkind, int curindex, int max_itemnum )
{
	if ( pItem == NULL || curindex >= max_itemnum || curindex < 0 )
		return -1;
	for ( int tmpi = curindex; tmpi < max_itemnum; tmpi++ )
	{
		if ( pItem[tmpi].m_num > 0 && pItem[tmpi].m_kind == itemkind )
		{
			return tmpi;
		}
	}
	return -1;
}

int item_packeg_in( int actor_index )
{
	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;
	Item *pItem = g_actors[actor_index].item;

	int max_itemnum = MAX_DEFAULT_ITEMNUM + g_actors[actor_index].itemext;

	if ( max_itemnum > MAX_ACTOR_ITEMNUM )
		max_itemnum = MAX_ACTOR_ITEMNUM;

	int overlap;
	int curindex;
	int nextindex;
	char haschange;
	int value[2];
	for ( int tmpi = 0; tmpi < max_itemnum; tmpi++ )
	{
		if ( pItem[tmpi].m_num <= 0 || pItem[tmpi].m_kind <= 0 )
			continue;
		overlap = item_get_overlap( pItem[tmpi].m_kind );
		if ( overlap <= 1 || pItem[tmpi].m_num >= overlap )
			continue;
		curindex = tmpi + 1;
		haschange = 0;
		while ( curindex < max_itemnum )
		{
			nextindex = item_find_nextkind( pItem, pItem[tmpi].m_kind, curindex, max_itemnum );
			if ( nextindex < curindex || nextindex >= max_itemnum )
				break;
			if ( pItem[nextindex].m_num + pItem[tmpi].m_num >= overlap )
			{
				haschange = 1;
				pItem[nextindex].m_num = pItem[nextindex].m_num + pItem[tmpi].m_num - overlap;
				pItem[tmpi].m_num = overlap;
				if ( pItem[nextindex].m_num <= 0 )
				{
					item_deletebox( actor_index, nextindex, 0 );
					pItem[nextindex].m_kind = 0;
				}
				value[0] = nextindex;
				value[1] = pItem[nextindex].m_num;
				actor_notify_value( actor_index, NOTIFY_ITEMNUM, 2, value, NULL );
			}
			else
			{
				pItem[tmpi].m_num += pItem[nextindex].m_num;
				haschange = 1;

				item_deletebox( actor_index, nextindex, 0 );
				pItem[nextindex].m_kind = 0;
				pItem[nextindex].m_num = 0;

				value[0] = nextindex;
				value[1] = pItem[nextindex].m_num;
				actor_notify_value( actor_index, NOTIFY_ITEMNUM, 2, value, NULL );
			}
			curindex = nextindex + 1;
		}
		if ( haschange )
		{
			value[0] = tmpi;
			value[1] = pItem[tmpi].m_num;
			actor_notify_value( actor_index, NOTIFY_ITEMNUM, 2, value, NULL );
		}
	}
	return 0;
}

//-----------------------------------------------------------------------------
// ����˵��: װ������
// ����    : actor_index - 
//           itemindex	- λ��
//           dropcount	- ����
//-----------------------------------------------------------------------------
int item_settle( int actor_index )
{
	Item tmp_item = { 0 };
	int new_index[MAX_ACTOR_ITEMNUM] = { 0 };
	int tmp_index = 0;
	int tmpi, tmpj;
	Item *pItemBase = NULL;

	if ( actor_index < 0 || actor_index >= g_maxactornum )
		return -1;

	pItemBase = g_actors[actor_index].item;

	item_packeg_in( actor_index );

	int max_itemnum = MAX_DEFAULT_ITEMNUM + g_actors[actor_index].itemext;
	if ( max_itemnum > MAX_ACTOR_ITEMNUM )
		max_itemnum = MAX_ACTOR_ITEMNUM;

	for ( tmpi = 0; tmpi < max_itemnum; tmpi++ )
	{
		new_index[tmpi] = tmpi;
	}

	for ( tmpi = 0; tmpi < max_itemnum; tmpi++ )
	{
		for ( tmpj = 0; tmpj < max_itemnum - 1; tmpj++ )
		{
			int item_kind_1 = 0, item_kind_2 = 0;
			int item_type_1 = -1, item_type_2 = -1;
			short item_level_1 = 0, item_level_2 = 0;
			unsigned order_1 = 0, order_2 = 0;

			item_kind_1 = pItemBase[tmpj].m_kind;
			if ( item_kind_1 > 0 )
			{
				item_type_1 = item_gettype( item_kind_1 );
				item_level_1 = item_getlevel( item_kind_1 );
			}
			item_kind_2 = pItemBase[tmpj + 1].m_kind;
			if ( item_kind_2 > 0 )
			{
				item_type_2 = item_gettype( item_kind_2 );
				item_level_2 = item_getlevel( item_kind_2 );
			}
			order_1 = item_get_order( item_type_1, item_level_1 );
			order_2 = item_get_order( item_type_2, item_level_2 );
			if ( (order_1 > order_2) ||
				(order_1 == order_2 && item_kind_1 > item_kind_2) )
			{ // Ҫ����λ����
				tmp_item = pItemBase[tmpj];
				pItemBase[tmpj] = pItemBase[tmpj + 1];
				pItemBase[tmpj + 1] = tmp_item;

				tmp_index = new_index[tmpj];
				new_index[tmpj] = new_index[tmpj + 1];
				new_index[tmpj + 1] = tmp_index;
			}
		}
	}

	SLK_NetS_ItemSettle Value = {};
	Value.m_itemnum = max_itemnum;
	for ( tmpi = 0; tmpi < max_itemnum; tmpi++ )
	{
		Value.m_itemoffset[tmpi] = new_index[tmpi];
	}
	netsend_itemsettle_S( actor_index, SENDTYPE_ACTOR, &Value );

	return 0;
}
