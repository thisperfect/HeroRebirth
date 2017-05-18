#ifndef __GLOBAL_H
#define __GLOBAL_H
#include "netserver.h"

#define MAX_GLOBALQUEUENUM			8192 // ��½���г���

// ����
struct _sglobalqueue
{
	short server_code;
	short cmd;
	int value[2];
	int buf_size;					// �ɲ��������ݴ�С
	char buf[MAX_BUF_SIZE];					// ��������
};
typedef struct _sglobalqueue SGlobalQueue;

// �������
struct _sglobalnetqueue
{
	SGlobalQueue *m_queue;
	int m_nQueueHead;
	int m_nQueueTail;
};
typedef struct _sglobalnetqueue SGlobalNetQueue;

typedef int( *LPCALLBACK_GLOBALPACK )(short server_code, short global_cmd, int value1, int value2, char *buf, int size);

int global_net_init( unsigned long global_ipaddress, unsigned short global_port, int server_code, LPCALLBACK_GLOBALPACK pCallbackGlobalPack );
int global_sendtoqueue( short server_code, short global_cmd, int value1, int value2, const char *buf, int bufsize );
#endif



