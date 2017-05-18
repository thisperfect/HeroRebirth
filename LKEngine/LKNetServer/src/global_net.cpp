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
#include "global_net.h"

static unsigned long s_global_ipaddress = 0;
static unsigned short s_global_port = 0;
static short s_global_server_code = 0;

SGlobalNetQueue g_global_send_queue;
//SGlobalNetQueue g_global_recv_queue;

// ���ն���
extern SReadQueue *read_queue;
extern int g_nReadQueueHead;
extern int g_nReadQueueTail;
// ���յĻ��������
extern ThrMux	*g_read_mmux;
extern Mthr	*g_pthr_recv;

Mthr	*g_pthr_send_global;	// �����߳�
ThrMux	*g_global_send_mmux;
Mthr	*g_pthr_recv_global;	// �����߳�
//ThrMux	*g_global_recv_mmux;

//Mthr	*g_pthr_work_global;	// ���չ����߳�

SOCKET g_global_socket = INVALID_SOCKET;
LPCALLBACK_GLOBALPACK g_pCallbackGlobalPack = NULL;

// ʹ��Global_netģ��(�����������)
/*
׼����buf����bufsize
����global_sendtoqueue( server_code ���������, global_cmd ���ָ��, value1�ص�����1, value2�ص�����2, data, datasize ); 

*/
extern char g_bServerIsInit;
extern char g_bExit;

int global_send_proc( );
int global_recv_proc( short cmd, char *recv_buf );
//int global_work_proc( );

void global_closesock( )
{
	if( g_global_socket < 0 )
		return;
	shutdown( g_global_socket, 2 );
#ifdef WIN32
	closesocket( g_global_socket );
#else
	close( g_global_socket );
#endif
	g_global_socket = -1;
}

int global_connect( )
{
	if( g_global_socket != INVALID_SOCKET && g_global_socket != -1 )
		return 0;

	struct sockaddr_in clientaddr;
	memset( &clientaddr, 0, sizeof( clientaddr ) );
	clientaddr.sin_family = AF_INET;
	clientaddr.sin_addr.s_addr = s_global_ipaddress;
	clientaddr.sin_port = htons( s_global_port );

	g_global_socket = socket( AF_INET, SOCK_STREAM, 0 );

	if( connect( g_global_socket, ( struct sockaddr * )&clientaddr, sizeof( clientaddr ) ) < 0 )
		return -1;

	int value = 1;
	setsockopt( g_global_socket, SOL_SOCKET, SO_RCVTIMEO, (char*)&value, sizeof( int ) );

	return 1;
}

// �������ĳ�ʼ��
int global_net_init( unsigned long global_ipaddress, unsigned short global_port, int server_code, LPCALLBACK_GLOBALPACK pCallbackGlobalPack )
{
	s_global_ipaddress = global_ipaddress;
	s_global_port = global_port;
	s_global_server_code = server_code;
#ifdef WIN32
	WORD tSocketVerNo;
	WSADATA tVerData;
	tSocketVerNo = MAKEWORD(2, 0);
	WSAStartup(tSocketVerNo, &tVerData);
#endif
	g_pCallbackGlobalPack = pCallbackGlobalPack;
	g_global_send_queue.m_nQueueHead = 0;
	g_global_send_queue.m_nQueueTail = 0;
	g_global_send_queue.m_queue = (SGlobalQueue *)malloc( sizeof(SGlobalQueue)*MAX_GLOBALQUEUENUM );
	printf_msg( "GReadQueue  memory=%0.2fMB\n", (sizeof( SGlobalQueue )*MAX_GLOBALQUEUENUM) / 1024.0 / 1024.0 );
	//g_global_recv_queue.m_nQueueHead = 0;
	//g_global_recv_queue.m_nQueueTail = 0;
	//g_global_recv_queue.m_queue = (SGlobalQueue *)malloc( sizeof(SGlobalQueue)*MAX_GLOBALQUEUENUM );

	g_global_socket = -1;
	g_global_send_mmux = mmux_open( );
	g_pthr_send_global = mthr_open( );
	mcond_init( g_pthr_send_global );

	//g_global_recv_mmux = mmux_open( );
	g_pthr_recv_global = mthr_open( );
	mcond_init( g_pthr_recv_global );

	// ���������̶߳���
	//g_pthr_work_global = mthr_open( );
	//mcond_init( g_pthr_work_global );

	if( s_global_ipaddress == 0 )
		return -1;
	global_connect();

	if( g_global_socket == INVALID_SOCKET )
	{
		printf_msg( "warning! global server is not run!\n" );
	}

	// ������¼�߳�
	mthr_create( g_pthr_send_global, (void*)global_send_proc, 0 );
	// ���������߳�
	mthr_create( g_pthr_recv_global, (void *)global_recv_proc, 0 );
	//// �������չ����߳�
	//mthr_create( g_pthr_work_global, (void *)global_work_proc, 0 );

	if ( g_global_socket != INVALID_SOCKET )
	{
		global_sendtoqueue( server_code, 0, 0, 0, "", 0 );
	}
	return 0;
}

