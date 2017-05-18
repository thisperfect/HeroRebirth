-- 世界地图
MAP_TILEWIDTH 		= 256;	-- 一块格子有多少像素	
MAP_TILEHEIGHT 		= 128;	-- 一块格子有多少像素

TMX_WIDTH 			= 96;  -- 一块tmx地图大小
TMX_HEIGHT 			= 96;  -- 一块tmx地图大小

WORLDMAP_ZORDER_CLICKMOD	=	-10000; 	-- 点击地图选择框层级
WORLDMAP_ZORDER_MARCHROUTE	=	-20000;		-- 行军路线层级
WORLDMAP_ZORDER_ARMY		=	-20001;		-- 部队层级
WORLDMAP_ZORDER_CITYMOVE	=	-80000;		-- 部队层级
WORLDMAP_ZORDER_CAMERA		=	-100000;	-- 摄像机层级

WORLDMAP_MODE_NORMAL	=	0; -- 缺省模式
WORLDMAP_MODE_FOLLOW	=	1; -- 跟随模式
WORLDMAP_MODE_MOVECITY	=	2; -- 迁城模式

-- 世界地图
WorldMap = {}
WorldMap.m_nMaxWidth 			= 0;    -- 世界地图大小（格子数）
WorldMap.m_nMaxHeight 			= 0;    -- 世界地图大小（格子数）
WorldMap.m_nAreaWidth 			= 0;    -- 区域大小（一个区域几个地图格子）
WorldMap.m_nAreaHeight 			= 0;    -- 区域大小（一个区域几个地图格子）
WorldMap.m_nAreaXNum 			= 0;    -- 一个地图有多少区域
WorldMap.m_nAreaYNum 			= 0;    -- 一个地图有多少区域
WorldMap.m_nLastAreaIndex		= -1;   -- 上一次发送区域
WorldMap.m_nMapUnitList			= {};   -- 现实对象缓存链表
WorldMap.m_nMyCityPosx			= 0;    -- 玩家主城位置（格子）
WorldMap.m_nMyCityPosy			= 0;    -- 玩家主城位置（格子）
WorldMap.m_nMyCityCameraX 		= 0;    -- 玩家主城位置（屏幕坐标）
WorldMap.m_nMyCityCameraY		= 0;    -- 玩家主城位置（屏幕坐标）
WorldMap.m_nMyCityUnitIndex 	= -1;   -- 玩家主城的显示索引
WorldMap.m_nMyCityState			= 0;	-- 玩家主城状态
WorldMap.m_nLastCameraX 		= 0; 	-- 上次摄像机位置（屏幕坐标）
WorldMap.m_nLastCameraY			= 0; 	-- 上次摄像机位置（屏幕坐标）
WorldMap.m_nLastCameraGameX 	= -1; 	-- 上次摄像机位置（格子坐标）
WorldMap.m_nLastCameraGameY 	= -1; 	-- 上次摄像机位置（格子坐标）
WorldMap.m_nLastTouchGameCoorX 	= 0; 	-- 上次点击位置（格子）
WorldMap.m_nLastTouchGameCoorY	= 0; 	-- 上次点击位置（格子）
WorldMap.m_nLastTouchUnitIndex	= -1; 	-- 上次点击单位
WorldMap.m_nLastTouchArmyIndex	= -1; 	-- 上次点击部队
WorldMap.m_nLastGotoUnitIndex	= -1;	-- 等待跳转的索引
WorldMap.m_nLastGotoPosX		= -1;	-- 等待跳转的位置
WorldMap.m_nLastGotoPosY		= -1;	-- 等待跳转的位置
WorldMap.m_nMode 				= WORLDMAP_MODE_NORMAL;


local TmxShowThreshold = 24;
local TmxShowList = { 0, 0, 0, 0 };
local TmxLastList = { 0, 0, 0, 0 };
local m_LastPosX;
local m_LastPosY;
local m_Faded = false;
local m_FadeStopCount = 0;
 
-- 地图区域
Area = {}
-- 根据世界坐标获取区域编号
function Area.GetIndex( posx, posy )
	local areax, areay;
	if posx >= WorldMap.m_nMaxWidth then
		posx = WorldMap.m_nMaxWidth - 1;
	end
	if posy >= WorldMap.m_nMaxHeight then
		posy = WorldMap.m_nMaxHeight - 1;
	end
	areax = math.modf( (posx+1)/WorldMap.m_nAreaWidth );
	areay = math.modf( (posy+1)/WorldMap.m_nAreaHeight );
	return math.modf( areay*(WorldMap.m_nAreaXNum) + areax );
end

-- 显示单元创建队列
local procQueue = Queue.new();
-- 部队单拿出来一个队列
local procQueueArmy = Queue.new();
local m_updateWaitFrame = 0;

