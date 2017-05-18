#ifndef WIN32
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
#endif // !WIN32

#include "http.h"

// http����
SOCKET HttpConnect( char *host, unsigned short port )
{
	SOCKET sock;
	struct sockaddr_in clientaddr;
	struct hostent *phe;
	memset( &clientaddr, 0, sizeof(clientaddr) );

	clientaddr.sin_family = AF_INET;

	if ( host == NULL )
		return INVALID_SOCKET;
	write_netlog( "HttpConnect:%s[%d]", host, port );
	if ( phe = gethostbyname( host ) )
	{
		memcpy( &clientaddr.sin_addr, phe->h_addr, phe->h_length );
	}
	else
	{
		if ( (clientaddr.sin_addr.s_addr = inet_addr( host )) == INADDR_NONE )
		{
			write_netlog( "HttpConnect:inet_addr error!" );
			return INVALID_SOCKET;
		}
		clientaddr.sin_addr.s_addr = inet_addr( host );
	}
	clientaddr.sin_port = htons( port );

	sock = socket( AF_INET, SOCK_STREAM, 0 );

	if ( connect( sock, (struct sockaddr *)&clientaddr, sizeof(clientaddr) ) < 0 )
	{
		write_netlog( "HttpConnect:connect error!" );
		return INVALID_SOCKET;
	}
	return sock;
}

// HTTP�ر�socket
void HttpClose( SOCKET socket )
{
	if ( socket == INVALID_SOCKET )
		return;
	shutdown( socket, 2 );
#ifdef WIN32
	closesocket( socket );
#else
	close( socket );
#endif
}

// �����������pSign==NULL������ȡ״̬���磺200��
// ���pSignΪָ������������outString�Լ�����ֵ����ֵ��
// ���pSignû�в�ѯ����������-1;
int HttpParse( char *stream, char *pSign, char *outString )
{
	int result;
	int sign_len;
	char tmpch;
	char *pstr, *ptail;
	if ( pSign == NULL )
	{
		pstr = (char *)strstr( stream, " " );	// "Http/1.1 200 OK"�еĿո�
		if ( pstr == NULL )
			return -1;
		pstr++;

		ptail = (char *)strstr( pstr, " " );
		if ( ptail == NULL )
		{
			ptail = (char *)strstr( pstr, "\r\n" );
			if ( ptail == NULL )
				return -1;
		}

		tmpch = *ptail;
		*ptail = 0;
		result = atoi( pstr );
		*ptail = tmpch;
		return result;
	}
	sign_len = (int)strlen( pSign );
	if ( sign_len <= 0 )
		return -1;

	pstr = stream;
	while ( pstr )
	{
		pstr = (char *)strstr( pstr, "\r\n" );
		if ( pstr == NULL )
			break;
		pstr += 2;
		if ( u_frontcmp( pstr, pSign ) )
			break;
	}
	if ( pstr == NULL )
		return -1;
	pstr += sign_len;

	for ( ; *pstr == ' ' || *pstr == '\t'; pstr++ );

	ptail = (char *)strstr( pstr, "\r\n" );
	if ( ptail == NULL )
		return -1;

	tmpch = *ptail;
	*ptail = 0;
	result = atoi( pstr );
	if ( outString )
		strcpy( outString, pstr );
	*ptail = tmpch;

	return result;

}

// ��β�����ݱ�ǽ���
int HttpGetPartTail( char *stream, char *pSign, char *outString )
{
	int result;
	int sign_len;
	char *pstr;
	if ( pSign == NULL )
	{
		return -1;
	}
	sign_len = (int)strlen( pSign );
	if ( sign_len <= 0 )
		return -1;

	pstr = (char *)strstr( stream, pSign );
	if ( pstr == NULL )
		return -1;
	pstr += sign_len;

	for ( ; *pstr == ' ' || *pstr == '\t'; pstr++ );

	result = atoi( pstr );
	if ( outString )
		strcpy( outString, pstr );

	return result;

}

// ��������
char *HttpGetHeaderEnd( char *stream )
{
	char *pstr;
	pstr = (char *)strstr( stream, "\r\n\r\n" );
	if ( pstr == NULL )
		return NULL;
	pstr += 4;
	return pstr;
}

// ����getָ��
int HttpGet( SOCKET socket, char *http_get, char *host )
{
	char buf[HTTPMAX_BUFFLEN + 1];
	int package_len;
	int packsize;
	int writesize;

	sprintf( buf, "GET %s HTTP/1.1\nHost: %s\nConnection: close\n\n", http_get, host );
	package_len = (int)strlen( buf );

	// ��ʼ����
	packsize = 0;
	while ( packsize < package_len )
	{
		if ( (writesize = send( socket, buf + packsize, package_len - packsize, 0 )) <= 0 )
		{
			// ���ӶϿ���(��Ҫ��������)
			HttpClose( socket );
			return -1;
		}
		packsize += writesize;
	}
	return 0;
}

// �ַ���ת��һ��
char *HttpString( const char *str, char *out )
{
	char tmpstr[16];
	out[0] = 0;
	for ( const char *p = str; *p != 0; p++ )
	{
		sprintf( tmpstr, "%%%.2X", *p );
		strcat( out, tmpstr );
	}
	return out;
}
