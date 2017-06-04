﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class DragonBones_TweenFrameData_DragonBones_BoneFrameDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DragonBones.TweenFrameData<DragonBones.BoneFrameData>), typeof(DragonBones.FrameData<DragonBones.BoneFrameData>), "TweenFrameData_DragonBones_BoneFrameData");
		L.RegFunction("SamplingEasingCurve", SamplingEasingCurve);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("tweenEasing", get_tweenEasing, set_tweenEasing);
		L.RegVar("curve", get_curve, set_curve);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SamplingEasingCurve(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			float[] arg0 = ToLua.CheckNumberArray<float>(L, 1);
			float[] arg1 = ToLua.CheckNumberArray<float>(L, 2);
			DragonBones.TweenFrameData<DragonBones.BoneFrameData>.SamplingEasingCurve(arg0, arg1);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_tweenEasing(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.TweenFrameData<DragonBones.BoneFrameData> obj = (DragonBones.TweenFrameData<DragonBones.BoneFrameData>)o;
			float ret = obj.tweenEasing;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index tweenEasing on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_curve(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.TweenFrameData<DragonBones.BoneFrameData> obj = (DragonBones.TweenFrameData<DragonBones.BoneFrameData>)o;
			float[] ret = obj.curve;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index curve on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_tweenEasing(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.TweenFrameData<DragonBones.BoneFrameData> obj = (DragonBones.TweenFrameData<DragonBones.BoneFrameData>)o;
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.tweenEasing = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index tweenEasing on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_curve(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			DragonBones.TweenFrameData<DragonBones.BoneFrameData> obj = (DragonBones.TweenFrameData<DragonBones.BoneFrameData>)o;
			float[] arg0 = ToLua.CheckNumberArray<float>(L, 2);
			obj.curve = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index curve on a nil value" : e.Message);
		}
	}
}

