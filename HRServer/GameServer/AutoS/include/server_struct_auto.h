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
struct _slk_NetU_Logined {
	int m_result;	//�û�����������-��¼����ֵ
	int m_client_index;	//�û�����������-��ɫ����
	int m_authid;	//�û�����������-��֤ID
	char m_userid[21];	//�û�����������-�û�ID
	char m_username[51];	//�û�����������-�û���
	short m_usertype;	//�û�����������-�û�����
	char m_checkflag;	//�û�����������-�����
	char m_isdeep;	//�û�����������-Ҫ������
	char m_access_token[65];	//�û�����������-360���û�����
	int m_expires_in;	//�û�����������-360��������Ч��
	char m_refresh_token[65];	//�û�����������-360��ˢ������
	char m_deviceid[65];	//�û�����������-���ص��豸ID
};
typedef struct _slk_NetU_Logined SLK_NetU_Logined;	//�û����������ص�½

struct _slk_NetU_UserAwarded {
	int m_result;	//�û�����������-�һ��������ֵ
	int m_client_index;	//�û�����������-��ɫ����
	int m_authid;	//�û�����������-��֤ID
	short m_cdkey_index;	//�û�����������-�һ���浵����
	int m_awardgroup;	//�û�����������-�һ��뽱����
	char m_cardnumber[32];	//�û�����������-�һ��뿨��
};
typedef struct _slk_NetU_UserAwarded SLK_NetU_UserAwarded;	//�û����������ضһ�����

struct _slk_NetC_Gmlocalcmd {
	short m_cmd;	//ָ��
	int m_value[4];	//��ֵ����
	short m_msglen;	//�ַ�������
	char m_msg[1024];	//�ַ�������
};
typedef struct _slk_NetC_Gmlocalcmd SLK_NetC_Gmlocalcmd;	//����GM��Ϣ

int struct_NetU_Logined_send( char **pptr, int *psize, SLK_NetU_Logined *pValue );
int struct_NetU_Logined_recv( char **pptr, int *psize, SLK_NetU_Logined *pValue );
int struct_NetU_UserAwarded_send( char **pptr, int *psize, SLK_NetU_UserAwarded *pValue );
int struct_NetU_UserAwarded_recv( char **pptr, int *psize, SLK_NetU_UserAwarded *pValue );
int struct_NetC_Gmlocalcmd_send( char **pptr, int *psize, SLK_NetC_Gmlocalcmd *pValue );
int struct_NetC_Gmlocalcmd_recv( char **pptr, int *psize, SLK_NetC_Gmlocalcmd *pValue );

#endif
