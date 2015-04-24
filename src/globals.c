/*
 * Compilation: $(CC) -lncurses -dM -o globals globals.c
 * Purpose    : This program will print out various global symbols.
 *              Note that the program is only valid when built, and
 *              thus should be re-compiled before use to avoid
 *              erroneous statements.
 */

#include <stdio.h>
#include <ncurses.h>

int main(int argc, char **argv) {

#ifdef __FreeBSD__
	printf("__FreeBSD__ Defined: %d\n", __FreeBSD__) ;
#else
	printf("__FreeBSD__ Not Defined\n") ;
#endif


#ifdef __ELF__
	printf("__ELF__ Defined: %d\n", __ELF__) ;
#else
	printf("__ELF__ Not Defined\n") ;
#endif


#ifdef __GNUC__
	printf("__GNUC__ Defined: %d\n", __GNUC__) ;
# ifdef __GNUC_MINOR__
	printf("\t__GNUC_MINOR__: %d\n", __GNUC_MINOR__) ;
# endif
#else
	printf("__GNUC__ Not Defined\n") ;
#endif


#ifdef NCURSES_VERSION_MAJOR
	printf("ncurses version: %s\n", curses_version() ) ;
	printf("NCURSES_VERSION_MAJOR Defined: %d\n", NCURSES_VERSION_MAJOR) ;
# ifdef NCURSES_VERSION_MINOR
	printf("\tNCURSES_VERSION_MINOR Defined: %d\n", NCURSES_VERSION_MINOR) ;
#  ifdef NCURSES_VERSION_PATCH
	printf("\tNCURSES_VERSION_PATCH Defined: %d\n", NCURSES_VERSION_PATCH) ;
#  endif
# endif
#else
	printf("NCURSES_VERSION_MAJOR Not Defined\n") ;
#endif

	return 0 ;
}
