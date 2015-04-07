// File: bank.cpp
// Author: Liam Bryan
// Language: C++
// First Created: 2002.08.11
// Last Modified: 2002.08.12

#include "bank.h"

// Constructors
Bank::Bank(void) {
	M_Money.Flood(0) ;
	M_Rate.Flood(1.0) ;
	M_Normalizer=100.0 ;
}

Bank::Bank(Configuration Config) {
	M_Money.Resize(Config.Get_Variable_Count(Money_Type),
			Config.Get_Variable_Count(Money_Adjective) ) ;
	M_Money.Flood(0) ;
	M_Rate.Resize(Config.Get_Variable_Count(Money_Type),
			Config.Get_Variable_Count(Money_Adjective) ) ;
	M_Rate.Flood(1.0) ;
	M_Normalizer=(double)100 ;//Config.Get_Variable(Money_Start) ;
}


// Destructors
Bank::~Bank(void) {
}


// Facilitators
unsigned int Bank::Trade(unsigned int Offer_Type, unsigned int Offer_Adjective,
		unsigned int Offer_Amount, unsigned int Receive_Type,
		unsigned int Receive_Adjective) {
	if(Offer_Type>=M_Money.Get_Width() ||
			Offer_Adjective>=M_Money.Get_Height() ||
			Receive_Type>=M_Money.Get_Width() ||
			Receive_Adjective>M_Money.Get_Height() ) {
		cerr << "Bank.Trade(" << Offer_Type << ", " << Offer_Adjective<<
			", " << Receive_Type << ", " << Receive_Adjective <<
			") out of range for (" << M_Money.Get_Width() << ", " <<
			 M_Money.Get_Height() << ")!" << endl ;
		return 0 ;
	}
	else {
		unsigned int Result=(unsigned int)floor(M_Rate(Offer_Type,
				Offer_Adjective)/M_Rate(Receive_Type,
				Receive_Adjective)*Offer_Amount) ;
		M_Money(Offer_Type, Offer_Adjective)+=Offer_Amount ;
		M_Money(Receive_Type, Receive_Adjective)-=Result ;
		return Result ;
	}
}

void Bank::Make_Rates(void) {
	if(M_Normalizer==0.0) {
		cerr << "Bank.Make_Rates(" << M_Normalizer <<
			") cannot be 0!" << endl ;
		return ;
	}
	for(unsigned int n=0; n<M_Rate.Get_Width(); n++)
		for(unsigned int nn=0; nn<M_Rate.Get_Height(); nn++)
			M_Rate(n, nn)=1.0 + 2*atan(
					M_Money(n, nn)/M_Normalizer)/PI ;
}


// Inspectors
double Bank::Get_Rate(unsigned int Type, unsigned int Adjective) const {
	if(Adjective>=M_Rate.Get_Height() ||
			Type>=M_Rate.Get_Width()) {
		cerr << "Bank.Get_Rate(" << Type << ", " << Adjective <<
			") out of range for (" << M_Rate.Get_Width() <<
			", " << M_Rate.Get_Height() << ")!" << endl ;
		return 1 ;
	}
	else
		return M_Rate(Type, Adjective) ;
}

long Bank::Get_Money(unsigned int Type, unsigned int Adjective) const {
	if(Adjective>=M_Money.Get_Height() ||
			Type>=M_Money.Get_Width()) {
		cerr << "Bank.Get_Money(" << Type << ", " << Adjective <<
			") out of range for (" << M_Money.Get_Width() <<
			", " << M_Money.Get_Height() << ")!" << endl ;
		return 0 ;
	}
	else
		return M_Money(Type, Adjective) ;
}

double Bank::Get_Normalizer(void) const {
	return M_Normalizer ;
}

// Mutators
void Bank::Set_Money(unsigned int Type, unsigned int Adjective, long Amount) {
	if(Adjective>=M_Money.Get_Height() ||
			Type>=M_Money.Get_Width()) {
		cerr << "Bank.Set_Money(" << Type << ", " << Adjective <<
			", " << Amount << ") out of range for (" <<
			M_Money.Get_Width() << ", " << M_Money.Get_Height() <<
			", " << Amount << ")!" << endl ;
		return ;
	}
	else
		M_Money(Type, Adjective)+=Amount ;
}

void Bank::Set_Normalizer(double Normalizer) {
	if(Normalizer==0.0) {
		cerr << "Bank.Set_Normalizer(" << Normalizer <<
			") cannot be 0!" << endl ;
		return ;
	}
	else
		M_Normalizer=Normalizer ;
}
