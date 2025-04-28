from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_title, as_rgb
from kitty.utils import color_as_int


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    orig_bg = screen.cursor.bg
    orig_fg = screen.cursor.fg
    screen.cursor.fg = orig_bg
    screen.cursor.bg = as_rgb(color_as_int(draw_data.default_bg))
    if index == 1:
        screen.draw(" ")
    screen.cursor.fg = orig_fg
    screen.cursor.bg = orig_bg
    screen.draw(" ")
    draw_title(draw_data, screen, tab, index, max(0, max_tab_length - 8))
    extra = screen.cursor.x - before - max_tab_length
    if extra > 0:
        screen.cursor.x = before
        draw_title(draw_data, screen, tab, index, max(0, max_tab_length - 4))
        extra = screen.cursor.x - before - max_tab_length
        if extra > 0:
            screen.cursor.x -= extra + 1
            screen.draw("…")
    screen.draw(" ")
    screen.cursor.fg = orig_bg
    screen.cursor.bg = as_rgb(color_as_int(draw_data.default_bg))
    screen.draw("")
    screen.cursor.fg = orig_fg
    screen.cursor.bg = orig_bg
    end = screen.cursor.x
    screen.cursor.bg = as_rgb(color_as_int(draw_data.default_bg))
    return end
