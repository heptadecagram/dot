// File: player.h
// Author: Liam Bryan
// Language: C++
// First Created: 2002.07.23
// Last Modified: 2002.08.11

#ifndef LIAM_PLAYER
# define LIAM_PLAYER

# include <string>

# include "array.h"
# include "config.h"

class Player {
public:
	// Constructors
	Player(void) ;
	Player(std::string Name, Configuration Config) ;

	// Facilitators
	bool Process_Command(std::string Command) ;

	// Inspectors
	std::string Get_Name(void) const ;
	unsigned int Get_Money(unsigned int Type, unsigned int Adjective) const;
	unsigned int Get_Object(unsigned int Type, unsigned int Adjective)const;

	// Mutators
	void Set_Name(std::string Name) ;
	void Set_Money(unsigned int Type, unsigned int Adjective, int Amount) ;
	void Set_Object(unsigned int Type, unsigned int Adjective, int Amount) ;

protected:
	// Member Variables
	std::string M_Name ;
	Array<unsigned int> M_Money ;
	Array<unsigned int> M_Object ;
} ;

#endif // LIAM_PLAYER
