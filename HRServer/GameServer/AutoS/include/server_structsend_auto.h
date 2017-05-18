#ifndef __STRUCTSEND0_AUTO_H
#define __STRUCTSEND0_AUTO_H
#include "server_struct_auto.h"

struct _slk_NetS_Login {
	int m_result;	//����������-����ֵ
	short m_username_length;	//����������-�û�������
	char m_username[51];	//����������-�û���
	short m_token_length;	//����������-token����
	char m_token[256];	//����������-token
	short m_usertype;	//����������-�û�����
};
typedef struct _slk_NetS_Login SLK_NetS_Login;	//�������˷��͵�¼������ͻ���

struct _slk_ListInfo {
	int m_actorid;	//��ɫID
	char m_name[22];	//��ɫ����
	char m_aclass;	//��ɫ����
	short m_level;	//��ɫ�ȼ�
	char m_offset;	//��ɫλ��
	char m_lockstat;	//����״̬
	int m_delete_stoptime;	//ɾ��ʱ��
	int m_lock_endtime;	//����ʱ��
};
typedef struct _slk_ListInfo SLK_ListInfo;	//������ɫ���б���Ϣ

struct _slk_NetS_List {
	char m_actor_num;	//����˷���-��ɫ����
	SLK_ListInfo m_listinfo[8];	//����˷���-��ɫ����
};
typedef struct _slk_NetS_List SLK_NetS_List;	//�������˷��ͽ�ɫ�б�

struct _slk_NetS_Create {
	char m_result;	//����˷���-������ɫ�Ľ��
	int m_actorid;	//����˷���-������ɫ�ı��
	int m_createtime;	//����˷���-������ɫ��ʱ��
};
typedef struct _slk_NetS_Create SLK_NetS_Create;	//���������ش�����ɫ���

struct _slk_NetS_EnterInfo {
	int m_actorid;	//����˷���-������Ϸ��ɫID
	int m_data_int;	//����˷���-������Ϸ��������[����]
	short m_data_short;	//����˷���-������Ϸ��������[����]
	char m_data_char;	//����˷���-������Ϸ��������[����]
	short m_serverid;	//����˷���-����ķ�����ID
	int m_servertime;	//����˷���-����ķ�����ʱ���
	int m_createtime;	//����˷���-������ɫʱ��
};
typedef struct _slk_NetS_EnterInfo SLK_NetS_EnterInfo;	//���������ؽ�����Ϸ�����Ϣ

struct _slk_NetS_Delete {
	int m_result;	//����������-ɾ������ֵ
	int m_actorid;	//����������-ɾ���Ľ�ɫ���
};
typedef struct _slk_NetS_Delete SLK_NetS_Delete;	//����������ɾ����ɫ

struct _slk_NetS_Heart {
	int m_value[2];	//����-��ֵ
};
typedef struct _slk_NetS_Heart SLK_NetS_Heart;	//����

struct _slk_NetS_Notify {
	short m_msgid;	//����������-����ϢID
	short m_valuenum;	//����������-����Ϣ��������
	int m_value[10];	//����������-����Ϣ��ֵ����
	short m_msg_length;	//����������-����Ϣ�ַ�����Ϣ����
	char m_msg[256];	//����������-����Ϣ�ַ�������
};
typedef struct _slk_NetS_Notify SLK_NetS_Notify;	//ͨ�ö���Ϣ

struct _slk_NetS_ActorInfo {
	int m_actorid;	//������������һ�����Ϣ-��ɫ���
	char m_name[22];	//������������һ�����Ϣ-��ɫ����
	char m_aclass;	//������������һ�����Ϣ-��ɫ����
	short m_shape;	//������������һ�����Ϣ-����
	short m_level;	//������������һ�����Ϣ-����
	i64 m_experience;	//������������һ�����Ϣ-����
	i64 m_experience_max;	//������������һ�����Ϣ-��������
	int m_token;	//������������һ�����Ϣ-��ʯ
	char m_viplevel;	//������������һ�����Ϣ-VIP�ȼ�
};
typedef struct _slk_NetS_ActorInfo SLK_NetS_ActorInfo;	//��ɫ������Ϣ

struct _slk_Corrdinate {
	short m_posx;	//����
	short m_posy;	//����
};
typedef struct _slk_Corrdinate SLK_Corrdinate;	//����

