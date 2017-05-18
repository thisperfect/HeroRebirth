#ifndef _GLOBAL_H_
#include "share_memory.h"

// ȫ�ֱ���
typedef struct _global
{
	int actorlevel_max;
}Global;
int global_init();
void global_reload();

// �������������������ȫ������
#define WORLD_DATA_LAST_CITYPOSX		1
#define WORLD_DATA_LAST_CITYPOSY		2
#define WORLD_DATA_SAVEFLAG				99		// �浵�ı��ʱ��
#define WORLD_DATA_SAVEFILE_FLAG		100		// ����ִ����ϵı��ʱ��
#define WORLD_DATA_MAX					128		
int world_data_init();
int world_data_get( int index, char *strvalue );
int world_data_set( int index, int value, char *strvalue, FILE *fp );
#endif
