#ifndef _AWARD_H_
#define _AWARD_H_

// -1~-100000 ������ı��
// 1~100000 ��Ʒ
// 100000~200000��ͨ��Դ����
#define AWARDKIND_RESBASE	100000
#define AWARDKIND_WOOD		 AWARDKIND_RESBASE+1		//	ľ��

// ��������µĸ�������
#define AWARDKIND_OTHERBASE	200000
#define AWARDKIND_QUEST_SUCCESS	AWARDKIND_OTHERBASE+1	// �������

#define AWARDGETINFO_MAXCOUNT	24

// ������(�����Ϊ�����)
typedef struct _award_group
{
	int *kind;			// ����
	int *minnum;		// ��������
	int *maxnum;		// ��������
	int *value;			// ����ֵ
	char *color;		// ��ɫ
	char *show;			// ��ʾ��ʾ
	short allcount;		// ���齱����Ʒ����
	int allvalue;		// ���齱��������ֵ
	short *type;        // ����
	int *appendnum;     // ����ֵ
}AwardGroup;

// ��ȡ���صĽ���
typedef struct _award_get_info
{
	int kind[AWARDGETINFO_MAXCOUNT];
	int num[AWARDGETINFO_MAXCOUNT];
	char color[AWARDGETINFO_MAXCOUNT];
	short count;
}AwardGetInfo;

// ��ʼ��
int awardgroup_init();

// �ض�
int awardgroup_reload();

// ���͸��ͻ�����ʾ�Ľ�����
int awardgroup_sendinfo( int actor_index, int awardgroup, int callback_code, int unit_index, int limitcount );

// ��������飬��ֱ�Ӹ�
int awardgroup_random( int awardgroup, int level, AwardGetInfo *getinfo );

// ������ ���ŵ��ʼ���������
int awardgroup_mail( int awardgroup, int level, char * itemContent );

// ��������飬ͨ��������Ĭ���������
int awardgroup_withindex( int actor_index, int awardgroup, int level, char path, AwardGetInfo *getinfo );

// ��������飬ͨ�����id����ȷ���Ƿ�����
int awardgroup_withid( int actorid, int awardgroup, char path, AwardGetInfo *getinfo );

// ������
int award_getaward( int actor_index, int kind, int num, char color, char path, AwardGetInfo *getinfo );

// ���߽�������
int gift( int actorid, int kind1, int num1, char color1, int kind2, int num2, char color2, int kind3, int num3, char color3, int kind4, int num4, char color4, unsigned char path );
int gift_check( int actor_index );

// ���߽������֣�����uid��
int gift_uid_check( int actor_index );

// ���߻�ȡ�������uid��
int gift_uid_get( int actor_index );

// �����
int awardgroup_randnum( int awardgroup, int level, int index );


#endif