struct _slk_NetS_ItemUse {
	short m_itemoffset;	//��Ʒλ��
	short m_usenum;	//ʹ�ø�����װ��λ��
	int m_effres;	//Ӱ�죬һ��������Ч��ʾ
};
typedef struct _slk_NetS_ItemUse SLK_NetS_ItemUse;	//����ʹ��|װ��

struct _slk_NetS_ItemPut {
	short m_res_offset;	//��ƷԴ
	short m_res_num;	//��ƷԴ����
	short m_target_offset;	//��ƷĿ��
	short m_target_num;	//Ŀ�����
};
typedef struct _slk_NetS_ItemPut SLK_NetS_ItemPut;	//���߷���|ж��

struct _slk_NetS_ItemSettle {
	short m_itemnum;	//�������ĸ���
	short m_itemoffset[100];	//���õ���Ʒλ��
};
typedef struct _slk_NetS_ItemSettle SLK_NetS_ItemSettle;	//��������

struct _slk_NetS_LostItem {
	short m_itemoffset;	//��Ʒλ��
	short m_itemnum;	//����
	int m_targetid;	//����Ķ���id
	char m_path;	//;��
};
typedef struct _slk_NetS_LostItem SLK_NetS_LostItem;	//��ʧ����

struct _slk_NetS_GetItem {
	short m_itemoffset;	//��Ʒλ��
	short m_kind;	//��Ʒ����
	short m_type;	//��Ʒ����
	char m_color;	//��ɫ
	short m_num;	//����
	int m_targetid;	//����Ķ���id
	char m_path;	//;��
	unsigned char m_situation;	//ʹ��״̬
};
typedef struct _slk_NetS_GetItem SLK_NetS_GetItem;	//��õ���

struct _slk_ItemSmpInfo {
	short m_offset;	//��Ʒλ��
	short m_kind;	//��Ʒ����
	short m_num;	//����
	unsigned char m_situation;	//ʹ��״̬
	char m_color_level;	//��ɫ
};
typedef struct _slk_ItemSmpInfo SLK_ItemSmpInfo;	//���߼�����Ϣ

struct _slk_NetS_ItemList {
	char m_itemext;	//��չ�ĸ���
	short m_kindnum;	//��Ʒ����
	SLK_ItemSmpInfo m_item[300];	//��Ʒ
};
typedef struct _slk_NetS_ItemList SLK_NetS_ItemList;	//�����б�

struct _slk_ItemAttr {
	short m_type;	//��Ʒ������������
	short m_ability;	//��Ʒ����
	int m_value;	//��Ʒ����
	int m_addvalue;	//��Ʒ��������
};
typedef struct _slk_ItemAttr SLK_ItemAttr;	//��������

struct _slk_NetS_ItemInfo {
	short m_itemoffset;	//��Ʒλ��
	short m_itemkind;	//װ��kind,У��
	short m_type;	//��Ʒ����
	short m_level;	//һ��ȼ�
	char m_color_level;	//��ɫ�ּ�
	int m_price;	//�ۼ�
	short m_attr_num;	//���Ը���
	SLK_ItemAttr m_attr[10];	//����
};
typedef struct _slk_NetS_ItemInfo SLK_NetS_ItemInfo;	//������Ϣ

struct _slk_WalkPath {
	short m_pathx[100];	//·����ṹ
	short m_pathy[100];	//·����ṹ
	short m_len;	//·����ṹ
};
typedef struct _slk_WalkPath SLK_WalkPath;	//�ƶ�·��

