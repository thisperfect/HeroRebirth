#ifndef __GAMELOG_H
#define __GAMELOG_H

#include "utils.h"

/* ���� */
#define LOGOP_TOKEN				1	// ��ʯ
#define LOGOP_HERO				2	// Ӣ��
#define LOGOP_ITEMGET			3	// ��õ���
#define LOGOP_ITEMLOST			4	// ��ʧ����
#define LOGOP_ACTOREXP			5	// ��ɫ����
#define LOGOP_UPGRADE			6	// ��ɫ����
#define LOGOP_BODY				7	// ����
#define LOGOP_VIPEXP			8	// vip����

/* ;�� */
#define PATH_SYSTEM						1	// ϵͳ
#define PATH_GM							2	// GM
#define PATH_PAY						3	// ��ֵ
#define PATH_ITEMUSE					4	// ����ʹ��
#define PATH_TOKENITEMUSE				5	// ��ʯֱ��ʹ��
#define PATH_SELL						6	// ��������

int log_init();
int wlog( char type, int op, char path, int object, int objectnum, i64 objectid, int source, int target );
int wlog_token( char type, int op, char path, int object, int objectnum, i64 objectid, int source, int target, i64 userid );
int wcount();

#endif

