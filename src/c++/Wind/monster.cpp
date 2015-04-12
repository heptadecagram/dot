#include "monster.h"

// Constructors
Monster::Monster(void) {
}

Monster::Monster(char* Name, char Image, Color color, int Max_Hit_Points) :
		Screen_Object(Name, Image, color) {
	M_Playable=false ;
	M_Hit_Points=Max_Hit_Points ;
	M_Max_Hit_Points=Max_Hit_Points ;
}

Monster &Monster::operator = (const Monster &monster) {
	M_Name=monster.Get_Name() ;
	M_Image=monster.Get_Image() ;
	M_Color=monster.Get_Color() ;

	return *this ;
}

// Destructor
Monster::~Monster(void) {
}


// Facilitators

// Mutators
void Monster::Set_Playable(bool Playable) {
	M_Playable=Playable ;
}

bool Monster::Damage(int Damage) {
	M_Hit_Points-=Damage ;
	if(M_Hit_Points<=0)
		return false ;
	else
		return true ;
}


// Inspectors
bool Monster::Get_Playable(void) const {
	return M_Playable ;
}
