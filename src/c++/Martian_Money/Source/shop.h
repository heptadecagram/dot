// File: shop.h
// Author: Liam Bryan
// Language: C++
// First Created: 2002.08.12
// Last Modified: 2002.08.12

#ifndef LIAM_SHOP
# define LIAM_SHOP

using namespace std ;

# include "array.h"
# include "config.h"

class Shop {
public:
	// Constructors
	Shop(void) ;
	Shop(Configuration Config) ;

	// Destructors
	~Shop(void) ;

	// Facilitators

	// Inspectors

	// Mutators

protected:
	// Member Variables
	Array<unsigned int> M_Price ;
	Array<unsigned int> M_Object ;
} ;

#endif // LIAM_SHOP
