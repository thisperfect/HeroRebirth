#ifndef __NETSERVER_H
#define __NETSERVER_H

#ifdef WIN32
#ifndef WIN32_LEAN_AND_MEAN
	#define WIN32_LEAN_AND_MEAN
#endif
#include <winsock2.h>
#include <windows.h>
#include <Ws2tcpip.h>
#endif
#include "utils.h"
#include "thread.h"
#ifdef _USEGATE
#include "netserver_gs.h"
#endif

#define MAX_SOCKET_NUM		512			// ���������
//#define MAX_SOCKET_NUM		1024*4			// ���������

#define MAX_BUF_SIZE		1024*4			// ��󻺳�������
#define MAX_PACKAGE_SIZE	1024*2			// ������������

#define MAX_SENDLIST_COUNT	1200				// һ���û��ķ����������󳤶�,������T

#define MAX_FD				8192

#define LISTEN_QUEUE		20				// �������г���
#define SERV_PORT 11521						// �����˿�

#ifdef WIN32
#define MAX_WORKER_THREAD	16				// �����̸߳���
#define IOREAD				1				// ������
#define IOWRITE				2				// д����
#endif

#define FORBID_IP_MAX	(100)
#define FORBID_IP_HITTIME	(60)
#define FORBID_ALL_TIME		(60)

#define MAX_DEVDATA_SIZE	256
#define DEVDATA_COUNT		16
// �ڴ��,ÿһ���ʾһ�������
struct _sbuf_pool
{
	int buf_size;				// ���������
	char buf[MAX_PACKAGE_SIZE];	// ���������
	int client_index;			// �ͻ�������(���ڲ���bug��)
	int next;
};
typedef struct _sbuf_pool SBufPool;

// �����İ�����
struct _sreadqueue
{
	int client_index;			// �ͻ�������
	int buf_size;				// ���������
	char buf[MAX_PACKAGE_SIZE];	// ���������
	int exec_code;

	// ���ר��
	char type;
	short server_code;
	short cmd;
	int value[2];
};
typedef struct _sreadqueue SReadQueue;

// ����һ���ͻ��Ļ�����
typedef struct _socket_buf {
#ifdef WIN32
	WSAOVERLAPPED	m_Overlapped;
	WSABUF			m_wsabuf;
	BYTE			m_nOption;		// IO������ʽ
#else
	char			*m_ptr;
#endif
	char			*m_pBuffer;		//8K
	int				m_nTotalBytes;	// ���ֽ���
	int				m_nProcBytes;	// ������ֽ���
} SOCKET_BUF;

// ����һ���ͻ���,����һ������һ��д�Ļ�����
typedef struct _socket_set {
	SOCKET			m_fd;
	char			m_stat;			// �ͻ��˵�״̬, ��,�ȴ�,�޵���,�ѵ���,�ѽ�����Ϸ
	char			m_iswait;		// �ͻ����Ƿ��ڵȴ�״̬�����ڵ���״̬�жϣ��ȴ�״̬�������κοͻ���Ϣ��
	char			m_ip[16];		// IP��ַ
	char			m_idle_time;	// ���е�ʱ��(10��Ϊһ����λ,����ﵽ6����λ1����,���߳�����ͻ�)
	int				m_enter_time;	// ������Ϸ��ʱ��
	i64				m_userid;		// --����:�û�id
	char			m_username[MAX_USERNAME_LENGTH+1];	// --����:�û���
	short			m_usertype;		// --����:�û�����

	char			m_deviceid[65];	//	--����:�豸ID
	short			m_platid;		// --����:�ͻ���ƽ̨���
	char			m_language;		// --����:�ͻ���ʹ�õ�����
	short			m_invcode;		// --����:�ͻ����ڲ���ʶ
	int				m_os;		// --����:����ϵͳ(1:ios 2:android)
	short			m_channelid;	// --����:����,����ƽ̨����Ϊ�����Ӹ�������
	int				m_ver[3];		//
	char			m_devdata[MAX_DEVDATA_SIZE];		// --����:�豸��Ϣ
	char			*m_dev[DEVDATA_COUNT];		// �豸��Ϣ�ָ�
	char			m_isnew;		// ���ʺű��
	short			m_country;		// �ͻ���ѡ��Ĺ���
	char			m_ipcountry[4];	// IP��ַ���ڹ���
	int				m_authid;		// ��֤�ͻ������ӵ���ȷ��
	SOCKET_BUF		m_recv_buf;		// ���ջ�����
	SOCKET_BUF		m_send_buf;		// ���ͻ�����
	int				m_send_head;	// ����ͷ
	int				m_send_tail;	// ����β
	short			m_recv_count;	// ���հ�����(1������)
	short			m_send_count;	// ��������Ĵ�С
	unsigned int	m_recv_key;		// ���ݽ��յ�����
	unsigned int	m_send_key;		// ���ݷ��͵�����
	char			m_pass_key;		// ������ܵ�xor
	int				m_gpk_key;		// GPK����������

	ThrMux			*m_mmux;		// ������
	int				m_exec_code;

} SOCKET_SET;


//typedef int (*ADD_FORBID_IP)( _net_protect *, int );
typedef struct  _net_protect
{
	int forbid_ip_list[FORBID_IP_MAX];
	time_t forbid_time[FORBID_IP_MAX];
	time_t all_forbid_time;
	ThrMux	*iplist_mutex;
}NetProtect;

#ifdef _USEGATE
void netserver_setgatemode( char usegate );
#endif

int fill_send_buf( int client_index );
int net_recv_clientver( int client_index, char *buf, int truesize );
int net_send_clientver( int client_index, int err_code );
int net_send_onepackeg( int client_index, char *pack_data, short pack_size );
int net_send_long_packeg( int client_index, char *long_data, int long_size );

int add_socketindex( SOCKET fd );
int unset_socket( int client_index, char is_remove );
void close_client( int client_index );
void net_closesock_direct( int client_index );
int server_getautuid( int client_index );

int get_sbuf_count();
int check_sbuf_count( int type, int *pcount_inv, int *pcount_exit );

int ReloadGPK( int code );

int add_forbid_ip( NetProtect *np, char *ip );
int check_forbid_ip( NetProtect *np, int ip );

void server_exit();

#endif
