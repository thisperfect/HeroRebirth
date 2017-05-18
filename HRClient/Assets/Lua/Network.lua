-- 脚本网络部分
Network = {};
local this = Network;

-- 本地协议
Connect           = -101;	--连接服务器
ConnectFail		  = -102;	--连接服务器失败
Exception         = -103;	--异常掉线
Disconnect        = -104;	--正常断线

-- 当前网络场景
-- 0未联网状态 
-- 1已经与服务器建立连接
-- 2已接收加密秘钥等信息
-- 3已经进入游戏
Const.NetStatus = 0;

-- 登陆排队人数
Network.LoginUserNum = 0;

-- 第一次连接返回的数据
local m_recv_key = 0;
local m_send_key = 0;
local m_code_len = 0;
local m_value1 = 0;
local m_value2 = 0;
local m_value3 = 0;
local m_value4 = 0;

-- 处理逻辑消息总入口 --
function Network.OnSocket(cmd, buffer)
	LogUtil.GetInstance():WriteNet("calllua cmd="..cmd);
	if buffer == nil then
		LogUtil.GetInstance():WriteNet("buffer == nil Network.OnSocket("..cmd..")");
		return;
	end
	-- 本地发过来的连接成功,断开,异常的消息
	if cmd == Connect then 
		this.OnConnect();
		return;
	
	-- 连接失败
	elseif cmd == ConnectFail then
		this.OnConnectFail( buffer );
		Const.NetStatus = 0;
		return;
	
	-- 连接异常关闭
	elseif cmd == Exception then
		local err = buffer:ReadShort();
		local msg = buffer:ReadString();
		LogUtil.GetInstance():WriteNet("[OnException] error:"..err.." msg:"..msg);
		
		if Const.NetStatus == 3 or GameManager.restart == true then
			this.OnException();
		end
		Const.NetStatus = 0;
		return;
		
	-- 失去连接
	elseif cmd == Disconnect then
		local err = buffer:ReadShort();
		local msg = buffer:ReadString();
		LogUtil.GetInstance():WriteNet("[OnDisconnect] error:"..err.." msg:"..msg);
		if Const.NetStatus == 3 then
			this.OnDisconnect();
		end
		Const.NetStatus = 0;
		return;
	end
	
	-- 连接开始接受服务器发过来的版本秘钥等的信息
	if Const.NetStatus == 1 then
		if cmd == 2015 then
			buffer:ReadShort();
			local err_code = buffer:ReadInt();
			local m_send_key = buffer:ReadUInt();
			local m_recv_key = buffer:ReadUInt();
			local m_code_len = buffer:ReadInt();
			local m_value1 = buffer:ReadInt();
			local m_value2 = buffer:ReadInt();
			local m_value3 = buffer:ReadInt();
			local m_value4 = buffer:ReadInt();

			-- 已接收加密秘钥等信息
			Const.NetStatus = 2;

			-- 扔到全局变量
			Const.RecvKey = m_recv_key;
			Const.SendKey = m_send_key;
			
			-- 登陆
			if Const.platid > 10 then
				GameManager.SDKLogin();
			else
				GameManager.TestLogin();
			end
		end
		LogUtil.GetInstance():WriteNet("Const.NetStatus="..Const.NetStatus);
		return;
	end
	
	-- 普通游戏数据包
	local datasize = buffer:ReadShort();
	if in_proc_command_C( cmd, buffer ) == 0 then
		LogUtil.GetInstance():WriteNet("cmd not found:"..cmd);
	end

	-- 检查一下后面是否还有小数据包
	local buffersize = buffer:Len() - 4 - datasize;
	while buffersize > 0 do
		local cmd = buffer:ReadShort();
		local datasize = buffer:ReadShort();
		if in_proc_command_C( cmd, buffer ) == 0 then
			LogUtil.GetInstance():WriteNet("cmd not found:"..cmd);
		end
		buffersize = buffersize - 4 - datasize;
	end
end

-- 当连接建立时 --
function Network.OnConnect()
	LogUtil.GetInstance():WriteGame( "Network.OnConnect()" );
    if Const.NetStatus == 0 then
		-- 已建立连接
		Const.NetStatus = 1;
		-- 建立连接后，发送版本信息
		local buffer = ByteBuffer.New();
		local str = Global.GetValue( "GetDeviceDesc" );
		if str == "" then
			str = DeviceHelper.GetDeviceDesc();
			Global.AddValue( "GetDeviceDesc", str );
		end
		local str = "";
		local ver = string.split(Application.version, ".");
		if ver[1] == nil then
			buffer:WriteInt(1);
		else
			buffer:WriteInt(tonumber(ver[1]));
		end
		
		if ver[2] == nil then
			buffer:WriteInt(0);
		else
			buffer:WriteInt(tonumber(ver[2]));
		end
		
		if ver[3] == nil then
			buffer:WriteInt(1);
		else
			buffer:WriteInt(tonumber(ver[3]));
		end
		
		-- 系统类型
		buffer:WriteInt( tonumber(Const.sdk_sysType) );
		-- 平台
		buffer:WriteShort( Const.platid );
		-- 国籍
		buffer:WriteShort( Localization.countryID( Localization.currentCountry ) );
		-- 语言
		buffer:WriteShort( Localization.languageCustomID( Localization.currentLanguage ) );
		-- 无用
		buffer:WriteInt(0);
		-- 渠道信息
		if Const.sdk_channelId == "" then
			Const.sdk_channelId = 0;
		end
		buffer:WriteInt( tonumber(Const.sdk_channelId) );
		-- 详细设备信息
		buffer:WriteString( str.."|"..Const.sdk_channelId );
		
		LogUtil.GetInstance():WriteGame("fruit.networkManager:SendMessage(buffer);begin");
		fruit.networkManager:SendMessage(buffer);
		LogUtil.GetInstance():WriteGame("fruit.networkManager:SendMessage(buffer);end");
    end
