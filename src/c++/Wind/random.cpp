#include <random>

#include "random.h"

static std::mt19937 gen{};

int Random(int Min, int Max) {
	return Random(Max - Min) + Min;
}

int Random(int Max) {
	return gen() % Max;
}

double Random_Percent(void) {
	return Random(100)/100.0;
}

int Dice(int Number, int Type, int Modifier) {
	int Returner=Modifier ;
	for(int n=1; n<=Number; n++)
		Returner+=Random(Type) ;
	return Returner ;
}
