// File: random.h
// Author: Liam Bryan
// Language: C++
// Last Modified: 2002.07.10

#ifndef LIAM_RANDOM
#define LIAM_RANDOM

#include <ctime>
#include <cstdlib>

void Start_Random(void) ;

int Random(int Max) ;

int Random(int Min, int Max) ;

float Random_Percent(void) ;

int Dice(int Number, int Size, int Modifier=0) ;

int Dice(char *Roll) ;

#endif // LIAM_RANDOM
