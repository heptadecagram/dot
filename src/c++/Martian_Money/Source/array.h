#ifndef MMONEY_ARRAY
# define MMONEY_ARRAY

# include <vector>

template<typename Type>
class Array {
	public:
		class Row: protected std::vector<Type> {
			friend class Array;
			typedef std::vector<Type> Vector;

			public:
			using Vector::at;
			using Vector::operator[];
		};

		// Constructors
		Array();
		Array(size_t Width, size_t Height);

		// Facilitators
		void Flood(Type Value);

		// Inspectors
		Row operator[](size_t row) const;
		Row& operator[](size_t row);

		size_t Get_Width(void) const noexcept;
		size_t Get_Height(void) const noexcept;

		// Mutators
		void Resize(size_t Width, size_t Height);

	protected:
		// Variables
		size_t M_Width;
		size_t M_Height;
		std::vector<Row> M_Values;
};

extern template class Array<double>;
extern template class Array<int>;

#endif // MMONEY_ARRAY
