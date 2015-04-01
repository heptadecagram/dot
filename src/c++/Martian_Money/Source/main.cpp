// File: main.cpp
// Author: Liam Bryan
// Language: C++
// First Created: 2002.07.17
// Last Modified: 2002.08.12


#include <iostream>
#include <string>
using namespace std ;

#include "config.h"
#include "array.h"
#include "player.h"
#include "bank.h"

int main(int argc, char** argv) {
	cout << "Executing..." << endl ;

	// The game-wide configuration
	Configuration Config ;
	Bank M_Bank(Config) ;



	cout << "Done!" << endl ;
	return 0 ;
}
