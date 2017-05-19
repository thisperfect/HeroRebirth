-- 一个战场单元
FightUnit = class("FightUnit")
function FightUnit:ctor()
	self:Reset();
end

function FightUnit:Reset()
	self.m_id				=	0;	-- 战场单元唯一标识ID
	self.m_kind				=	0;	-- 种类
	self.m_aclass			=	0;	-- 职业
	self.m_side				=	0;	-- 1攻击方 2防御方
	self.m_state			=	0;	-- 状态
	self.m_target			=	0;	-- 目标
	
	-- 基础属性
	self.m_life				=	0;	-- 当前生命值
	self.m_life_max			=	0;	-- 生命值
	self.m_attack			=	0;	-- 攻击
	self.m_defence			=	0;	-- 防御
	
	self.m_precision		=	0;	-- 命中
	self.m_dodge			=	0;	-- 闪避
	
	self.m_crit				=	0;	-- 暴击
	self.m_crit_resist		=	0;	-- 抗暴
	
	self.m_life_max			=	0;	-- 暴伤
	self.m_life_max			=	0;	-- 暴伤减免
	
	self.m_speed_attack		=	0;	-- 攻速
	self.m_speed_move		=	0;	-- 移速
	
	self.m_life_max			=	0;	-- 破击率
	self.m_life_max			=	0;	-- 破击强度
	
	self.m_damage_add		=	0;	-- 伤害加成
	self.m_damage_sub		=	0;	-- 伤害减免
	
	self.m_record_damage	=	0;  -- 数据统计 - 造成伤害
	self.m_record_bear		=	0;	-- 数据统计 - 承受伤害
	self.m_record_addhp		=	0;	-- 数据统计 - 治疗
	
	-- 拥有技能
	self.m_skills			=	{};
	-- 正在使用的技能
	self.m_useskill			=	0;
	
	-- BUFF
	self.m_buffs			=	{};
	-- 事件
	self.m_events			=	{};
end

-- 帧逻辑
function FightUnit:Logic()
	for k, v in pairs( self.m_buffs ) do
		v:Logic( self );
	end
	for k, v in pairs( self.m_events ) do
		v:Logic( self );
	end
end

-- 创建
function FightUnit:Create( id, kind, attr )
	
end

-- 删除
function FightUnit:Delete()
	
end

-- 添加Buff
function FightUnit:AddBuff( buff )
	table.insert( self.m_buffs, buff );
end

-- 添加事件
function FightUnit:AddEvent( event )
	table.insert( self.m_events, event );
end
