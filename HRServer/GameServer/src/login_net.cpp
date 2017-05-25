#ifdef WIN32
#include <winsock2.h>
#include <mswsock.h>
#else
#include <strings.h>
#include <sys/socket.h>
#include <sys/epoll.h>
#include <sys/resource.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#endif
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "http.h"
#include "netfunc.h"
#include "login.h"
#include "actor.h"
#include "define.h"
#include "server_netsend_auto.h"
#include "actor_send.h"

extern SConfig g_Config;
extern int g_tick;

SLoginQueue *login_queue;
int g_nLoginQueueHead;
int g_nLoginQueueTail;

int g_login_timeout	= 5;

Mthr	*g_pthr_login;
ThrMux	*g_login_mmux;
Mthr	*g_pthr_recv_login;

SOCKET g_login_socket;

extern int g_maxactorid;
extern Actor *g_actors;
extern int g_maxactornum;
extern char g_bServerIsInit;
extern PlatInfo *g_platinfo;
extern int g_platinfo_maxnum;

// �û���¼����ĳ�ʼ��
int login_init()
{
#ifdef WIN32
	WORD tSocketVerNo;
	WSADATA tVerData;
	tSocketVerNo = MAKEWORD(2, 0);
	WSAStartup(tSocketVerNo, &tVerData);
#endif

	g_nLoginQueueHead = 0;
	g_nLoginQueueTail = 0;
	login_queue = (SLoginQueue *)malloc( sizeof(SLoginQueue)*MAX_LOGINQUEUENUM );
	memset( login_queue, 0, sizeof(SLoginQueue)*MAX_LOGINQUEUENUM );
	for ( int tmpi = 0; tmpi < MAX_LOGINQUEUENUM; tmpi++ )
	{
		login_queue[tmpi].client_index = -1;
	}

	g_login_socket = -1;
	g_login_mmux = mmux_open();
	g_pthr_login = mthr_open();
	mcond_init( g_pthr_login );

	g_pthr_recv_login = mthr_open();

	g_login_socket = HttpConnect( g_Config.user_host, g_Config.user_port );
	if( g_login_socket == INVALID_SOCKET )
	{
		printf_msg( "warning! login server is not run!\n" );
	}
	HttpClose( g_login_socket );
	g_login_socket = INVALID_SOCKET;
	// ������¼�߳�
	mthr_create( g_pthr_login, (void*)login_send_proc, 0 );
	return 0;
}

// ���ó�ʱʱ��
void login_settimeout()
{
	if( g_login_timeout > 0 )
	{
#ifdef WIN32
		int timeout = g_login_timeout*1000;
		setsockopt( g_login_socket, SOL_SOCKET, SO_RCVTIMEO, (char*)&timeout, sizeof(timeout) );
#else
		struct timeval tv_out;
		tv_out.tv_sec = g_login_timeout;
		tv_out.tv_usec = 0;
		setsockopt( g_login_socket, SOL_SOCKET, SO_RCVTIMEO, &tv_out, sizeof(tv_out) );
#endif
	}
}

// ����
void login_reconnect( int client_index )
{
	int platid = client_getplatid( client_index );
	if ( platid < 0 || platid >= g_platinfo_maxnum )
		return;

	// ���ӶϿ���(��Ҫ��������)
	HttpClose( g_login_socket );
	g_login_socket = INVALID_SOCKET;
	while( 1 )
	{
		if ( platid == 0 || g_platinfo[platid].allow == 0 )
		{ // ����Ĭ�������ļ������õ�
			g_login_socket = HttpConnect( g_Config.user_host, g_Config.user_port );
			write_netlog( "login_connect:host[%s:%d]", g_Config.user_host, g_Config.user_port );
			login_settimeout();
		}
		else
		{ // �������ݿ����õ�
			g_login_socket = HttpConnect( g_platinfo[platid].userhost, g_platinfo[platid].userport );
			write_netlog( "login_connect:host[%s:%d]", g_platinfo[platid].userhost, g_platinfo[platid].userport );
			login_settimeout();
		}
		if( g_login_socket != INVALID_SOCKET )
			break;
#ifdef WIN32
		Sleep( 1000 );
#else
		sleep( 1 );
#endif
	}
}

