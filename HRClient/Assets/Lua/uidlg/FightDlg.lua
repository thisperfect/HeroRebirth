-- 界面
local m_Dlg = nil;
local m_uiCountdown = nil; --UnityEngine.GameObject
local m_uiAttack = nil; --UnityEngine.GameObject
local m_uiDefense = nil; --UnityEngine.GameObject
local m_uiHeroList = nil; --UnityEngine.GameObject
local m_uiUIP_FightHero = nil; --UnityEngine.GameObject

-- 打开界面
function FightDlgOpen()
	m_Dlg = eye.uiManager:Open( "FightDlg" );
end

-- 隐藏界面
function FightDlgClose()
	if m_Dlg == nil then
		return;
	end
	
	eye.uiManager:Close( "FightDlg" );
end

-- 删除界面
function FightDlgDestroy()
	GameObject.Destroy( m_Dlg );
	m_Dlg = nil;
end

----------------------------------------
-- 事件
----------------------------------------

-- 所属按钮点击时调用
function FightDlgOnEvent( nType, nControlID, value, gameObject )
	if nType == UI_EVENT_CLICK then
        if nControlID == -1 then
            FightDlgClose();
        end
	end
end

-- 载入时调用
function FightDlgOnAwake( gameObject )
	-- 控件赋值	
	local objs = gameObject:GetComponent( typeof(UISystem) ).relatedGameObject;	
	m_uiCountdown = objs[0];
	m_uiAttack = objs[1];
	m_uiDefense = objs[2];
	m_uiHeroList = objs[3];
	m_uiUIP_FightHero = objs[4];
end

-- 界面初始化时调用
function FightDlgOnStart( gameObject )
	
end

-- 界面显示时调用
function FightDlgOnEnable( gameObject )
	
end

-- 界面隐藏时调用
function FightDlgOnDisable( gameObject )
	
end

-- 界面删除时调用
function FightDlgOnDestroy( gameObject )
	m_Dlg = nil;
end

-- 每帧调用
function FightDlgOnLogic( gameObject )
	
end


----------------------------------------
-- 自定
----------------------------------------
