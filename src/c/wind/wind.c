#include <ncurses.h>
#include <locale.h>
#include <stdlib.h>
#include <time.h>

#include "log.h"
#include "walls.h"

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
				addwstr(L"█");
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

	for (int n=0; n < 3; ++n) {
		// 3, from 2 walls separated by at least one walkable middle
		// 10, max of 2 wall plus 8 middle tiles
		int height = 3 + rand() % 10;
		int width = 3 + rand() % 10;

		int y = rand() % ((int)map.height-height);
		int x = rand() % ((int)map.width-width);
		write_room(y, x, height, width);
	}
}

int main(int argc, char *argv[])
{
	time_t seed;
	if (argc == 1) {
		seed = time(NULL);
	} else if (argc == 2) {
		seed = strtol(argv[1], NULL, 10);
	} else {
		fprintf(stderr, "Usage: %s [seed]\n", argv[0]);
		return 1;
	}

	printf("%ld\n", seed);
	srand((unsigned)seed);
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
	size_t trail_index = 0;

	clear();
	draw_map();
	while (input != 'q') {
		mvaddch(player.y, player.x, '@');
		move(player.y, player.x);
		refresh();

		input = getch();
		if (map.glyphs[player.y][player.x]) {
			add_wch(map.glyphs[player.y][player.x]);
		} else {
			add_wch(&glyphs[trail_index]);
		}

		switch (input) {
			case KEY_SRIGHT:
				++trail_index;
				break;
			case KEY_SLEFT:
				--trail_index;
				break;
			case KEY_UP:
				if (player.y > 0 && !map.glyphs[player.y-1][player.x]) {
					--player.y;
				}
				break;
			case KEY_DOWN:
				if (player.y < config.max.y-1 && !map.glyphs[player.y+1][player.x]) {
					++player.y;
				}
				break;
			case KEY_LEFT:
				if (player.x > 0 && !map.glyphs[player.y][player.x-1]) {
					--player.x;
				}
				break;
			case KEY_RIGHT:
				if (player.x < config.max.x-1 && !map.glyphs[player.y][player.x+1]) {
					++player.x;
				}
				break;
				// Plenty big for formatting an int
				char buf[16];
			default:
				snprintf(buf, sizeof(buf), "%d ", input);
				mvaddstr(config.max.y-1, 0, buf);
		}
	}

	endwin();
}
