#include <string.h>
#include "server_structsend_auto.h"
#include "actor_send.h"

int struct_NetU_Logined_send( char **pptr, int *psize, SLK_NetU_Logined *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_result, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_client_index, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_authid, (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_userid, 21*sizeof(char), (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_username, 51*sizeof(char), (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_usertype, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_checkflag, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_isdeep, (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_access_token, 65*sizeof(char), (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_expires_in, (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_refresh_token, 65*sizeof(char), (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_deviceid, 65*sizeof(char), (*psize) );
	return 0;
}

int struct_NetS_Login_send( char **pptr, int *psize, SLK_NetS_Login *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_result, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_username_length, (*psize) );
	if( pValue->m_username_length > 0 && pValue->m_username_length <= 51 )
		LKSET_MEM_SEND( (*pptr), pValue->m_username, pValue->m_username_length*sizeof(char), (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_token_length, (*psize) );
	if( pValue->m_token_length > 0 && pValue->m_token_length <= 256 )
		LKSET_MEM_SEND( (*pptr), pValue->m_token, pValue->m_token_length*sizeof(char), (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_usertype, (*psize) );
	return 0;
}

int struct_ListInfo_send( char **pptr, int *psize, SLK_ListInfo *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_actorid, (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_name, 22*sizeof(char), (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_aclass, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_level, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_offset, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_lockstat, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_delete_stoptime, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_lock_endtime, (*psize) );
	return 0;
}

int struct_NetS_List_send( char **pptr, int *psize, SLK_NetS_List *pValue )
{
	int tmpi = 0;

	LKSET_SBYTE_SEND( (*pptr), &pValue->m_actor_num, (*psize) );
	for( tmpi = 0; tmpi < pValue->m_actor_num; tmpi++ )
	{
		struct_ListInfo_send( pptr, psize, &pValue->m_listinfo[tmpi] );
	}
	return 0;
}

int struct_NetS_Create_send( char **pptr, int *psize, SLK_NetS_Create *pValue )
{
	int tmpi = 0;

	LKSET_SBYTE_SEND( (*pptr), &pValue->m_result, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_actorid, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_createtime, (*psize) );
	return 0;
}

int struct_NetS_EnterInfo_send( char **pptr, int *psize, SLK_NetS_EnterInfo *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_actorid, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_data_int, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_data_short, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_data_char, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_serverid, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_servertime, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_createtime, (*psize) );
	return 0;
}

int struct_NetS_Delete_send( char **pptr, int *psize, SLK_NetS_Delete *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_result, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_actorid, (*psize) );
	return 0;
}

int struct_NetS_Heart_send( char **pptr, int *psize, SLK_NetS_Heart *pValue )
{
	int tmpi = 0;

	LKSET_MEM_SEND( (*pptr), pValue->m_value, 2*sizeof(int), (*psize) );
	return 0;
}

int struct_NetS_Notify_send( char **pptr, int *psize, SLK_NetS_Notify *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_msgid, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_valuenum, (*psize) );
	if( pValue->m_valuenum > 0 && pValue->m_valuenum <= 10 )
		LKSET_MEM_SEND( (*pptr), pValue->m_value, pValue->m_valuenum*sizeof(int), (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_msg_length, (*psize) );
	if( pValue->m_msg_length > 0 && pValue->m_msg_length <= 256 )
		LKSET_MEM_SEND( (*pptr), pValue->m_msg, pValue->m_msg_length*sizeof(char), (*psize) );
	return 0;
}

int struct_NetU_UserAwarded_send( char **pptr, int *psize, SLK_NetU_UserAwarded *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_result, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_client_index, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_authid, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_cdkey_index, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_awardgroup, (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_cardnumber, 32*sizeof(char), (*psize) );
	return 0;
}

int struct_NetC_Gmlocalcmd_send( char **pptr, int *psize, SLK_NetC_Gmlocalcmd *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_cmd, (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_value, 4*sizeof(int), (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_msglen, (*psize) );
	if( pValue->m_msglen > 0 && pValue->m_msglen <= 1024 )
		LKSET_MEM_SEND( (*pptr), pValue->m_msg, pValue->m_msglen*sizeof(char), (*psize) );
	return 0;
}

int struct_NetS_ActorInfo_send( char **pptr, int *psize, SLK_NetS_ActorInfo *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_actorid, (*psize) );
	LKSET_MEM_SEND( (*pptr), pValue->m_name, 22*sizeof(char), (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_aclass, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_shape, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_level, (*psize) );
	LKSET_LONG_SEND( (*pptr), &pValue->m_experience, (*psize) );
	LKSET_LONG_SEND( (*pptr), &pValue->m_experience_max, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_token, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_viplevel, (*psize) );
	return 0;
}

int struct_Corrdinate_send( char **pptr, int *psize, SLK_Corrdinate *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_posx, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_posy, (*psize) );
	return 0;
}

int struct_NetS_ItemUse_send( char **pptr, int *psize, SLK_NetS_ItemUse *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_itemoffset, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_usenum, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_effres, (*psize) );
	return 0;
}

int struct_NetS_ItemPut_send( char **pptr, int *psize, SLK_NetS_ItemPut *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_res_offset, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_res_num, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_target_offset, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_target_num, (*psize) );
	return 0;
}

int struct_NetS_ItemSettle_send( char **pptr, int *psize, SLK_NetS_ItemSettle *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_itemnum, (*psize) );
	if( pValue->m_itemnum > 0 && pValue->m_itemnum <= 100 )
		LKSET_MEM_SEND( (*pptr), pValue->m_itemoffset, pValue->m_itemnum*sizeof(short), (*psize) );
	return 0;
}

int struct_NetS_LostItem_send( char **pptr, int *psize, SLK_NetS_LostItem *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_itemoffset, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_itemnum, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_targetid, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_path, (*psize) );
	return 0;
}

int struct_NetS_GetItem_send( char **pptr, int *psize, SLK_NetS_GetItem *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_itemoffset, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_kind, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_type, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_color, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_num, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_targetid, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_path, (*psize) );
	LKSET_BYTE_SEND( (*pptr), &pValue->m_situation, (*psize) );
	return 0;
}

int struct_ItemSmpInfo_send( char **pptr, int *psize, SLK_ItemSmpInfo *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_offset, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_kind, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_num, (*psize) );
	LKSET_BYTE_SEND( (*pptr), &pValue->m_situation, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_color_level, (*psize) );
	return 0;
}

