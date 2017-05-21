﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class IniUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(IniUtil), typeof(System.Object));
		L.RegFunction("OpenFromData", OpenFromData);
		L.RegFunction("OpenFromTXT", OpenFromTXT);
		L.RegFunction("OpenFromStreamingAssets", OpenFromStreamingAssets);
		L.RegFunction("OpenFromMemory", OpenFromMemory);
		L.RegFunction("Clear", Clear);
		L.RegFunction("WriteValue", WriteValue);
		L.RegFunction("ReadValue", ReadValue);
		L.RegFunction("SetGlobal", SetGlobal);
		L.RegFunction("New", _CreateIniUtil);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateIniUtil(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				IniUtil obj = new IniUtil();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: IniUtil.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int OpenFromData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IniUtil obj = (IniUtil)ToLua.CheckObject(L, 1, typeof(IniUtil));
			string arg0 = ToLua.CheckString(L, 2);
			bool o = obj.OpenFromData(arg0);
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int OpenFromTXT(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IniUtil obj = (IniUtil)ToLua.CheckObject(L, 1, typeof(IniUtil));
			string arg0 = ToLua.CheckString(L, 2);
			bool o = obj.OpenFromTXT(arg0);
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int OpenFromStreamingAssets(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IniUtil obj = (IniUtil)ToLua.CheckObject(L, 1, typeof(IniUtil));
			string arg0 = ToLua.CheckString(L, 2);
			bool o = obj.OpenFromStreamingAssets(arg0);
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int OpenFromMemory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IniUtil obj = (IniUtil)ToLua.CheckObject(L, 1, typeof(IniUtil));
			byte[] arg0 = ToLua.CheckByteBuffer(L, 2);
			bool o = obj.OpenFromMemory(arg0);
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Clear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IniUtil obj = (IniUtil)ToLua.CheckObject(L, 1, typeof(IniUtil));
			obj.Clear();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int WriteValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			IniUtil obj = (IniUtil)ToLua.CheckObject(L, 1, typeof(IniUtil));
			string arg0 = ToLua.CheckString(L, 2);
			object arg1 = ToLua.ToVarObject(L, 3);
			obj.WriteValue(arg0, arg1);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ReadValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			IniUtil obj = (IniUtil)ToLua.CheckObject(L, 1, typeof(IniUtil));
			string arg0 = ToLua.CheckString(L, 2);
			string arg1 = ToLua.CheckString(L, 3);
			object o = obj.ReadValue(arg0, arg1);
			ToLua.Push(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int SetGlobal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IniUtil obj = (IniUtil)ToLua.CheckObject(L, 1, typeof(IniUtil));
			obj.SetGlobal();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

