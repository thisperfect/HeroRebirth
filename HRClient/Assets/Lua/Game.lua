g_ipCountryStr = "us";

--游戏管理器--
GameManager = {};

GameManager.restart = false; -- 强制重启

-- 游戏脚本主逻辑入口
function GameManager.OnStart()
	LogUtil.GetInstance():WriteGame("GameManager.OnStart();begin");
	
	
	
	--[[coroutine.start( function()
		local request = WWW( "http://www.baidu.com" );
		coroutine.www( request )
		local s = tolua.tolstring( request.bytes )
		print(s:sub(1, 128));
	end)--]]
	print("www end");
	local recvValue = {
		m_map_width = 960,
		m_map_height = 960,
		m_area_width = 8,
		m_area_height = 8,
		m_map_area_xnum = 0,
		m_map_area_ynum = 0,
		m_my_city_posx = 480,
		m_my_city_posy = 480,
		m_my_city_unit_index = -1,
		m_citystate = 0,
		m_target_posx = -1,
		m_target_posy = -1
	}
	WorldMap.Init( recvValue );
	
	LoadPrefabAsyn( "WorldMap", function( obj )
		local _worldMapScence = GameObject.Instantiate( obj );
	end );
	
	LogUtil.GetInstance():WriteGame("GameManager.OnStart();end");
end

-- 游戏销毁
function GameManager.OnDestroy()	

end



-- 请求退出账号
function GameManager.Logout( voluntary )
	-- 1主动 0被动
	Global.AddValue("ISLOGOUT" , voluntary );
	--fruit.networkManager:Logout();
end


-- 主逻辑，1分钟一次
function GameManager.GameLogic()
	
end

-- 请求退出游戏
function GameManager.OnAskQuit()
   
    -- 没进游戏
    if Const.NetStatus < 3 then
        return;
    end

    -- 先关闭最后打开的界面
    if fruit.uiManager:CloseLast() then
        return;
    end

    
    --[[MsgBoxEx( GetLocalizeText( 507 ), GetLocalizeText( 508 ), nil, GetLocalizeText( 509 ), 
                function()
			        		Application.Quit() 
		        		end )--]]
end

-- 是否进入后台
GameManager.OnApplicationPauseTime = 0;
function GameManager.OnApplicationPause( paused )
	if paused == true then
		LogUtil.GetInstance():WriteGame( "OnApplicationPause: paused == true" );
	else
		LogUtil.GetInstance():WriteGame( "OnApplicationPause: paused == false" );
	end

	-- 进入后台
	if paused == true then

		GameManager.OnApplicationPauseTime = os.time();
	
	-- 从后台进入前台时
	else

		LogUtil.GetInstance():WriteGame( "PauseTime:"..GameManager.OnApplicationPauseTime.." os.time():"..os.time() );
		-- 检测是否断线
		if GameManager.OnApplicationPauseTime > 0 and os.time() - GameManager.OnApplicationPauseTime > 180 then
			
				if Const.NetStatus > 2 or GameManager.restart == true then
					Invoke( function() 
							fruit.uiManager:Clear();
							LoginModDestroy();
							SceneManager.LoadScene( "launcher" ); 
						end, 1/2 ); 
				end
				Const.NetStatus = 0;
		end
		GameManager.OnApplicationPauseTime = 0;
	end
	
end

-- 摇一摇
local m_WaveTime = 0;
function GameManager.GameWave()
	if os.time() - m_WaveTime <= 3 then
      return;
  end
  m_WaveTime = os.time();
end

-- 所有UI关闭事件
function GameManager.AllUIClose()
    --GetDialogQueue():Show();
end

-- 读取AssetBundle的回调
function GameManager.OnLoadAssetBundleProc( progress, totalProgress )

end

-- 远程推送
function GameManager.PushKey( key )
	local sendValue = {}
	sendValue.m_pushkey = key;
	sendValue.m_pushkey_len = string.len( sendValue.m_pushkey );
	netsend_pushkey_C( sendValue )
end
