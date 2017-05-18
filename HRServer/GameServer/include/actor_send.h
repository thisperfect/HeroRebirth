#ifndef __ACTOR_SEND_H
#define __ACTOR_SEND_H


#define SENDTYPE_ACTOR		0	// �����������
#define SENDTYPE_TEAM		1	// ���������Ա
#define SENDTYPE_AREA		2	// ������ǰ����
#define SENDTYPE_FIGHTAREA	3	// ������ǰ����/ս������
#define SENDTYPE_NPCAREA	4	// ������ǰ����/ս������
#define SENDTYPE_MAP		5	// ������ǰ��ͼ
#define SENDTYPE_WORLD		6	// ������ǰ������
#define SENDTYPE_FIGHT		7	// ����ս����˫��
#define SENDTYPE_CLUB		8	// ��������

int readtoqueue( int client_index, char *pBuf, int readsize, char stat );
int actor_senddata( int actor_index, char send_type, char *data, int datasize );

#endif
