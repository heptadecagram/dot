// File: terrain.cpp
// Author: Liam Bryan
// Language: C++
// Last Modified: 2002.03.10

#include "terrain.h"

// Constructors
Terrain::Terrain(void) {
}

Terrain::Terrain(char* Name, char Image, Color color, Density density) :
		Screen_Object(Name, Image, color) {
	M_Density=density ;
}

Terrain &Terrain::operator = (const Terrain &terrain) {
	M_Name=terrain.Get_Name() ;
	M_Image=terrain.Get_Image() ;
	M_Color=terrain.Get_Color() ;
	M_Density=terrain.Get_Density() ;

	return *this ;
}

// Destructors
Terrain::~Terrain(void) {
}

// Facilitators

// Mutators
void Terrain::Set_Density(Density density) {
	M_Density=density ;
}

Density Terrain::Get_Density(void) const {
	return M_Density ;
}