-- 地图对象组件
local WorldMapPrefab	= nil;	-- 地图根
local MapTmxRoot		= nil;	-- tmx地图根节点
MapUnitRoot				= nil;	-- 所有显示对象的根节点
local MapLineRoot		= nil;	-- 所有线根节点
local MapClickEffect	= nil;	-- 点击特效
local MapClickMod		= nil;	-- 操作界面
local MapCamera 		= nil;	-- 地图摄像机
local MapTmx            = {};   -- 地图池，只实例化4个

-- 世界地图信息设置-服务端发送来的
function WorldMap.Init( recvValue )	
	WorldMap.m_nMaxWidth			= 	recvValue.m_map_width;
	WorldMap.m_nMaxHeight			= 	recvValue.m_map_height;
	WorldMap.m_nAreaWidth			= 	recvValue.m_area_width;
	WorldMap.m_nAreaHeight			= 	recvValue.m_area_height;
	WorldMap.m_nAreaXNum			= 	recvValue.m_map_area_xnum;
	WorldMap.m_nAreaYNum			= 	recvValue.m_map_area_ynum;
	WorldMap.m_nMyCityPosx			= 	recvValue.m_my_city_posx;
	WorldMap.m_nMyCityPosy			= 	recvValue.m_my_city_posy;
	WorldMap.m_nMyCityUnitIndex 	= 	recvValue.m_my_city_unit_index;
	WorldMap.m_nMyCityState			=	recvValue.m_citystate;
	WorldMap.m_nLastAreaIndex 		= 	-1;
	WorldMap.m_nLastGotoPosX		= 	recvValue.m_target_posx;
	WorldMap.m_nLastGotoPosY		= 	recvValue.m_target_posy;
	WorldMap.m_nMapUnitList			= {};
	MapUnit.init();
end

function WorldMap.Clear()
	WorldMap.m_nLastAreaIndex = -1;
	WorldMap.m_nLastTouchArmyIndex = -1;
	WorldMap.m_nLastTouchUnitIndex = -1;
	WorldMap.m_nLastGotoUnitIndex = -1;
    WorldMap.m_nLastCameraGameX = -1;
    WorldMap.m_nLastCameraGameY = -1;
    WorldMap.m_nMapUnitList = {};
	WorldMap.QueueClear();
	MapUnit.clear();
	MapTile.clear();
	--MapMarchRoute.clear();
	--MapCityMove.close();
    --WorldMapDlgClose();
	MapUnitRoot = nil;
    MapCamera = nil;
    --ClubZone.Clear();
	--system_askinfo( ASKINFO_AREAENTER, "", WorldMap.m_nLastAreaIndex );
    
    m_LastPosX = nil;
    m_LastPosY = nil;
	TmxLastList = { 0, 0, 0, 0 };
	--collectgarbage("collect");
end

-- 确定哪个图显示
function WorldMap.RefreshShow( gamePosX, gamePosY )
    TmxShowList = { 0, 0, 0, 0 };

    -- 小格坐标
	local localPosX = math.floor( math.mod( gamePosX, TMX_WIDTH ) );
	local localPosY = math.floor( math.mod( gamePosY, TMX_HEIGHT ) );

    -- 哪格地图
    local mapX = math.floor( gamePosX / TMX_WIDTH );
    local mapY = math.floor( gamePosY / TMX_HEIGHT );
    TmxShowList[1] = { mapX, mapY };

    local index = 2;
    -- 判断小格地图边缘
    -- X轴
    if localPosX < TmxShowThreshold then
        TmxShowList[index] = { mapX - 1, mapY };
        index = index + 1;
    elseif localPosX > TMX_WIDTH - TmxShowThreshold then
        TmxShowList[index] = { mapX + 1, mapY };
        index = index + 1;
    end
    
    -- Y轴
    if localPosY < TmxShowThreshold then
        TmxShowList[index] = { mapX, mapY - 1 };
        index = index + 1;
    elseif localPosY > TMX_HEIGHT - TmxShowThreshold then
        TmxShowList[index] = { mapX, mapY + 1 };
        index = index + 1;
    end
    
    -- XY轴上下
    if localPosX < TmxShowThreshold and localPosY < TmxShowThreshold then
        TmxShowList[index] = { mapX - 1, mapY - 1 };
        index = index + 1;
    elseif localPosX > TMX_WIDTH - TmxShowThreshold and localPosY > TMX_HEIGHT - TmxShowThreshold then
        TmxShowList[index] = { mapX + 1, mapY + 1 };
        index = index + 1;
    end    

    -- XY轴左右
    if localPosX < TmxShowThreshold and localPosY > TMX_HEIGHT - TmxShowThreshold then
        TmxShowList[index] = { mapX - 1, mapY + 1 };
        index = index + 1;
    elseif localPosX > TMX_WIDTH - TmxShowThreshold and localPosY < TmxShowThreshold then
        TmxShowList[index] = { mapX + 1, mapY - 1 };
        index = index + 1;
    end

    -- 刷新地图位置
    local changed = false;
    for i = 1, 4, 1 do
        if TmxShowList[i] ~= 0 and TmxLastList[i] ~= 0 and TmxLastList[i][1] == TmxShowList[i][1] and TmxLastList[i][2] == TmxShowList[i][2] then
        elseif TmxShowList[i] ~= 0 then
            MapTmx[i]:SetActive( true );
            MapTmx[i].transform.localPosition = Vector3.New( WorldMap.m_nMaxWidth * MAP_TILEWIDTH / 2 / 100 +
                MAP_TILEWIDTH * TMX_WIDTH * ( TmxShowList[i][1] - TmxShowList[i][2] - 1 ) / 2 / 100,
                    - MAP_TILEHEIGHT * TMX_HEIGHT * ( TmxShowList[i][2] + TmxShowList[i][1] ) / 2 / 100, 0 );

            changed = true;
        else
            MapTmx[i]:SetActive( false );
            changed = true;
        end
    end

    if changed then
        TmxLastList = clone( TmxShowList );
    end
