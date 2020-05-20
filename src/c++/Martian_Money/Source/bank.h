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
	size_t Trade(size_t Offer_Type, size_t Offer_Adjective, size_t Offer_Amount, size_t Receive_Type,
			size_t Receive_Adjective);
	void Make_Rates();

	// Inspectors
	double Get_Rate(unsigned int Type, unsigned int Adjective) const;
	int Get_Money(unsigned int Type, unsigned int Adjective) const;
	double Get_Normalizer() const;

	// Mutators
	void Set_Money(unsigned int Type, unsigned int Adjective, int Amount);
	void Set_Normalizer(double Normalizer);

protected:
	// Member Variables
	Array<int> M_Money;
	Array<double> M_Rate;
	double M_Normalizer;
};

#endif // MMONEY_BANK
