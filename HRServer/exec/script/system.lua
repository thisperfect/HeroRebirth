
local totle_minute;
function IN_GetCondSql( cond, sql )
	
end

-- ϵͳ����ʱִ��
function IN_Script_Init()
	math.randomseed(os.time())
	print( "global.actorlevel_max="..global.actorlevel_max )
end

-- ϵͳÿ����ִ��һ��
function IN_Script_Timer()
	--[[for i=0,g_itemkind_maxnum-1,1 do
		local pitem = g_itemkind[i];
		if pitem ~= nil then
			print( "kind=".. pitem.m_kind .."	ability0="..pitem.m_base_ability[0].."	ability1="..pitem.m_base_ability[1].."	value0="..pitem.m_base_value[0].."	value1="..pitem.m_base_value[1].." overlap="..pitem.m_overlap.."\n" );
		end
	end
	print( "g_itemkind_maxnum="..g_itemkind_maxnum.."\n" );--]]
end

-- ϵͳÿСʱִ��һ��
function IN_Script_Hour()

end

-- ����ִ��
function IN_OnClockProcess( hour )
	if hour == 3 then

	end
end

-- ϵͳʱ���ַ���
function IN_TimeString( timestamp )
	return os.date("%Y-%m-%d %X", timestamp), 0;
end

-- ϵͳGMָ��
function IN_Script_Command( v1, v2, v3, v4, msg, PlayerIdx )
	local temp = os.date("*t", os.time());
	
	if v1 == 1 then
		
	end
	return 0;
end

function IN_Script_Exec( id, value1, value2 )
	
end

