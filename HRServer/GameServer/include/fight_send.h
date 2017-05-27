#ifndef _FIGHT_SEND_H_
#define _FIGHT_SEND_H_

// 发送战场房间信息
int fightroominfo_sendroom( int fight_index );

// 发送战场房间信息
int fightroominfo_sendactor( int actor_index, int fight_index );

// 发送离开战场
int fightroom_sendquit( int fight_index, int actor_index );

// 发送进入英雄设置
int fightroom_sethero_sendroom( int fight_index );

// 发送进入英雄设置
int fightroom_sethero_sendactor( int fight_index, int actor_index );

// 发送战斗开始
int fightroom_start_sendroom( int fight_index );

// 发送战斗开始
int fightroom_start_sendactor( int fight_index, int actor_index );

// 发送战斗回合
int fightroom_turns_sendroom( int fight_index );

// 发送战斗回合
int fightroom_turns_sendactor( int fight_index, int actor_index );
#endif