end

-- 连接服务器失败 -- 
function Network.OnConnectFail( buffer )
	local err = buffer:ReadShort();
	local msg = buffer:ReadString();
	LogUtil.GetInstance():WriteNet("[OnConnectFail] error:"..err.." msg:"..msg);
	
	if Const.NetStatus < 2 then
--[[		if Const.platid > 10 then
			LoginModOpenSDKLoginActive( true );
		else
			LoginModOpenTestLogin();
		end--]]
	end

	Const.NetStatus = 0;	
	LoginModLoginQueue( false );
	LoginModWarning( T(501) );
end

-- 异常断线，需重连 
-- 向socket写入数据异常
function Network.OnException() 
	if Const.NetStatus > 2 or GameManager.restart == true then
		fruit.uiManager:Clear();
		LoginModDestroy();
		SceneManager.LoadScene( "launcher" );
	end
	Const.NetStatus = 0;
	
--[[    Alert( GetLocalizeText(502), GetLocalizeText(503), function()
		fruit.networkManager:SendConnect();
		WaitDlgOpen();
	end )--]]
end

-- 连接中断，或者被踢掉 --
-- 服务器发过来的包大小不对
function Network.OnDisconnect()
	if Const.NetStatus > 2 then
		fruit.uiManager:Clear();
		LoginModDestroy();
		SceneManager.LoadScene( "launcher" );
	end
	Const.NetStatus = 0;
	
--[[	Alert( GetLocalizeText(502), GetLocalizeText(503), function()
		fruit.networkManager:SendConnect();
		WaitDlgOpen();
	end )--]]
end

--  HTTP Response --
function Network.OnHttpResponse( err, response )
	--LogUtil.GetInstance():WriteGame( "response:"..response );
	
	-- 错误处理
	if err == 1 then
		return;
	end

	local json = require "cjson"
	local info = json.decode(response);
	if info == nil or info["cmd"] == nil then
		return;
	end
	local cmd = info["cmd"];
	
	-- SDK模式下的用户信息
	if cmd == "1" then
		LoginModSetLoadingProgress( 0, 3, 4 );
		LoginModLoginQueue( true );
		local serverid = info["s"];
		local host = info["h"];
		local port = info["p"];
		
		-- 是否入口关闭
		local closeserver = info["close"];
		if closeserver == nil then
			closeserver = 0;
		end
		
		-- android 限制资源版本
		local force_android_ver = info["force_android_ver"];
		if force_android_ver == nil then
			force_android_ver = 0;
		end
		
		-- ios限制资源版本
		local force_ios_ver = info["force_ios_ver"];
		if force_ios_ver == nil then
			force_ios_ver = 0;
		end
		
		-- IP所在国家
		if info["ipcountry"] ~= nil and info["ipcountry"] ~= "" then
			g_ipCountryStr = string.lower( info["ipcountry"] );
		end
		LogUtil.GetInstance():WriteGame( "ipcountry:"..g_ipCountryStr );
		
		Const.serverid = serverid;
		--LogUtil.GetInstance():WriteGame("Network.OnHttpResponse:host:"..host.." port:"..port.." close:"..closeserver.." force_ios_ver:"..force_ios_ver.." force_android_ver:"..force_android_ver.." nowver:"..Global.GetValue("RESOURCE_VERSION"));
		
		-- 强制更新版本
		local nowver = tonumber( Global.GetValue("RESOURCE_VERSION") );
		if tonumber(Const.sdk_sysType) == 1 and nowver <= tonumber(force_ios_ver) then
			Network.GetForceWarning();
			return;
		elseif tonumber(Const.sdk_sysType) == 2 and nowver <= tonumber(force_android_ver) then
			Network.GetForceWarning();
			return;
		end
		
		-- 维护中
		if tonumber(closeserver) == 1 then
			Network.GetNotice();
		else
			Network.SDKConnectServer( host, port );
		end
	
	-- 测试模式下的服务器列表
	elseif cmd == "2" then
		
		-- IP所在国家
		if info["ipcountry"] ~= nil and info["ipcountry"] ~= "" then
			g_ipCountryStr = string.lower( info["ipcountry"] );
		end
		LogUtil.GetInstance():WriteGame( "ipcountry:"..g_ipCountryStr );
		
		-- 服务器列表
		Cache.ServerInfo = info["list"];
		for i = 1, #Cache.ServerInfo, 1 do
			LoginModAddServer( i, Cache.ServerInfo[i]["n"] );
		end
		
		-- 当前已选择的服务器
		local serinfo = Cache.GetServerInfoByID( Data.userini:ReadValue( "LASTSERVERID", "" ) );
		if serinfo == nil then
			serinfo = Cache.GetServerInfoByID( info["default"] );
		end
		LoginModSetCurrentServer( serinfo["id"], serinfo["n"] );

		-- 自动登录
		if LoginModAutoLogin() < 0 then
			LoginModOpenTestLogin();
		end
		
	-- 获取维护公告
	elseif cmd == "3" then
		local notice = info["notice"];
		LoginModSetNotice( notice );
	
	-- 获取邮件标题
	elseif cmd == "4" then
		local notice = info["notice"];
		local mailid = tonumber(info["ext"]);
		local notice = string.split( notice, '|' );
		local title = ""
		local content = "";
		local gotoMarket = "";
		local ver = "";
		if notice[1] then
			title = notice[1];
		end
		if notice[2] then
			content = notice[2];
		end
		if notice[3] then
			ver = notice[3];
		end
			
		GetMail():RecvNotifyTitle( mailid, title, content, ver );

	-- 获取邮件内容
	elseif cmd == "5" then
		local content = info["notice"];
		local mailid = tonumber(info["ext"]);
		GetMail():RecvNotifyContent( mailid, content );
		
	-- 获取强制更新提示
	elseif cmd == "6" then
		local notice = info["notice"];
		LoginModSetNotice( notice );
	
	-- 获取服务器列表地图
	elseif cmd == "7" then
		Cache.SetServerList( info["list"] );
	
	-- 选择新服务器	
	elseif cmd == "8" then
		local serverid = tonumber( info["s"] );
		local host = info["h"];
		local port = info["p"];
		-- 是否入口关闭
		local closeserver = info["close"];
		if closeserver == nil then
			closeserver = 0;
		end

		if tonumber( closeserver ) == 0 and serverid > 0 then
			GameManager.Logout( 0 );
		end

    -- 翻译结果
    elseif cmd == "9" then
		local str = info["str"];
		local ext = info["ext"];
        -- 错误
