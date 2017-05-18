-- 地图显示单元

-- 显示单元类型
MAPUNIT_TYPE_CITY		=	1	-- 城池
MAPUNIT_TYPE_ARMY		=	2	-- 部队
MAPUNIT_TYPE_RES		=	3	-- 资源点
MAPUNIT_TYPE_MONSTER	=	4	-- 怪物

-- 单只部队状态
ARMY_STATE_IDLE				=	0	-- 空闲

-- 行为
ARMY_ACTION_IDLE			=	0	-- 空闲


-- Prefab
local MapUnitCity 		= nil;
local MapUnitArmy 		= nil;
local MapUnitRes 		= nil;
local MapUnitMonster 	= nil;
local MapUnitInited		= false;

-- 显示单元集合
MapUnit = {};

-- 地图对象的根节点
MapUnit.unitRoot = nil;

-- 当前显示的单元对象缓存
MapUnit.cache = {};

-- 显示单元对象缓存池
-- 已经创建的，删除时不删，隐藏，下次无需创建直接拿来用
MapUnit.objectPoolCity 			= {}; 	-- 城池
MapUnit.objectPoolArmy 			= {}; 	-- 城池
MapUnit.objectPoolRes 			= {}; 	-- 资源田
MapUnit.objectPoolMonster 		= {}; 	-- 野怪


-- 初始化
function MapUnit.init()
	if MapUnitInited == false then
		-- 预置的初始化
--[[		MapUnitCity 		= LoadPrefab("MapUnitCity");
		MapUnitArmy 		= LoadPrefab("MapUnitArmy");
		MapUnitRes 			= LoadPrefab("MapUnitRes");
		MapUnitMonster 		= LoadPrefab("MapUnitMonster");--]]
		MapUnitInited 	= true;
	end
end

-- 清除
function MapUnit.clear()
	MapUnitCity 		= nil;
	MapUnitArmy 		= nil;
	MapUnitRes 			= nil;
	MapUnitMonster 		= nil;
	MapUnitInited		= false;
	MapUnit.unitRoot 	= nil;
	MapUnit.objectPoolCity 		= {};
	MapUnit.objectPoolArmy		= {};
	MapUnit.objectPoolRes 		= {};
	MapUnit.objectPoolMonster 	= {};
	MapUnit.cache 				= {};
end

-- 添加显示单元
function MapUnit.add( unitRoot, recvValue )
	local unit = nil;
	MapUnit.unitRoot = unitRoot;

	-- 城池
	if recvValue.m_type == MAPUNIT_TYPE_CITY then
		unit = MapUnit.createCity( recvValue );
		
	-- 部队
	elseif recvValue.m_type == MAPUNIT_TYPE_ARMY then
		unit = MapUnit.createArmy( recvValue )
		
	-- 资源
	elseif recvValue.m_type == MAPUNIT_TYPE_RES then
		unit = MapUnit.createRes( recvValue );
				
	-- 怪物	
	elseif recvValue.m_type == MAPUNIT_TYPE_MONSTER then
		unit = MapUnit.createMonster( recvValue );
		
	end
	
	-- 缓存起来，以便删除
	if unit ~= nil then
		unit.gameObject:SetActive( true );
		MapUnit.cache[recvValue.m_unit_index] = unit;
	end

    return unit;
end

-- 创建城池
function MapUnit.createCity( recvValue )
	
	return unitObj;
end


-- 创建部队
function MapUnit.createArmy( recvValue )
	
	return unitObj;
end

-- 创建资源点
function MapUnit.createRes( recvValue )
	
	return unitObj;
end

-- 创建野怪
function MapUnit.createMonster( recvValue )
	
	return unitObj;
end

-- 删除显示单元
function MapUnit.del( unit_index )
	local unit = MapUnit.cache[unit_index];
	if unit ~= nil then
		unit.gameObject:SetActive( false );
		MapUnit.cache[unit_index] = nil;
	end
end

-- 获取占地块
function MapUnit.typeTotype( recvValue )
	if recvValue.m_type == MAPUNIT_TYPE_ACTIVITY then
		if recvValue.m_char_value[5] then
			return -recvValue.m_char_value[5];
		end
	end
	return recvValue.m_type;
end

-- 获取占地块
function MapUnit.getGrid( unittype )
	-- 城池
	if unittype == MAPUNIT_TYPE_CITY then
		return 2;
	-- 部队
	elseif unittype == MAPUNIT_TYPE_ARMY then
		return 1;
	-- NPC
	elseif unittype == MAPUNIT_TYPE_RES then
		return 1;
	-- 怪物	
	elseif unittype == MAPUNIT_TYPE_MONSTER then
		return 1;
	elseif unittype == -2 then
		return 2;
	elseif unittype == -1 then
		return 1;
	end	
	return 1;
end

-- 根据占地块转换位置坐标
function MapUnit.getGridTrans( unittype, posx, posy )
	local grid = MapUnit.getGrid( unittype );
	if grid == 1 then
		return posx, posy - MAP_TILEHEIGHT/100/2;
	elseif grid == 2 then
		return posx + MAP_TILEWIDTH/100/2, posy - MAP_TILEHEIGHT/100/2;
	elseif grid == 3 then
		return posx, posy - MAP_TILEHEIGHT/100/2;
	end
	return posx, posy;
end
