﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class DragonBones_BoneTimelineDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DragonBones.BoneTimelineData), typeof(DragonBones.TimelineData<DragonBones.BoneFrameData>));
		L.RegFunction("New", _CreateDragonBones_BoneTimelineData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("bone", get_bone, set_bone);
		L.RegVar("originTransform", get_originTransform, null);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateDragonBones_BoneTimelineData(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				DragonBones.BoneTimelineData obj = new DragonBones.BoneTimelineData();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: DragonBones.BoneTimelineData.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_bone(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.BoneTimelineData obj = (DragonBones.BoneTimelineData)o;
			DragonBones.BoneData ret = obj.bone;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index bone on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_originTransform(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.BoneTimelineData obj = (DragonBones.BoneTimelineData)o;
			DragonBones.Transform ret = obj.originTransform;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index originTransform on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_bone(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.BoneTimelineData obj = (DragonBones.BoneTimelineData)o;
			DragonBones.BoneData arg0 = (DragonBones.BoneData)ToLua.CheckObject(L, 2, typeof(DragonBones.BoneData));
			obj.bone = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index bone on a nil value" : e.Message);
		}
	}
}

