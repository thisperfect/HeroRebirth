---------------------- UI�¼� ----------------------
UI_EVENT_CLICK 			    = 0;		-- UIButton����				�޲�
UI_EVENT_PRESS 			    = 1;		-- UIButton����				0 ���£�1 ̧��
UI_EVENT_INPUTSUBMIT	    = 2;		-- UIInputField�ύ			�޲�
UI_EVENT_TWEENFINISH	    = 3;		-- UITween�������			0 ���������1 ����
UI_EVENT_SCROLLDRAG		    = 4;		-- UIScrollRect�϶�			0 ��ʼ�϶���1 �϶��У�2 �����϶�
UI_EVENT_SLIDERVALUECHANGE  = 5;		-- UISliderֵ�ı�			slider valueֵ
UI_EVENT_CENTERCHILD	    = 6;		-- UIScrollRing�Ӿ���		��index
UI_EVENT_TIMECOUNTEND       = 7;        -- UITextTimeCountdown      ��ʱ����
UI_EVENT_DRAGSENSOR         = 8;        -- UIDragSensor��ק�¼�
UI_EVENT_RICHTEXTSETEND     = 9;        -- UIRcihText��ǵ��
UI_EVENT_RICHTEXTMASKCLICK  = 10;       -- UIRcihText��ǵ��
UI_EVENT_INPUTVALUECHANGED  = 11;       -- UIInputField�����޸�		��ǰinputfield����
UI_EVENT_TIMECOUNTCHANGED   = 12;       -- �����޸�
UI_EVENT_VOICE              = 13;       -- UIVoice
UI_EVENT_PUSHEVENT		    = 1000;		-- UIͨ���¼������붨�����¼�����			    ����

-- ���ֱ�
-- ��ȡ���ػ�����
function GetLocalizeText( id )
    if id == nil then
        return "";
    end
	return Localization.text( id );
end
function T( nameid )
    return GetLocalizeText( nameid );
end
