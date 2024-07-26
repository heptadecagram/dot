#include <limits.h>
#include <stdint.h>
#include <stdio.h>

union end_test {
	uint16_t num;
	struct {
		uint8_t one;
		uint8_t two;
	};
};

int main(void)
{
	union end_test alfa;
	alfa.num = 0x0102;
	if (alfa.one == 0x01 && alfa.two == 0x02) {
		puts("Big-Endian");
	} else if (alfa.one == 0x02 && alfa.two == 0x01) {
		puts("Little-Endian");
	} else {
		puts("Endianess unknown");
	}

	puts("size\ttype");
	// Signed and unsigned are guaranteed to be the same size
	printf("%db\tchar\n", CHAR_BIT);
	printf("%zu\tshort\n", sizeof(short));
	printf("%zu\tint\n", sizeof(int));
	printf("%zu\tlong\n", sizeof(long));
	printf("%zu\tlong long\n", sizeof(long long));

	// _Complex types are guaranteed to be double their prefix
	printf("%zu\tfloat\n", sizeof(float));
	printf("%zu\tdouble\n", sizeof(double));
	printf("%zu\tlong double\n", sizeof(long double));

	printf("%zu\tsize_t\n", sizeof(size_t));

	// Non-void pointers are NOT guaranteed to be the same size as void pointers
	// But they to tend to be the same.  The most likely culprit are strings and
	// non-double floats.
	printf("%zu\tvoid*\n", sizeof(void*));
	printf("%zu\tchar*\n", sizeof(char*));
	printf("%zu\tint*\n", sizeof(int*));
	printf("%zu\tlong long*\n", sizeof(long long*));
	printf("%zu\tfloat*\n", sizeof(float*));
	printf("%zu\tlong double*\n", sizeof(long double*));
	// Function pointers have conversion guaranteed
	printf("%zu\tfunc*\n", sizeof(void(*)()));
}
