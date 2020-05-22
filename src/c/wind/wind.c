#include <ncurses.h>
#include <locale.h>
#include <stdlib.h>

#include "log.h"

struct coord {
	int y, x;
};

struct {
	struct coord max;
} config;

void write_room(int y, int x, int width, int height)
{
	mvadd_wch(y, x, WACS_ULCORNER);
	for (int n=1; n < width-1; ++n) {
		add_wch(WACS_HLINE);
	}
	add_wch(WACS_URCORNER);

	for (int n=1; n < height-1; ++n) {
		mvadd_wch(y+n, x, WACS_VLINE);
		mvadd_wch(y+n, x+width-1, WACS_VLINE);
	}

	mvadd_wch(y+height-1, x, WACS_LLCORNER);
	for (int n=1; n < width-1; ++n) {
		add_wch(WACS_HLINE);
	}
	add_wch(WACS_LRCORNER);
}

void draw_map(void)
{
		write_room(1, 1, rand() % (config.max.x-2) + 2, rand() % (config.max.y-2) + 2);
}

int main(void)
{
	srand((unsigned)time(NULL));
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
		getmaxyx(stdscr, config.max.y, config.max.x);
		clear();
		draw_map();

		mvaddch(player.y, player.x, '@');
		move(player.y, player.x);
		refresh();
		input = getch();
		switch (input) {
			case KEY_UP:
				if (player.y > 0) {
					--player.y;
				}
				break;
			case KEY_DOWN:
				if (player.y < config.max.y-1) {
					++player.y;
				}
				break;
			case KEY_LEFT:
				if (player.x > 0) {
					--player.x;
				}
				break;
			case KEY_RIGHT:
				if (player.x < config.max.x-1) {
					++player.x;
				}
				break;
		}
	}

	endwin();
}
