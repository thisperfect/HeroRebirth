-- ��ɫ����

-- ��ɫ�Ѿ�����
function IN_OnActorIn( PlayerIdx )
	
end

-- ��ȡ�ʼ���������
function IN_OnMailReadAttach( PlayerIdx, szAttach )
    local splits = string.split(szAttach,'@');
    for k, v in  pairs(splits) do
        local subSplits = string.split( v,',');
        if #subSplits == 2 then
			local kind = tonumber( subSplits[1] );
			local num = tonumber( subSplits[2] );
            c_award_getaward(PlayerIdx,kind,num,-1,PATH_MAIL_ATTACH);
            
        else
            -- �������ݳ��ִ���
            
        end
    end

    return 0;
end
