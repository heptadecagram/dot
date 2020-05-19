#ifndef MMONEY_ARRAY
# define MMONEY_ARRAY

# include <cstdlib>
# include <vector>

template<typename Type>
class Array {
public:
	// Constructors
	Array();
	Array(unsigned int Width, unsigned int Height);

	// Facilitators
	void Flood(Type Value);

	// Inspectors
	Type operator () (unsigned int Column, unsigned int Row) const;
	unsigned int Get_Width(void) const;
	unsigned int Get_Height(void) const;

	// Mutators
	Type& operator () (unsigned int Column, unsigned int Row);
	void Resize(unsigned int Width, unsigned int Height);

protected:
	// Variables
	unsigned int M_Width;
	unsigned int M_Height;
	std::vector<Type> M_Values;
};

extern template class Array<double>;
extern template class Array<long>;

#endif // MMONEY_ARRAY
