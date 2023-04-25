if !visible exit;
draw_sprite(spr_pizzascore,0,128 + irandom_range(shakeit,shakeit2),125 + irandom_range(shakeit,shakeit2))
draw_set_font(global.ltfont)
draw_set_halign(fa_middle)
if global.heat {
	hud_frame += hud_speed;
	draw_sprite(hud, hud_frame, 128,175);
} else if !global.heat {
	draw_sprite(spr_heatmeter1,0,128,175)	
}
draw_text(128, 64, string(global.collect))

draw_set_halign(fa_center)
draw_set_font(fnt_textregular)
if global.panic {
	//draw_sprite(spr_timer_clock,0,480 + irandom_range(-1,1),global.timerpos + irandom_range(-1,1))
	var col = 255 - panictime_color
	draw_set_color(make_color_rgb(255, col, col))
	var spacer = global.timer[1] < 10 ? ":0" : ":"
	draw_set_font(global.ltfontREAL)
	var s = 1
	draw_text((480 + irandom_range((-s), s)),global.timerpos + irandom_range((-s), s),string(global.timer[0]) + spacer + string(global.timer[1]))
	draw_set_color(c_white)
}
/* BROKEN
if global.panic
{
    var _fill = global.fill
    var _currentbarpos = (chunkmax - _fill)
    _perc = (_currentbarpos / chunkmax)
    var _max_x = 299
    var _barpos = (_max_x * _perc)
    if (!surface_exists(bar_surface))
        bar_surface = surface_create(298, 30)
    var _barfillpos = (floor(_barpos) + 13)
    if (_barfillpos > 0)
    {
        surface_resize(bar_surface, _barfillpos, 30)
        surface_set_target(bar_surface)
        draw_clear_alpha(c_black, 0)
        var clip_x = (timer_x + 3)
        var clip_y = (timer_y + 5)
        for (i = 0; i < 3; i++)
            draw_sprite(spr_timer_barfill, 0, (barfill_x + (i * 173)), 0)
        surface_reset_target()
        draw_surface(bar_surface, clip_x, clip_y)
    }
    draw_sprite(spr_timer_bar, -1, timer_x, timer_y)
    draw_sprite(johnface_sprite, johnface_index, ((timer_x + 13) + _barpos), (timer_y + 20))
    var timerspr = pizzaface_sprite
    draw_sprite(timerspr, pizzaface_index, (timer_x + 320), (timer_y + 10))
    var minutes = 0
    for (var seconds = ceil((global.fill / 12)); seconds > 59; seconds -= 60)
        minutes++
    if (seconds < 10)
        seconds = gml_Script_concat("0", seconds)
    else
        seconds = string(seconds)
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    draw_set_font(global.ltfontREAL)
    draw_text((timer_x + 153), (timer_y + 18), gml_Script_concat(minutes, ":", seconds))
}
else if surface_exists(bar_surface)
    surface_free(bar_surface)
*/
if global.armorytimer {
	var col = 255 - panictime_color
	draw_set_color(make_color_rgb(255, col, col))
	var spacer = global.settimer[1] < 10 ? ":0" : ":"
	draw_set_font(global.armoryfont)
	draw_text(480,timerpos,string(global.settimer[0]) + spacer + string(global.settimer[1]))
	draw_set_color(c_white)
}


if displaymessage {
	draw_text(480, 248, msg_text)
	draw_set_font(global.ltfont)
}
draw_set_halign(fa_left)

switch hudstate // the order of cases matters
{
	case hudstates.hurt:
		draw_sprite_ext(spr_plrhud_hurt,0,930,32,-1,1,0,c_white,1)
		break;
	case hudstates.yippee:
		draw_sprite_ext(spr_plrhud_yippee,0,930,32,-1,1,0,c_white,1)
		break;
	case hudstates.dash:
		dashhud_frame += dashhud_speed;
		draw_sprite_ext(dashhud, dashhud_frame, 930, 32,-1,1,0,c_white,1);
		break;
	case hudstates.normal:
		draw_sprite_ext(global.panic ? spr_plrhud_panic : spr_plrhud,0,930,32,-1,1,0,c_white,1)
		break;
	case hudstates.adbelike:
		draw_sprite_ext(spr_plrhud_ad,0,812,32,-1,1,0,c_white,1)
		break;
}
if hudstate != hudstates.normal hudstate_timer -= 1
draw_set_font(fnt_textregular)

if room = floor_1 {
	visible = false
}

//draw_sprite(rank,0,64,32)