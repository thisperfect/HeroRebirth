#ifndef __MAPUNIT_H_
#define __MAPUNIT_H_

#define MAPUNIT_TYPE_CITY			1	// �ǳ�
#define MAPUNIT_TYPE_ARMY			2	// ����
#define MAPUNIT_TYPE_TOWER			3	// ��¥

// �����ͼ��ʾ��Ԫ
typedef struct _mapunit
{
	char type;					// ����1=City 2=ARMY 3...
	int index;					// ���Ͷ�Ӧ����
	int pre_index;				// ǰһ����Ԫ������
	int next_index;				// ��һ����Ԫ������
	int lastadd_areaindex;		// �ϴν����������
}MapUnit;

int mapunit_init();

// �������ͺͶ�Ӧ����ȷ����Ԫ����
int mapunit_getindex( char type, int index );

// ��ȡ��ʾ��Ԫ��Ӧ��������Ϣ
int mapunit_getattr( int unit_index, SLK_NetS_AddMapUnit *pAttr );

// ��ȡ��ʾ��Ԫ��Ӧ��λ��
int mapunit_getpos( int unit_index, short *posx, short *posy );

// ����Ҫ��ʾ�ĳǳػ������ӵ���ʾ��Ԫ
int mapunit_add( char type, int index );

// ���Ѿ������ĵ�ͼ��Ԫɾ����
int mapunit_del( char type, int index, int unit_index );

// ���µ�ͼ��Ԫ����
int mapunit_update( char type, int index, int unit_index );

// ��ʾ��Ԫ���������ͼ
int mapunit_enterworld( int unit_index, short posx, short posy );

// ��֯һ����Ԫ�������룬�뿪��������ݰ�
int mapunit_enterinfo( int unit_index, char *databuf, int *psize );
int mapunit_leaveinfo( int unit_index, char *databuf, int *psize );

// ��һ����ķ����¼�
int mapunit_enterarea( int unit_index, int area_index );
int mapunit_leavearea( int unit_index, int area_index );

int mapunit_resetinfo( int unit_index, char *databuf, int *psize );
int mapunit_resetarea( int unit_index, int area_index );

// ����λ�û�ȡ��ǰλ�õ���ʾ��Ԫ��Ϣ
MapUnit *mapunit_getinfo_withpos( short posx, short posy, char excude_unittype, int excude_index );

// ����λ�û�ȡ��ǰλ�õ�����
int mapunit_getindex_withpos( short posx, short posy, char excude_unittype, int excude_index );

#endif
