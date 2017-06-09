--client_structrecv_auto.lua

function struct_NetS_Login_recv( buffer )
	local recvValue = {};
	recvValue.m_result = buffer:ReadInt();
	recvValue.m_username_length = buffer:ReadShort();
	recvValue.m_username = buffer:ReadStringWithLen( recvValue.m_username_length );
	recvValue.m_token_length = buffer:ReadShort();
	recvValue.m_token = buffer:ReadStringWithLen( recvValue.m_token_length );
	recvValue.m_usertype = buffer:ReadShort();
	return recvValue;
end

function struct_ListInfo_recv( buffer )
	local recvValue = {};
	recvValue.m_actorid = buffer:ReadInt();
	recvValue.m_name = buffer:ReadStringWithLen( 22 );
	recvValue.m_aclass = buffer:ReadSByte();
	recvValue.m_level = buffer:ReadShort();
	recvValue.m_offset = buffer:ReadSByte();
	recvValue.m_lockstat = buffer:ReadSByte();
	recvValue.m_delete_stoptime = buffer:ReadInt();
	recvValue.m_lock_endtime = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_List_recv( buffer )
	local recvValue = {};
	recvValue.m_actor_num = buffer:ReadSByte();
	recvValue.m_listinfo = {};
	for tmpi=1,recvValue.m_actor_num,1 do
		local tmpValue={};
		tmpValue = struct_ListInfo_recv( buffer );
		table.insert( recvValue.m_listinfo, tmpValue );
	end
	return recvValue;
end

function struct_NetS_Create_recv( buffer )
	local recvValue = {};
	recvValue.m_result = buffer:ReadSByte();
	recvValue.m_actorid = buffer:ReadInt();
	recvValue.m_createtime = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_EnterInfo_recv( buffer )
	local recvValue = {};
	recvValue.m_actorid = buffer:ReadInt();
	recvValue.m_data_int = buffer:ReadInt();
	recvValue.m_data_short = buffer:ReadShort();
	recvValue.m_data_char = buffer:ReadSByte();
	recvValue.m_serverid = buffer:ReadShort();
	recvValue.m_servertime = buffer:ReadInt();
	recvValue.m_createtime = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_Delete_recv( buffer )
	local recvValue = {};
	recvValue.m_result = buffer:ReadInt();
	recvValue.m_actorid = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_Heart_recv( buffer )
	local recvValue = {};
	recvValue.m_value={};
	for tmpi=1,2,1 do
		recvValue.m_value[tmpi] = buffer:ReadInt();
	end
	return recvValue;
end

function struct_NetS_Notify_recv( buffer )
	local recvValue = {};
	recvValue.m_msgid = buffer:ReadShort();
	recvValue.m_valuenum = buffer:ReadShort();
	recvValue.m_value={};
	for tmpi=1,recvValue.m_valuenum,1 do
		recvValue.m_value[tmpi] = buffer:ReadInt();
	end
	recvValue.m_msg_length = buffer:ReadShort();
	recvValue.m_msg = buffer:ReadStringWithLen( recvValue.m_msg_length );
	return recvValue;
end

function struct_NetS_ActorInfo_recv( buffer )
	local recvValue = {};
	recvValue.m_actorid = buffer:ReadInt();
	recvValue.m_name = buffer:ReadStringWithLen( 22 );
	recvValue.m_aclass = buffer:ReadSByte();
	recvValue.m_shape = buffer:ReadShort();
	recvValue.m_level = buffer:ReadShort();
	recvValue.m_experience = buffer:ReadLong();
	recvValue.m_experience_max = buffer:ReadLong();
	recvValue.m_token = buffer:ReadInt();
	recvValue.m_viplevel = buffer:ReadSByte();
	return recvValue;
end

function struct_Corrdinate_recv( buffer )
	local recvValue = {};
	recvValue.m_posx = buffer:ReadShort();
	recvValue.m_posy = buffer:ReadShort();
	return recvValue;
end

function struct_NetS_ItemUse_recv( buffer )
	local recvValue = {};
	recvValue.m_itemoffset = buffer:ReadShort();
	recvValue.m_usenum = buffer:ReadShort();
	recvValue.m_effres = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_ItemPut_recv( buffer )
	local recvValue = {};
	recvValue.m_res_offset = buffer:ReadShort();
	recvValue.m_res_num = buffer:ReadShort();
	recvValue.m_target_offset = buffer:ReadShort();
	recvValue.m_target_num = buffer:ReadShort();
	return recvValue;
