/*
 * Project  Name: None
 * File / Folder: size.c
 * File Language: c
 * Copyright (C): 2005 Liam Bryan
 * First  Author: Liam Bryan
 * First Created: 2005.04.21 14:11:12
 * Last Modifier: Liam Echlin
 * Last Modified: 2008.05.02

*/

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
	printf("size\ttype\n");
	printf("%d\t", sizeof(char) );
	printf("char\n");
	printf("%d\t", sizeof(short) );
	printf("short\n");
	printf("%d\t", sizeof(int) );
	printf("int\n");
	printf("%d\t", sizeof(long) );
	printf("long\n");
	printf("%d\t", sizeof(long int) );
	printf("long int\n");
	printf("%d\t", sizeof(long long) );
	printf("long long\n");
	printf("%d\t", sizeof(float) );
	printf("float\n");
	printf("%d\t", sizeof(double) );
	printf("double\n");
	printf("%d\t", sizeof(long double) );
	printf("long double\n");
	return EXIT_SUCCESS;
}
