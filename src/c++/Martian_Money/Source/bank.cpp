#include "bank.h"

#include <cfloat>
#include <cmath>
# ifndef M_PI
#  define M_PI 3.14159265358979323846264338
# endif // M_PI
#include <iostream>
#include <stdexcept>

// Constructors
Bank::Bank() {
	M_Money.Flood(0);
	M_Rate.Flood(1.0);
	M_Normalizer=100.0;
}

Bank::Bank(Configuration Config) {
	M_Money.Resize(Config.Get_Variable_Count(Config_Variable::Money_Type),
			Config.Get_Variable_Count(Config_Variable::Money_Adjective) );
	M_Money.Flood(0);
	M_Rate.Resize(Config.Get_Variable_Count(Config_Variable::Money_Type),
			Config.Get_Variable_Count(Config_Variable::Money_Adjective) );
	M_Rate.Flood(1.0);
	M_Normalizer = 100.0;//Config.Get_Variable(Money_Start);
}

// Facilitators
size_t Bank::Trade(size_t Offer_Type, size_t Offer_Adjective,
		size_t Offer_Amount, size_t Receive_Type,
		size_t Receive_Adjective) {

	auto Result = static_cast<size_t>(M_Rate[Offer_Type][Offer_Adjective] /
				M_Rate[Receive_Type][Receive_Adjective] * Offer_Amount);

	M_Money[Offer_Type][Offer_Adjective] += Offer_Amount;
	M_Money[Receive_Type][Receive_Adjective] -= Result;
	return Result;
}

void Bank::Make_Rates() {
	for(auto n=0u; n<M_Rate.Get_Width(); n++)
		for(auto nn=0u; nn<M_Rate.Get_Height(); nn++)
			M_Rate[n][nn] = 1.0 + 2*std::atan(M_Money[n][nn]/M_Normalizer)/M_PI;
}


// Inspectors
double Bank::Get_Rate(unsigned int Type, unsigned int Adjective) const {
	return M_Rate[Type][Adjective];
}

int Bank::Get_Money(unsigned int Type, unsigned int Adjective) const {
	return M_Money[Type][Adjective];
}

double Bank::Get_Normalizer() const {
	return M_Normalizer;
}

// Mutators
void Bank::Set_Money(unsigned int Type, unsigned int Adjective, int Amount) {
	M_Money[Type][Adjective] += Amount;
}

void Bank::Set_Normalizer(double Normalizer) {
	if(abs(Normalizer) < DBL_EPSILON) {
		throw std::out_of_range{"Normalizer may not be set to 0"};
	}
	else
		M_Normalizer=Normalizer;
}
