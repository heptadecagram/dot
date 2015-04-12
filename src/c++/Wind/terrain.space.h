#ifndef LIAM_TERRAIN_SPACE
#define LIAM_TERRAIN_SPACE

#include "terrain.h"

namespace Terrain_Space {

	const Terrain ROCK("Rock", '#', Black, Rock) ;
	const Terrain STONE("Rock", '#', Black, Solid) ;

	const Terrain WATER_DEEP("Deep Water", '~', Navy, Liquid) ;

	const Terrain FLOOR("Floor", '.', Grey, Open) ;
}

#endif // LIAM_TERRAIN_SPACE
