#ifndef __HTTP_H_
#define __HTTP_H_

#include "utils.h"

#define  HTTPMAX_BUFFLEN 2048

// http����
SOCKET HttpConnect( char *host, unsigned short port );

// HTTP�ر�socket
void HttpClose( SOCKET socket );

// ������
int HttpParse( char *stream, char *pSign, char *outString );

// ��β�����ݱ�ǽ���
int HttpGetPartTail( char *stream, char *pSign, char *outString );

// ��������
char *HttpGetHeaderEnd( char *stream );

// ����getָ��
int HttpGet( SOCKET socket, char *http_get, char *host );

// �ַ���ת��һ��
char *HttpString( const char *str, char *out );

#endif

