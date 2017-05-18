HttpRequest = {};
local SECRET_KEY = "eye^20170517"

-- SDK获取用户信息
function HttpRequest.GetSDKUserInfo()
	local RequestTable = {
	c 			=	"userinfo",
	m 			=	"get",
	uid 		=	Const.sdk_uid,
	sign		=	Const.sdk_sign,
	timestamp	=	Const.sdk_timestamp,
	lang		=	DeviceHelper.getLanguage(),
	country		=	DeviceHelper.getCountry(),
	channelId	=	Const.sdk_channelId,
	os			=	Const.sdk_sysType,
	version		=	Application.version,
	platid		=	Const.platid,
	};
	HttpRequest.Get( RequestTable, HttpResponse.GetSDKUserInfo );
end

-- 获取服务器信息列表
function HttpRequest.GetServerList()
	local RequestTable = {
	c 			=	"serverinfo",
	m 			=	"getlist",
	uid 		=	Const.sdk_uid,
	country		=	DeviceHelper.getCountry(),
	channelId	=	Const.sdk_channelId,
	os			=	Const.sdk_sysType,
	platid		=	Const.platid,
	};
	HttpRequest.Get( RequestTable, HttpResponse.GetServerList );
end

-- 执行http get请求
-- 参数{c="serverinfo",m="getlist"}
function HttpRequest.Get( paramTable, callBack )
	local url = Global.GetValue("WEBCLI_URL");
	local paramString = HttpRequest.BuildParam( paramTable );
	local sign = Utils.md5( paramString..SECRET_KEY );
	url = url.."api.php?"..paramString.."&sign="..sign;
	print( url )
	-- 启动协程
	coroutine.start( function()
		local request = WWW( url );
		coroutine.www( request );
		if callBack ~= nil then
			callBack( tolua.tolstring( request.bytes ) );
		end
	end)
end

-- table转成k=v的httpget串
function HttpRequest.BuildParam( paramTable )
	local str = "";
	local frist = 0;
	for k, v in pairs(paramTable) do
		if frist == 0 then
			str = str..k.."="..v;
		else
			str = str.."&"..k.."="..v;
		end
		frist = 1;
	end
	return str;
end
