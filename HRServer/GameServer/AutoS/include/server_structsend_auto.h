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

struct _slk_NetS_FightRoomActor {
	char m_name_length;	//���Ƴ���
	char m_name[32];	//����
	short m_level;	//�ȼ�
	int m_actorid;	//��ɫID
	int m_headid;	//ͷ��
	char m_ready;	//׼����
};
typedef struct _slk_NetS_FightRoomActor SLK_NetS_FightRoomActor;	//ս��1�������Ϣ

struct _slk_NetS_FightRoomInfo {
	char m_attack_actornum;	//����������
	SLK_NetS_FightRoomActor m_attack_actorinfo[3];	//�����������Ϣ
	char m_defense_actornum;	//����������
	SLK_NetS_FightRoomActor m_defense_actorinfo[3];	//�����������Ϣ
	int m_fightid;	//ս��ID
	char m_pvpnum;	//PVP����
};
typedef struct _slk_NetS_FightRoomInfo SLK_NetS_FightRoomInfo;	//ս������ȫ��Ϣ

struct _slk_NetS_FightRoomQuit {
	int m_fightid;	//ս���뿪
	int m_actorid;	//ս���뿪��
};
typedef struct _slk_NetS_FightRoomQuit SLK_NetS_FightRoomQuit;	//ս�������뿪���

struct _slk_NetS_FightRoomSetHero {
	int m_fightid;	//ս��ID
};
typedef struct _slk_NetS_FightRoomSetHero SLK_NetS_FightRoomSetHero;	//ս����ʼ����Ӣ��

struct _slk_NetS_FightRoomReady {
	int m_fightid;	//ս��ȷ��
	int m_actorid;	//ս��ȷ����
};
typedef struct _slk_NetS_FightRoomReady SLK_NetS_FightRoomReady;	//ս���������׼����

struct _slk_NetS_FightStart {
	int m_fightid;	//ս��ID
};
typedef struct _slk_NetS_FightStart SLK_NetS_FightStart;	//ս����ʼ�����������

struct _slk_NetS_FightTurns {
	int m_turns;	//ս���غ�
};
typedef struct _slk_NetS_FightTurns SLK_NetS_FightTurns;	//ÿ�غ�ս������

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
	int m_addexp;	//�����ȡ
	i64 m_curexp;	//��ǰ����
	char m_isup;	//�Ƿ�����
	short m_path;	//;��
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
int struct_NetS_FightRoomActor_send( char **pptr, int *psize, SLK_NetS_FightRoomActor *pValue );
int struct_NetS_FightRoomInfo_send( char **pptr, int *psize, SLK_NetS_FightRoomInfo *pValue );
int struct_NetS_FightRoomQuit_send( char **pptr, int *psize, SLK_NetS_FightRoomQuit *pValue );
int struct_NetS_FightRoomSetHero_send( char **pptr, int *psize, SLK_NetS_FightRoomSetHero *pValue );
int struct_NetS_FightRoomReady_send( char **pptr, int *psize, SLK_NetS_FightRoomReady *pValue );
int struct_NetS_FightStart_send( char **pptr, int *psize, SLK_NetS_FightStart *pValue );
int struct_NetS_FightTurns_send( char **pptr, int *psize, SLK_NetS_FightTurns *pValue );
int struct_NetS_AwardInfo_send( char **pptr, int *psize, SLK_NetS_AwardInfo *pValue );
int struct_NetS_AwardInfoList_send( char **pptr, int *psize, SLK_NetS_AwardInfoList *pValue );
int struct_NetS_Experience_send( char **pptr, int *psize, SLK_NetS_Experience *pValue );
int struct_NetS_Body_send( char **pptr, int *psize, SLK_NetS_Body *pValue );

#endif
