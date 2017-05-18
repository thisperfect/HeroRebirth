#ifndef __TIMEGMCMD_H
#define __TIMEGMCMD_H

#include "timecalc.h"
#define COMMAND_STRVALUE_MAX	1024
typedef struct _command_entry
{
	int m_id;
	int m_cond;
	int m_cmd;
	int m_value[4];
	char m_strvalue[COMMAND_STRVALUE_MAX];		// ���ĸ�ʱ��
	char m_timestr[128];	// ʱ����ַ�����ʾ����
	TimeEntry m_time;
} CommandEntry;

int time_gmcmd_init();
int time_gmcmd_logic();
void time_gmcmd_reset();

// �����´����������ʱ��
int time_gmcmd_getnexttime( int cmd, int value );
#endif
