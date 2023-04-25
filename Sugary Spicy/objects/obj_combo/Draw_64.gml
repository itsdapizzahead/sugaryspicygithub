if global.combostart = true and visible = true {
	draw_set_font(fnt_textregular)
	draw_text(430,100,string("Combo x" + string(global.combocount)))
	var barxx = -26
	var baryy = 30
	draw_sprite(spr_barpop, 0, (480 + barxx), (120 + baryy))
	var sw = sprite_get_width(spr_barpop)
	var sh = sprite_get_height(spr_barpop)
	var b = (combo / 150)
	draw_sprite_part(spr_barpop, 1, 0, 0, (sw * b), sh, (480 + barxx), (120 + baryy))
}