/*
 * Project  Name: None
 * File / Folder: size.c
 * File Language: c
 * Copyright (C): 2005 Liam Bryan
 * First  Author: Liam Bryan
 * First Created: 2005.04.21 14:11:12
 * Last Modifier: Liam Echlin
 * Last Modified: 2010.11.30

*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
	printf("size\ttype\n");
	printf("%zu\t", sizeof(char) );
	printf("char\n");
	printf("%zu\t", sizeof(short) );
	printf("short\n");
	printf("%zu\t", sizeof(int) );
	printf("int\n");
	printf("%zu\t", sizeof(long) );
	printf("long\n");
	printf("%zu\t", sizeof(long int) );
	printf("long int\n");
	printf("%zu\t", sizeof(long long) );
	printf("long long\n");
	printf("%zu\t", sizeof(float) );
	printf("float\n");
	printf("%zu\t", sizeof(double) );
	printf("double\n");
	printf("%zu\t", sizeof(long double) );
	printf("long double\n");
	return EXIT_SUCCESS;
}
