
#include "player.h"

using namespace std ;

// Constructors
Player::Player(void) {
	M_Name="" ;
}

Player::Player(std::string Name, Configuration Config) {
	M_Name=Name ;
	M_Money.Resize(Config.Get_Variable_Count(Money_Type),
			Config.Get_Variable_Count(Money_Adjective) ) ;
	M_Object.Resize(Config.Get_Variable_Count(Object_Type),
			Config.Get_Variable_Count(Object_Adjective) ) ;
}

// Inspectors
std::string Player::Get_Name(void) const {
	return M_Name ;
}

unsigned int Player::Get_Money(unsigned int Type, unsigned int Adjective) const{
	if(Adjective>=M_Money.Get_Height() ||
			Type>=M_Money.Get_Width()) {
		cerr << "Player.Get_Money(" << Type << ", " << Adjective <<
			") out of range for (" << M_Money.Get_Width() <<
			", " << M_Money.Get_Height() << ")!" << endl ;
		return 0 ;
	}
	else
		return M_Money(Type, Adjective) ;
}

unsigned int Player::Get_Object(unsigned int Type, unsigned int Adjective)const{
	if(Adjective>=M_Object.Get_Height() ||
			Type>=M_Object.Get_Width() ) {
		cerr << "Player.Get_Object(" << Type << ", " << Adjective <<
			") out of range for (" << M_Object.Get_Width() <<
			", " << M_Object.Get_Height() << ")!" << endl ;
		return 0 ;
	}
	else
		return M_Object(Type, Adjective) ;
}


// Mutators
void Player::Set_Name(string Name) {
	M_Name=Name ;
}

void Player::Set_Money(unsigned int Type, unsigned int Adjective, int Amount) {
	if(Adjective>=M_Money.Get_Height() ||
			Type>=M_Money.Get_Width() ||
			Amount>(signed)M_Money(Type, Adjective) ) {
		cerr << "Player.Set_Money(" << Type << ", " << Adjective <<
			", " << Amount << ") out of range for (" <<
			M_Money.Get_Width() << ", " << M_Money.Get_Height() <<
			", " << Amount << ")!" << endl ;
		return ;
	}
	else
		M_Money(Type, Adjective)+=Amount ;
}

void Player::Set_Object(unsigned int Type, unsigned int Adjective, int Amount){
	if(Adjective>=M_Object.Get_Height() ||
			Type>=M_Object.Get_Width() ||
			Amount>(signed)M_Object(Type, Adjective) ) {
		cerr << "Player.Set_Object(" << Type << ", " << Adjective <<
			", " << Amount << ") out of range for (" <<
			M_Object.Get_Width() << ", " << M_Object.Get_Height() <<
			", " << Amount << ")!" << endl ;
		return ;
	}
	else
		M_Object(Type, Adjective)+=Amount ;
}
