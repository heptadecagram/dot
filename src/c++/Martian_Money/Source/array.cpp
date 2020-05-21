#include "array.h"

#include <iostream>

// Constructors
template<class Type>
Array<Type>::Array() {
	M_Height = 0;
	M_Width = 0;
	M_Values.resize(0);
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

	M_Values.resize(M_Width);
	for (auto& r: M_Values) {
		r.resize(M_Height);
	}
}

template<typename T>
using ARow = typename Array<T>::Row;

template<typename T>
ARow<T> Array<T>::operator [](size_t Column) const {
	if (Column >= M_Width) {
		throw std::range_error{"Column out of range"};
	}

	return M_Values[Column];
}

template<typename T>
ARow<T>& Array<T>::operator [](size_t Column) {
	if (Column >= M_Width) {
		throw std::range_error{"Column out of range"};
	}

	return M_Values[Column];
}

// Facilitators
template<typename Type>
void Array<Type>::Flood(Type Value) {
	M_Values.resize(0);

	M_Values.resize(M_Width);
	for (auto& r: M_Values) {
		r.resize(M_Height, Value);
	}
}


template<typename Type>
size_t Array<Type>::Get_Width(void) const noexcept {
	return M_Width;
}

template<typename Type>
size_t Array<Type>::Get_Height(void) const noexcept {
	return M_Height;
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
	M_Values.resize(M_Width);
	for (auto& r: M_Values) {
		r.resize(0);
		r.resize(M_Height);
	}
}

template class Array<double>;
template class Array<int>;
