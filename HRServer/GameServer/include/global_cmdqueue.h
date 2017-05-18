#ifndef _GLOBAL_CMDQUEUE_H
#define _GLOBAL_CMDQUEUE_H

#define GLOBALCMD_MAXNUM	4096 // ���ָ���б���
#define GLOBALCMD_TIMEOUT	6	 // ���

// ���ָ�����
typedef struct _global_cmd
{
	int id;
	short cmd;
	int city_index;
	char timeout;
}GlobalCmd;

int globalcmd_init();
int globalcmd_add( short cmd, int city_index );
void globalcmd_del( int index );
int globalcmd_response( int id );
void globalcmd_fetch();
#endif