struct _slk_NetS_AddMapUnit {
	char m_type;	//��ͼ��Ԫ-����
	char m_state;	//��ͼ��Ԫ-״̬
	short m_posx;	//��ͼ��Ԫ-��ǰ����
	int m_unit_index;	//��ͼ��Ԫ-���
	short m_posy;	//��ͼ��Ԫ-��ǰ����
	char m_namelen;	//��ͼ��Ԫ-���Ƴ���
	char m_name[32];	//��ͼ��Ԫ-����
	char m_char_value_count;	//��ͼ��Ԫ-ͨ���ֶγ���
	char m_char_value[16];	//��ͼ��Ԫ-ͨ���ֶ�
	char m_short_value_count;	//��ͼ��Ԫ-ͨ���ֶγ���
	short m_short_value[8];	//��ͼ��Ԫ-ͨ���ֶ�
	char m_int_value_count;	//��ͼ��Ԫ-ͨ���ֶγ���
	int m_int_value[8];	//��ͼ��Ԫ-ͨ���ֶ�
	char m_prefixlen;	//��ͼ��Ԫ-�ƺų���
	char m_prefix[22];	//��ͼ��Ԫ-�ƺ�
};
typedef struct _slk_NetS_AddMapUnit SLK_NetS_AddMapUnit;	//��ʾ��Ԫ�����ͼ

struct _slk_NetS_DelMapUnit {
	int m_unit_index;	//��ͼ��Ԫ-���
};
typedef struct _slk_NetS_DelMapUnit SLK_NetS_DelMapUnit;	//��ʾ��Ԫ�뿪��ͼ

struct _slk_NetS_WorldMapInfo {
	short m_map_width;	//�����ͼ��С����������
	short m_map_height;	//�����ͼ��С����������
	char m_area_width;	//�����С��һ�����򼸸���ͼ���ӣ�
	char m_area_height;	//�����С��һ�����򼸸���ͼ���ӣ�
	short m_map_area_xnum;	//һ����ͼ�ж�������
	short m_map_area_ynum;	//һ����ͼ�ж�������
	short m_my_city_posx;	//�ҵĳǳ�λ��
	short m_my_city_posy;	//�ҵĳǳ�λ��
	int m_my_city_unit_index;	//�ҵĳǳص�ͼ��Ԫ-���
	char m_citystate;	//�ҵĳǳ�״̬
	short m_target_posx;	//Ŀ�ĵ�
	short m_target_posy;	//Ŀ�ĵ�
};
typedef struct _slk_NetS_WorldMapInfo SLK_NetS_WorldMapInfo;	//�����ͼ��Ϣ

struct _slk_NetS_MapUnitCorrdinate {
	int m_unit_index;	//��ͼ��Ԫ-���
	short m_posx;	//��ͼ��Ԫ-��ǰ����
	short m_posy;	//��ͼ��Ԫ-��ǰ����
};
typedef struct _slk_NetS_MapUnitCorrdinate SLK_NetS_MapUnitCorrdinate;	//��ͼ��ʾ��Ԫλ��

struct _slk_NetS_AddMarchRoute {
	char m_from_type;	//�о�·��-������Ԫ����
	short m_from_posx;	//�о�·��-����λ��
	short m_from_posy;	//�о�·��-����λ��
	char m_to_type;	//�о�·��-���ﵥԪ����
	short m_to_posx;	//�о�·��-����λ��
	short m_to_posy;	//�о�·��-����λ��
	char m_state;	//�о�·��-״̬
	int m_from_cityid;	//�о�·��-����
	int m_from_clubid;	//�о�·��-����
	int m_to_cityid;	//�о�·��-Ŀ�����
	int m_to_clubid;	//�о�·��-Ŀ������
	int m_army_index;	//�о�·��-��������
	char m_action;	//�о�·��-��Ϊ
};
typedef struct _slk_NetS_AddMarchRoute SLK_NetS_AddMarchRoute;	//�о�·��

struct _slk_NetS_DelMarchRoute {
	int m_army_index;	//ɾ����-��������
};
typedef struct _slk_NetS_DelMarchRoute SLK_NetS_DelMarchRoute;	//ɾ���о�·��

struct _slk_NetS_UpdateMapUnit {
	SLK_NetS_AddMapUnit m_info;	//���µ�ͼ��ʾ��Ԫ��Ϣ
};
typedef struct _slk_NetS_UpdateMapUnit SLK_NetS_UpdateMapUnit;	//���µ�ͼ��ʾ��Ԫ��Ϣ

struct _slk_NetS_AwardInfo {
	int m_kind;	//����
	int m_num;	//����
};
typedef struct _slk_NetS_AwardInfo SLK_NetS_AwardInfo;	//������Ϣ

