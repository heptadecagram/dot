
#include <stdio.h>

int main(void) {
	printf("size\ttype\n");
	// Signed and unsigned are guaranteed to be the same size
	printf("%zu\tchar\n", sizeof(char));
	printf("%zu\tshort\n", sizeof(short));
	printf("%zu\tint\n", sizeof(int));
	printf("%zu\tlong int\n", sizeof(long int));
	printf("%zu\tlong long\n", sizeof(long long int));

	// _Complex types are guaranteed to be double their prefix
	printf("%zu\tfloat\n", sizeof(float));
	printf("%zu\tdouble\n", sizeof(double));
	printf("%zu\tlong double\n", sizeof(long double));

	printf("%zu\tsize_t\n", sizeof(size_t));

	// Non-void pointers are NOT guaranteed to be the same size as void pointers
	printf("%zu\tvoid*\n", sizeof(void*));
	printf("%zu\tchar*\n", sizeof(char*));
	printf("%zu\tint*\n", sizeof(int*));
	printf("%zu\tlong double*\n", sizeof(long double*));
	// Function pointers have conversion guaranteed
	printf("%zu\tfunc*\n", sizeof(int(*)(int, int)));

	return 0;
}
