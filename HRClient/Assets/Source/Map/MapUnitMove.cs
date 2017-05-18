using UnityEngine;
using System;
using System.Collections;
using LuaInterface;
using DG.Tweening;

// 世界地图显示单元移动脚本
public class MapUnitMove : MonoBehaviour
{
    public int stat = 0;                    // 1开始行走
    public Vector3 toPosition;              // 目的坐标
    public float speed = 0.01f;             // 速度
    ShareData data;
    // Use this for initialization
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        if ( stat == 1 )
        {
            transform.localPosition = Vector3.MoveTowards( transform.localPosition, toPosition, speed*Time.deltaTime );
        }
    }


}
