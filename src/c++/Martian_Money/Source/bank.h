// File: bank.h
// Author: Liam Bryan
// Language: C++
// First Created: 2002.08.11
// Last Modified: 2002.08.12

#ifndef LIAM_BANK
# define LIAM_BANK

# include <cmath>
using namespace std ;
# ifndef PI
#  define PI 3.14159265358979323846264338
# endif // PI

# include "array.h"
# include "config.h"

class Bank {
public:
	// Constructors
	Bank(void) ;
	Bank(Configuration Config) ;

	// Destructors
	~Bank(void) ;

	// Facilitators
	unsigned int Trade(unsigned int Offer_Type,unsigned int Offer_Adjective,
			unsigned int Offer_Amount, unsigned int Receive_Type,
			unsigned int Receive_Adjective) ;
	void Make_Rates(void) ;

	// Inspectors
	double Get_Rate(unsigned int Type, unsigned int Adjective) const ;
	long Get_Money(unsigned int Type, unsigned int Adjective) const ;
	double Get_Normalizer(void) const ;

	// Mutators
	void Set_Money(unsigned int Type, unsigned int Adjective, long Amount) ;
	void Set_Normalizer(double Normalizer) ;

protected:
	// Member Variables
	Array<long> M_Money ;
	Array<double> M_Rate ;
	double M_Normalizer ;
} ;

#endif // LIAM_BANK
