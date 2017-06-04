-- 一个战场房间
-- PVE战场 客户端驱动战斗逻辑，所有运算均在客户端，战斗结束，客户端上报战斗结果，服务器返回战斗奖励，不考虑断线情况
-- PVP战场 服务器驱动每秒10次驱动一个会和客户端战斗逻辑，客户端每秒10次上传操作，客户端每秒30次检查帧队列里是否有帧驱动
-- 断线重连，服务器发送当前第几回合和之前的所有操作列表，客户端快速跟上。
-- 录像只记录玩家所有的操作，格式第几帧4字节操作1字节数据4字节
-- 属于乐观帧锁定，网速好的玩家不会有问题，网速不好的会觉得卡，一会又快速追上
FightRoom = class("FightRoom")
function FightRoom:ctor()
	self:Reset();
end

function FightRoom:Reset()
	self.m_fightid			=	0;				-- 战场ID
	self.m_maxtime			=	0;				-- 战场时间
	self.m_randseed			=	0;				-- 随机种子
	self.m_turns			=	0;				-- 当前第几回合(N帧1个回合)
	self.m_server_turns		=	0;				-- 当前第几回合(N帧1个回合)
	self.m_auto_increment	=	0;				-- 自动增量，每增加一个单元自增
	self.m_cmdqueue			=	Queue.new();	-- 服务器帧驱动队列
	self.m_side				=	0;				-- 我是攻击方1还是防御方-1
	
	-- 我方
	self.m_our_units		=	{};				-- 单元
	self.m_our_unitnum 		=	0;				-- 单元总数量
	self.m_our_god			=	nil;			-- 神邸
	
	-- 敌方
	self.m_enemy_units		=	{};
	self.m_enemy_unitnum 	=	0;	
	self.m_enemy_god		=	nil;
end

-- 帧驱动
function FightRoom:FrameDrive()
	while Queue.has( self.m_cmdqueue ) do
		local op = Queue.popFirst( self.m_cmdqueue );
		if op then
			FightRoom:Logic();
		end
	end
end

-- 回合逻辑
function FightRoom:Logic()
	-- 战斗单元逻辑
	for k, v in pairs( self.m_our_units ) do
		v:Logic();
	end
	for k, v in pairs( self.m_enemy_units ) do
		v:Logic();
	end
	self.m_our_god:Logic( self );
	self.m_enemy_god:Logic( self );
	self.m_turns = self.m_turns + 1;
end

function myrand( down, up )
end

-- 创建一个战场
function FightRoom:Create( recvValue )
	MainDlgClose();
	FightRoomSetHeroDlgClose();
	if GameManager.MainCityScence ~= nil then
		GameManager.MainCityScence.gameObject:SetActive( false );
	end
	self:Reset();
	self.m_fightid = recvValue.m_fightid;
	self.m_side = recvValue.m_side;
	self.m_maxtime = recvValue.m_maxtime;
	self.m_randseed = recvValue.m_randseed;
	custom.randseed( self.m_randseed );
	
	if self.m_side == 1 then
		-- 我是攻击方
	else
		-- 我是防御方
	end
	
	-- 战场
	GameManager.FightScence = GameObject.Instantiate( LoadPrefab( "FightScence" ) );
	GameManager.FightScence.transform:Find("Camera").localPosition = Vector3( 930, 0, -10000 );
	
	Invoke( function()
		GameManager.FightScence.transform:Find("Camera"):GetComponent( "FightCamera" ):TweenPosToInBound( Vector3( -930, 0, -10000 ), 1 );
	end, 1, param, "11111")
	
	Invoke( function()
		FightDlgShow();
		GameManager.FightScence.transform:GetComponent( "LockStepManager" ).enabled = true;
	end, 1, param, "22222")
	
	-- 我方神邸
	self.m_our_god = FightUnit.new();
	self.m_our_god:CreateGod( 1, 1, { m_life = 10000 } );
	self.m_our_god:Play( "wind_left_loop", 0 );
	self.m_our_god:SetPos( -1400, 0 );
	
	
	-- 敌方神邸
	self.m_enemy_god = FightUnit.new();
	self.m_enemy_god:CreateGod( -1, 1, { m_life = 10000 } );
	self.m_enemy_god:Play( "wind_left_loop", 0 );
	self.m_enemy_god:SetPos( 1400, 0 );
	
	-- 倒计时
	FightDlgChangeCountdown( self.m_maxtime - self.m_server_turns/3 );
	
	-- 血条
	FightDlgChangeOurLife( 10000, 10000 );
	FightDlgChangeEnemyLife( 10000, 10000 );
	
	
	GetFightRoom():AddUnit( {m_side = -1, m_kind = 1, m_offsetx = -200} )
	--GetFightRoom():AddUnit( {m_side = -1, m_kind = 2, m_offsetx = -400} )
	--GetFightRoom():AddUnit( {m_side = -1, m_kind = 3, m_offsetx = -600} )
end

-- 加入一个单元
function FightRoom:AddUnit( recvValue )
	local unitObj = FightUnit.new();		
	unitObj:Create( recvValue.m_side, recvValue.m_kind, {}, function() 
		unitObj:SetPos( -1400*recvValue.m_side + recvValue.m_offsetx, 0 );
		unitObj:ChangeState( 1 );
		if recvValue.m_side == self.m_side then
			-- 加入我方
			table.insert( self.m_our_units, unitObj );
		else
			-- 加入敌方
			table.insert( self.m_enemy_units, unitObj );
		end
	
	end );
end

-- 获取自动增量
function FightRoom:GetIncrement()
	self.m_auto_increment = self.m_auto_increment + 1;
	return self.m_auto_increment;
end

-- 全局
G_FightRoom = nil;
function GetFightRoom()
	if G_FightRoom == nil then
		G_FightRoom = FightRoom.new();
	end
	return G_FightRoom;
end

-- 战斗回合
function FightFrameTurn()
	GetFightRoom():Logic();
end

