#include <ncurses.h>
#include <locale.h>

#include "log.h"

void write_room(int y, int x, int width, int height)
{
	mvaddwstr(y, x, L"┌");
	for (int n=1; n < width-1; ++n) {
		addwstr(L"─");
	}
	addwstr(L"┐");

	for (int n=1; n < height-1; ++n) {
		mvaddwstr(y+n, x, L"│");
		mvaddwstr(y+n, x+width-1, L"│");
	}

	mvaddwstr(y+height-1, x, L"└");
	for (int n=1; n < width-1; ++n) {
		addwstr(L"─");
	}
	addwstr(L"┘");
}

struct coord {
	int y, x;
};

int main(void)
{
	setlocale(LC_ALL, "");
	initscr();
	cbreak();
	noecho();

	nonl();
	intrflush(stdscr, false);
	keypad(stdscr, true);

	struct coord player = { 15, 15 };
	int input = '\0';

	while (input != 'q') {
		clear();
		write_room(2, 4, 5, 10);

		write_room(15, 20, 2, 2);

		mvaddch(player.y, player.x, '@');
		move(player.y, player.x);
		refresh();
		input = getch();
		switch (input) {
			case KEY_UP:
				player.y--;
				break;
			case KEY_DOWN:
				player.y++;
				break;
			case KEY_LEFT:
				player.x--;
				break;
			case KEY_RIGHT:
				player.x++;
				break;
		}
	}

	endwin();
}
