-- ���߲���
ITEM_ABILITY_SCRIPTID				=	25	-- �ű�����ID

------------------------------------------------------------------ ���ߵĽű���������� ------------------------------------------------------------------------
function IN_UseItem( PlayerIdx, nMember, nItemIndex, nItemKind, nUseNum )
	local nID = c_item_get_ability_value( nItemKind, ITEM_ABILITY_SCRIPTID );
	if nID == 1 then
		
		
	elseif nID == 2 then
		
	elseif nID == 3 then
	
	end
	return nUseNum;
end
