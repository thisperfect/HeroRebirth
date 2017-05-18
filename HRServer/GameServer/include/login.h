#ifndef __LOGIN_H
#define __LOGIN_H
#include "define.h"
#include "server_structsend_auto.h"

#define MAX_LOGINQUEUENUM			256 // ��½���г���

#define COMMAND_PACK_LEN			512
#define RETURN_PACK_LEN				256

#define USERCMDS_LOGIN				1
#define USERCMDS_AWARD				2
#define USERCMDS_LOCKUSER			3
#define USERCMDS_CHANGESEV			4

#define USERCMDC_LOGIN				1
#define USERCMDC_AWARD				2
#define USERCMDC_LOCKUSER			3
#define USERCMDC_CHANGESEV			4

// ��½����
struct _sloginqueue
{
	int client_index;
	int authid;
	short command;
	int platcode;
	char data[COMMAND_PACK_LEN];
};
typedef struct _sloginqueue SLoginQueue;

int login_init();
int login_send_proc();
int login_recv_proc();

// �û����͵�½���󵽵�½����
int user_login( int client_index, const char *szUserName, const char *szPassWord, char *szDeviceID );
// �û����������ص�½���
int user_logined( int client_index, int authid, SClientInfo *pClientInfo );

// ���Ͷһ�������Ϣ
int user_award( int client_index, char *cardnumber );
// �û����������ؽ�����Ϣ
int user_awarded( int client_index, int authid, int cdkey_index, int awardgroup, int result, char *cardnumber );

// �û������˺�
int user_lock( int client_index, int authid, i64 player_userid, int lockmin );

// �û��ı������������������������������
int user_changesev( int client_index, short serverid, char *sevname, char *kingname, char *kingclub, short king_country );

// �޸����ջ���а�����
int user_change_summerrank( int client_index, short serverid, int actorid, int cityid, char *name, int headid, short countryid, int flower );

// �Ŷӻ���
int user_queue_logic();
void login_queue_clear();
#endif



