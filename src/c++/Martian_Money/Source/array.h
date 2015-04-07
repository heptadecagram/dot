
#ifndef LIAM_ARRAY
# define LIAM_ARRAY

# include <cstdlib>
# include <vector>

template<typename Type>
class Array {
public:
	// Constructors
	Array(void) ;
	Array(unsigned int Width, unsigned int Height) ;

	// Destructor
	~Array(void) ;

	// Facilitators
	void Flood(Type Value) ;

	// Inspectors
	Type operator () (unsigned int Column, unsigned int Row) const ;
	unsigned int Get_Width(void) const ;
	unsigned int Get_Height(void) const ;

	// Mutators
	Type& operator () (unsigned int Column, unsigned int Row) ;
	void Resize(unsigned int Width, unsigned int Height) ;

protected:
	// Variables
	unsigned int M_Width ;
	unsigned int M_Height ;
	std::vector<Type> M_Values ;
} ;

# ifndef LIAM_ARRAY_IMPLEMENT
#  include "array.cpp"
# endif // LIAM_ARRAY_IMPLEMENT

#endif // LIAM_ARRAY
