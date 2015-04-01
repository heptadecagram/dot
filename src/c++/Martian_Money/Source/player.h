// File: player.h
// Author: Liam Bryan
// Language: C++
// First Created: 2002.07.23
// Last Modified: 2002.08.11

#ifndef LIAM_PLAYER
# define LIAM_PLAYER

# include <string>
using namespace std ;

# include "array.h"
# include "config.h"

class Player {
public:
	// Constructors
	Player(void) ;
	Player(string Name, Configuration Config) ;

	// Destructors
	~Player(void) ;

	// Facilitators
	bool Process_Command(string Command) ;

	// Inspectors
	string Get_Name(void) const ;
	unsigned int Get_Money(unsigned int Type, unsigned int Adjective) const;
	unsigned int Get_Object(unsigned int Type, unsigned int Adjective)const;

	// Mutators
	void Set_Name(string Name) ;
	void Set_Money(unsigned int Type, unsigned int Adjective, int Amount) ;
	void Set_Object(unsigned int Type, unsigned int Adjective, int Amount) ;

protected:
	// Member Variables
	string M_Name ;
	Array<unsigned int> M_Money ;
	Array<unsigned int> M_Object ;
} ;

#endif // LIAM_PLAYER
