
#define MAX_TIMER	16	// ����ʹ�õļ�ʱ���ĸ���

void init_timer();
void append_timer( void *proc, void *para, int speed );
void exit_timer();
int delete_timer( void *proc );