end
	
-- 世界地图启动
function WorldMap.Start( Prefab )
	-- 初始化根节点
	WorldMapPrefab	= Prefab;
    MapUnit.unitRoot = Prefab.transform:FindChild("MapUnitRoot");

	-- 获取组件
	MapTmxRoot				= WorldMapPrefab:GetComponent("Transform"):FindChild( "MapTmxRoot" );
	MapUnitRoot				= WorldMapPrefab:GetComponent("Transform"):FindChild( "MapUnitRoot" );
	MapLineRoot				= WorldMapPrefab:GetComponent("Transform"):FindChild( "MapLineRoot" );
	--MapClickEffect			= WorldMapPrefab:GetComponent("Transform"):FindChild( "MapClickEffect" );
	--MapClickMod				= WorldMapPrefab:GetComponent("Transform"):FindChild( "MapClickMod" );
	MapCamera				= WorldMapPrefab:GetComponent("Transform"):FindChild( "MapCamera" );
	
	-- 根据地图大小动态加载N*N个Tmx地图
	local TmxMapPrefab = LoadPrefab( "TmxMap" );

    -- 只实例化4个
    for i = 1, 4, 1 do
        MapTmx[i] = GameObject.Instantiate( TmxMapPrefab );
		MapTmx[i].transform:SetParent( MapTmxRoot );
		MapTmx[i].transform.localScale = Vector3.one;
        MapTmx[i].gameObject:SetActive( false );
    end
    
	-- 设置摄像机初始位置为我的城池
--[[	if Utils.byteAndOp( WorldMap.m_nMyCityState, CITY_STATE_KICK ) == CITY_STATE_KICK then
		-- 被击飞中
		WorldMap.CameraSetPosition( MAPUNIT_TYPE_CITY, WorldMap.m_nMyCityPosx, WorldMap.m_nMyCityPosy );
		system_askinfo( ASKINFO_WORLDMAP, "", 4, WorldMap.m_nMyCityPosx, WorldMap.m_nMyCityPosy, 3 );
		Notify( 62 );
	else--]]
		-- 存在
		WorldMap.m_nMyCityCameraX, WorldMap.m_nMyCityCameraY = WorldMap.ConvertGameToCamera( WorldMap.m_nMyCityPosx, WorldMap.m_nMyCityPosy );
		WorldMap.m_nMyCityCameraX, WorldMap.m_nMyCityCameraY = MapUnit.getGridTrans( MAPUNIT_TYPE_CITY, WorldMap.m_nMyCityCameraX, WorldMap.m_nMyCityCameraY );
			
		if WorldMap.m_nLastGotoPosX >=0 and WorldMap.m_nLastGotoPosY >= 0 then
			WorldMap.CameraSetPosition( MAPUNIT_TYPE_CITY, WorldMap.m_nLastGotoPosX, WorldMap.m_nLastGotoPosY );
		else
			-- 跳转到玩家城
			MapCamera.transform.position = Vector3.New( WorldMap.m_nMyCityCameraX, WorldMap.m_nMyCityCameraY, WORLDMAP_ZORDER_CAMERA );
		end
	--[[end--]]
	
	-- 边界
	--MapUnit.createRange( MAPUNIT_TYPE_CITY, 479, 480, 960, false );
	
	-- 初始化行军路线
	--MapMarchRoute.init( MapLineRoot );
	
	-- 初始化地图格子数据
	--MapTile.init();
	
	-- 请求出征队列
	--system_askinfo( ASKINFO_WORLDMAP, "", 2 );
		
	-- 返回地图数据给程序一份
	return WorldMap.m_nMaxWidth, WorldMap.m_nMaxHeight, MAP_TILEWIDTH, MAP_TILEHEIGHT
end


