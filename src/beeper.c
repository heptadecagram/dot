/*
 * Project  Name: None
 * File / Folder: beeper.c
 * File Language: c
 * Copyright (C): 2005 Liam Bryan
 * First  Author: Liam Bryan
 * First Created: 2002.07.12
 * Last Modifier: Liam Echlin
 * Last Modified: 2008.04.22 10:10:27
 *
 * Compilation  : $(CC) -O3 -o beeper beeper.c
 * Purpose      : This program sounds the terminal bell.  It is useful to
 *                call this program after a long string of commands, so as
 *                to alert the user (who may be off doing something else
 *                by then) that the command string has finished.
 */

#include <stdio.h>

int main(void) {
	printf("%c", 7);
	return 0;
}
