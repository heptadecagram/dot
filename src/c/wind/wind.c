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

// XXX To make a wide character understandable to curses, build a cchar_t structure.
// Second element should be an array of ints that make up the code point.
// attr, chars, ext_color
cchar_t glyphs[] = {
	{WA_NORMAL, {0x2500}, 0}, // ─ WACS_HLINE
	{WA_NORMAL, {0x2501}, 0}, // ━
	{WA_NORMAL, {0x2502}, 0}, // │ WACS_VLINE
	{WA_NORMAL, {0x2503}, 0}, // ┃
	{WA_NORMAL, {0x2504}, 0}, // ┄
	{WA_NORMAL, {0x2505}, 0}, // ┅
	{WA_NORMAL, {0x2506}, 0}, // ┆
	{WA_NORMAL, {0x2507}, 0}, // ┇
	{WA_NORMAL, {0x2508}, 0}, // ┈
	{WA_NORMAL, {0x2509}, 0}, // ┉
	{WA_NORMAL, {0x250a}, 0}, // ┊
	{WA_NORMAL, {0x250b}, 0}, // ┋
	{WA_NORMAL, {0x250c}, 0}, // ┌
	{WA_NORMAL, {0x250d}, 0}, // ┍
	{WA_NORMAL, {0x250e}, 0}, // ┎
	{WA_NORMAL, {0x250f}, 0}, // ┏
	{WA_NORMAL, {0x2510}, 0}, // ┐
	{WA_NORMAL, {0x2511}, 0}, // ┑
	{WA_NORMAL, {0x2512}, 0}, // ┒
	{WA_NORMAL, {0x2513}, 0}, // ┓
	{WA_NORMAL, {0x2514}, 0}, // └
	{WA_NORMAL, {0x2515}, 0}, // ┕
	{WA_NORMAL, {0x2516}, 0}, // ┖
	{WA_NORMAL, {0x2517}, 0}, // ┗
	{WA_NORMAL, {0x2518}, 0}, // ┘
	{WA_NORMAL, {0x2519}, 0}, // ┙
	{WA_NORMAL, {0x251a}, 0}, // ┚
	{WA_NORMAL, {0x251b}, 0}, // ┛
	{WA_NORMAL, {0x251c}, 0}, // ├
	{WA_NORMAL, {0x251d}, 0}, // ┝
	{WA_NORMAL, {0x251e}, 0}, // ┞
	{WA_NORMAL, {0x251f}, 0}, // ┟
	{WA_NORMAL, {0x2520}, 0}, // ┠
	{WA_NORMAL, {0x2521}, 0}, // ┡
	{WA_NORMAL, {0x256C}, 0}  // ╬
};

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
			add_wch(glyphs + 2);
		}

		switch (input) {
			case 'b':
				glyphs[2].chars[0] = 0x2550;
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
		}
	}

	endwin();
}