-- 摄像机坐标=》游戏坐标(菱形格)
function WorldMap.ConvertCameraToGame( cameraPosX, cameraPosY )
	local screen_x = math.modf(cameraPosX * 100) - WorldMap.m_nMaxWidth/2 * MAP_TILEWIDTH;
	local screen_y = math.modf(cameraPosY * 100) + WorldMap.m_nMaxHeight/2 * MAP_TILEHEIGHT;
	local logic_ptx = math.modf(screen_x - math.modf(MAP_TILEWIDTH*screen_y/MAP_TILEHEIGHT));
	local logic_pty = -math.modf(screen_x + math.modf(MAP_TILEWIDTH*screen_y/MAP_TILEHEIGHT));
	if logic_ptx < 0 then
		logic_ptx = logic_ptx - MAP_TILEWIDTH;
	end
	if logic_pty < 0 then
		logic_pty = logic_pty - MAP_TILEWIDTH;
	end
	local gameCoorX = math.modf(logic_ptx/MAP_TILEWIDTH) + WorldMap.m_nMaxWidth/2;
	local gameCoorY = math.modf(logic_pty/MAP_TILEWIDTH) + WorldMap.m_nMaxHeight/2;
	return gameCoorX, gameCoorY 
end

-- 游戏坐标(菱形格)=》摄像机坐标
function WorldMap.ConvertGameToCamera( gameCoorX, gameCoorY )
    if gameCoorX == nil then
        return;
    end
	local px  = ( MAP_TILEWIDTH/2/100 ) * ( gameCoorX - gameCoorY );
    local py  = 0 -( MAP_TILEHEIGHT/2/100 ) * ( gameCoorX + gameCoorY );
	return px + WorldMap.m_nMaxWidth*MAP_TILEWIDTH/2/100, py
end

-- 添加单元
function WorldMap.AddMapUnit( recvValue )

	-- 添加显示对象
	MapUnit.add( MapUnitRoot, recvValue );
	
	-- 添加格子数据
	MapTile.add( recvValue );
	
	-- 接收到的完整数据插入缓存
	WorldMap.m_nMapUnitList[recvValue.m_unit_index] = recvValue;
	
	-- 需要跳转
	if WorldMap.m_nLastGotoUnitIndex == recvValue.m_unit_index then
		WorldMap.OnSelect( MapUnit.cache[recvValue.m_unit_index], recvValue.m_posx, recvValue.m_posy, recvValue.m_unit_index );
		WorldMap.m_nLastGotoUnitIndex = -1;
	end
end

-- 移除单元
function WorldMap.DelMapUnit( recvValue )
	
	-- 移除显示对象
	MapUnit.del( recvValue.m_unit_index )
	
	-- 移除格子数据
	MapTile.del( WorldMap.m_nMapUnitList[recvValue.m_unit_index] )
	
	-- 移除接收到的缓存数据
	WorldMap.m_nMapUnitList[recvValue.m_unit_index] = nil;
	
	-- 如果正在显示操作界面
	if recvValue.m_unit_index == WorldMap.m_nLastTouchUnitIndex then
		--WorldMap.OnClickClose();
		WorldMap.m_nLastTouchUnitIndex = -1;
	end
end

-- 更新单元
function WorldMap.UpdateMapUnit( recvValue )
	
	-- 如果之前是部队，并且是驻扎状态，现在不驻扎了
	--[[local oldCache = WorldMap.m_nMapUnitList[recvValue.m_unit_index];
	if oldCache ~= nil and oldCache.m_type == MAPUNIT_TYPE_ARMY then
		if oldCache.m_state == ARMY_STATE_OCCUPY and recvValue.m_state ~= ARMY_STATE_OCCUPY then
			-- 移除格子数据
			MapTile.del( WorldMap.m_nMapUnitList[recvValue.m_unit_index] )
		end
	end--]]

	-- 添加
	WorldMap.AddMapUnit( recvValue );
	
	-- 如果正在显示操作界面
	--[[if recvValue.m_unit_index == WorldMap.m_nLastTouchUnitIndex then
		WorldMap.OnClickClose();
		GatherInfoDlgClose();
		MonsterInfoDlgClose();
		if oldCache ~= nil and oldCache.m_type == MAPUNIT_TYPE_ARMY then
			WorldMap.m_nLastTouchUnitIndex = -1;
		end
	end--]]
end

-- 移动单元
function WorldMap.MoveMapUnit( recvValue )
	if WorldMap.m_nMapUnitList[recvValue.m_unit_index] == nil then
		return;
	end
	-- 移除格子数据
	if WorldMap.m_nMapUnitList[recvValue.m_unit_index].m_type ~= MAPUNIT_TYPE_ARMY then
		MapTile.del( WorldMap.m_nMapUnitList[recvValue.m_unit_index] );
	end
    WorldMap.m_nMapUnitList[recvValue.m_unit_index].m_posx = recvValue.m_posx;
    WorldMap.m_nMapUnitList[recvValue.m_unit_index].m_posy = recvValue.m_posy;
	
	
	if WorldMap.m_nMapUnitList[recvValue.m_unit_index].m_type ~= MAPUNIT_TYPE_ARMY then
		-- 添加格子数据
		MapTile.add( WorldMap.m_nMapUnitList[recvValue.m_unit_index] );
		WorldMap.UpdateMapUnit( WorldMap.m_nMapUnitList[recvValue.m_unit_index] ); 
	end
