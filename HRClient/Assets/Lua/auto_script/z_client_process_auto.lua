--client_process_auto.lua

-- m_result=0,m_username_length=0,m_username="[m_username_length]",m_token_length=0,m_token="[m_token_length]",m_usertype=0,
function proc_login_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_login_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_login_C", recvValue );
end

-- m_actor_num=0,m_listinfo={m_actorid=0,m_name="[22]",m_aclass=0,m_level=0,m_offset=0,m_lockstat=0,m_delete_stoptime=0,m_lock_endtime=0,[m_actor_num]},
function proc_list_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_list_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_list_C", recvValue );
end

-- m_result=0,m_actorid=0,m_createtime=0,
function proc_create_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_create_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_create_C", recvValue );
end

-- m_actorid=0,m_data_int=0,m_data_short=0,m_data_char=0,m_serverid=0,m_servertime=0,m_createtime=0,
function proc_enterinfo_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_enterinfo_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_enterinfo_C", recvValue );
end

-- m_result=0,m_actorid=0,
function proc_delete_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_delete_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_delete_C", recvValue );
end

-- m_value={[2]},
function proc_heart_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_heart_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_heart_C", recvValue );
end

-- m_msgid=0,m_valuenum=0,m_value={}[m_valuenum],m_msg_length=0,m_msg="[m_msg_length]",
function proc_notify_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_notify_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_notify_C", recvValue );
end

-- m_actorid=0,m_name="[22]",m_aclass=0,m_shape=0,m_level=0,m_experience=0,m_experience_max=0,m_token=0,m_viplevel=0,
function proc_actorinfo_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_actorinfo_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_actorinfo_C", recvValue );
end

-- m_itemoffset=0,m_usenum=0,m_effres=0,
function proc_itemuse_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_itemuse_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_itemuse_C", recvValue );
end

-- m_res_offset=0,m_res_num=0,m_target_offset=0,m_target_num=0,
function proc_itemput_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_itemput_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_itemput_C", recvValue );
end

-- m_itemnum=0,m_itemoffset={}[m_itemnum],
function proc_itemsettle_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_itemsettle_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_itemsettle_C", recvValue );
end

-- m_itemoffset=0,m_itemnum=0,m_targetid=0,m_path=0,
function proc_lostitem_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_lostitem_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_lostitem_C", recvValue );
end

-- m_itemoffset=0,m_kind=0,m_type=0,m_color=0,m_num=0,m_targetid=0,m_path=0,m_situation=0,
function proc_getitem_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_getitem_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_getitem_C", recvValue );
end

-- m_itemext=0,m_kindnum=0,m_item={m_offset=0,m_kind=0,m_num=0,m_situation=0,m_color_level=0,[m_kindnum]},
function proc_itemlist_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_itemlist_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_itemlist_C", recvValue );
end

-- m_itemoffset=0,m_itemkind=0,m_type=0,m_level=0,m_color_level=0,m_price=0,m_attr_num=0,m_attr={m_type=0,m_ability=0,m_value=0,m_addvalue=0,[m_attr_num]},
function proc_iteminfo_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_iteminfo_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_iteminfo_C", recvValue );
end

-- m_unit_index=0,m_type=0,m_state=0,m_posx=0,m_posy=0,m_namelen=0,m_name="[m_namelen]",m_char_value_count=0,m_char_value={}[m_char_value_count],m_short_value_count=0,m_short_value={}[m_short_value_count],m_int_value_count=0,m_int_value={}[m_int_value_count],m_prefixlen=0,m_prefix="[m_prefixlen]",
function proc_addmapunit_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_addmapunit_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_addmapunit_C", recvValue );
end

-- m_unit_index=0,
function proc_delmapunit_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_delmapunit_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_delmapunit_C", recvValue );
end

-- m_info={m_unit_index=0,m_type=0,m_state=0,m_posx=0,m_posy=0,m_namelen=0,m_name="[m_namelen]",m_char_value_count=0,m_char_value={}[m_char_value_count],m_short_value_count=0,m_short_value={}[m_short_value_count],m_int_value_count=0,m_int_value={}[m_int_value_count],m_prefixlen=0,m_prefix="[m_prefixlen]",},
function proc_updatemapunit_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_updatemapunit_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_updatemapunit_C", recvValue );
end

-- m_unit_index=0,m_type=0,m_state=0,m_posx=0,m_posy=0,m_namelen=0,m_name="[m_namelen]",m_char_value_count=0,m_char_value={}[m_char_value_count],m_short_value_count=0,m_short_value={}[m_short_value_count],m_int_value_count=0,m_int_value={}[m_int_value_count],m_prefixlen=0,m_prefix="[m_prefixlen]",
function proc_mapunitsingle_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_mapunitsingle_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_mapunitsingle_C", recvValue );
end

-- m_map_width=0,m_map_height=0,m_area_width=0,m_area_height=0,m_map_area_xnum=0,m_map_area_ynum=0,m_my_city_posx=0,m_my_city_posy=0,m_my_city_unit_index=0,m_citystate=0,m_target_posx=0,m_target_posy=0,
function proc_worldmapinfo_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_worldmapinfo_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_worldmapinfo_C", recvValue );
end

-- m_unit_index=0,m_posx=0,m_posy=0,
function proc_mapunitcorrdinate_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_mapunitcorrdinate_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_mapunitcorrdinate_C", recvValue );
end

-- m_from_type=0,m_from_posx=0,m_from_posy=0,m_to_type=0,m_to_posx=0,m_to_posy=0,m_state=0,m_from_cityid=0,m_from_clubid=0,m_to_cityid=0,m_to_clubid=0,m_army_index=0,m_action=0,
function proc_addmarchroute_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_addmarchroute_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_addmarchroute_C", recvValue );
end

-- m_army_index=0,
function proc_delmarchroute_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_delmarchroute_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_delmarchroute_C", recvValue );
end

-- m_count=0,m_list={m_kind=0,m_num=0,[m_count]},m_callback_code=0,
function proc_awardinfolist_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_awardinfolist_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_awardinfolist_C", recvValue );
end

-- m_addexp=0,m_curexp=0,m_isup=0,m_path=0,
function proc_experience_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_experience_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_experience_C", recvValue );
end

-- m_body=0,m_addbody=0,m_path=0,
function proc_body_C( recvValue )
	-- process.
	-- EventProtocol.addEventListener( "proc_body_C", function( recvValue ) end )
	EventProtocol.dispatchEvent( "proc_body_C", recvValue );
end

