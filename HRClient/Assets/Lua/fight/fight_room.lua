-- 一个战场房间
FightRoom = class("FightRoom")
function FightRoom:ctor()
	self:Reset();
end

function FightRoom:Reset()
	self.m_id				=	0;	-- 战场ID
	self.m_turn				=	0;	-- 当前第几回合(N帧1个回合)
	self.m_auto_increment	=	1;	-- 自动增量，每增加一个单元自增
	
	-- 攻击方
	self.m_attack_op		=	Queue.new();	-- 同步到的操作队列
	self.m_attack_units		=	{};				-- 单元
	self.m_attack_unitnum 	=	0;				-- 单元总数量
	
	-- 防守方
	self.m_defense_op		=	Queue.new();
	self.m_defense_units	=	{};
	self.m_defense_unitnum 	=	0;	
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
function FightRoom:Create()
	
end

