#ifndef __ACTOR_SEND_H
#define __ACTOR_SEND_H


#define SENDTYPE_ACTOR		0	// �����������
#define SENDTYPE_WORLD		1	// ������ǰ������
#define SENDTYPE_FIGHT		2	// ����ս����˫��
#define SENDTYPE_CLUB		3	// ��������

int readtoqueue( int client_index, char *pBuf, int readsize, char stat );
int actor_senddata( int actor_index, char send_type, char *data, int datasize );

#endif
