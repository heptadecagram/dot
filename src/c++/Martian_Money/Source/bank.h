
#ifndef MMONEY_BANK
# define MMONEY_BANK

# include <cmath>
# ifndef M_PI
#  define M_PI 3.14159265358979323846264338
# endif // M_PI

# include "array.h"
# include "config.h"

class Bank {
public:
	// Constructors
	Bank(void);
	Bank(Configuration Config);

	// Facilitators
	unsigned int Trade(unsigned int Offer_Type,unsigned int Offer_Adjective,
			unsigned int Offer_Amount, unsigned int Receive_Type,
			unsigned int Receive_Adjective);
	void Make_Rates(void);

	// Inspectors
	double Get_Rate(unsigned int Type, unsigned int Adjective) const;
	long Get_Money(unsigned int Type, unsigned int Adjective) const;
	double Get_Normalizer(void) const;

	// Mutators
	void Set_Money(unsigned int Type, unsigned int Adjective, long Amount);
	void Set_Normalizer(double Normalizer);

protected:
	// Member Variables
	Array<long> M_Money;
	Array<double> M_Rate;
	double M_Normalizer;
};

#endif // MMONEY_BANK
