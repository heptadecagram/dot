/*
 * Compilation: $(CC) -O3 -o beeper beeper.c
 * Purpose    : This program sounds the terminal bell.  It is useful to
 *              call this program after a long string of commands, so as
 *              to alert the user (who may be off doing something else
 *              by then) that the command string has finished.
 */

#include <stdio.h>

int main(void) {
	printf("%c", 7);
	return 0;
}
