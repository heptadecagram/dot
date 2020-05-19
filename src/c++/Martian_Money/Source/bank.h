#ifndef MMONEY_BANK
# define MMONEY_BANK

# include "array.h"
# include "config.h"

class Bank {
public:
	// Constructors
	Bank();
	Bank(Configuration Config);

	// Facilitators
	unsigned int Trade(unsigned int Offer_Type,unsigned int Offer_Adjective,
			unsigned int Offer_Amount, unsigned int Receive_Type,
			unsigned int Receive_Adjective);
	void Make_Rates();

	// Inspectors
	double Get_Rate(unsigned int Type, unsigned int Adjective) const;
	long Get_Money(unsigned int Type, unsigned int Adjective) const;
	double Get_Normalizer() const;

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