// ��ȡ��һ���ֶ�
char *login_getnextvalue( char *stream )
{
	char *pstr;
	pstr = (char *)strstr( stream, "\n" );
	if ( pstr == NULL )
	{
		return NULL;
	}
	*pstr = 0;
	pstr++;
	return pstr;
}

// �û���¼�Ľ��չ���
int login_loginproc( char *recv_buf )
{
	int valuecount = 10;
	int tmpi;
	char *pcur;
	char *pnext;
	SLK_NetU_Logined Value = {0};
	pcur = recv_buf;
	for( tmpi = 0; tmpi < valuecount; tmpi++ )
	{
		if( pcur == NULL )
			break;
		pnext = login_getnextvalue( pcur );
		switch( tmpi )
		{
		case 0:
			Value.m_client_index = atoi( pcur );
			break;
		case 1:
			Value.m_authid = atoi( pcur );
			break;
		case 2:
			Value.m_result = atoi( pcur );
			break;
		case 3:
			Value.m_usertype = atoi( pcur );
			break;
		case 4:
			break;
		case 5:
			strncpy( Value.m_userid, pcur, 20 );
			break;
		case 6:
			strncpy( Value.m_username, pcur, 50 );
			break;
		case 7:
			strncpy( Value.m_access_token, pcur, 64 );
			break;
		case 8:
			Value.m_expires_in = atoi( pcur );
			break;
		case 9:
			strncpy( Value.m_refresh_token, pcur, 64 );
			break;
		case 10:
			strncpy( Value.m_deviceid, pcur, 64 );
			break;
		}
		pcur = pnext;
	}

	netsend_logined_S( -2, 0, &Value );
	return 0;
}

// �һ��뽱��
int login_awardproc( char *recv_buf )
{
	int valuecount = 6;
	int tmpi;
	char *pcur;
	char *pnext;
	pcur = recv_buf;
	SLK_NetU_UserAwarded Value = {0};
	for ( tmpi = 0; tmpi < valuecount; tmpi++ )
	{
		if ( pcur == NULL )
			return -1;
		pnext = login_getnextvalue( pcur );
		switch ( tmpi )
		{
		case 0:
			Value.m_client_index = atoi( pcur );
			break;
		case 1:
			Value.m_authid = atoi( pcur );
			break;
		case 2:
			Value.m_cdkey_index = atoi( pcur );
			break;
		case 3:
			Value.m_awardgroup = atoi( pcur );
			break;
		case 4:
			Value.m_result = atoi( pcur );
			break;
		case 5:
			strncpy( Value.m_cardnumber, pcur, 31 );
			break;
		}
		pcur = pnext;
	}
	netsend_userawarded_S( -2, 0, &Value );
	return 0;
}

//�û������Ľ��չ���
int login_lockproc( char *recv_buf )
{
	/*int valuecount = 4;

	int tmpi;

	char *pcur;
	char *pnext;

	pcur = recv_buf;

	SLK_NetC_LockUser Value = {};
	for( tmpi = 0; tmpi < valuecount; tmpi++ )
	{
	if( pcur == NULL )
	return -1;
	pnext = login_getnextvalue( pcur );
	switch( tmpi )
	{
	case 0:
	Value.m_client_index = atoi( pcur );
	break;
	case 1:
	Value.m_authid = atoi( pcur );
	break;
	case 2:
	strncpy( Value.m_userid, pcur, 20 );
	break;
	case 3:
	Value.m_errcode = atoi( pcur );
	break;
	}
	pcur = pnext;
	}
	netsend_lockuser_S( -2, 0, &Value );*/
	return 0;
}

// �ı������������Ϣ����
int login_changesevproc( char *recv_buf )
{
	//int valuecount = 3;
	//int tmpi;
	//char *pcur;
	//char *pnext;
	//pcur = recv_buf;
	//SLK_NetU_ChangeSev Value = { 0 };
	//for ( tmpi = 0; tmpi < valuecount; tmpi++ )
	//{
	//	if ( pcur == NULL )
	//		return -1;
	//	pnext = login_getnextvalue( pcur );
	//	switch ( tmpi )
	//	{
	//	case 0:
	//		Value.m_client_index = atoi( pcur );
	//		break;
	//	case 1:
	//		Value.m_authid = atoi( pcur );
	//		break;
	//	case 2:
	//		Value.m_result = atoi( pcur );
	//		break;
	//	}
	//	pcur = pnext;
	//}
	//netsend_changesrv_S( -2, 0, &Value );
	return 0;
}

