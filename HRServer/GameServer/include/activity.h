
#ifndef __ACTIVITY_H
#define __ACTIVITY_H

#define MAX_ACTIVITY_COUNT					50

#define ACTIVITY_NORMAL						1	// 
#define ACTIVITY_AD1						30	// �����
#define ACTIVITY_AD2						31	// �����
#define ACTIVITY_AD3						32	// �����
#define ACTIVITY_AD4						33	// �����
#define ACTIVITY_AD5						34	// �����
#define ACTIVITY_PAYBAG1					40	// ����
#define ACTIVITY_PAYBAG2					41	// ����
#define ACTIVITY_PAYBAG3					42	// ����
#define ACTIVITY_PAYBAG4					43	// ����
#define ACTIVITY_PAYBAG5					44	// ����

typedef struct _activity_item
{
	int m_activityid;
	int m_starttime;	// �����ʱ��
	int m_endtime;		// �����ʱ��
	int m_closetime;	// ��ر�ʱ�䣬�ö�Ϊ����ҿ���������ʲô�ģ������������ʱ��
	int m_value[4];
	char m_strvalue[256];
	char m_openstat;
	char m_endstat;
}ActivityItem;

int activity_init();
int activity_logic();
int activity_onwarning( int activityid, int surplus );
int activity_onopen( int activityid );
int activity_onend( int activityid );
int activity_onclose( int activityid );
int activity_onlogic( int activityid );

// ��û����ʱ��
int activity_starttime( int activityid );

// �����ʱ��
int activity_endtime( int activityid );

// ��ر�ʱ��
int activity_closetime( int activityid );

// ��ûʣ��ʱ��
int activity_lefttime( int activityid );

// ��ûӦ�ó���ʱ��
int activity_totaltime( int activityid );

int activity_intime( int activityid );
int activity_inclose( int activityid );
int activity_settime( int activityid, int begin_min, int len_min, int value0, int value1, int value2, int value3, char *pstr );
int activity_setendtime( int activityid, int endtime );
int activity_getdata( int activityid, int *value, char *pstr );
int activity_setdata( int activityid, int value0, int value1, int value2, int value3, char* pstr );
int activity_getvalue( int activityid, int index );
int activity_setopenstat( int activityid, int stat );
int activity_setendstat( int activityid, int stat );
int activity_countdown( int activityid );
#endif