int global_recvtoqueue( short server_code, short cmd, int value1, int value2, char *pBuf, int readsize )
{
	int queue_tail;
	if ( readsize == 0 )
	{
		return -1;
	}
	// ��ס�����л���
	mmux_lock( g_read_mmux );

	queue_tail = g_nReadQueueTail + 1;
	if ( queue_tail >= MAX_QUEUE_NUM )
	{
		queue_tail = 0;
	}
	if ( g_nReadQueueHead == queue_tail )
	{
		// �����Ѿ�����, �Ͽ�����ͻ�,�Ѿ��Ƿǳ���Σ��ʱ��,�������е����ݰ�
		g_nReadQueueHead = g_nReadQueueTail;
		mmux_unlock( g_read_mmux );
		mcond_broadcast( g_pthr_recv );
		return -1;
	}

	memcpy( read_queue[g_nReadQueueTail].buf, pBuf, readsize );
	read_queue[g_nReadQueueTail].buf_size = readsize;
	read_queue[g_nReadQueueTail].client_index = -1;
	read_queue[g_nReadQueueTail].exec_code = 0;

	// ���ר������
	read_queue[g_nReadQueueTail].type = 1;
	read_queue[g_nReadQueueTail].server_code = server_code;
	read_queue[g_nReadQueueTail].cmd = cmd;
	read_queue[g_nReadQueueTail].value[0] = value1;
	read_queue[g_nReadQueueTail].value[1] = value2;

	g_nReadQueueTail = queue_tail;

	mmux_unlock( g_read_mmux );
	mcond_broadcast( g_pthr_recv );
	return 0;
}

int global_sendtoqueue( short server_code, short global_cmd, int value1, int value2, const char *buf, int bufsize )
{
	int queue_tail;

	if( s_global_ipaddress == 0 && s_global_port )
		return -1;

	if( buf == NULL || bufsize < 0 )
		return -1;

	// ��ס���л���
	mmux_lock( g_global_send_mmux );

	queue_tail = g_global_send_queue.m_nQueueTail + 1;
	if( queue_tail >= MAX_GLOBALQUEUENUM )
	{
		queue_tail = 0;
	}
	if( g_global_send_queue.m_nQueueHead == queue_tail )
	{
		// �����Ѿ�����
		mmux_unlock( g_global_send_mmux );
		write_netlog( "global write queue full" );
		//global_closesock( );
		return -1;
	}

	memcpy( g_global_send_queue.m_queue[g_global_send_queue.m_nQueueTail].buf, buf, bufsize );
	g_global_send_queue.m_queue[g_global_send_queue.m_nQueueTail].buf_size = bufsize;
	g_global_send_queue.m_queue[g_global_send_queue.m_nQueueTail].server_code = server_code;
	g_global_send_queue.m_queue[g_global_send_queue.m_nQueueTail].cmd = global_cmd;
	g_global_send_queue.m_queue[g_global_send_queue.m_nQueueTail].value[0] = value1;
	g_global_send_queue.m_queue[g_global_send_queue.m_nQueueTail].value[1] = value2;
	g_global_send_queue.m_nQueueTail = queue_tail;

	mmux_unlock( g_global_send_mmux );
	mcond_broadcast( g_pthr_send_global );
	return 0;
}

