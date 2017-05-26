-- 界面
local m_Dlg = nil;
local m_uiButtonListB = nil; --UnityEngine.GameObject
local m_uiButtonListR = nil; --UnityEngine.GameObject
local m_uiShowButtonT = nil; --UnityEngine.GameObject
local m_uiShowButtonF = nil; --UnityEngine.GameObject
local testnum;

-- 打开界面
function MainDlgOpen()
	m_Dlg = eye.uiManager:Open( "MainDlg" );
end

-- 隐藏界面
function MainDlgClose()
	if m_Dlg == nil then
		return;
	end
	
	eye.uiManager:Close( "MainDlg" );
end

-- 删除界面
function MainDlgDestroy()
	GameObject.Destroy( m_Dlg );
	m_Dlg = nil;
end

----------------------------------------
-- 事件
----------------------------------------

-- 所属按钮点击时调用
function MainDlgOnEvent( nType, nControlID, value, gameObject )
	if nType == UI_EVENT_CLICK then
        if nControlID == -1 then
            MainDlgClose();
			
		-- 主按钮展开
		elseif nControlID == 1 then
			m_uiButtonListB:GetComponent( typeof(UITweenRectPosition) ):Play( true );
			m_uiButtonListR:GetComponent( typeof(UITweenRectPosition) ):Play( true );
			m_uiShowButtonT.gameObject:SetActive( false );
			m_uiShowButtonF.gameObject:SetActive( true );
			
		-- 主按钮缩回
		elseif nControlID == 2 then
			m_uiButtonListB:GetComponent( typeof(UITweenRectPosition) ):Play( false );
			m_uiButtonListR:GetComponent( typeof(UITweenRectPosition) ):Play( false );
			m_uiShowButtonT.gameObject:SetActive( true );
			m_uiShowButtonF.gameObject:SetActive( false );
		
		-- 
		elseif nControlID == 101 then
			
			
			
        end
	end
end

-- 载入时调用
function MainDlgOnAwake( gameObject )
	-- 控件赋值	
	local objs = gameObject:GetComponent( typeof(UISystem) ).relatedGameObject;	
	m_uiButtonListB = objs[0];
	m_uiButtonListR = objs[1];
	m_uiShowButtonT = objs[2];
	m_uiShowButtonF = objs[3];
	testnum = objs[4];
end

-- 界面初始化时调用
function MainDlgOnStart( gameObject )
	
end

-- 界面显示时调用
function MainDlgOnEnable( gameObject )
	
end

-- 界面隐藏时调用
function MainDlgOnDisable( gameObject )
	
end

-- 界面删除时调用
function MainDlgOnDestroy( gameObject )
	m_Dlg = nil;
end

-- 每帧调用
function MainDlgOnLogic( gameObject )
	
end


----------------------------------------
-- 自定
----------------------------------------
function MainDlgOnSetTestNum( value )
	if m_Dlg == nil then
		return
	end
	testnum:GetComponent( typeof(UIText) ).text = value;
end