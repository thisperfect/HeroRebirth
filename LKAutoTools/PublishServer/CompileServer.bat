rem �������ܣ���svn�еķ����������Լ�lua�ű��ϴ�������������101���б���

set SVN_HOST="https://192.168.16.102/svn/undead"
set LOCAL_PROJDIR="./undeadServer"
set REMOTE_IP="192.168.16.101"
set REMOTE_HOST="/192.168.16.101"

rem 1.�ȴ�svn�е������°汾���뵽����XxServerĿ¼
"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/undeadServer/GameServer/AutoS %LOCAL_PROJDIR%/project/GameServer/AutoS
"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/undeadServer/GameServer/include %LOCAL_PROJDIR%/project/GameServer/include
"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/undeadServer/GameServer/src %LOCAL_PROJDIR%/project/GameServer/src

"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/undeadServer/exec/script %LOCAL_PROJDIR%/exec/script

"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/LKEngine/LKNetServer/include %LOCAL_PROJDIR%/project/LKNetServer/include
"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/LKEngine/LKNetServer/src %LOCAL_PROJDIR%/project/LKNetServer/src

"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/LKEngine/LKUtils/include %LOCAL_PROJDIR%/project/LKUtils/include
"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/LKEngine/LKUtils/src %LOCAL_PROJDIR%/project/LKUtils/src

"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/LKEngine/Lua/src %LOCAL_PROJDIR%/project/Lua/src

"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/globalServer/GlobalServer/include %LOCAL_PROJDIR%/project/GlobalServer/include
"C:\Program Files\TortoiseSVN\bin\svn.exe" --force export %SVN_HOST%/globalServer/GlobalServer/src %LOCAL_PROJDIR%/project/GlobalServer/src

rem 2.ִ��ant�ű������ϴ�������
ant -buildfile	CompileServer.xml -verbose

pause