﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class DragonBones_AnimationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DragonBones.Animation), typeof(DragonBones.BaseObject));
		L.RegFunction("Reset", Reset);
		L.RegFunction("Stop", Stop);
		L.RegFunction("PlayConfig", PlayConfig);
		L.RegFunction("FadeIn", FadeIn);
		L.RegFunction("Play", Play);
		L.RegFunction("GotoAndPlayByTime", GotoAndPlayByTime);
		L.RegFunction("GotoAndPlayByFrame", GotoAndPlayByFrame);
		L.RegFunction("GotoAndPlayByProgress", GotoAndPlayByProgress);
		L.RegFunction("GotoAndStopByTime", GotoAndStopByTime);
		L.RegFunction("GotoAndStopByFrame", GotoAndStopByFrame);
		L.RegFunction("GotoAndStopByProgress", GotoAndStopByProgress);
		L.RegFunction("GetState", GetState);
		L.RegFunction("HasAnimation", HasAnimation);
		L.RegFunction("New", _CreateDragonBones_Animation);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("timeScale", get_timeScale, set_timeScale);
		L.RegVar("isPlaying", get_isPlaying, null);
		L.RegVar("isCompleted", get_isCompleted, null);
		L.RegVar("lastAnimationName", get_lastAnimationName, null);
		L.RegVar("lastAnimationState", get_lastAnimationState, null);
		L.RegVar("animationConfig", get_animationConfig, null);
		L.RegVar("animationNames", get_animationNames, null);
		L.RegVar("animations", get_animations, set_animations);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateDragonBones_Animation(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				DragonBones.Animation obj = new DragonBones.Animation();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: DragonBones.Animation.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			obj.Reset();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Stop(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			obj.Stop(arg0);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int PlayConfig(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			DragonBones.AnimationConfig arg0 = (DragonBones.AnimationConfig)ToLua.CheckObject(L, 2, typeof(DragonBones.AnimationConfig));
			DragonBones.AnimationState o = obj.PlayConfig(arg0);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int FadeIn(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 11);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
			int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
			int arg3 = (int)LuaDLL.luaL_checknumber(L, 5);
			string arg4 = ToLua.CheckString(L, 6);
			DragonBones.AnimationFadeOutMode arg5 = (DragonBones.AnimationFadeOutMode)ToLua.CheckObject(L, 7, typeof(DragonBones.AnimationFadeOutMode));
			bool arg6 = LuaDLL.luaL_checkboolean(L, 8);
			bool arg7 = LuaDLL.luaL_checkboolean(L, 9);
			bool arg8 = LuaDLL.luaL_checkboolean(L, 10);
			bool arg9 = LuaDLL.luaL_checkboolean(L, 11);
			DragonBones.AnimationState o = obj.FadeIn(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Play(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			int arg1 = (int)LuaDLL.luaL_checknumber(L, 3);
			DragonBones.AnimationState o = obj.Play(arg0, arg1);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GotoAndPlayByTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
			int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
			DragonBones.AnimationState o = obj.GotoAndPlayByTime(arg0, arg1, arg2);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GotoAndPlayByFrame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			uint arg1 = (uint)LuaDLL.luaL_checknumber(L, 3);
			int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
			DragonBones.AnimationState o = obj.GotoAndPlayByFrame(arg0, arg1, arg2);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GotoAndPlayByProgress(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
			int arg2 = (int)LuaDLL.luaL_checknumber(L, 4);
			DragonBones.AnimationState o = obj.GotoAndPlayByProgress(arg0, arg1, arg2);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GotoAndStopByTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
			DragonBones.AnimationState o = obj.GotoAndStopByTime(arg0, arg1);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GotoAndStopByFrame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			uint arg1 = (uint)LuaDLL.luaL_checknumber(L, 3);
			DragonBones.AnimationState o = obj.GotoAndStopByFrame(arg0, arg1);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GotoAndStopByProgress(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			float arg1 = (float)LuaDLL.luaL_checknumber(L, 3);
			DragonBones.AnimationState o = obj.GotoAndStopByProgress(arg0, arg1);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			DragonBones.AnimationState o = obj.GetState(arg0);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int HasAnimation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DragonBones.Animation obj = (DragonBones.Animation)ToLua.CheckObject(L, 1, typeof(DragonBones.Animation));
			string arg0 = ToLua.CheckString(L, 2);
			bool o = obj.HasAnimation(arg0);
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_timeScale(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			float ret = obj.timeScale;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index timeScale on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isPlaying(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			bool ret = obj.isPlaying;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index isPlaying on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_isCompleted(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			bool ret = obj.isCompleted;
			LuaDLL.lua_pushboolean(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index isCompleted on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_lastAnimationName(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			string ret = obj.lastAnimationName;
			LuaDLL.lua_pushstring(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index lastAnimationName on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_lastAnimationState(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			DragonBones.AnimationState ret = obj.lastAnimationState;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index lastAnimationState on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_animationConfig(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			DragonBones.AnimationConfig ret = obj.animationConfig;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index animationConfig on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_animationNames(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			System.Collections.Generic.List<string> ret = obj.animationNames;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index animationNames on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_animations(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			System.Collections.Generic.Dictionary<string,DragonBones.AnimationData> ret = obj.animations;
			ToLua.PushObject(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index animations on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_timeScale(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.timeScale = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index timeScale on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_animations(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.Animation obj = (DragonBones.Animation)o;
			System.Collections.Generic.Dictionary<string,DragonBones.AnimationData> arg0 = (System.Collections.Generic.Dictionary<string,DragonBones.AnimationData>)ToLua.CheckObject(L, 2, typeof(System.Collections.Generic.Dictionary<string,DragonBones.AnimationData>));
			obj.animations = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index animations on a nil value" : e.Message);
		}
	}
}

