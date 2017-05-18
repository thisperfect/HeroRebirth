#ifndef __CITY_AUTO_H
#define __CITY_AUTO_H
#include "define.h"

struct _city {
//--Automatically generated
				int cityid;	//�ǳ�ID
				int actorid;	//��ɫID
				char name[22];	//����
				char type;	//�ǳ�����
				char shape;	//�ǳ�����
				int headid;	//Ĭ��ͷ��
				char country[3];	//ѡ��Ĺ���
				char ipcountry[3];	//IP��ַ���ڹ���
				char language;	//ѡ������
				char os;	//ϵͳ1ios 2android 3win
				char platid;	//ƽ̨
				int createtime;	//����ʱ��
				int lastlogin;	//�ϴε�½ʱ��
				int lastlogout;	//�ϴεǳ�ʱ��
				char state;	//�ǳص�ǰ״̬
				short posx;	//λ��
				short posy;	//λ��
				int sflag;	//��־λ
				char level;	//�ȼ�
				char viplevel;	//VIP�ȼ�
				int vipexp;	//VIP����
				short politics;	//������ʩ(һ������)
				int politics_exp;	//������ʩ����
				short farm;	//ũҵ��ʩ(һ������)
				int farm_exp;	//ũҵ��ʩ����
				short business;	//��ҵ��ʩ(һ������)
				int business_exp;	//��ҵ��ʩ����
				short military;	//������ʩ(һ������)
				int military_exp;	//������ʩ����
				int people;	//�˿�(��������)
				int food;	//ʳ��(��������)
				int money;	//��Ǯ(��������)
				int soldiers;	//��Ա(��������)
				int city_index;	//�ǳ�����
				int actor_index;	//��ɫ����
				int unit_index;	//��ʾ����
				int army_index[5];	//����
};
typedef struct _city City;

typedef City * (*LPCB_GETCITY)( int actorid );
typedef int (*LPCB_LOADCITY)( int actorid );
int city_load_auto( LPCB_GETCITY pCB_GetCity, LPCB_LOADCITY pCB_LoadCity, char *pTab );
int city_save_auto( City *pCity, char *pTab, FILE *fp );
int city_batch_save_auto( City *pCity, int maxcount,  char *pTab, FILE *fp );

#endif