--[[        if info["error_code"] ~= nil then
            LogUtil.GetInstance():WriteGame( "Translate Error:" .. info["error_msg"] );
            local msg = {};
            msg.error = info["error_msg"];
            msg.translation = "";
            EventProtocol.dispatchEvent("ChatTranslation",msg);
            return;
        end--]]
        local msg = {};
        msg.error = nil;
        msg.translation = str;
        msg.ext = ext;
        EventProtocol.dispatchEvent("ChatTranslation",msg);
        -- 结果
        -- print( info["trans_result"][1]["dst"] );   
		
	-- 获取夏日活动跨服排行榜信息
	elseif cmd == "10" then
		--info["list"]; 
		--{\"r\":$rank,\"sid\":\"$serverid\",\"aid\":$actorid,\"cid\":$cityid,\"n\":$name,\"hid\":\"$headid\",\"co\":\"$countryid\",\"f\":$flower}         
        SummerKingModSetAllServer( info );  
        SummerKingRankingModSeverInfo( info["list"] );
	
	-- 当前服务器候选人在全服排名	
	elseif cmd == "11" then
		--info["list"];
		-- {\"r\":$rank,\"cid\":$cityid}
        SummerKingModSetMySeverRank( info["list"] );
    end
end

-- SDK模式下连接服务器
function Network.SDKConnectServer( host, port )
	Const.SocketAddress = host;
	Const.SocketPort = port;
	fruit.networkManager:SendConnect();
end

-- 测试模式下连接服务器
function Network.TestConnectServer( id )
	local serinfo = Cache.GetServerInfoByID( id );
	if serinfo == nil then
		print( "Can't Find ServerID: " .. id );
        LoginModOpenTestLogin();
		return;
	end
	Const.SocketAddress = serinfo["h"];
	Const.SocketPort = serinfo["p"];
	if tonumber(serinfo["close"]) == 1 then
		Network.GetNotice();
	else
	print( Const.SocketAddress..":"..Const.SocketPort )
		fruit.networkManager:SendConnect();
	end
end

-- 检测收发包时间
function Network.Ping( state )
	-- 正常状态发ping包
	if state == 0 then
		if Const.NetStatus < 3 then
			if Novice_IsIn() == true then
				if MainDlgPing() then
					MainDlgPing().transform:GetComponent( "ShowPing" ):Response();
				end
			end
			return -1;
		end
		if fruit.scenceManager.cityScence == nil then
			return -1;
		end
		local sendValue = {};
		sendValue.m_time = 0;
		netsend_pingrequest_C( sendValue );

	-- 关闭网络不好提醒	
	elseif state == 1 then
		--WaitDlgClose();
		
	-- 显示网络不好提醒	
	elseif state == 2 and Novice_IsIn() == false and RecUtil.GetInstance():IsRec() then
		--WaitDlgOpen();
	end
	return 0;
end