end

-- 随机获取的单元
function WorldMap.RandMapUnit( recvValue )
	-- 接收到的完整数据插入缓存
	WorldMap.m_nMapUnitList[recvValue.m_unit_index] = recvValue;
	WorldMap.m_nLastTouchUnitIndex = recvValue.m_unit_index;
	if recvValue.m_type == MAPUNIT_TYPE_MONSTER then
		--MonsterInfoDlgOnClick( recvValue, true );
	elseif recvValue.m_type == MAPUNIT_TYPE_RES then
		WorldMap.GotoUnit( recvValue.m_unit_index );
	end
end

-- 帧逻辑
function WorldMap.Update()
	WorldMap.QueueFetchArmy();
	
	m_updateWaitFrame = m_updateWaitFrame + 1;
	if m_updateWaitFrame > 90 then
		if Queue.has( procQueue ) == false then
			--WorldMapDlgWaiting( false );
			return;
		end
	end

	-- 一帧创建一个对象
	WorldMap.QueueFetch();
end

--  每秒通知2次位置变化了-负责区域计算
function WorldMap.ViewChangeSec()
    --if MainDlgCutSceneIsPlaying() then
        --return;
    --end

	local cameraPosX = MapCamera:GetComponent("Transform").position.x;
	local cameraPosY = MapCamera:GetComponent("Transform").position.y;


	-- 坐标计算区域索引
	local gameCoorX, gameCoorY = WorldMap.ConvertCameraToGame( cameraPosX, cameraPosY );
    WorldMap.RefreshShow( gameCoorX, gameCoorY );

	local now_areaindex = Area.GetIndex( gameCoorX, gameCoorY );
	if now_areaindex < 0 or now_areaindex == WorldMap.m_nLastAreaIndex then
		return
	end
	
	WorldMap.m_nLastAreaIndex = now_areaindex;
	--system_askinfo( ASKINFO_AREAENTER, "", now_areaindex );
	--WorldMapDlgWaiting( true );
	m_updateWaitFrame = 0;
end

--  每秒通知30次位置变化了-负责距离和方位
function WorldMap.ViewChangeFrame()
    if MapCamera == nil then
        return;
    end

	local cameraPosX = MapCamera:GetComponent("Transform").position.x;
	local cameraPosY = MapCamera:GetComponent("Transform").position.y;
    
    m_LastPosX = cameraPosX;
    m_LastPosY = cameraPosY;
	
	-- 位置没变化就不计算了
	if cameraPosX == WorldMap.m_nLastCameraX and cameraPosY == WorldMap.m_nLastCameraY then
		return;
	end
	WorldMap.m_nLastCameraX = cameraPosX;
	WorldMap.m_nLastCameraY	= cameraPosY;
    -- 主城坐标
	local gameCoorX, gameCoorY = WorldMap.ConvertCameraToGame( cameraPosX, cameraPosY );
    WorldMap.m_nLastCameraGameX = gameCoorX;
    WorldMap.m_nLastCameraGameY = gameCoorY;
	
	-- 操作界面更新坐标
	--MapClickModCoordinate( gameCoorX, gameCoorY );
	
	-- 更新箭头朝向
    WorldMap.UpdateArrow();
end

-- 更新箭头朝向
function WorldMap.UpdateArrow()
    -- 刷新所有角色缩放
    --MapUnit.ResetScale( WorldMap.m_nLastCameraX, WorldMap.m_nLastCameraY );

    -- 箭头位置
	--local arrowPos = WorldMapDlgArrowPosition();
	-- 计算自己主城与当前视口中心的方位和距离
	local cityPos = cc.p( WorldMap.m_nMyCityCameraX, WorldMap.m_nMyCityCameraY );
	local cameraPos = cc.p( WorldMap.m_nLastCameraX, WorldMap.m_nLastCameraY );
	
	-- 转换成游戏坐标
	local cityGameCoorX, cityGameCoorY = WorldMap.ConvertCameraToGame( WorldMap.m_nMyCityCameraX, WorldMap.m_nMyCityCameraY );
	local cameraGameCoorX, cameraGameCoorY = WorldMap.ConvertCameraToGame( WorldMap.m_nLastCameraX, WorldMap.m_nLastCameraY );
	
	-- 距离
	local distance = math.sqrt( ( cameraGameCoorX - cityGameCoorX )*( cameraGameCoorX - cityGameCoorX ) + ( cameraGameCoorY - cityGameCoorY )*( cameraGameCoorY - cityGameCoorY ) );
	
	-- 角度
	--[[local o = cameraPos.x + arrowPos.x - cityPos.x;
	local a = cameraPos.y + arrowPos.y - cityPos.y;
	local angle = math.deg( math.atan( o/a ) );
	if a < 0 then
		if o < 0 then
			angle = 180 + math.abs(angle);
		else
			angle = 180 - math.abs(angle);
		end 
	end--]]
	
	--WorldMapDlgOnDirectionArrow( distance, 180-angle, cc.p( WorldMap.m_nLastCameraGameX, WorldMap.m_nLastCameraGameY ) );
