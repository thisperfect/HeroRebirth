#include "share_memory.h"

/* ���������ڴ��� */
SM_HANDLE share_memory_create( SM_KEY key, unsigned int size )
{
#ifdef WIN32
	char keybuf[64];
	memset( keybuf, 0, 64 );
	sprintf( keybuf, "%d", key );
	return CreateFileMapping( (HANDLE)0xFFFFFFFFFFFFFFFF, NULL, PAGE_READWRITE, 0, size, keybuf );
#else
	SM_HANDLE smh = shmget( key, size, IPC_CREAT | IPC_EXCL | 0666 );
	//printf_msg( "handle = %d ,key = %d ,error: %d \r\n", smh, key, errno );
	return smh;
#endif
}

/* �򿪹����ڴ��� */
SM_HANDLE share_memory_open( SM_KEY key, unsigned int size )
{
#ifdef WIN32
	char keybuf[64];
	memset( keybuf, 0, 64 );
	sprintf( keybuf, "%d", key );
	return OpenFileMapping( FILE_MAP_ALL_ACCESS, TRUE, keybuf );
#else
	SM_HANDLE smh = shmget( key, size, 0 );
	//printf_msg( "handle = %d ,key = %d ,error: %d \r\n", smh, key, errno );
	return smh;
#endif
}

/* ӳ�乲���ڴ���*/
char* share_memory_mapping( SM_HANDLE smh )
{
#ifdef WIN32
	return (char*)MapViewOfFile( smh, FILE_MAP_ALL_ACCESS, 0, 0, 0 );
#else
	return  (char*)shmat( smh, NULL, 0 );
#endif
}

/* �ر�ӳ�乲���ڴ��� */
void share_memory_unmapping( char* memptr )
{
#ifdef WIN32
	UnmapViewOfFile( memptr );
#else
	shmdt( memptr );
#endif
}

/*	�رչ����ڴ��� */
void share_memory_close( SM_HANDLE smh )
{
#ifdef WIN32
	CloseHandle( smh );
#else
	shmctl( smh, IPC_RMID, 0 );
#endif
}
