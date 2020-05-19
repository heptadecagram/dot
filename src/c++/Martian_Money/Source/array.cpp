#include "array.h"

#include <iostream>

// Constructors
template<class Type>
Array<Type>::Array() {
	M_Height = 1;
	M_Width = 1;
	M_Values.resize(1);
}

template<class Type>
Array<Type>::Array(size_t Width, size_t Height) {
	if(Height == 0) {
		throw std::domain_error{"Height cannot be 0"};
	} else if(Width == 0) {
		throw std::domain_error{"Width cannot be 0"};
	}

	M_Height = Height;
	M_Width = Width;
	M_Values.resize(M_Height*M_Width);
}


// Facilitators
template<typename Type>
void Array<Type>::Flood(Type Value) {
	M_Values.resize(0);
	M_Values.resize(M_Height * M_Width, Value);
}


// Inspectors
template<typename Type>
Type Array<Type>::operator () (size_t Column, size_t Row) const {
	if(Row >= M_Height) {
		throw std::range_error{"Row out of range"};
	} else if (Column >= M_Width) {
		throw std::range_error{"Column out of range"};
	}

	return M_Values[Column+Row*M_Height];
}

template<typename Type>
size_t Array<Type>::Get_Width(void) const noexcept {
	return M_Width;
}

template<typename Type>
size_t Array<Type>::Get_Height(void) const noexcept {
	return M_Height;
}


// Mutators
template<typename Type>
Type& Array<Type>::operator () (size_t Column, size_t Row) {
	if(Row >= M_Height) {
		throw std::range_error{"Row out of range"};
	} else if (Column >= M_Width) {
		throw std::range_error{"Column out of range"};
	}

	return M_Values[Column+Row*M_Height];
}

template<typename Type>
void Array<Type>::Resize(size_t Width, size_t Height) {
	if(Height == 0) {
		throw std::domain_error{"Height cannot be 0"};
	} else if(Width == 0) {
		throw std::domain_error{"Width cannot be 0"};
	}

	M_Width = Width;
	M_Height = Height;
	M_Values.resize(Height*Width);
}

template class Array<double>;
template class Array<long>;