// ��������ײ�, �Ǽ򵥵İ��ṹ: len[short]|data[len]
int global_recv_package( char *buf, int size )
{
	char *ptr;
	int package_size;
	int proc_size;
	int remain_size;

	ptr = buf;

	proc_size = 0;
	remain_size = size;

	while( 1 )
	{
		if( remain_size < ( int )sizeof( short ) + 12 )
		{
			return proc_size;
		}
		package_size = *( (short *)(ptr+12) );	// package_size �����Լ����������ٱ������sizeof(short)
		package_size += 12+sizeof(short);
		if( package_size < 12 || package_size >= MAX_PACKAGE_SIZE )
		{
			return -1;
		}
		if( remain_size < package_size )
		{
			return proc_size;
		}
		// ����һ����ptr(package_size)
		global_recvtoqueue( *((short *)ptr), *((short *)(ptr + 2)), *((int *)(ptr + 4)), *((int *)(ptr + 8)), ptr + 12, package_size - 12 );

		proc_size += package_size;
		remain_size -= package_size;
		ptr += package_size;
	}
	return -1;
}


// �������Ľ����߳�
int global_recv_proc( short cmd, char *recv_buf )
{
	int readsize;
	char tmpbuf[MAX_BUF_SIZE];
	int nProcBytes = 0;
	int procsize = 0;

	if ( global_connect() == 1 )
	{
		global_sendtoqueue( s_global_server_code, 0, 0, 0, "", 0 );
	}

	while( !g_bExit )
	{
		if( g_global_socket == INVALID_SOCKET || g_global_socket < 0 )
		{
			// ������ӶϿ�����Ҫ��������
#ifdef WIN32
			Sleep( 1000 );
#else
			sleep( 1 );
#endif
			if ( global_connect() == 1 )
			{
				global_sendtoqueue( s_global_server_code, 0, 0, 0, "", 0 );
			}
			continue;
		}
		if( g_bExit )
		{
			return -1;
		}
		if( g_global_socket < 0 )
		{
			continue;
		}
		if ( g_bServerIsInit == 0 )
		{
			continue;
		}
		// ��sock�ж����ݵ�������
		if( ( readsize = recv( g_global_socket, tmpbuf + nProcBytes, MAX_PACKAGE_SIZE - nProcBytes, 0 ) ) < 0 )
		{
#ifdef WIN32
			if( WSAETIMEDOUT == WSAGetLastError( ) )
			{
				continue;
			}
			// ���ӶϿ���(����������)
			write_netlog( "socket recv error, recv_proc errno = %d", WSAGetLastError( ) );
			global_closesock( );
#else
			global_closesock();
#endif
			continue;
		}
		else if( readsize == 0 )
		{
			// �ͻ��˶Ͽ�
			write_netlog( "1socket closed read == 0" );
			global_closesock( );
			continue;
		}
		nProcBytes += readsize;
		procsize = global_recv_package( tmpbuf, nProcBytes );
		if( procsize < 0 )
		{
			procsize = readsize;
			write_netlog( "socket closed procsize < 0 " );
			global_closesock( );
			continue;
		}
		if( procsize > 0 )
		{
			nProcBytes -= procsize;
			memmove( tmpbuf, tmpbuf + procsize, nProcBytes );
		}
	}
	return 0;
}

