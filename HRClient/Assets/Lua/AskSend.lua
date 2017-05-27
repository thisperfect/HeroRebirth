-- ͨ�ö���Ϣ����
ASKINFO_NORMAL		= 	0;
ASKINFO_FIGHTMATCH		= 	10;
ASKINFO_FIGHTROOMQUIT 	= 11;

function system_askinfo( msgid, msg, ... )
	-- δ������Ϸ��������ͨ�ö�Э��
	if Const.NetStatus < 3 then
		return
	end
	-- m_msgid=0,m_valuenum=0,m_value={}[m_valuenum],m_msg_length=0,m_msg="[m_msg_length]",
	local arg={...}
	local sendValue = {};
	sendValue.m_msgid = msgid;
	sendValue.m_msg = msg;
	sendValue.m_msg_length = string.len( sendValue.m_msg );
	sendValue.m_valuenum = #arg;
	sendValue.m_value={};
	for i,v in ipairs(arg) do
		sendValue.m_value[i] = v;
   	end	
	netsend_askinfo_C( sendValue );
end



-- ����Э������
-- ����һ����Ϣ��������ֻ�����ĵ��û�������Ϣ
function SubscribeCmd( cmd )
	system_askinfo( ASKINFO_SUBSCRIBE, "", 1, cmd );
end

-- ȡ������һ����Ϣ
function SubscribeCmdCancel( cmd )
	system_askinfo( ASKINFO_SUBSCRIBE, "", 2, cmd );
end
