// File: shop.cpp
// Author: Liam Bryan
// Language: C++
// First Created: 2002.08.12
// Last Modified: 2002.08.12

#include "shop.h"

// Constructors
Shop::Shop(void) {
	M_Price.Flood(0) ;
	M_Object.Flood(1.0) ;
}

Shop::Shop(Configuration Config) {
	M_Price.Resize(Config.Get_Variable_Count(Money_Type),
			Config.Get_Variable_Count(Money_Adjective) ) ;
	M_Price.Flood(0) ;
	M_Object.Resize(Config.Get_Variable_Count(Object_Type),
			Config.Get_Variable_Count(Object_Adjective) ) ;
	M_Object.Flood(5) ;
}


// Destructors
Shop::~Shop(void) {
}


// Facilitators


// Inspectors


// Mutators
