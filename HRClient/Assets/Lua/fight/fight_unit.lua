-- 一个战场单元
heroprefab = {
[1] = "hero_brute_dragon",
[2] = "hero_centaur",
[3] = "hero_faith_healer",
[4] = "hero_orc_monk",
[5] = "hero_pirate",
[6] = "hero_polemaster",
[7] = "hero_shadow_assassin",
}

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
	self.m_obj				=	nil;-- 对象
	
	-- 基础属性
	self.m_life						=	0;	-- 当前生命值(固定数值)
	self.m_life_max					=	0;	-- 生命值(固定数值)
	self.m_attack					=	0;	-- 攻击(固定数值)
	self.m_defence					=	0;	-- 防御(固定数值)
	
	self.m_precision				=	0;	-- 命中率(百分比数值)
	self.m_dodge					=	0;	-- 闪避率(百分比数值)
	
	self.m_crit						=	0;	-- 暴击率(百分比数值)
	self.m_crit_resist				=	0;	-- 抗暴率(百分比数值)
	
	self.m_crit_damage				=	0;	-- 暴伤(固定数值)
	self.m_crit_damage_resist		=	0;	-- 暴伤减免(固定数值)
	
	self.m_speed_attack				=	0;	-- 攻速(固定数值)
	self.m_speed_move				=	0;	-- 移速(固定数值)
	
	self.m_ignore_defence			=	0;	-- 破击率(百分比数值)
	
	self.m_damage_increase			=	0;	-- 伤害加成
	self.m_damage_reduce			=	0;	-- 伤害减免
	
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

-- 回合逻辑
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
	self.m_id = id;
	self.m_kind = kind;
	LoadPrefabAsyn( heroprefab[kind], function( obj )
			self.m_obj = GameObject.Instantiate( obj );
			self.m_obj.transform:SetParent( GameManager.FightScence.transform:Find("Land").transform );
			self.m_obj.transform.localScale = Vector3.one;
			self.m_obj.transform:Find("armatureName"):GetComponent( "UnityArmatureComponent" ).animation:Play( "move", 0 );
		end );
end

-- 删除
function FightUnit:Delete()
	GameObject.Destroy( self.m_obj );
end

-- 添加Buff
function FightUnit:AddBuff( buff )
	table.insert( self.m_buffs, buff );
end

-- 添加事件
function FightUnit:AddEvent( event )
	table.insert( self.m_events, event );
end
