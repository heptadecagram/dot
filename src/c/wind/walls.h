#ifndef WALLS_H
 #define WALLS_H

#include <ncurses.h>

enum {
  // TRBL
  NORTH, EAST, SOUTH, WEST
};

extern cchar_t glyphs[];

int next_up(int code_point);
int next_right(int code_point);
int next_down(int code_point);
int next_left(int code_point);


#endif
