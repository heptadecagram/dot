#include "walls.h"

// Cycle nothing, thin line, thick line (double line to be added later)
int next_up(int code_point)
{
  switch(code_point) {
    case ' ':
      return L'╵';
    case L'─':
      return L'┴';
    case L'━':
      return L'┷';
    case L'│':
      return L'╿';
    case L'┃':
      return L'╻';
    case L'┌':
      return L'├';
    case L'┍':
      return L'┝';
    case L'┎':
      return L'┟';
    case L'┏':
      return L'┢';
    case L'┐':
      return L'┤';
    case L'┑':
      return L'┥';
    case L'┒':
      return L'┧';
    case L'┓':
      return L'┪';
    case L'└':
      return L'┖';
    case L'┕':
      return L'┗';
    case L'┖':
      return L'╶';
    case L'┗':
      return L'╺';
    case L'┘':
      return L'┚';
    case L'┙':
      return L'┛';
    case L'┚':
      return L'╴';
    case L'┛':
      return L'╸';

    case L'├':
      return L'┞';
    case L'┝':
      return L'┡';
    case L'┞':
      return L'┌';
    case L'┟':
      return L'┠';
    case L'┠':
      return L'┎';
    case L'┡':
      return L'┍';
    case L'┢':
      return L'┣';
    case L'┣':
      return L'┏';

    case L'┤':
      return L'┦';
    case L'┥':
      return L'┩';
    case L'┦':
      return L'┐';
    case L'┧':
      return L'┨';
    case L'┨':
      return L'┒';
    case L'┩':
      return L'┑';
    case L'┪':
      return L'┫';
    case L'┫':
      return L'┓';

    case L'┬':
      return L'┼';
    case L'┭':
      return L'┽';
    case L'┮':
      return L'┾';
    case L'┯':
      return L'┿';
    case L'┰':
      return L'╁';
    case L'┱':
      return L'╅';
    case L'┲':
      return L'╆';
    case L'┳':
      return L'╈';

    case L'┴':
      return L'┸';
    case L'┵':
      return L'┹';
    case L'┶':
      return L'┺';
    case L'┷':
      return L'┻';
    case L'┸':
      return L'─';
    case L'┹':
      return L'╾';
    case L'┺':
      return L'╼';
    case L'┻':
      return L'━';

    case L'┼':
      return L'╀';
    case L'┽':
      return L'╃';
    case L'┾':
      return L'╄';
    case L'┿':
      return L'╇';
    case L'╀':
      return L'┬';
    case L'╁':
      return L'╂';
    case L'╂':
      return L'┰';
    case L'╃':
      return L'┭';
    case L'╄':
      return L'┮';
    case L'╅':
      return L'╉';
    case L'╆':
      return L'╊';
    case L'╇':
      return L'┯';
    case L'╈':
      return L'╋';
    case L'╉':
      return L'┱';
    case L'╊':
      return L'┲';
    case L'╋':
      return L'┳';

    case L'╴':
      return L'┘';
    case L'╵':
      return L'╹';
    case L'╶':
      return L'└';
    case L'╷':
      return L'│';
    case L'╸':
      return L'┙';
    case L'╹':
      return ' ';
    case L'╺':
      return L'┕';
    case L'╻':
      return L'╽';
    case L'╼':
      return L'┶';
    case L'╽':
      return L'┃';
    case L'╾':
      return L'┵';
    case L'╿':
      return L'╷';
    default:
      // Default to empty
      return ' ';
  }
}

