#ifndef __HERO_DATA_AUTO_H
#define __HERO_DATA_AUTO_H
#include "define.h"

struct _hero {
//--Automatically generated
				int kind;	//
				char name[255];	//
				short color;	//
				short job;	//
				short level_init;	//
				short star_init;	//
				short star_max;	//
				int life;	//
				int attack;	//
				int defence;	//
				int precision;	//
				int dodge;	//
				int crit;	//
				int crit_resist;	//
				int crit_damage;	//
				int crit_damage_resist;	//
				int speed_attack;	//
				int speed_move;	//
				int ignore_defence;	//
				int damage_increase;	//
				int damage_reduce;	//
				int skillid[4];	//
};
typedef struct _hero Hero;

int hero_init_auto();
int hero_reload_auto();
int hero_luatable_auto();

#endif
