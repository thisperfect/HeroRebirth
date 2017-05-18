#ifndef __AREA_H
#define __AREA_H

#define MAX_AREAMSGSIZE	2048

#define AREA_WIDTH		7
#define AREA_HEIGHT		7

// �����ͼһ������ṹ
typedef struct _area
{
	int unit_head;
	int unit_tail;
	short sendcount;
	int pos;							// ȷ���Ǹ���Ϣ��Ҫ����
    char actor_msg[2][MAX_AREAMSGSIZE];	// ��ǰҪ���͵���Ϣ����,һ���Ǳ��滺��
	int actor_size[2];

	int *unit_queue;
	int nMaxUnitQueueNum;
}Area;
typedef void( *LPCALLBACK_UNITACTION )( int army_index, int areax, int areay );
typedef void (*p_actor_func)(int actor_index, void *data);

int area_initqueue( Area *pArea );
int area_addtoqueue( int area_index, int army_index );
int area_delfromqueue( int area_index, int army_index );
void area_effect( int army_index, int posx1, int posy1, int posx2, int posy2, LPCALLBACK_UNITACTION pUnitAction );

// �����߼����ɵ�ͼ����
void area_logic( int area_index );

// ��ȡ�������
int area_getoffset( int area_index, int *px, int *py );

// ����������ӻ�ȡ������
int area_getindex_fromgrid( int areax, int areay );

// �������������ȡ����������
int area_getindex( int posx, int posy );

// ����ʾ��Ԫ��ӵ�����
int area_addmapunit( int unit_index, int area_index );

// ����ʾ��Ԫ�Ƴ�������
int area_delmapunit( int unit_index, int area_index );

// һ������ƶ���Ļ���뵽������Ҫ��������е�����
int area_enter( int actor_index, int area_index );

// һ������ƶ���Ļ�뿪������Ҫ��������뿪������
int area_leave( int actor_index, int area_index );

// ��ʾ��Ԫλ�ñ仯��Ҫ���µ�����
int mapunit_area_change( int unit_index, int new_posx, int new_posy, char flag );

// �ӿڱ仯��������Ϣ���µ��ӿ�
int view_area_change( int unit_index, int new_area_index );

int area_clearmsg( int area_index );
int area_sendunitinfo( int client_index, int posx, int posy );
int area_sendmsg(int area_index, int datasize, char *databuf);
int area_send(int area_index, int datasize, char *databuf);

#endif
