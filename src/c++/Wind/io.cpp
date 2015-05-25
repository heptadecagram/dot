// Description of use and declared constants
#include "io.h"

void Begin_Display(void) {
#ifdef UNIX
	// All functions here are dependent upon the curses(3) library
	initscr() ;
	// The size of the screen must be at least standard VT100 size
	if(SCREEN_HEIGHT<MINIMUM_SCREEN_HEIGHT ||
			SCREEN_WIDTH<MINIMUM_SCREEN_WIDTH)
		Die("Begin_Display(%d,%d) out of range of minimum accepted values (%d, %d)",
				SCREEN_HEIGHT, SCREEN_WIDTH, MINIMUM_SCREEN_HEIGHT, MINIMUM_SCREEN_WIDTH) ;
	// Initialize colors, if necessary
	if(has_colors())
		Begin_Color() ;
	notimeout(stdscr, true) ;
	// Do not echo input
	noecho() ;
	// Do not buffer input, make it immediately available
	cbreak() ;
	// Initialize the numeric keypad for input
	keypad(stdscr, true) ;
#endif
	// Clean up any display disturbances
	atexit(&End_Display) ;
}

int Begin_Color(void) {
#ifdef UNIX
	// All functions here are dependent upon the curses(3) library
	start_color() ;
	use_default_colors() ;
	// Assign color pairs to the numbers 0-15
	for(int n=0; n<8; n++) {
		init_pair(n, n, COLOR_BLACK) ;
		init_pair(n+8, n, COLOR_BLACK) ;
	}
#endif
	return 0 ;
}

void Change_Color(Color color) {
	// There are only 15 known colors
	if(color>15 || color<0)
		Warn("Change_Color(%d) out of standard range(0-15)", color) ;
#ifdef UNIX
	// If the color is "high-intensity", curses(3) requires setting the
	// A_BOLD attribute.  Otherwise, turn it off.
	if(color>7)
		attrset(A_BOLD | COLOR_PAIR(color) ) ;
	else
		attrset(COLOR_PAIR(color) ) ;
#endif
}

void Output_Char(char Character) {
#ifdef UNIX
	// Simple printf(3) function for curses(3)
	printw("%c", Character) ;
#endif
}

void Output_String(char* Format, ...) {
	// Allocate memory for the string
	char* Buffer= new char[1023] ;
	// If there is not enough memory, exit the program
	if(Buffer==NULL)
		Die("Output_String(%s) Out of Memory", Format) ;
	va_list List ;
	va_start(List, Format) ;
	// If there is too much to write, exit the program
	if(vsprintf(Buffer, Format, List)>SCREEN_WIDTH)
		Warn("Output_String(%s,%s) Too Large", Buffer, Format) ;
	va_end(List) ;
#ifdef UNIX
	// Simple printf(3) function for curses(3)
	printw("%s", Buffer) ;
#endif
}

char Input_Char(void) {
	char Return=1 ;
#ifdef UNIX
	// Only alphanumeric values will be accepted
	while(Return<32 || Return>126)
		Return=getch() ;
#endif
	return Return ;
}

void Locate(int X_Coord, int Y_Coord) {
	// Insure that the value lies within accepted viewing space
	if(X_Coord>SCREEN_HEIGHT || Y_Coord>SCREEN_WIDTH ||
			X_Coord<1 || Y_Coord<1)
		Warn("Locate(%d, %d) Out of Range of standar(%d, %d)",
				X_Coord, Y_Coord,
				SCREEN_HEIGHT, SCREEN_WIDTH) ;
#ifdef UNIX
	// curses(3) function
	move(X_Coord, Y_Coord) ;
#endif
}

int Locate_X(void) {
	int Return = -1;
#ifdef UNIX
	int Y ;
	// curses(3) function
	getyx(stdscr, Return, Y) ;
#endif
	return Return ;
}

int Locate_Y(void) {
	int Return = -1;
#ifdef UNIX
	int X ;
	// curses(3) function
	getyx(stdscr, X, Return) ;
#endif
	return Return ;
}

void Clear_Screen(void) {
#ifdef UNIX
	// curses(3) function
	clear() ;
#endif
}

void Clear_Line(void) {
#ifdef UNIX
	// curses(3) function
	clrtoeol() ;
#endif
}

void Refresh(void) {
#ifdef UNIX
	// curses(3) function
	refresh() ;
#endif
}

void End_Display(void) {
#ifdef UNIX
	// Enable line buffering again
	nocbreak() ;
	// All inputs are now echoed again
	echo() ;
	// Remove allocated memory
	endwin() ;
#endif
}
