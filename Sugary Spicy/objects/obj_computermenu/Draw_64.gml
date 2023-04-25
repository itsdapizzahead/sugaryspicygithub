draw_sprite_tiled(bg_lasthub, 0, bg_x, bg_y)
draw_set_halign(fa_middle)
draw_text(235,147,levels[lvl_select][0])
draw_text_ext(235, 265, levels[lvl_select][1], 24, 377)

bg_x--
bg_y++