end

function struct_NetS_ItemSettle_recv( buffer )
	local recvValue = {};
	recvValue.m_itemnum = buffer:ReadShort();
	recvValue.m_itemoffset={};
	for tmpi=1,recvValue.m_itemnum,1 do
		recvValue.m_itemoffset[tmpi] = buffer:ReadShort();
	end
	return recvValue;
end

function struct_NetS_LostItem_recv( buffer )
	local recvValue = {};
	recvValue.m_itemoffset = buffer:ReadShort();
	recvValue.m_itemnum = buffer:ReadShort();
	recvValue.m_targetid = buffer:ReadInt();
	recvValue.m_path = buffer:ReadSByte();
	return recvValue;
end

function struct_NetS_GetItem_recv( buffer )
	local recvValue = {};
	recvValue.m_itemoffset = buffer:ReadShort();
	recvValue.m_kind = buffer:ReadShort();
	recvValue.m_type = buffer:ReadShort();
	recvValue.m_color = buffer:ReadSByte();
	recvValue.m_num = buffer:ReadShort();
	recvValue.m_targetid = buffer:ReadInt();
	recvValue.m_path = buffer:ReadSByte();
	recvValue.m_situation = buffer:ReadByte();
	return recvValue;
end

function struct_ItemSmpInfo_recv( buffer )
	local recvValue = {};
	recvValue.m_offset = buffer:ReadShort();
	recvValue.m_kind = buffer:ReadShort();
	recvValue.m_num = buffer:ReadShort();
	recvValue.m_situation = buffer:ReadByte();
	recvValue.m_color_level = buffer:ReadSByte();
	return recvValue;
end

function struct_NetS_ItemList_recv( buffer )
	local recvValue = {};
	recvValue.m_itemext = buffer:ReadSByte();
	recvValue.m_kindnum = buffer:ReadShort();
	recvValue.m_item = {};
	for tmpi=1,recvValue.m_kindnum,1 do
		local tmpValue={};
		tmpValue = struct_ItemSmpInfo_recv( buffer );
		table.insert( recvValue.m_item, tmpValue );
	end
	return recvValue;
end

function struct_ItemAttr_recv( buffer )
	local recvValue = {};
	recvValue.m_type = buffer:ReadShort();
	recvValue.m_ability = buffer:ReadShort();
	recvValue.m_value = buffer:ReadInt();
	recvValue.m_addvalue = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_ItemInfo_recv( buffer )
	local recvValue = {};
	recvValue.m_itemoffset = buffer:ReadShort();
	recvValue.m_itemkind = buffer:ReadShort();
	recvValue.m_type = buffer:ReadShort();
	recvValue.m_level = buffer:ReadShort();
	recvValue.m_color_level = buffer:ReadSByte();
	recvValue.m_price = buffer:ReadInt();
	recvValue.m_attr_num = buffer:ReadShort();
	recvValue.m_attr = {};
	for tmpi=1,recvValue.m_attr_num,1 do
		local tmpValue={};
		tmpValue = struct_ItemAttr_recv( buffer );
		table.insert( recvValue.m_attr, tmpValue );
	end
	return recvValue;
end

function struct_HeroAttr_recv( buffer )
	local recvValue = {};
	recvValue.m_life = buffer:ReadInt();
	recvValue.m_attack = buffer:ReadInt();
	recvValue.m_defence = buffer:ReadInt();
	recvValue.m_precision = buffer:ReadUShort();
	recvValue.m_dodge = buffer:ReadUShort();
	recvValue.m_crit = buffer:ReadUShort();
	recvValue.m_crit_resist = buffer:ReadUShort();
	recvValue.m_crit_damage = buffer:ReadInt();
	recvValue.m_crit_damage_resist = buffer:ReadInt();
	recvValue.m_speed_attack = buffer:ReadUShort();
	recvValue.m_speed_move = buffer:ReadUShort();
	recvValue.m_ignore_defence = buffer:ReadUShort();
	recvValue.m_damage_increase = buffer:ReadInt();
	recvValue.m_damage_reduce = buffer:ReadInt();
	recvValue.m_skillid={};
	for tmpi=1,4,1 do
		recvValue.m_skillid[tmpi] = buffer:ReadShort();
	end
	return recvValue;
end