int next_right(int code_point)
{
  switch(code_point) {
    case ' ':
      return L'╶';
    case L'─':
      return L'╼';
    case L'━':
      return L'╸';
    case L'│':
      return L'├';
    case L'┃':
      return L'┠';
    case L'┌':
      return L'┍';
    case L'┍':
      return L'╷';
    case L'┎':
      return L'┏';
    case L'┏':
      return L'╻';
    case L'┐':
      return L'┬';
    case L'┑':
      return L'┭';
    case L'┒':
      return L'┰';
    case L'┓':
      return L'┱';
    case L'└':
      return L'┕';
    case L'┕':
      return L'╵';
    case L'┖':
      return L'┗';
    case L'┗':
      return L'╹';
    case L'┘':
      return L'┴';
    case L'┙':
      return L'┵';
    case L'┚':
      return L'┸';
    case L'┛':
      return L'┹';

    case L'├':
      return L'┝';
    case L'┝':
      return L'│';
    case L'┞':
      return L'┡';
    case L'┟':
      return L'┢';
    case L'┠':
      return L'┣';
    case L'┡':
      return L'╿';
    case L'┢':
      return L'╽';
    case L'┣':
      return L'┃';

    case L'┤':
      return L'┼';
    case L'┥':
      return L'┽';
    case L'┦':
      return L'╀';
    case L'┧':
      return L'╅';
    case L'┨':
      return L'┿';
    case L'┩':
      return L'╃';
    case L'┪':
      return L'╅';
    case L'┫':
      return L'╉';

    case L'┬':
      return L'┮';
    case L'┭':
      return L'┯';
    case L'┮':
      return L'┐';
    case L'┯':
      return L'┑';
    case L'┰':
      return L'┲';
    case L'┱':
      return L'┳';
    case L'┲':
      return L'┒';
    case L'┳':
      return L'┓';

    case L'┴':
      return L'┶';
    case L'┵':
      return L'┷';
    case L'┶':
      return L'┘';
    case L'┷':
      return L'┙';
    case L'┸':
      return L'┺';
    case L'┹':
      return L'┻';
    case L'┺':
      return L'┚';
    case L'┻':
      return L'┛';

    case L'┼':
      return L'┾';
    case L'┽':
      return L'┿';
    case L'┾':
      return L'┤';
    case L'┿':
      return L'┥';
    case L'╀':
      return L'╄';
    case L'╁':
      return L'╆';
    case L'╂':
      return L'╊';
    case L'╃':
      return L'╇';
    case L'╄':
      return L'┦';
    case L'╅':
      return L'╈';
    case L'╆':
      return L'┧';
    case L'╇':
      return L'┩';
    case L'╈':
      return L'┪';
    case L'╉':
      return L'╋';
    case L'╊':
      return L'┨';
    case L'╋':
      return L'┫';

    case L'╴':
      return L'─';
    case L'╵':
      return L'└';
    case L'╶':
      return L'╺';
    case L'╷':
      return L'┌';
    case L'╸':
      return L'╾';
    case L'╹':
      return L'┖';
    case L'╺':
      return ' ';
    case L'╻':
      return L'┎';
    case L'╼':
      return L'╴';
    case L'╽':
      return L'┟';
    case L'╾':
      return L'━';
    case L'╿':
      return L'┞';
    default:
      // Default to empty
      return ' ';
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

	{WA_NORMAL, {L'┌'}, 0}, // ┌
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
	{WA_NORMAL, {0x2522}, 0}, // ┢
	{WA_NORMAL, {0x2523}, 0}, // ┣

	{WA_NORMAL, {0x2524}, 0}, // ┤
	{WA_NORMAL, {0x2525}, 0}, // ┥
	{WA_NORMAL, {0x2526}, 0}, // ┦
	{WA_NORMAL, {0x2527}, 0}, // ┧
	{WA_NORMAL, {0x2528}, 0}, // ┨
	{WA_NORMAL, {0x2529}, 0}, // ┩
	{WA_NORMAL, {0x252a}, 0}, // ┪
	{WA_NORMAL, {0x252b}, 0}, // ┫

	{WA_NORMAL, {0x252c}, 0}, // ┬
	{WA_NORMAL, {0x252d}, 0}, // ┭
	{WA_NORMAL, {0x252e}, 0}, // ┮
	{WA_NORMAL, {0x252f}, 0}, // ┯
	{WA_NORMAL, {0x2530}, 0}, // ┰
	{WA_NORMAL, {0x2531}, 0}, // ┱
	{WA_NORMAL, {0x2532}, 0}, // ┲
	{WA_NORMAL, {0x2533}, 0}, // ┳

	{WA_NORMAL, {0x2534}, 0}, // ┴
	{WA_NORMAL, {0x2535}, 0}, // ┵
	{WA_NORMAL, {0x2536}, 0}, // ┶
	{WA_NORMAL, {0x2537}, 0}, // ┷
	{WA_NORMAL, {0x2538}, 0}, // ┸
	{WA_NORMAL, {0x2539}, 0}, // ┹
	{WA_NORMAL, {0x253a}, 0}, // ┺
	{WA_NORMAL, {0x253b}, 0}, // ┻

	{WA_NORMAL, {0x253c}, 0}, // ┼
	{WA_NORMAL, {0x253d}, 0}, // ┽
	{WA_NORMAL, {0x253e}, 0}, // ┾
	{WA_NORMAL, {0x253f}, 0}, // ┿
	{WA_NORMAL, {0x2540}, 0}, // ╀
	{WA_NORMAL, {0x2541}, 0}, // ╁
	{WA_NORMAL, {0x2542}, 0}, // ╂
	{WA_NORMAL, {0x2543}, 0}, // ╃
	{WA_NORMAL, {0x2544}, 0}, // ╄
	{WA_NORMAL, {0x2545}, 0}, // ╅
	{WA_NORMAL, {0x2546}, 0}, // ╆
	{WA_NORMAL, {0x2547}, 0}, // ╇
	{WA_NORMAL, {0x2548}, 0}, // ╈
	{WA_NORMAL, {0x2549}, 0}, // ╉
	{WA_NORMAL, {0x254a}, 0}, // ╊
	{WA_NORMAL, {0x254b}, 0}, // ╋

	{WA_NORMAL, {0x254c}, 0}, // ╌
	{WA_NORMAL, {0x254d}, 0}, // ╍
	{WA_NORMAL, {0x254e}, 0}, // ╎
	{WA_NORMAL, {0x254f}, 0}, // ╏
	{WA_NORMAL, {0x2550}, 0}, // ═
	{WA_NORMAL, {0x2551}, 0}, // ║
	{WA_NORMAL, {0x2552}, 0}, // ╒
	{WA_NORMAL, {0x2553}, 0}, // ╓
	{WA_NORMAL, {0x2554}, 0}, // ╔
	{WA_NORMAL, {0x2555}, 0}, // ╕
	{WA_NORMAL, {0x2556}, 0}, // ╖
	{WA_NORMAL, {0x2557}, 0}, // ╗
	{WA_NORMAL, {0x2558}, 0}, // ╘
	{WA_NORMAL, {0x2559}, 0}, // ╙
	{WA_NORMAL, {0x255a}, 0}, // ╚
	{WA_NORMAL, {0x255b}, 0}, // ╛
	{WA_NORMAL, {0x255c}, 0}, // ╜
	{WA_NORMAL, {0x255d}, 0}, // ╝

	{WA_NORMAL, {0x255e}, 0}, // ╞
	{WA_NORMAL, {0x255f}, 0}, // ╟
	{WA_NORMAL, {0x2560}, 0}, // ╠
	{WA_NORMAL, {0x2561}, 0}, // ╡
	{WA_NORMAL, {0x2562}, 0}, // ╢
	{WA_NORMAL, {0x2563}, 0}, // ╣
	{WA_NORMAL, {0x2564}, 0}, // ╤
	{WA_NORMAL, {0x2565}, 0}, // ╥
	{WA_NORMAL, {0x2566}, 0}, // ╦
	{WA_NORMAL, {0x2567}, 0}, // ╧
	{WA_NORMAL, {0x2568}, 0}, // ╨
	{WA_NORMAL, {0x2569}, 0}, // ╩
	{WA_NORMAL, {0x256a}, 0}, // ╪
	{WA_NORMAL, {0x256b}, 0}, // ╫
	{WA_NORMAL, {0x256c}, 0}  // ╬
};

