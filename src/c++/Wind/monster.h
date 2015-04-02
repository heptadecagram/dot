// File: monster.h
// Author: Liam Bryan
// Language: C++
// Last Modified: 2001.11.27

#ifndef LIAM_MONSTER
#define LIAM_MONSTER

#include "screen_object.h"

class Monster : public Screen_Object {
	public:
	// Constructors
	Monster(void) ;
	Monster(char* Name, char Image, Color color, int Max_Hit_Points) ;

	Monster &operator = (const Monster &monster) ;

	// Destructor
	~Monster(void) ;

	// Facilitators
	
	// Mutators
	void Set_Playable(bool Playable) ;
	bool Damage(int Damage) ;

	// Inspectors
	bool Get_Playable(void) const ;

	protected:
	// Member Variables
	bool M_Playable ;
	int M_Max_Hit_Points ;
	int M_Hit_Points ;
} ;

#endif
