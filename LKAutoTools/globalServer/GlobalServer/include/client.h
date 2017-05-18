#ifndef __CLIENT_H
#define __CLIENT_H

#ifdef WIN32
#include <winsock2.h>
#include <windows.h>
#endif
#include "netserver.h"
#include "define.h"

#define CLIENT_STAT_VER_ERR		-2		// �ͻ��˰汾����
#define CLIENT_STAT_NULL		-1		// ������
#define CLIENT_STAT_WAIT		0		// �ȴ��ͻ��˷��Ͱ汾��Ϣ
#define CLIENT_STAT_LOGIN		1		// �ͻ����Ѿ�����
#define CLIENT_STAT_ENTERGAME	2		// �ͻ��˽�������Ϸ

struct _clientinfo
{
	int result;
	i64 userid;								// �û�id
	char username[MAX_USERNAME_LENGTH+1];	// �û���
	short usertype;							// �û�����
	char access_token[65];
	int expires_in;
	char refresh_token[65];
	char deviceid[65];
};
typedef struct _clientinfo SClientInfo;

void client_setstat( int client_index, char stat );
char client_getstat( int client_index );
void client_setwait( int client_index, char iswait );
char client_getwait( int client_index );

void client_setuserinfo( int client_index, SClientInfo *pClientInfo );
i64 client_getuserinfo( int client_index, SClientInfo *pClientInfo );
i64 client_getuserid( int client_index );
short client_getusertype( int client_index );
char *client_getusername( int client_index );
int client_getplatid( int client_index );
int client_getlanguage( int client_index );
int client_getinvcode( int client_index );
int client_getclientoptype( int client_index );
int client_getindex( i64 userid, int begin_index );
int client_nextindex( int cur_index );

void clients_logic();

// �˳���־
char client_isexited( int client_index );

// �ͻ���Ψһ��������
int client_get_exec_code( int client_index );

// ��ȡ�ͻ���IP
char *client_getip( int client_index );

// ��ȡ�ͻ����豸ID
char *client_getdeviceid( int client_index );

// �Ƚ�IP�Ƿ���ͬ
char cleint_ipcomp( int client_index, char *ip );

#endif
