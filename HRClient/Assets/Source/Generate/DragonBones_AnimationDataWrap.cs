﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class DragonBones_AnimationDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DragonBones.AnimationData), typeof(DragonBones.TimelineData<DragonBones.AnimationFrameData>));
		L.RegFunction("CacheFrames", CacheFrames);
		L.RegFunction("AddBoneTimeline", AddBoneTimeline);
		L.RegFunction("AddSlotTimeline", AddSlotTimeline);
		L.RegFunction("AddFFDTimeline", AddFFDTimeline);
		L.RegFunction("GetBoneTimeline", GetBoneTimeline);
		L.RegFunction("GetSlotTimeline", GetSlotTimeline);
		L.RegFunction("GetFFDTimeline", GetFFDTimeline);
		L.RegFunction("GetBoneCachedFrameIndices", GetBoneCachedFrameIndices);
		L.RegFunction("GetSlotCachedFrameIndices", GetSlotCachedFrameIndices);
		L.RegFunction("New", _CreateDragonBones_AnimationData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("frameCount", get_frameCount, set_frameCount);
		L.RegVar("playTimes", get_playTimes, set_playTimes);
		L.RegVar("duration", get_duration, set_duration);
		L.RegVar("fadeInTime", get_fadeInTime, set_fadeInTime);
		L.RegVar("cacheFrameRate", get_cacheFrameRate, set_cacheFrameRate);
		L.RegVar("name", get_name, set_name);
		L.RegVar("boneTimelines", get_boneTimelines, null);
		L.RegVar("slotTimelines", get_slotTimelines, null);
		L.RegVar("ffdTimelines", get_ffdTimelines, null);
		L.RegVar("cachedFrames", get_cachedFrames, null);
		L.RegVar("boneCachedFrameIndices", get_boneCachedFrameIndices, null);
		L.RegVar("slotCachedFrameIndices", get_slotCachedFrameIndices, null);
		L.RegVar("zOrderTimeline", get_zOrderTimeline, set_zOrderTimeline);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateDragonBones_AnimationData(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				DragonBones.AnimationData obj = new DragonBones.AnimationData();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: DragonBones.AnimationData.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int CacheFrames(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.CacheFrames(arg0);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int AddBoneTimeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			DragonBones.BoneTimelineData arg0 = (DragonBones.BoneTimelineData)ToLua.CheckObject(L, 2, typeof(DragonBones.BoneTimelineData));
			obj.AddBoneTimeline(arg0);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int AddSlotTimeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			DragonBones.SlotTimelineData arg0 = (DragonBones.SlotTimelineData)ToLua.CheckObject(L, 2, typeof(DragonBones.SlotTimelineData));
			obj.AddSlotTimeline(arg0);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int AddFFDTimeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			DragonBones.FFDTimelineData arg0 = (DragonBones.FFDTimelineData)ToLua.CheckObject(L, 2, typeof(DragonBones.FFDTimelineData));
			obj.AddFFDTimeline(arg0);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetBoneTimeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			string arg0 = ToLua.CheckString(L, 2);
			DragonBones.BoneTimelineData o = obj.GetBoneTimeline(arg0);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetSlotTimeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			string arg0 = ToLua.CheckString(L, 2);
			DragonBones.SlotTimelineData o = obj.GetSlotTimeline(arg0);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetFFDTimeline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			string arg0 = ToLua.CheckString(L, 2);
			string arg1 = ToLua.CheckString(L, 3);
			System.Collections.Generic.Dictionary<string,DragonBones.FFDTimelineData> o = obj.GetFFDTimeline(arg0, arg1);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetBoneCachedFrameIndices(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			string arg0 = ToLua.CheckString(L, 2);
			System.Collections.Generic.List<int> o = obj.GetBoneCachedFrameIndices(arg0);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetSlotCachedFrameIndices(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)ToLua.CheckObject(L, 1, typeof(DragonBones.AnimationData));
			string arg0 = ToLua.CheckString(L, 2);
			System.Collections.Generic.List<int> o = obj.GetSlotCachedFrameIndices(arg0);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_frameCount(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			uint ret = obj.frameCount;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index frameCount on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_playTimes(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			uint ret = obj.playTimes;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index playTimes on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_duration(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			float ret = obj.duration;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index duration on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_fadeInTime(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			float ret = obj.fadeInTime;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index fadeInTime on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_cacheFrameRate(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			float ret = obj.cacheFrameRate;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index cacheFrameRate on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_name(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
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
	static int get_boneTimelines(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			System.Collections.Generic.Dictionary<string,DragonBones.BoneTimelineData> ret = obj.boneTimelines;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index boneTimelines on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_slotTimelines(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			System.Collections.Generic.Dictionary<string,DragonBones.SlotTimelineData> ret = obj.slotTimelines;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index slotTimelines on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ffdTimelines(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			System.Collections.Generic.Dictionary<string,System.Collections.Generic.Dictionary<string,System.Collections.Generic.Dictionary<string,DragonBones.FFDTimelineData>>> ret = obj.ffdTimelines;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index ffdTimelines on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_cachedFrames(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			System.Collections.Generic.List<bool> ret = obj.cachedFrames;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index cachedFrames on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_boneCachedFrameIndices(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			System.Collections.Generic.Dictionary<string,System.Collections.Generic.List<int>> ret = obj.boneCachedFrameIndices;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index boneCachedFrameIndices on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_slotCachedFrameIndices(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			System.Collections.Generic.Dictionary<string,System.Collections.Generic.List<int>> ret = obj.slotCachedFrameIndices;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index slotCachedFrameIndices on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_zOrderTimeline(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			DragonBones.ZOrderTimelineData ret = obj.zOrderTimeline;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index zOrderTimeline on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_frameCount(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			uint arg0 = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj.frameCount = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index frameCount on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_playTimes(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			uint arg0 = (uint)LuaDLL.luaL_checknumber(L, 2);
			obj.playTimes = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index playTimes on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_duration(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.duration = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index duration on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_fadeInTime(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.fadeInTime = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index fadeInTime on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_cacheFrameRate(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.cacheFrameRate = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index cacheFrameRate on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_name(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
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
	static int set_zOrderTimeline(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.AnimationData obj = (DragonBones.AnimationData)o;
			DragonBones.ZOrderTimelineData arg0 = (DragonBones.ZOrderTimelineData)ToLua.CheckObject(L, 2, typeof(DragonBones.ZOrderTimelineData));
			obj.zOrderTimeline = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index zOrderTimeline on a nil value" : e.Message);
		}
	}
}
