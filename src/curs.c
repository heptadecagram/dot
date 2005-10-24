/* 
 * Project  Name: None
 * File / Folder: curs.c
 * File Language: c
 * Copyright (C): 2005 Richard Group, Inc.
 * First  Author: Liam Bryan
 * First Created: 2005.04.20 12:54:15
 * Last Modifier: Liam Bryan
 * Last Modified: 2005.04.20 12:57:20

*/

#include <curses.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
	printf("%s\n", curses_version() );

	return 0;
}
