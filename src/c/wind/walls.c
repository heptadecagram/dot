#include "walls.h"

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