function struct_NetS_FightRoomActor_recv( buffer )
	local recvValue = {};
	recvValue.m_name_length = buffer:ReadSByte();
	recvValue.m_name = buffer:ReadStringWithLen( recvValue.m_name_length );
	recvValue.m_level = buffer:ReadShort();
	recvValue.m_actorid = buffer:ReadInt();
	recvValue.m_headid = buffer:ReadInt();
	recvValue.m_ready = buffer:ReadSByte();
	return recvValue;
end

function struct_NetS_FightRoomInfo_recv( buffer )
	local recvValue = {};
	recvValue.m_attack_actornum = buffer:ReadSByte();
	recvValue.m_attack_actorinfo = {};
	for tmpi=1,3,1 do
		local tmpValue={};
		tmpValue = struct_NetS_FightRoomActor_recv( buffer );
		table.insert( recvValue.m_attack_actorinfo, tmpValue );
	end
	recvValue.m_defense_actornum = buffer:ReadSByte();
	recvValue.m_defense_actorinfo = {};
	for tmpi=1,3,1 do
		local tmpValue={};
		tmpValue = struct_NetS_FightRoomActor_recv( buffer );
		table.insert( recvValue.m_defense_actorinfo, tmpValue );
	end
	recvValue.m_fightid = buffer:ReadInt();
	recvValue.m_pvpnum = buffer:ReadSByte();
	return recvValue;
end

function struct_NetS_FightRoomQuit_recv( buffer )
	local recvValue = {};
	recvValue.m_fightid = buffer:ReadInt();
	recvValue.m_actorid = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_FightRoomSetHero_recv( buffer )
	local recvValue = {};
	recvValue.m_fightid = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_FightRoomReady_recv( buffer )
	local recvValue = {};
	recvValue.m_fightid = buffer:ReadInt();
	recvValue.m_actorid = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_FightStart_recv( buffer )
	local recvValue = {};
	recvValue.m_fightid = buffer:ReadInt();
	recvValue.m_attack_godattr = struct_HeroAttr_recv( buffer );
	recvValue.m_defense_godattr = struct_HeroAttr_recv( buffer );
	recvValue.m_attack_godkind = buffer:ReadShort();
	recvValue.m_defense_godkind = buffer:ReadShort();
	recvValue.m_side = buffer:ReadSByte();
	recvValue.m_maxtime = buffer:ReadInt();
	recvValue.m_randseed = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_FightCommand_recv( buffer )
	local recvValue = {};
	recvValue.m_side = buffer:ReadSByte();
	recvValue.m_cmd = buffer:ReadSByte();
	recvValue.m_kind = buffer:ReadShort();
	recvValue.m_attr = struct_HeroAttr_recv( buffer );
	return recvValue;
end

function struct_NetS_FightTurns_recv( buffer )
	local recvValue = {};
	recvValue.m_turns = buffer:ReadInt();
	recvValue.m_count = buffer:ReadShort();
	recvValue.m_list = {};
	for tmpi=1,recvValue.m_count,1 do
		local tmpValue={};
		tmpValue = struct_NetS_FightCommand_recv( buffer );
		table.insert( recvValue.m_list, tmpValue );
	end
	return recvValue;
end

function struct_NetS_FightTimeout_recv( buffer )
	local recvValue = {};
	recvValue.m_fightid = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_AwardInfo_recv( buffer )
	local recvValue = {};
	recvValue.m_kind = buffer:ReadInt();
	recvValue.m_num = buffer:ReadInt();
	return recvValue;
end

function struct_NetS_AwardInfoList_recv( buffer )
	local recvValue = {};
	recvValue.m_count = buffer:ReadShort();
	recvValue.m_list = {};
	for tmpi=1,recvValue.m_count,1 do
		local tmpValue={};
		tmpValue = struct_NetS_AwardInfo_recv( buffer );
		table.insert( recvValue.m_list, tmpValue );
	end
	recvValue.m_callback_code = buffer:ReadShort();
	return recvValue;
end

function struct_NetS_Experience_recv( buffer )
	local recvValue = {};
	recvValue.m_addexp = buffer:ReadInt();
	recvValue.m_curexp = buffer:ReadLong();
	recvValue.m_isup = buffer:ReadSByte();
	recvValue.m_path = buffer:ReadShort();
	return recvValue;
end

function struct_NetS_Body_recv( buffer )
	local recvValue = {};
	recvValue.m_body = buffer:ReadShort();
	recvValue.m_addbody = buffer:ReadShort();
	recvValue.m_path = buffer:ReadInt();
	return recvValue;
end

