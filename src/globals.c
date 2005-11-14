/* 
 * Project  Name: None
 * File / Folder: globals.c
 * File Language: c
 * Copyright (C): 2005 Liam Bryan
 * First  Author: Liam Bryan
 * First Created: 2002.07.12
 * Last Modifier: Liam Bryan
 * Last Modified: 2005.10.24 20:53:26
 * Compilation  : $(CC) -lncurses -O3 -o globals globals.c
 * Purpose      : This program will print out various global symbols.
 *                Note that the program is only valid when built, and
 *                thus should be re-compiled before use to avoid
 *                erroneous statements.
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


#ifdef i386
	printf("i386 Defined: %d\n", i386) ;
#else
	printf("i386 Not Defined\n") ;
#endif
#ifdef __i386
	printf("__i386 Defined: %d\n", __i386) ;
#else
	printf("__i386 Not Defined\n") ;
#endif
#ifdef __i386__
	printf("__i386__ Defined: %d\n", __i386__) ;
#else
	printf("__i386__ Not Defined\n") ;
#endif


#ifdef unix
	printf("unix Defined: %d\n", unix) ;
#else
	printf("unix Not Defined\n") ;
#endif
#ifdef __unix
	printf("__unix Defined: %d\n", __unix) ;
#else
	printf("__unix Not Defined\n") ;
#endif
#ifdef __unix__
	printf("__unix__ Defined: %d\n", __unix__) ;
#else
	printf("__unix__ Not Defined\n") ;
#endif


#ifdef __STDC__
	printf("__STDC__ Defined: %d\n", __STDC__) ;
#else
	printf("__STDC__ Not Defined\n") ;
#endif


#ifdef __DJGPP__
	printf("__DJGPP__ Defined: %d\n", __DJGPP__) ;
#else
	printf("__DJGPP__ Not Defined\n") ;
#endif

	return 0 ;
}