#ifndef __DB_H
#define __DB_H
#include "define.h"

#define BATCHSQL_MAXSIZE	1048576 // ����sql��󳤶�(1024*1024)

int db_init();
int db_opendata();
int db_closedata();
int db_closegame();
char *db_escape( const char *pStr, char *pBuf, int size );
int db_reconnect_game();
int db_reconnect_log();
int db_query( FILE *fp, const char *pSql );

// �����߼��޹ص����ݿ����
#define DBWORK_THREAD_NUM					1
#define MAX_DBQUEUE_BUFF					4096
#define DBWORK_CMD_MAIL_INSERT				1
#define DBWORK_CMD_MAIL_INSERTCOMPLETE		2
#define DBWORK_CMD_TALK_CACHE				3
#define DBWORK_CMD_NORMAL					4

// SQL��������
struct _sdbqueue
{
	char sql[MAX_DBQUEUE_BUFF];	// sql
	char cmd;
	int value;
};
typedef struct _sdbqueue SDBQueue;

// SQL��ɶ���
struct _sdbqueuecomplete
{
	char cmd;
	int value;
};
typedef struct _sdbqueuecomplete SDBQueueComplete;

int dbwork_start();
int dbwork_stop();
int dbwork_addsql( const char *pSql, char cmd, int value );
int dbwork_addcomplete( char cmd, int value );
void dbwork_fetchcomplete();
#endif