end

-- 触发点击地图
function WorldMap.OnClick( obj, touchpos, unit_index )
	--[[if MapClickEffect.gameObject.activeSelf == true or MapClickMod.gameObject.activeSelf == true then
		WorldMap.OnClickClose();
		return;
	end--]]
	
	-- 屏幕坐标转换到世界坐标
	local touchpos = Camera.main:ScreenToWorldPoint( touchpos );
	local gameCoorX, gameCoorY = WorldMap.ConvertCameraToGame( touchpos.x, touchpos.y );
    if gameCoorX < 0 or gameCoorX >= WorldMap.m_nMaxWidth or
       gameCoorY < 0 or gameCoorY >= WorldMap.m_nMaxHeight then
       return;
    end

    --[[-- 如果在迁城状态则取消迁城
    if MapCityMove.enable and unit_index == -1 then
        MapCityMove.close();
        return;
    end--]]
	
	-- 选择
	WorldMap.OnSelect( obj, gameCoorX, gameCoorY, unit_index );
end

-- 选择单元
function WorldMap.OnSelect( unit, gameCoorX, gameCoorY, unit_index )
	if WorldMap.m_nMode == WORLDMAP_MODE_MOVECITY then
		return;
	end
	--[[if MapClickEffect.gameObject.activeSelf == true or MapClickMod.gameObject.activeSelf == true then
		WorldMap.OnClickClose();
	end--]]

	-- 只有army对象有触发器,并且只有移动中的才判定有效
	--[[if unit_index >= 0 then
		local recvValue = WorldMap.m_nMapUnitList[unit_index];
		if recvValue ~= nil then
			if recvValue.m_type == MAPUNIT_TYPE_ARMY then
				if recvValue.m_state == ARMY_STATE_GROUP_ING or recvValue.m_state == ARMY_STATE_MARCH or recvValue.m_state == ARMY_STATE_REBACK then
                    -- 播放音效
                    
					-- 记录点击的显示单元索引
					WorldMap.m_nLastTouchUnitIndex = unit_index;
					-- 记录点击的部队单元索引
					WorldMap.m_nLastTouchArmyIndex = recvValue.m_int_value[1];
					-- 	启动跟随
					WorldMap.StartFollow( unit_index );
					return;
				end
			end
		end
	end--]]
	
	-- 记录一下点击的坐标格子
	WorldMap.m_nLastTouchGameCoorX = gameCoorX;
	WorldMap.m_nLastTouchGameCoorY = gameCoorY;
	
	-- 游戏格子坐标转换成摄像机坐标
	local cameraPosX = 0;
	local cameraPosY = 0;
	
	-- 点击的格子是否有缓存数据
	unit_index = MapTile.get( gameCoorX, gameCoorY );  

    -- 其他
	if unit_index >= 0 then
		-- 接收数据
		local recvValue = WorldMap.m_nMapUnitList[unit_index];
		if recvValue == nil then
			return;
		end
		
		--[[-- 检查资源点采集等级,点击就提示
		if recvValue.m_type == MAPUNIT_TYPE_RES then
			local limitlevel = recvValue.m_char_value[3];
			if GetCity().BuildingList[1].m_level < -limitlevel then
				Notify( 173, { -limitlevel, GetResNameByType( recvValue.m_char_value[1] ) } )
				return;
			end
		end
	
		-- 设置缩放
		local grid = MapUnit.getGrid( MapUnit.typeTotype( recvValue ) );
		MapClickEffect.transform.localScale = Vector3.New( grid, grid, grid );--]]
		-- 转换中心坐标
		cameraPosX, cameraPosY = WorldMap.ConvertGameToCamera( recvValue.m_posx, recvValue.m_posy );
		cameraPosX, cameraPosY = MapUnit.getGridTrans( MapUnit.typeTotype( recvValue ), cameraPosX, cameraPosY );
	else
		-- 设置缩放
		--MapClickEffect.transform.localScale = Vector3.New( 1, 1, 1 );
		-- 转换中心坐标
		cameraPosX, cameraPosY = WorldMap.ConvertGameToCamera( gameCoorX, gameCoorY );
		cameraPosX, cameraPosY = MapUnit.getGridTrans( 0, cameraPosX, cameraPosY );
	end
	
	-- 记录点击的显示单元索引
	WorldMap.m_nLastTouchUnitIndex = unit_index;
	WorldMap.m_nLastTouchArmyIndex = -1;
	-- 选择框
	--MapClickEffect.transform.localPosition = Vector3.New( cameraPosX, cameraPosY, WORLDMAP_ZORDER_CLICKMOD );
	--MapClickEffect.gameObject:SetActive( true );
	
	-- 操作界面
	--[[local recvValue = WorldMap.m_nMapUnitList[unit_index];
	if recvValue then
		if recvValue.m_type == MAPUNIT_TYPE_ARMY then
			WorldMap.m_nLastTouchArmyIndex = recvValue.m_int_value[1];
		
		-- 野怪
		elseif recvValue.m_type == MAPUNIT_TYPE_MONSTER then
			MonsterInfoDlgOnClick( recvValue ,false );
			return;	
				
		-- 活动怪
		elseif recvValue.m_type == MAPUNIT_TYPE_ACTIVITY then
			local type = recvValue.m_char_value[4];
			local activityid = recvValue.m_char_value[6];
				
			-- 集结野怪
			if type == 2 then
				DragonInfoDlgOnClick( recvValue );
				
			-- 交谈类
			elseif type == 3 then
				SnowDenDlgOnClick( recvValue );
			end
			return;	
		end
	end
	
	-- 操作框
	MapClickMod.transform.localPosition = Vector3.New( cameraPosX, cameraPosY, WORLDMAP_ZORDER_CLICKMOD );
	MapClickMod.gameObject:SetActive( true );--]]
