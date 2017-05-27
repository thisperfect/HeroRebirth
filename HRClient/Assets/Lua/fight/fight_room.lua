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
	self.m_id				=	0;	-- 战场ID
	self.m_turn				=	0;	-- 当前第几回合(N帧1个回合)
	self.m_auto_increment	=	1;	-- 自动增量，每增加一个单元自增
	self.m_cmdqueue		=	Queue.new();	-- 服务器帧驱动队列
	
	-- 攻击方
	self.m_attack_op		=	Queue.new();	-- 同步到的操作队列
	self.m_attack_units		=	{};				-- 单元
	self.m_attack_unitnum 	=	0;				-- 单元总数量
	
	-- 防守方
	self.m_defense_op		=	Queue.new();
	self.m_defense_units	=	{};
	self.m_defense_unitnum 	=	0;	
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
	
	-- 操作队列
	while Queue.has( self.m_attack_op ) do
		local op = Queue.popFirst( self.m_attack_op );
		if op then
			
		end
	end
	while Queue.has( self.m_defense_op ) do
		local op = Queue.popFirst( self.m_defense_op );
		if op then
			
		end
	end
	
	-- 战斗单元逻辑
	for k, v in pairs( self.m_attack_units ) do
		v:Logic( self );
	end
	for k, v in pairs( self.m_defense_units ) do
		v:Logic( self );
	end
	
	self.m_turn = self.m_turn + 1;
end

-- 创建一个战场
function FightRoom:Create( recvValue )
	MainDlgClose();
	FightRoomSetHeroDlgClose();
	GameManager.MainCityScence.gameObject:SetActive( false );
	LoadPrefabAsyn( "FightScence", function( obj )
			GameManager.FightScence = GameObject.Instantiate( obj );
		end );
end

-- 全局
G_FightRoom = nil;
function GetFightRoom()
	if G_FightRoom == nil then
		G_FightRoom = FightRoom.new();
	end
	return G_FightRoom;
end