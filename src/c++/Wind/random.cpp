#include "random.h"

void Start_Random(void) {
	srandom(unsigned(time(NULL) ) ) ;
}

int Random(int Min, int Max) {
	return random()%(Max-Min+1)+Min ;
}

int Random(int Max) {
	return random()%Max+1 ;
}

float Random_Percent(void) {
	return float(Random(0, 100) )/100 ;
}

int Dice(int Number, int Type, int Modifier) {
	int Returner=Modifier ;
	for(int n=1; n<=Number; n++)
		Returner+=Random(Type) ;
	return Returner ;
}
