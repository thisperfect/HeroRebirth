-- 一个战场房间
FightRoom = class("FightRoom")
function FightRoom:ctor()
	self:Reset();
end

function FightRoom:Reset()
	-- 战场ID
	self.m_id				=	0;
		
	-- 攻方列表FightUnit
	self.m_attack_units		=	{};
	self.m_attack_unitnum 	=	0;
	
	-- 守方列表FightUnit
	self.m_defense_units	=	{};
	self.m_defense_unitnum 	=	0;
	
end

-- 帧逻辑
function FightRoom:Logic()
	for k, v in pairs( self.m_attack_units ) do
		v:Logic( self );
	end
	for k, v in pairs( self.m_defense_units ) do
		v:Logic( self );
	end
end

-- 帧逻辑
function FightRoom:Create()
	
end