end

-- 关闭操作界面
function WorldMap.OnClickClose()
	--[[if MapClickEffect ~= nil and MapClickEffect.gameObject ~= nil then
		MapClickEffect.gameObject:SetActive( false );
	end
	if MapClickMod ~= nil and MapClickMod.gameObject ~= nil then
		MapClickMod.gameObject:SetActive( false );
	end
	WorldMap.StopFollow();--]]
end

-- 触发拖拽对象
function WorldMap.OnDrag( touchpos )
	--MapCityMove.OnDrag( touchpos )
end

-- 设置摄像机位置
function WorldMap.CameraSetPosition( unittype, gameCoorX, gameCoorY )
	-- 位置
    local cameraPosX, cameraPosY = WorldMap.ConvertGameToCamera( gameCoorX, gameCoorY );
	local posx, posy = MapUnit.getGridTrans( unittype, cameraPosX, cameraPosY );
	if MapCamera then
		MapCamera.transform.position = Vector3.New( posx, posy, WORLDMAP_ZORDER_CAMERA );
		WorldMap.m_nLastCameraX 	 = posx;
		WorldMap.m_nLastCameraY		 = posy;
		WorldMap.m_nLastCameraGameX  = gameCoorX;
		WorldMap.m_nLastCameraGameY  = gameCoorY;
	end

    WorldMap.RefreshShow( gameCoorX, gameCoorY );
    
    m_LastPosX = nil;
    m_LastPosY = nil;
end

-- 摄像机滑动至
function WorldMap.TweenPosition( unittype, gameCoorX, gameCoorY, time )
	-- 位置
    local cameraPosX, cameraPosY = WorldMap.ConvertGameToCamera( gameCoorX, gameCoorY );
	local posx, posy = MapUnit.getGridTrans( unittype, cameraPosX, cameraPosY );
	if MapCamera then
		MapCamera:GetComponent( "Camera2D" ):TweenPosTo( Vector3.New( posx, posy, WORLDMAP_ZORDER_CAMERA ), time );
		WorldMap.m_nLastCameraX 	 = posx;
		WorldMap.m_nLastCameraY		 = posy;
		WorldMap.m_nLastCameraGameX  = gameCoorX;
		WorldMap.m_nLastCameraGameY  = gameCoorY;
	end
end

-- 跳转到unit位置
function WorldMap.GotoUnit( unit_index )
	--[[local recvValue = WorldMap.m_nMapUnitList[unit_index];
	if recvValue == nil then
		system_askinfo( ASKINFO_WORLDMAP, "", 6, unit_index );
	else
		WorldMap.CameraSetPosition( recvValue.m_type, recvValue.m_posx, recvValue.m_posy );
		WorldMap.OnSelect( MapUnit.cache[unit_index], recvValue.m_posx, recvValue.m_posy, unit_index );
	end
    
    m_LastPosX = nil;
    m_LastPosY = nil;--]]
end

-- 服务器发回的到unit位置
function WorldMap.GotoUnitAsyn( recvValue )
	WorldMap.m_nLastGotoUnitIndex = recvValue.m_unit_index;
	WorldMap.CameraSetPosition( recvValue.m_type, recvValue.m_posx, recvValue.m_posy );
end

