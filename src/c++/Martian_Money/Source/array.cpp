// File: array.cpp
// Author: Liam Bryan
// Language: C++
// First Created: 2002.07.23
// Last Modified: 2002.08.11

#ifndef LIAM_ARRAY_IMPLEMENT
# define LIAM_ARRAY_IMPLEMENT
#endif // LIAM_ARRAY_IMPLEMENT

#ifndef LIAM_ARRAY
# include "array.h"
#endif // LIAM_ARRAY

#include <iostream>

using namespace std ;

// Constructors
template<class Type>
Array<Type>::Array(void) {
	M_Height=1 ;
	M_Width=1 ;
	Type Blank ;
	M_Values.push_back(Blank) ;
}

template<class Type>
Array<Type>::Array(unsigned int Width, unsigned int Height) {
	if(Height==0 || Width==0) {
		cerr << "Array(" << Height << ", " << Width <<
			") cannot contain 0!" << endl ;
		exit(EXIT_FAILURE) ;
	}
	M_Height=Height ;
	M_Width=Width ;
	Type Blank ;
	for(unsigned int n=0; n<M_Height*M_Width; n++)
		M_Values.push_back(Blank) ;
}


// Destructor
template<typename Type>
Array<Type>::~Array(void) {
}


// Facilitators
template<typename Type>
void Array<Type>::Flood(Type Value) {
	for(unsigned int n=0; n<M_Height*M_Width; n++)
		M_Values[n]=Value ;
}


// Inspectors
template<typename Type>
Type Array<Type>::operator () (unsigned int Column, unsigned int Row) const {
	if(Row>=M_Height || Column>=M_Width) {
		cerr << "Array(" << Row << ", " << Column <<
			") out of range for size: " << M_Height << ", " <<
			M_Width << endl ;
		exit(EXIT_FAILURE) ;
	}
	else
		return M_Values[Column+Row*M_Height] ;
}

template<typename Type>
unsigned int Array<Type>::Get_Width(void) const {
	return M_Width ;
}

template<typename Type>
unsigned int Array<Type>::Get_Height(void) const {
	return M_Height ;
}


// Mutators
template<typename Type>
Type& Array<Type>::operator () (unsigned int Column, unsigned int Row) {
	if(Row>=M_Height || Column>=M_Width) {
		cerr << "&Array(" << Row << ", " << Column <<
			") out of range for size: " << M_Height << ", " <<
			M_Width << endl ;
		exit(EXIT_FAILURE) ;
	}
	else
		return M_Values[Column+Row*M_Height] ;
}

template<typename Type>
void Array<Type>::Resize(unsigned int Width, unsigned int Height) {
	if(Height==0 || Width==0) {
		cerr << "Array.Resize(" << Height << ", " << Width <<
			") cannot contain 0!" << endl ;
		exit(EXIT_FAILURE) ;
	}
	M_Width=Width ;
	M_Height=Height ;
	Type Blank ;
	M_Values.empty() ;
	for(unsigned int n=0; n<M_Height*M_Width; n++)
		M_Values.push_back(Blank) ;
}
