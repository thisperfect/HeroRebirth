--  ��ɫ������Ϣ
local Player = class("Player");
function Player:ctor()
	self:Init();
end
function Player:Init()
	self.m_actorid			=	0;	-- ��ɫ���
	self.m_usertype			=	0;	-- �û�����
	self.m_aclass			=	0;	-- ��ɫ����
	self.m_shape			=	0;	-- ����
	self.m_level			=	0;	-- ����
	self.m_exp				=	0;	-- ����
	self.m_expmax			=	0;	-- �����
	self.m_viplevel 		=	0;  -- VIP�ȼ�
	self.m_vipexp 			=	0;  -- VIP����
	self.m_money			=	0;	-- ��Ǯ
	self.m_token			=	0;	-- ��ʯ
	self.m_createtime		=	0;	-- ����ʱ��
	self.m_name				=	"";	-- ��ɫ����
	self.m_config		    =   {};  --������Ϣ
end

-- ���Ա仯
function Player:Set( recvValue )
	self.m_actorid 			= 	recvValue.m_actorid;
	self.m_viplevel			=	recvValue.m_viplevel;
	self.m_name				=	recvValue.m_name;
	self.m_aclass			=	tonumber(recvValue.m_aclass);
	self.m_shape			=	recvValue.m_shape;
	self.m_level			=	recvValue.m_level;
	self.m_vipexp			=	recvValue.m_vipexp;
	self:ChangeToken( recvValue.m_exp, 0 )
	self:ChangeExp( recvValue.m_exp, recvValue.m_expmax, 0, 0 )
end

-- ��ʯ�ı�
-- EventProtocol.addEventListener( "ChangeToken", function( recvValue ) end )
function Player:ChangeToken( nValue, nPath )
	local oldValue = self.m_token;
	self.m_token = nValue;
	EventProtocol.dispatchEvent( "ChangeToken", { value=nValue, change=nValue-oldValue, path=nPath } );
end

-- ����ı�
-- EventProtocol.addEventListener( "ChangeExp", function( recvValue ) end )
function Player:ChangeExp( nValue, nMaxValue, bIsUp, nPath )
	local oldValue = self.m_exp;
	self.m_exp = nValue;
	if nMaxValue ~= 0 then
		self.m_expmax = nMaxValue;
	end
	EventProtocol.dispatchEvent( "ChangeExp", { value=nValue, maxvalue=self.m_expmax, change=nValue-oldValue, isup=bIsUp, path=nPath } );
end

-- ȫ��
G_Player = nil;
function GetPlayer()
	if G_Player == nil then
		G_Player = Player.new();
	end
	return G_Player;
end
