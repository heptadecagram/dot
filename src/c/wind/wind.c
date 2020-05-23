#include <ncurses.h>
#include <locale.h>
#include <stdlib.h>
#include <time.h>

#include "log.h"

struct coord {
	int y, x;
};

struct {
	struct coord max;
} config;

struct {
	cchar_t ***glyphs;
	size_t height;
	size_t width;
} map;

void init_map(void)
{
	map.height = (unsigned)config.max.y;
	map.width = (unsigned)config.max.x;
	map.glyphs = malloc(map.height * sizeof(*map.glyphs));
	for (size_t n=0; n < map.height; ++n) {
		map.glyphs[n] = calloc(map.width, sizeof(map.glyphs[n]));
	}
}

void draw_map(void)
{
	for (size_t y=0; y < map.height; ++y) {
		move((int)y, 0);
		for (size_t x=0; x < map.width; ++x) {
			if (map.glyphs[y][x]) {
				add_wch(map.glyphs[y][x]);
			} else {
				addch(' ');
			}
		}
	}
}

void write_room(int y, int x, int height, int width)
{
	map.glyphs[y][x] = WACS_ULCORNER;
	for (int n=1; n < width-1; ++n) {
		map.glyphs[y][x+n] = WACS_HLINE;
	}
	map.glyphs[y][x+width-1] = WACS_URCORNER;

	for (int n=1; n < height-1; ++n) {
		map.glyphs[y+n][x] = WACS_VLINE;
		map.glyphs[y+n][x+width-1] = WACS_VLINE;
	}

	map.glyphs[y+height-1][x] = WACS_LLCORNER;
	for (int n=1; n < width-1; ++n) {
		map.glyphs[y+height-1][x+n] = WACS_HLINE;
	}
	map.glyphs[y+height-1][x+width-1] = WACS_LRCORNER;
}

void write_map(void)
{
		write_room(1, 1, rand() % ((int)map.height-2) + 2, rand() % ((int)map.width-2) + 2);
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
	getmaxyx(stdscr, config.max.y, config.max.x);
	init_map();
	write_map();

	while (input != 'q') {
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
