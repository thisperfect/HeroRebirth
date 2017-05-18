#ifndef __DEFINE_H
#define __DEFINE_H
#include "utils.h"
#include "client.h"

#define LOG_PATH	"./glog/"

#ifndef NAME_SIZE
#define NAME_SIZE					22		// ������ֺ���Ʒ���ֳ���
#endif

/* �����ļ� */
typedef struct _sconfig {
	unsigned long ipaddress;
	unsigned short port;
	int max_connection;
} SConfig;

void sendtoclient( int actor_index, char *tmpbuf, int size );

#endif
