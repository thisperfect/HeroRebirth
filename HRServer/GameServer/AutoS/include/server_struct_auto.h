#ifndef __STRUCT_AUTO0_H
#define __STRUCT_AUTO0_H

#include "define.h"
#define CMDS_BASE	0
#define CMDC_BASE	0

#define CMDS_LOGIN	(CMDS_BASE+1)
#define CMDS_LIST	(CMDS_BASE+2)
#define CMDS_CREATE	(CMDS_BASE+3)
#define CMDS_ENTERINFO	(CMDS_BASE+4)
#define CMDS_DELETE	(CMDS_BASE+5)
#define CMDS_HEART	(CMDS_BASE+6)
#define CMDS_NOTIFY	(CMDS_BASE+7)
#define CMDS_ACTORINFO	(CMDS_BASE+8)
#define CMDS_ITEMUSE	(CMDS_BASE+9)
#define CMDS_ITEMPUT	(CMDS_BASE+10)
#define CMDS_ITEMSETTLE	(CMDS_BASE+11)
#define CMDS_LOSTITEM	(CMDS_BASE+12)
#define CMDS_GETITEM	(CMDS_BASE+13)
#define CMDS_ITEMLIST	(CMDS_BASE+14)
#define CMDS_ITEMINFO	(CMDS_BASE+15)
#define CMDS_AWARDINFOLIST	(CMDS_BASE+24)
#define CMDS_EXPERIENCE	(CMDS_BASE+25)
#define CMDS_BODY	(CMDS_BASE+26)
#define CMDS_FIGHTROOMINFO	(CMDS_BASE+27)
#define CMDS_FIGHTROOMQUIT	(CMDS_BASE+28)
#define CMDS_FIGHTROOMSETHERO	(CMDS_BASE+29)
#define CMDS_FIGHTROOMREADY	(CMDS_BASE+30)
#define CMDS_FIGHTROOMSTART	(CMDS_BASE+31)
#define CMDS_FIGHTTURNS	(CMDS_BASE+32)
#define CMDS_FIGHTTIMEOUT	(CMDS_BASE+33)

#define CMDC_USERAWARDED	(CMDC_BASE-4)
#define CMDC_GMLOCALCMD	(CMDC_BASE-3)
#define CMDC_LOGINED	(CMDC_BASE-2)
#define CMDC_TIMER	(CMDC_BASE-1)
#define CMDC_LOGIN	(CMDC_BASE+1)
#define CMDC_CREATE	(CMDC_BASE+2)
#define CMDC_LIST	(CMDC_BASE+3)
#define CMDC_ENTERGAME	(CMDC_BASE+4)
#define CMDC_DELETE	(CMDC_BASE+5)
#define CMDC_HEART	(CMDC_BASE+6)
#define CMDC_GMCMD	(CMDC_BASE+7)
#define CMDC_ASKINFO	(CMDC_BASE+9)
#define CMDC_FIGHTCOMMAND	(CMDC_BASE+10)
struct _slk_NetU_Logined {
	int m_result;	//用户服务器返回-登录返回值
	int m_client_index;	//用户服务器返回-角色索引
	int m_authid;	//用户服务器返回-认证ID
	char m_userid[21];	//用户服务器返回-用户ID
	char m_username[51];	//用户服务器返回-用户名
	short m_usertype;	//用户服务器返回-用户类型
	char m_checkflag;	//用户服务器返回-检测标记
	char m_isdeep;	//用户服务器返回-要防沉迷
	char m_access_token[65];	//用户服务器返回-360的用户令牌
	int m_expires_in;	//用户服务器返回-360的令牌有效期
	char m_refresh_token[65];	//用户服务器返回-360的刷新令牌
	char m_deviceid[65];	//用户服务器返回-传回的设备ID
};
typedef struct _slk_NetU_Logined SLK_NetU_Logined;	//用户服务器返回登陆

struct _slk_NetU_UserAwarded {
	int m_result;	//用户服务器返回-兑换结果返回值
	int m_client_index;	//用户服务器返回-角色索引
	int m_authid;	//用户服务器返回-认证ID
	short m_cdkey_index;	//用户服务器返回-兑换码存档索引
	int m_awardgroup;	//用户服务器返回-兑换码奖励组
	char m_cardnumber[32];	//用户服务器返回-兑换码卡号
};
typedef struct _slk_NetU_UserAwarded SLK_NetU_UserAwarded;	//用户服务器返回兑换奖励

struct _slk_NetU_Gmlocalcmd {
	short m_cmd;	//指令
	int m_value[4];	//数值参数
	short m_msglen;	//字符串长度
	char m_msg[1024];	//字符串参数
};
typedef struct _slk_NetU_Gmlocalcmd SLK_NetU_Gmlocalcmd;	//本地GM信息

int struct_NetU_Logined_send( char **pptr, int *psize, SLK_NetU_Logined *pValue );
int struct_NetU_Logined_recv( char **pptr, int *psize, SLK_NetU_Logined *pValue );
int struct_NetU_UserAwarded_send( char **pptr, int *psize, SLK_NetU_UserAwarded *pValue );
int struct_NetU_UserAwarded_recv( char **pptr, int *psize, SLK_NetU_UserAwarded *pValue );
int struct_NetU_Gmlocalcmd_send( char **pptr, int *psize, SLK_NetU_Gmlocalcmd *pValue );
int struct_NetU_Gmlocalcmd_recv( char **pptr, int *psize, SLK_NetU_Gmlocalcmd *pValue );

#endif
