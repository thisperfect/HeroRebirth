#ifndef __ACTOR_SEND_H
#define __ACTOR_SEND_H


#define SENDTYPE_ACTOR		0	// 发给单个玩家
#define SENDTYPE_WORLD		1	// 发给当前服务器
#define SENDTYPE_FIGHT		2	// 发给战斗的双方
#define SENDTYPE_CLUB		3	// 发给联盟

int readtoqueue( int client_index, char *pBuf, int readsize, char stat );
int actor_senddata( int actor_index, char send_type, char *data, int datasize );

#endif
