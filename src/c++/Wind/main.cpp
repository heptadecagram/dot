// File: main.cpp
// Author: Liam Bryan
// Language: C++
// Last Modified: 2001.11.26

#include <cstdlib>
using namespace std ;

#include "io.h"
#include "terrain.h"
#include "terrain.space.h"
#include "random.h"
using namespace Terrain_Space ;

int main(int argc, char** argv) {

	Begin_Display() ;

	Terrain G=ROCK ;

	for(int n=1; n<=7; n++)
		for(int nn=1; nn<=26; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }

	G.Set_Color(Blue) ;
	for(int n=8; n<=14; n++)
		for(int nn=1; nn<=26; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }

	//G.Set_Color(Yellow) ;
	G=WATER_DEEP ;
	for(int n=15; n<=21; n++)
		for(int nn=1; nn<=26; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }


	G.Set_Color(Lime) ;
	for(int n=1; n<=7; n++)
		for(int nn=27; nn<=52; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }

	G.Set_Color(Orange) ;
	for(int n=8; n<=14; n++)
		for(int nn=27; nn<=52; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }

	G.Set_Color(White) ;
	for(int n=15; n<=21; n++)
		for(int nn=27; nn<=52; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }


	G.Set_Color(Cyan) ;
	for(int n=1; n<=7; n++)
		for(int nn=53; nn<=78; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }

	G.Set_Color(Aqua) ;
	for(int n=8; n<=14; n++)
		for(int nn=53; nn<=78; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }

	G.Set_Color(Brown) ;
	for(int n=15; n<=21; n++)
		for(int nn=53; nn<=78; nn++) {
	Locate(n, nn) ;
	G.Put_Image() ; }



	Refresh() ;
	return EXIT_SUCCESS ;
}
