﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class DragonBones_EventObjectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DragonBones.EventObject), typeof(DragonBones.BaseObject));
		L.RegFunction("New", _CreateDragonBones_EventObject);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("START", get_START, null);
		L.RegVar("LOOP_COMPLETE", get_LOOP_COMPLETE, null);
		L.RegVar("COMPLETE", get_COMPLETE, null);
		L.RegVar("FADE_IN", get_FADE_IN, null);
		L.RegVar("FADE_IN_COMPLETE", get_FADE_IN_COMPLETE, null);
		L.RegVar("FADE_OUT", get_FADE_OUT, null);
		L.RegVar("FADE_OUT_COMPLETE", get_FADE_OUT_COMPLETE, null);
		L.RegVar("FRAME_EVENT", get_FRAME_EVENT, null);
		L.RegVar("SOUND_EVENT", get_SOUND_EVENT, null);
		L.RegVar("type", get_type, set_type);
		L.RegVar("name", get_name, set_name);
		L.RegVar("frame", get_frame, set_frame);
		L.RegVar("data", get_data, set_data);
		L.RegVar("armature", get_armature, set_armature);
		L.RegVar("bone", get_bone, set_bone);
		L.RegVar("slot", get_slot, set_slot);
		L.RegVar("animationState", get_animationState, set_animationState);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateDragonBones_EventObject(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				DragonBones.EventObject obj = new DragonBones.EventObject();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: DragonBones.EventObject.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_START(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.START);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_LOOP_COMPLETE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.LOOP_COMPLETE);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_COMPLETE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.COMPLETE);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_FADE_IN(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.FADE_IN);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_FADE_IN_COMPLETE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.FADE_IN_COMPLETE);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_FADE_OUT(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.FADE_OUT);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_FADE_OUT_COMPLETE(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.FADE_OUT_COMPLETE);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_FRAME_EVENT(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.FRAME_EVENT);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_SOUND_EVENT(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, DragonBones.EventObject.SOUND_EVENT);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_type(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			string ret = obj.type;
			LuaDLL.lua_pushstring(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index type on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_name(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			string ret = obj.name;
			LuaDLL.lua_pushstring(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index name on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_frame(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.AnimationFrameData ret = obj.frame;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index frame on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_data(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.CustomData ret = obj.data;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index data on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_armature(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.Armature ret = obj.armature;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index armature on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_bone(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.Bone ret = obj.bone;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index bone on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_slot(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.Slot ret = obj.slot;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index slot on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_animationState(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.AnimationState ret = obj.animationState;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index animationState on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_type(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			string arg0 = ToLua.CheckString(L, 2);
			obj.type = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index type on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_name(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			string arg0 = ToLua.CheckString(L, 2);
			obj.name = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index name on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_frame(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.AnimationFrameData arg0 = (DragonBones.AnimationFrameData)ToLua.CheckObject(L, 2, typeof(DragonBones.AnimationFrameData));
			obj.frame = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index frame on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_data(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.CustomData arg0 = (DragonBones.CustomData)ToLua.CheckObject(L, 2, typeof(DragonBones.CustomData));
			obj.data = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index data on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_armature(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.Armature arg0 = (DragonBones.Armature)ToLua.CheckObject(L, 2, typeof(DragonBones.Armature));
			obj.armature = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index armature on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_bone(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.Bone arg0 = (DragonBones.Bone)ToLua.CheckObject(L, 2, typeof(DragonBones.Bone));
			obj.bone = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index bone on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_slot(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.Slot arg0 = (DragonBones.Slot)ToLua.CheckObject(L, 2, typeof(DragonBones.Slot));
			obj.slot = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index slot on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_animationState(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.EventObject obj = (DragonBones.EventObject)o;
			DragonBones.AnimationState arg0 = (DragonBones.AnimationState)ToLua.CheckObject(L, 2, typeof(DragonBones.AnimationState));
			obj.animationState = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index animationState on a nil value" : e.Message);
		}
	}
}

