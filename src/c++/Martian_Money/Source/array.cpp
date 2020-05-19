#ifndef MMONEY_ARRAY
# include "array.h"
#endif // MMONEY_ARRAY

#include <iostream>

// Constructors
template<class Type>
Array<Type>::Array() {
	M_Height=1;
	M_Width=1;
	Type Blank;
	M_Values.push_back(Blank);
}

template<class Type>
Array<Type>::Array(unsigned int Width, unsigned int Height) {
	if(Height==0 || Width==0) {
		std::cerr << "Array(" << Height << ", " << Width <<
			") cannot contain 0!" << std::endl;
		std::exit(EXIT_FAILURE);
	}
	M_Height=Height;
	M_Width=Width;
	Type Blank;
	M_Values.resize(M_Height*M_Width, Blank);
}


// Facilitators
template<typename Type>
void Array<Type>::Flood(Type Value) {
	M_Values.resize(0);
	M_Values.resize(M_Height*M_Width, Value);
}


// Inspectors
template<typename Type>
Type Array<Type>::operator () (unsigned int Column, unsigned int Row) const {
	if(Row>=M_Height || Column>=M_Width) {
		std::cerr << "Array(" << Row << ", " << Column << ") out of range for size: " <<
			M_Height << ", " << M_Width << std::endl;
		std::exit(EXIT_FAILURE);
	}
	else
		return M_Values[Column+Row*M_Height];
}

template<typename Type>
unsigned int Array<Type>::Get_Width(void) const {
	return M_Width;
}

template<typename Type>
unsigned int Array<Type>::Get_Height(void) const {
	return M_Height;
}


// Mutators
template<typename Type>
Type& Array<Type>::operator () (unsigned int Column, unsigned int Row) {
	if(Row>=M_Height || Column>=M_Width) {
		std::cerr << "&Array(" << Row << ", " << Column <<
			") out of range for size: " << M_Height << ", " <<
			M_Width << std::endl;
		std::exit(EXIT_FAILURE);
	}
	else
		return M_Values[Column+Row*M_Height];
}

template<typename Type>
void Array<Type>::Resize(unsigned int Width, unsigned int Height) {
	if(Height==0 || Width==0) {
		std::cerr << "Array.Resize(" << Height << ", " << Width <<
			") cannot contain 0!" << std::endl;
		std::exit(EXIT_FAILURE);
	}
	M_Width=Width;
	M_Height=Height;
	Type Blank;
	M_Values.resize(Height*Width, Blank);
}

template class Array<double>;
template class Array<long>;
