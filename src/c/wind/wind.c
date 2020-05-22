#include <ncurses.h>
#include <locale.h>

#include "log.h"

int main(void)
{
	setlocale(LC_ALL, "");
	initscr();
	cbreak();
	noecho();

	nonl();
	intrflush(stdscr, false);
	keypad(stdscr, true);

	clear();
	mvaddwstr(3, 4, L"┌────┐");
	mvaddwstr(4, 4, L"│    │");
	mvaddwstr(5, 4, L"└────┘");
	refresh();
	getch();

	endwin();
}
