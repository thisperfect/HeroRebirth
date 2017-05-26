CC=g++
SRC = \
../AutoS/src/auto_actor.cpp \
../AutoS/src/auto_actor_hero.cpp \
../AutoS/src/auto_actor_item.cpp \
../AutoS/src/auto_data_item.cpp \
../AutoS/src/auto_data_paycountry.cpp \
../AutoS/src/auto_data_paygoods.cpp \
../AutoS/src/auto_data_platinfo.cpp \
../AutoS/src/auto_data_upgrade.cpp \
../AutoS/src/global_netrecv_auto.cpp \
../AutoS/src/global_netsend_auto.cpp \
../AutoS/src/global_process_auto.cpp \
../AutoS/src/global_structrecv_auto.cpp \
../AutoS/src/global_structsend_auto.cpp \
../AutoS/src/server_netrecv_auto.cpp \
../AutoS/src/server_netsend_auto.cpp \
../AutoS/src/server_process_auto.cpp \
../AutoS/src/server_structrecv_auto.cpp \
../AutoS/src/server_structsend_auto.cpp \
account.cpp \
activity.cpp \
actor.cpp \
actor_func.cpp \
actor_gmcmd.cpp \
actor_notify.cpp \
actor_send.cpp \
award.cpp \
client.cpp \
db.cpp \
dbredis.cpp \
fight.cpp \
gamelog.cpp \
gameproc.cpp \
global.cpp \
global_cmdqueue.cpp \
global_netprocess.cpp \
gmcmd.cpp \
item.cpp \
item_proc.cpp \
item_send.cpp \
login_net.cpp \
login_user.cpp \
main.cpp \
mem_dump.cpp \
script.cpp \
script_auto.cpp \
script_reg_auto.cpp \
system.cpp \
system_askinfo.cpp \
timecalc.cpp \
timegmcmd.cpp \
wqueue.cpp \


INCLUDE = -I ../include  -I ../AutoS/include -I  ../../LKUtils/include  -I ../../LKNetServer/include  -I ../../Lua/src  -I /usr/include/mysql  -I ../../hiredis_linux
LIBRARY = -L ../../../public/lib -L /usr/lib/mysql
OBJ = $(SRC:.cpp=.o)
LIB = -llua -llknet -llkutils -lmysqlclient -lhiredis -lpthread -ldl -lm
EXE = ../../../exec/hrserver
CFLAGS = -g
$(EXE) : $(OBJ)
	$(CC)  $(CFLAGS) $(INCLUDE) $(LIBRARY) -o $(EXE) $(CF) $(OBJ) $(LIB)


../AutoS/src/auto_actor.o: ../AutoS/src/auto_actor.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/auto_actor_hero.o: ../AutoS/src/auto_actor_hero.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/auto_actor_item.o: ../AutoS/src/auto_actor_item.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/auto_data_item.o: ../AutoS/src/auto_data_item.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/auto_data_paycountry.o: ../AutoS/src/auto_data_paycountry.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/auto_data_paygoods.o: ../AutoS/src/auto_data_paygoods.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/auto_data_platinfo.o: ../AutoS/src/auto_data_platinfo.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/auto_data_upgrade.o: ../AutoS/src/auto_data_upgrade.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/global_netrecv_auto.o: ../AutoS/src/global_netrecv_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/global_netsend_auto.o: ../AutoS/src/global_netsend_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/global_process_auto.o: ../AutoS/src/global_process_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/global_structrecv_auto.o: ../AutoS/src/global_structrecv_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/global_structsend_auto.o: ../AutoS/src/global_structsend_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/server_netrecv_auto.o: ../AutoS/src/server_netrecv_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/server_netsend_auto.o: ../AutoS/src/server_netsend_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/server_process_auto.o: ../AutoS/src/server_process_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/server_structrecv_auto.o: ../AutoS/src/server_structrecv_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
../AutoS/src/server_structsend_auto.o: ../AutoS/src/server_structsend_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $< -o $@
account.o: account.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
activity.o: activity.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
actor.o: actor.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
actor_func.o: actor_func.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
actor_gmcmd.o: actor_gmcmd.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
actor_notify.o: actor_notify.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
actor_send.o: actor_send.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
award.o: award.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
client.o: client.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
db.o: db.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
dbredis.o: dbredis.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
fight.o: fight.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
gamelog.o: gamelog.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
gameproc.o: gameproc.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
global.o: global.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
global_cmdqueue.o: global_cmdqueue.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
global_netprocess.o: global_netprocess.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
gmcmd.o: gmcmd.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
item.o: item.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
item_proc.o: item_proc.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
item_send.o: item_send.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
login_net.o: login_net.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
login_user.o: login_user.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
main.o: main.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
mem_dump.o: mem_dump.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
script.o: script.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
script_auto.o: script_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
script_reg_auto.o: script_reg_auto.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
system.o: system.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
system_askinfo.o: system_askinfo.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
timecalc.o: timecalc.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
timegmcmd.o: timegmcmd.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<
wqueue.o: wqueue.cpp 
	$(CC) $(CFLAGS) -c $(INCLUDE) $<


all: $(EXE)
clean :
	rm -f *.o
	rm -f ../AutoS/src/*.o
	rm -f $(EXE)
