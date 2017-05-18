 
#ifndef __TIMECALC_H
#define __TIMECALC_H

typedef struct _entry
{
	char point_max;
	char point_min;
	char point_count;
	char point_from[32];	// ���ĸ�ʱ��
	char point_to[32];		// ���ĸ�ʱ��
	char point_space[32];	// ʱ����
	char any;
	char unsafe;
} Entry;

typedef struct _timeentry
{
	Entry min;
	Entry hour;
	Entry day;
	Entry mon;
	Entry week;
	time_t mtime;
} TimeEntry;

int time_format( TimeEntry *pTimeEntry, char *pString );
int time_checktime( TimeEntry *pTimeEntry );
int time_reset( TimeEntry *pTimeEntry );
#endif
