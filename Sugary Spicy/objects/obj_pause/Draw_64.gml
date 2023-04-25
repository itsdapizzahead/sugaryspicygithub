bgx++
bgy++
draw_sprite_tiled(bg_pause, 0, bgx, bgy)
for (var i = 0; i < array_length(menu); i++) {
	draw_set_color(select == i ? c_red : c_white)
	draw_set_font(global.ltfontREAL)
	draw_text(480, 260 + 32 * i,string_upper(menu[i]))
}
draw_set_halign(fa_center)
draw_set_halign(fa_left)
draw_set_color(c_white)
#region // draw the score
draw_sprite(spr_pizzascore,0,480,500)
draw_set_halign(fa_middle)
draw_text(480,500,string(global.collect))
if global.collect {
	draw_set_font(global.ltfont)	
}
#endregion

#region //detrixies
if global.detrixies = 0 {
	image_alpha = 0.5
	draw_sprite(spr_detrixiebox,image_alpha = 0.5,480,600)
}
if global.detrixies = 1 {
	draw_sprite(spr_detrixiebox,image_alpha = 1,480,600)
}
#endregion