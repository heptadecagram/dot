/*
 * Project  Name: None
 * File / Folder: size.c
 * File Language: c
 * Copyright (C): 2005 Liam Bryan
 * First  Author: Liam Bryan
 * First Created: 2005.04.21 14:11:12
 * Last Modifier: Liam Echlin
 * Last Modified: 2014.04.30

*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
	printf("size\ttype\n");
	printf("%zu\tchar\n", sizeof(char) );
	printf("%zu\tshort\n", sizeof(short) );
	printf("%zu\tint\n", sizeof(int) );
	printf("%zu\tlong\n", sizeof(long) );
	printf("%zu\tlong int\n", sizeof(long int) );
	printf("%zu\tlong long\n", sizeof(long long) );
	printf("%zu\tfloat\n", sizeof(float) );
	printf("%zu\tdouble\n", sizeof(double) );
	printf("%zu\tlong double\n", sizeof(long double) );
	printf("%zu\tsize_t\n", sizeof(size_t) );
	printf("%zu\tchar*\n", sizeof(char*) );
	printf("%zu\tlong double*\n", sizeof(long double*) );
	printf("%zu\tvoid*\n", sizeof(void*) );
	printf("%zu\tfunc*\n", sizeof(int(*)(int, int)));
	return EXIT_SUCCESS;
}