int struct_NetS_ItemList_send( char **pptr, int *psize, SLK_NetS_ItemList *pValue )
{
	int tmpi = 0;

	LKSET_SBYTE_SEND( (*pptr), &pValue->m_itemext, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_kindnum, (*psize) );
	for( tmpi = 0; tmpi < pValue->m_kindnum; tmpi++ )
	{
		struct_ItemSmpInfo_send( pptr, psize, &pValue->m_item[tmpi] );
	}
	return 0;
}

int struct_ItemAttr_send( char **pptr, int *psize, SLK_ItemAttr *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_type, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_ability, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_value, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_addvalue, (*psize) );
	return 0;
}

int struct_NetS_ItemInfo_send( char **pptr, int *psize, SLK_NetS_ItemInfo *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_itemoffset, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_itemkind, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_type, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_level, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_color_level, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_price, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_attr_num, (*psize) );
	for( tmpi = 0; tmpi < pValue->m_attr_num; tmpi++ )
	{
		struct_ItemAttr_send( pptr, psize, &pValue->m_attr[tmpi] );
	}
	return 0;
}

int struct_NetS_FightRoomActor_send( char **pptr, int *psize, SLK_NetS_FightRoomActor *pValue )
{
	int tmpi = 0;

	LKSET_SBYTE_SEND( (*pptr), &pValue->m_name_length, (*psize) );
	if( pValue->m_name_length > 0 && pValue->m_name_length <= 32 )
		LKSET_MEM_SEND( (*pptr), pValue->m_name, pValue->m_name_length*sizeof(char), (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_level, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_actorid, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_headid, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_ready, (*psize) );
	return 0;
}

int struct_NetS_FightRoomInfo_send( char **pptr, int *psize, SLK_NetS_FightRoomInfo *pValue )
{
	int tmpi = 0;

	LKSET_SBYTE_SEND( (*pptr), &pValue->m_attack_actornum, (*psize) );
	for( tmpi = 0; tmpi < 3; tmpi++ )
	{
		struct_NetS_FightRoomActor_send( pptr, psize, &pValue->m_attack_actorinfo[tmpi] );
	}
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_defense_actornum, (*psize) );
	for( tmpi = 0; tmpi < 3; tmpi++ )
	{
		struct_NetS_FightRoomActor_send( pptr, psize, &pValue->m_defense_actorinfo[tmpi] );
	}
	LKSET_DWORD_SEND( (*pptr), &pValue->m_fightid, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_pvpnum, (*psize) );
	return 0;
}

int struct_NetS_FightRoomQuit_send( char **pptr, int *psize, SLK_NetS_FightRoomQuit *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_fightid, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_actorid, (*psize) );
	return 0;
}

int struct_NetS_FightRoomSetHero_send( char **pptr, int *psize, SLK_NetS_FightRoomSetHero *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_fightid, (*psize) );
	return 0;
}

int struct_NetS_FightRoomReady_send( char **pptr, int *psize, SLK_NetS_FightRoomReady *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_fightid, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_actorid, (*psize) );
	return 0;
}

int struct_NetS_FightStart_send( char **pptr, int *psize, SLK_NetS_FightStart *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_fightid, (*psize) );
	return 0;
}

int struct_NetS_FightTurns_send( char **pptr, int *psize, SLK_NetS_FightTurns *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_turns, (*psize) );
	return 0;
}

int struct_NetS_AwardInfo_send( char **pptr, int *psize, SLK_NetS_AwardInfo *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_kind, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_num, (*psize) );
	return 0;
}

int struct_NetS_AwardInfoList_send( char **pptr, int *psize, SLK_NetS_AwardInfoList *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_count, (*psize) );
	for( tmpi = 0; tmpi < pValue->m_count; tmpi++ )
	{
		struct_NetS_AwardInfo_send( pptr, psize, &pValue->m_list[tmpi] );
	}
	LKSET_WORD_SEND( (*pptr), &pValue->m_callback_code, (*psize) );
	return 0;
}

int struct_NetS_Experience_send( char **pptr, int *psize, SLK_NetS_Experience *pValue )
{
	int tmpi = 0;

	LKSET_DWORD_SEND( (*pptr), &pValue->m_addexp, (*psize) );
	LKSET_LONG_SEND( (*pptr), &pValue->m_curexp, (*psize) );
	LKSET_SBYTE_SEND( (*pptr), &pValue->m_isup, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_path, (*psize) );
	return 0;
}

int struct_NetS_Body_send( char **pptr, int *psize, SLK_NetS_Body *pValue )
{
	int tmpi = 0;

	LKSET_WORD_SEND( (*pptr), &pValue->m_body, (*psize) );
	LKSET_WORD_SEND( (*pptr), &pValue->m_addbody, (*psize) );
	LKSET_DWORD_SEND( (*pptr), &pValue->m_path, (*psize) );
	return 0;
}

