#ifndef __ACTOR_NOTIFY_H
#define __ACTOR_NOTIFY_H
#include "server_structsend_auto.h"

#define NOTIFY_NORMAL		0	// ����˷�������Ϣ
#define	NOTIFY_TEXTTABLE	1	// 
#define	NOTIFY_ITEM			2
#define	NOTIFY_ITEMNUM		3
#define	NOTIFY_LOGIN_QUEUE	4

// ���͸���ɫ����Ϣ �޲���
int actor_notify( int actor_index, short msgid, const char *msg );

// ���͸���ɫ����Ϣ ������
int actor_notify_value( int actor_index, short msgid, char count, const int *data, const char *msg );

// ����Ϣ��ʾ��ͨ����ϢID
int actor_system_message( int actor_index, int msgid );

#endif