-- 跳转到位置
function WorldMap.GotoCoor( gameCoorX, gameCoorY )
--[[	if GameManager.currentScence == "city" then
		system_askinfo( ASKINFO_WORLDMAP, "", 13, gameCoorX, gameCoorY );
    elseif GameManager.currentScence == "worldmap" then
		WorldMap.CameraSetPosition( MAPUNIT_TYPE_CITY, gameCoorX, gameCoorY );
		--WorldMap.ViewChangeSec();
	end
    
    m_LastPosX = nil;
    m_LastPosY = nil;--]]
end

-- 开启摄像机跟随模式
function WorldMap.StartFollow( unit_index )
--[[    if WorldMap.m_nMode == WORLDMAP_MODE_NORMAL then
		local unit = MapUnit.cache[unit_index];
		if unit == nil then
			return;
		end
		
		-- 操作界面跟随
		MapClickMod.gameObject:SetActive( true );	
        MapClickMod.transform:SetParent( unit.transform );
		MapClickMod.transform.localPosition = Vector3.New( 0, 0, WORLDMAP_ZORDER_CLICKMOD );
        MapClickMod.transform.localScale = Vector3.New( 0.01, 0.01, 1 );
		
		-- 摄像机跟随
        local unitPos = unit.transform.position;
        MapCamera.transform.position= Vector3.New( unitPos.x, unitPos.y, WORLDMAP_ZORDER_CAMERA );
        MapCamera.transform:SetParent( unit.transform );
        MapCamera:GetComponent("WorldMapCamera").IsCanMoved = false;
		
		WorldMap.m_nMode = WORLDMAP_MODE_FOLLOW;
    end--]]
end

-- 关闭跟随模式
function WorldMap.StopFollow()

--[[	-- 操作界面停止跟随
	MapClickMod.transform:SetParent( WorldMapPrefab.transform );
	MapClickMod.transform.localPosition = Vector3.New( 0, 0, WORLDMAP_ZORDER_CLICKMOD );
	
	-- 摄像机停止跟随
	MapCamera.transform:SetParent( WorldMapPrefab.transform );
	MapCamera:GetComponent("WorldMapCamera").IsCanMoved = true;
	
	WorldMap.m_nMode = WORLDMAP_MODE_NORMAL;
--]]
end

-- 返回选择特效
function WorldMap.ClickEffect()
	return MapClickEffect
end
function WorldMap.MapClickMod()
	return MapClickMod;
end

-- 添加到创建队列
function WorldMap.QueueAdd( operation, recvValue )
	
	local unittype = 0;
	if operation == 1 then
		
		unittype = recvValue.m_type;
		
	elseif operation == 2 then
	
		local unit = WorldMap.m_nMapUnitList[recvValue.m_unit_index];
		if unit then
			unittype = unit.m_type;
		end
		
	elseif operation == 3 then
	
		unittype = recvValue.m_type;
		
	elseif operation == 4 then
	
		local unit = WorldMap.m_nMapUnitList[recvValue.m_unit_index];
		if unit then
			unittype = unit.m_type;
		end
		
	end
	
	if unittype == MAPUNIT_TYPE_ARMY then
		Queue.pushBack( procQueueArmy, { op=operation, value = recvValue } );
	else
		Queue.pushBack( procQueue, { op=operation, value = recvValue } );
	end
	
	m_updateWaitFrame = m_updateWaitFrame - 1;
	if m_updateWaitFrame < 0 then
		m_updateWaitFrame = 0;
	end
end

-- 清空创建队列
function WorldMap.QueueClear()
	Queue.clear( procQueue );
	Queue.clear( procQueueArmy );
end

-- 创建队列取出一项
function WorldMap.QueueFetch()
	
	-- 普通对象
	for tmpi=1, 3, 1 do
		local v = Queue.popFirst( procQueue );
		if v == nil then
			return;
		end
		if v.op == 1 then
			WorldMap.AddMapUnit( v.value );
		elseif v.op == 2 then
			WorldMap.DelMapUnit( v.value );
		elseif v.op == 3 then
			WorldMap.UpdateMapUnit( v.value );
		elseif v.op == 4 then
			WorldMap.MoveMapUnit( v.value );
		elseif v.op == 5 then
			MapMarchRoute.add( v.value );
		elseif v.op == 6 then
			MapMarchRoute.del( v.value );
		end
		m_updateWaitFrame = m_updateWaitFrame + 1;
	end
	
end

-- 创建队列取出一项
function WorldMap.QueueFetchArmy()
	
	-- 部队对象
	for tmpi=1, 3, 1 do
		local v = Queue.popFirst( procQueueArmy );
		if v == nil then
			return;
		end
		if v.op == 1 then
			WorldMap.AddMapUnit( v.value );
		elseif v.op == 2 then
			WorldMap.DelMapUnit( v.value );
		elseif v.op == 3 then
			WorldMap.UpdateMapUnit( v.value );
		elseif v.op == 4 then
			WorldMap.MoveMapUnit( v.value );
		end
	end
	
end

-- 获得摄像机
function WorldMap.GetCamera()
    return MapCamera;
end
