
#ifndef LIAM_TERRAIN
#define LIAM_TERRAIN

#include "screen_object.h"

enum Density { Rock, Solid, Liquid, Open } ;

class Terrain : public Screen_Object {
public:
	// Constructors
	Terrain(void) ;
	Terrain(const char* Name, char Image, Color color, Density density) ;

	Terrain &operator = (const Terrain &terrain) ;

	// Destructor
	~Terrain(void) ;

	// Facilitator

	// Mutators
	void Set_Density(Density density) ;

	// Inspectors
	Density Get_Density(void) const ;

protected:
	Density M_Density ;
} ;

#endif // LIAM_TERRAIN
