#ifndef __NETSEND_AUTO_H0
#define __NETSEND_AUTO_H0

#include "server_structsend_auto.h"
int netsend_login_S( int actor_index, char send_type, SLK_NetS_Login *pValue );
int netsend_list_S( int actor_index, char send_type, SLK_NetS_List *pValue );
int netsend_create_S( int actor_index, char send_type, SLK_NetS_Create *pValue );
int netsend_enterinfo_S( int actor_index, char send_type, SLK_NetS_EnterInfo *pValue );
int netsend_delete_S( int actor_index, char send_type, SLK_NetS_Delete *pValue );
int netsend_heart_S( int actor_index, char send_type, SLK_NetS_Heart *pValue );
int netsend_notify_S( int actor_index, char send_type, SLK_NetS_Notify *pValue );
int netsend_actorinfo_S( int actor_index, char send_type, SLK_NetS_ActorInfo *pValue );
int netsend_itemuse_S( int actor_index, char send_type, SLK_NetS_ItemUse *pValue );
int netsend_itemput_S( int actor_index, char send_type, SLK_NetS_ItemPut *pValue );
int netsend_itemsettle_S( int actor_index, char send_type, SLK_NetS_ItemSettle *pValue );
int netsend_lostitem_S( int actor_index, char send_type, SLK_NetS_LostItem *pValue );
int netsend_getitem_S( int actor_index, char send_type, SLK_NetS_GetItem *pValue );
int netsend_itemlist_S( int actor_index, char send_type, SLK_NetS_ItemList *pValue );
int netsend_iteminfo_S( int actor_index, char send_type, SLK_NetS_ItemInfo *pValue );
int netsend_awardinfolist_S( int actor_index, char send_type, SLK_NetS_AwardInfoList *pValue );
int netsend_experience_S( int actor_index, char send_type, SLK_NetS_Experience *pValue );
int netsend_body_S( int actor_index, char send_type, SLK_NetS_Body *pValue );
int netsend_fightroominfo_S( int actor_index, char send_type, SLK_NetS_FightRoomInfo *pValue );
int netsend_fightroomquit_S( int actor_index, char send_type, SLK_NetS_FightRoomQuit *pValue );
int netsend_fightroomsethero_S( int actor_index, char send_type, SLK_NetS_FightRoomSetHero *pValue );
int netsend_fightroomready_S( int actor_index, char send_type, SLK_NetS_FightRoomReady *pValue );
int netsend_fightroomstart_S( int actor_index, char send_type, SLK_NetS_FightStart *pValue );
int netsend_fightturns_S( int actor_index, char send_type, SLK_NetS_FightTurns *pValue );
int netsend_fighttimeout_S( int actor_index, char send_type, SLK_NetS_FightTimeout *pValue );

int netsend_userawarded_S( int actor_index, char send_type, SLK_NetU_UserAwarded *pValue );
int netsend_gmlocalcmd_S( int actor_index, char send_type, SLK_NetU_Gmlocalcmd *pValue );
int netsend_logined_S( int actor_index, char send_type, SLK_NetU_Logined *pValue );
int netsend_timer_S( int actor_index, char send_type, char *pValue );

#endif