// 
int login_recv_proc( short cmd, char *recv_buf )
{
	switch( cmd )
	{
	case USERCMDS_LOGIN:	// �˺ŵ�½
		return login_loginproc( recv_buf );
		break;
	case USERCMDS_AWARD:	// �һ���
		return login_awardproc( recv_buf );
		break;
	case USERCMDS_LOCKUSER:	// �˺�����
		return login_lockproc( recv_buf );
		break;
	case USERCMDS_CHANGESEV:// ������������Ϣ
		return login_changesevproc( recv_buf );
		break;
	}
	return -1;
}

// �û�����ķ����߳�
int login_send_proc()
{
	char send_buf[COMMAND_PACK_LEN];
	char *pstr;
	int package_len;
	int packsize;
	char recv_buf[HTTPMAX_BUFFLEN+1];
	int value;
	int readsize;
	int datasize;
	int client_index;

	short cmd;

	while( !g_bServerIsInit )
	{
//		printf_msg( "Server Is Not Init, login_send_proc Wait...\n" );
#ifdef WIN32
		Sleep( 1000 );
#else
		sleep( 1 );
#endif
	}
	printf_msg( "login_send_proc is run!\n" );

	while( 1 )
	{
		// ��ס��¼�Ķ��л���
		mmux_lock( g_login_mmux );
		while( g_nLoginQueueTail == g_nLoginQueueHead )
		{
			mcond_wait( g_pthr_login, g_login_mmux );
		}
		// �Ӷ�����ȡ��һ��
		cmd = login_queue[g_nLoginQueueHead].command;
		client_index = login_queue[g_nLoginQueueHead].client_index;
		sprintf( send_buf, "/u.php?c=%d&i=%d&a=%d%s", cmd, login_queue[g_nLoginQueueHead].client_index, login_queue[g_nLoginQueueHead].authid, login_queue[g_nLoginQueueHead].data );

		g_nLoginQueueHead++;
		if( g_nLoginQueueHead >= MAX_LOGINQUEUENUM )
		{
			g_nLoginQueueHead = 0;
		}
		mmux_unlock( g_login_mmux );
		// 1.����Get����
//LOGIN_RESEND:
		login_reconnect( client_index );
		if ( HttpGet( g_login_socket, send_buf, g_Config.user_host ) < 0 )
		{
			continue;
		}
		// Ȼ��ʼ��������
		package_len = HTTPMAX_BUFFLEN;
		packsize = 0;
		while( packsize < package_len )
		{
			if ( ( readsize = recv( g_login_socket, recv_buf+packsize, package_len-packsize, 0 ) ) <= 0 )
			{
				break;
			}
			packsize += readsize;
		}
		*(recv_buf+packsize)=0;

		// �Ƚ���״̬��
		if( (value = HttpParse( recv_buf, NULL, NULL ) ) == -1 )
		{
			continue;
		}

		if( value != 200 && value != 206 )
		{
			continue;
		}

		char transfer_encoding = 0;
		if( (package_len = HttpParse( recv_buf, "Content-Length:", NULL ) ) == -1 )
		{
			package_len = 0;
			if ( HttpParse( recv_buf, "Transfer-Encoding:", NULL ) == -1 )
			{
				transfer_encoding = 0;
			}
			else
			{
				transfer_encoding = 1;
			}
		}

		// ָ������
		pstr = HttpGetHeaderEnd( recv_buf );
		if( pstr == NULL )
		{
			continue;
		}

		// �����Transfer-Encoding:Э��ͷ
		if ( transfer_encoding )
		{
			char *stream = pstr;
			pstr = login_getnextvalue( stream );
			package_len = atoi( stream );
		}

		datasize = packsize - (int)( pstr - recv_buf );
//		fwrite( pstr, sizeof(char), datasize, fp );
		package_len -= datasize;
		packsize = 0;

		login_recv_proc( cmd, pstr );

		HttpClose( g_login_socket );
		g_login_socket = INVALID_SOCKET;
	}

	printf_msg( "[thread]Login Proc Exited.\n" );
	return 0;
}

