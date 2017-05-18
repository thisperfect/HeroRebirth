
#ifndef __CLIENT_H
#define __CLIENT_H

#ifdef WIN32
#include <winsock2.h>
#include <mswsock.h>
#endif
#include "netserver.h"

#define CLIENT_STAT_VER_ERR		-2 // �ͻ��˰汾���� [9/4/2009 yxx]
#define CLIENT_STAT_NULL		-1		// ������
#define CLIENT_STAT_WAIT		0		// �ȴ��ͻ��˷��Ͱ汾��Ϣ
#define CLIENT_STAT_CHECK		1		// �ͻ��˻������֤
#define CLIENT_STAT_NOFEE		2		// �ͻ���û�з���
#define CLIENT_STAT_LOGIN		3		// �ͻ����Ѿ�����
#define CLIENT_STAT_ENTERGAME	4		// �ͻ��˽�������Ϸ

struct _clientinfo
{
	int result;
	char ekey_type;
	char challengeNum[16];
	i64 userid;	// �û�id
	char username[MAX_USERNAME_LENGTH+1];	// �û���
	short usertype;		// �û�����
	short isgolden;	// �Ƿ�ƽ��˻�
	char isdeep;	// �Ƿ������
	char cardstat[4];	// ���ֿ�״̬
	int point_totle;	// �ܳ�ֵ��
};
typedef struct _clientinfo SClientInfo;

void client_setstat( int client_index, char stat );
char client_getstat( int client_index );
void client_setwait( int client_index, char iswait );
char client_getwait( int client_index );

char *client_getip( int client_index );
void client_setuserinfo( int client_index, SClientInfo *pClientInfo );
i64 client_getuserinfo( int client_index, SClientInfo *pClientInfo );
i64 client_getuserid( int client_index );
short client_getusertype( int client_index );
char *client_getusername( int client_index );
char client_isexited( int client_index );	// �˳���־
int client_logic();
char client_getpasskey( int client_index );
char client_setsyspwd( int client_index, char *syspwd ); // �������socket����֤��
char client_getsyspwd( int client_index, char *outpwd ); // ��ȡ���socket����֤��
short client_addsyspwd_error( int client_index ); // �������socket����֤���������Ĵ���
short client_getsyspwd_error( int client_index ); // ��ȡ���socket����֤���������Ĵ���
short client_clearsyspwd_error( int client_index ); // ������socket����֤���������Ĵ���
int client_get_maxrecvcount();

int client_get_exec_code( int client_index );


char client_is_same_mac( int client_index, short nMac, char *pMac );
char client_is_same_cpu( int client_index, short nCpu, char *pCpu );
short client_get_mac( int client_index, char *pMac );
short client_get_cpu( int client_index, char *pCpu );
void client_setmaccpu_info( int client_index, short nMac, char *pMac, short nCpu, char *pCpu );

char cleint_ipcomp( int client_index, char *ip );

#endif