struct _slk_NetS_AwardInfoList {
	short m_count;	//��������
	SLK_NetS_AwardInfo m_list[32];	//�����б�
	short m_callback_code;	//�ĸ�ϵͳҪ��ʾ���ش�
};
typedef struct _slk_NetS_AwardInfoList SLK_NetS_AwardInfoList;	//������Ϣ�б�

struct _slk_NetS_Experience {
	int m_addexp;	//
	i64 m_curexp;	//
	char m_isup;	//
	short m_path;	//
};
typedef struct _slk_NetS_Experience SLK_NetS_Experience;	//�����ȡ

struct _slk_NetS_Body {
	short m_body;	//����
	short m_addbody;	//��ȡ����
	int m_path;	//;��
};
typedef struct _slk_NetS_Body SLK_NetS_Body;	//������ȡ

int struct_NetS_Login_send( char **pptr, int *psize, SLK_NetS_Login *pValue );
int struct_ListInfo_send( char **pptr, int *psize, SLK_ListInfo *pValue );
int struct_NetS_List_send( char **pptr, int *psize, SLK_NetS_List *pValue );
int struct_NetS_Create_send( char **pptr, int *psize, SLK_NetS_Create *pValue );
int struct_NetS_EnterInfo_send( char **pptr, int *psize, SLK_NetS_EnterInfo *pValue );
int struct_NetS_Delete_send( char **pptr, int *psize, SLK_NetS_Delete *pValue );
int struct_NetS_Heart_send( char **pptr, int *psize, SLK_NetS_Heart *pValue );
int struct_NetS_Notify_send( char **pptr, int *psize, SLK_NetS_Notify *pValue );
int struct_NetS_ActorInfo_send( char **pptr, int *psize, SLK_NetS_ActorInfo *pValue );
int struct_Corrdinate_send( char **pptr, int *psize, SLK_Corrdinate *pValue );
int struct_NetS_ItemUse_send( char **pptr, int *psize, SLK_NetS_ItemUse *pValue );
int struct_NetS_ItemPut_send( char **pptr, int *psize, SLK_NetS_ItemPut *pValue );
int struct_NetS_ItemSettle_send( char **pptr, int *psize, SLK_NetS_ItemSettle *pValue );
int struct_NetS_LostItem_send( char **pptr, int *psize, SLK_NetS_LostItem *pValue );
int struct_NetS_GetItem_send( char **pptr, int *psize, SLK_NetS_GetItem *pValue );
int struct_ItemSmpInfo_send( char **pptr, int *psize, SLK_ItemSmpInfo *pValue );
int struct_NetS_ItemList_send( char **pptr, int *psize, SLK_NetS_ItemList *pValue );
int struct_ItemAttr_send( char **pptr, int *psize, SLK_ItemAttr *pValue );
int struct_NetS_ItemInfo_send( char **pptr, int *psize, SLK_NetS_ItemInfo *pValue );
int struct_WalkPath_send( char **pptr, int *psize, SLK_WalkPath *pValue );
int struct_NetS_AddMapUnit_send( char **pptr, int *psize, SLK_NetS_AddMapUnit *pValue );
int struct_NetS_DelMapUnit_send( char **pptr, int *psize, SLK_NetS_DelMapUnit *pValue );
int struct_NetS_WorldMapInfo_send( char **pptr, int *psize, SLK_NetS_WorldMapInfo *pValue );
int struct_NetS_MapUnitCorrdinate_send( char **pptr, int *psize, SLK_NetS_MapUnitCorrdinate *pValue );
int struct_NetS_AddMarchRoute_send( char **pptr, int *psize, SLK_NetS_AddMarchRoute *pValue );
int struct_NetS_DelMarchRoute_send( char **pptr, int *psize, SLK_NetS_DelMarchRoute *pValue );
int struct_NetS_UpdateMapUnit_send( char **pptr, int *psize, SLK_NetS_UpdateMapUnit *pValue );
int struct_NetS_AwardInfo_send( char **pptr, int *psize, SLK_NetS_AwardInfo *pValue );
int struct_NetS_AwardInfoList_send( char **pptr, int *psize, SLK_NetS_AwardInfoList *pValue );
int struct_NetS_Experience_send( char **pptr, int *psize, SLK_NetS_Experience *pValue );
int struct_NetS_Body_send( char **pptr, int *psize, SLK_NetS_Body *pValue );

#endif
