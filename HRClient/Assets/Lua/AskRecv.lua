-- ͨ�ö���Ϣ����
NOTIFY_NORMAL = 0	-- ȱʡ������ʾ������˷�����

-- ������յ�����Ϣ
function RecvActorNotify(recvValue)
    local msgid = recvValue.m_msgid;
    local value = recvValue.m_value;
    local msg = recvValue.m_msg;
    
    if msgid == NOTIFY_NORMAL then
       MainDlgOnSetTestNum( value[1] )
		
    end
end
