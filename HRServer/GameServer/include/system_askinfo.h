#ifndef __SYSTEM_ASKINFO_H
#define __SYSTEM_ASKINFO_H
// 客户端发过来的简单请求

#define ASKINFO_NORMAL				0
#define ASKINFO_FIGHTMATCH			10
#define ASKINFO_FIGHTROOMQUIT		11

int system_askinfo( int actor_index, int msgid, char *pstr, int *pvalue );

#endif
