﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class UnityEngine_UICharInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UnityEngine.UICharInfo), null);
		L.RegFunction("New", _CreateUnityEngine_UICharInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("cursorPos", get_cursorPos, set_cursorPos);
		L.RegVar("charWidth", get_charWidth, set_charWidth);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateUnityEngine_UICharInfo(IntPtr L)
	{
		UnityEngine.UICharInfo obj = new UnityEngine.UICharInfo();
		ToLua.PushValue(L, obj);
		return 1;
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_cursorPos(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.UICharInfo obj = (UnityEngine.UICharInfo)o;
			UnityEngine.Vector2 ret = obj.cursorPos;
			ToLua.Push(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index cursorPos on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_charWidth(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.UICharInfo obj = (UnityEngine.UICharInfo)o;
			float ret = obj.charWidth;
			LuaDLL.lua_pushnumber(L, ret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index charWidth on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_cursorPos(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.UICharInfo obj = (UnityEngine.UICharInfo)o;
			UnityEngine.Vector2 arg0 = ToLua.ToVector2(L, 2);
			obj.cursorPos = arg0;
			ToLua.SetBack(L, 1, obj);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index cursorPos on a nil value" : e.Message);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_charWidth(IntPtr L)
	{
		object o = null;

		try
		{
			o = ToLua.ToObject(L, 1);
			UnityEngine.UICharInfo obj = (UnityEngine.UICharInfo)o;
			float arg0 = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.charWidth = arg0;
			ToLua.SetBack(L, 1, obj);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, o == null ? "attempt to index charWidth on a nil value" : e.Message);
		}
	}
}