// �������ķ����߳�
int global_send_proc( )
{
	char send_buf[MAX_BUF_SIZE];
	int writesize;
	int writecount;
	char *buf;

	while( !g_bServerIsInit )
	{
#ifdef WIN32
		Sleep( 1000 );
#else
		sleep( 1 );
#endif
	}
	printf_msg( "global_send_proc is run!\n" );

	while( !g_bExit )
	{
		// ��ס��¼�Ķ��л���
		mmux_lock( g_global_send_mmux );
		while( g_global_send_queue.m_nQueueTail == g_global_send_queue.m_nQueueHead )
		{
			mcond_wait( g_pthr_send_global, g_global_send_mmux );
			if( g_bExit )
			{
				mmux_unlock( g_global_send_mmux );
				return 0;
			}
		}
		// �Ӷ�����ȡ��һ��
		writesize = g_global_send_queue.m_queue[g_global_send_queue.m_nQueueHead].buf_size + 16;
		*( (short *)send_buf ) = writesize-2;
		*((short *)(send_buf + 2)) = g_global_send_queue.m_queue[g_global_send_queue.m_nQueueHead].server_code;
		*((short *)(send_buf + 4)) = g_global_send_queue.m_queue[g_global_send_queue.m_nQueueHead].cmd;
		*((int *)(send_buf + 6)) = g_global_send_queue.m_queue[g_global_send_queue.m_nQueueHead].value[0];
		*((int *)(send_buf + 10)) = g_global_send_queue.m_queue[g_global_send_queue.m_nQueueHead].value[1];
		*((short *)(send_buf + 14)) = g_global_send_queue.m_queue[g_global_send_queue.m_nQueueHead].buf_size;
		memcpy( send_buf + 16, g_global_send_queue.m_queue[g_global_send_queue.m_nQueueHead].buf, g_global_send_queue.m_queue[g_global_send_queue.m_nQueueHead].buf_size );
		g_global_send_queue.m_nQueueHead++;
		if( g_global_send_queue.m_nQueueHead >= MAX_GLOBALQUEUENUM )
		{
			g_global_send_queue.m_nQueueHead = 0;
		}
		buf = send_buf;
		mmux_unlock( g_global_send_mmux );

		while( 1 )
		{
			writecount = send( g_global_socket, buf, writesize, 0 );
			if( writecount <= 0 )
			{
				break;
			}
			else
			{
				writesize -= writecount;
				if( writesize <= 0 )
				{
					break;
				}
				buf += writecount;
			}
		}
//		global_recv_proc( cmd, pstr );

	}

	printf_msg( "[thread]global Proc Exited.\n" );
	return 0;
}

// ���յĹ����߳�, �������Ϸ���̴�����Ĳ���, �����������Ƚ���, ����������ݴ�����Ӱ��, ���ٵĲ���Ӧ���ӵ�һ�����ٵĴ���������
//int global_work_proc( )
//{
//	int readsize;
//	char tmpbuf[MAX_PACKAGE_SIZE];
//
//	short server_code;
//	short cmd;
//	int value1;
//	int value2;
//
//	srand( (unsigned int)time( NULL ) );
//	while( g_pCallbackGlobalPack == NULL )
//	{
//		printf_msg( "g_pCallbackGlobalPack Is empty, Wait...\n" );
//#ifdef WIN32
//		Sleep( 1000 );
//#else
//		sleep( 1 );
//#endif
//	}
////	printf_msg( "recv_proc is run!\n" );
//
//	while( !g_bExit )
//	{
//		readsize = 0;
//		// ��ס���л���
//		mmux_lock( g_global_recv_mmux );
//		while( g_global_recv_queue.m_nQueueTail == g_global_recv_queue.m_nQueueHead )
//		{
//			mcond_wait( g_pthr_work_global, g_global_recv_mmux );
//			if( g_bExit )
//			{
//				mmux_unlock( g_global_recv_mmux );
//				write_netlog( "[thread]Recv Proc Exited." );
//				return 0;
//			}
//		}
//		// �Ӷ�����ȡ��һ��
//		memcpy( tmpbuf, g_global_recv_queue.m_queue[g_global_recv_queue.m_nQueueHead].buf, g_global_recv_queue.m_queue[g_global_recv_queue.m_nQueueHead].buf_size );
//		readsize = g_global_recv_queue.m_queue[g_global_recv_queue.m_nQueueHead].buf_size;
//		server_code = g_global_recv_queue.m_queue[g_global_recv_queue.m_nQueueHead].server_code;
//		cmd = g_global_recv_queue.m_queue[g_global_recv_queue.m_nQueueHead].cmd;
//		value1 = g_global_recv_queue.m_queue[g_global_recv_queue.m_nQueueHead].value[0];
//		value2 = g_global_recv_queue.m_queue[g_global_recv_queue.m_nQueueHead].value[1];
//
//		g_global_recv_queue.m_nQueueHead++;
//		if( g_global_recv_queue.m_nQueueHead >= MAX_GLOBALQUEUENUM )
//		{
//			g_global_recv_queue.m_nQueueHead = 0;
//		}
//		mmux_unlock( g_global_recv_mmux );
//		if ( g_pCallbackGlobalPack )
//		{
//			g_pCallbackGlobalPack( server_code, cmd, value1, value2, tmpbuf + 2, readsize - 2 );
//		}
//	}
//	write_netlog( "[thread]Global Worker Proc Exited." );
//	return 0;
//}
