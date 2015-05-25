//
// This file is designed for system-dependent configuration of input and output
// routines.  All functions that deal with keyboard input or terminal output
// are abstracted through this file.  Two constants, SCREEN_HEIGHT and
// SCREEN_WIDTH are defined as the height and width of the screen, respectively,
// in character spaces.  Sixteen colors are also defined, as well as their
// enumerated type (see file line 34).  Color Empty is not defined and should
// not be used.  All colors are foreground text on a black background.  To
// begin input-output functions, call Begin_Display(), which will call
// Begin_Color() automatically.  At the program's termination, End_Display()
// is automatically called.  To change the text color to a different color,
// use the Change_Color() function.  To output to the screen, use the
// Output_Char() and Output_String() functions.  Output_String() takes the same
// arguments and follows the same format as the printf(3) function, and cannot
// display more than SCREEN_WIDTH characters at once.  No text written
// will actually be displayed on the screen until Refresh() is called.  The
// functions Clear_Screen() and Clear_Line() clear the screen and clear up
// until the end of the cursor's current line, respectively, and also require
// Refresh() to view the changes.  Locate() will set the cursor's position
// on the screen according to its arguments.  Locate_X() and Locate_Y()
// return the X or Y coordinate of the cursor on the screen, respectively.
// Input_Char() accepts a single alphanumeric input from the keyboard and
// returns it.



#ifndef LIAM_IO
#define LIAM_IO

#define MINIMUM_SCREEN_HEIGHT 25
#define MINIMUM_SCREEN_WIDTH 80

#ifdef unix
#include <curses.h>
#define SCREEN_HEIGHT LINES
#define SCREEN_WIDTH COLS
#endif

#ifdef __DJGPP__
#define SCREEN_HEIGHT
#define SCREEN_WIDTH
#endif

#include <cstdarg>
#include <cstdlib>
using namespace std ;

#include "error.h"


enum Color {Empty, Red, Green, Brown, Navy, Magenta, Cyan, Grey,
	Black, Orange, Lime, Yellow, Blue, Pink, Aqua, White} ;

void Begin_Display(void) ;
int Begin_Color(void) ;

void Change_Color(Color color) ;

void Output_Char(char Character) ;
void Output_String(char* Format, ...) ;

char Input_Char(void) ;

void Locate(int X_Coord, int Y_Coord) ;
int Locate_X(void) ;
int Locate_Y(void) ;

void Clear_Screen(void) ;
void Clear_Line(void) ;
void Refresh(void) ;

void End_Display(void) ;

#endif // LIAM_IO
