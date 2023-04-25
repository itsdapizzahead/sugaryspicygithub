draw_sprite_tiled_ext(bg_options,0,hbg,vbg,1,1,c_white,alpher)
draw_sprite_ext(spr_title, 0, 480, 144,1,1,0,c_white,alpher2)

draw_set_halign(fa_center)
draw_set_font(global.ltfontREAL)
switch curmenu
{
	case menutype.options:
		var theStuff = [
			"Video",
			"Audio",
			"Effects",
			"Back"
		]
		for (var i = 0; i < array_length(theStuff); i++) {
			draw_set_color(select == i ? c_red : c_white)
			draw_text(480, 260 + 32 * i,string_upper(theStuff[i]))
		}
		break;
	case menutype.options_video:
		var screenres
		switch global.resolution
		{
			case 1: default:
				screenres = "960x540"
				break;
			case 2:
				screenres = "1280x720"
				break;
			case 3:
				screenres = "1600x900"
				break;
			case 4:
				screenres = "1920x1080"
				break;
		}
		var theStuff = [
			"Fullscreen: " + string(global.fullscreen),
			"Screen Resolution: " + screenres,
			"Back"
		]
		for (var i = 0; i < array_length(theStuff); i++) {
			draw_set_color(select == i ? c_red : c_white)
			draw_text(480, 260 + 32 * i, string_upper(theStuff[i]))
		}
		break;
	case menutype.options_audio:
		var theStuff = [
			"Sound Volume: " + string(global.sfxvol),
			"Music Volume: " + string(global.musvol),
			"Back"
		]
		for (var i = 0; i < array_length(theStuff); i++) {
			draw_set_color(select == i ? c_red : c_white)
			draw_text(480, 260 + 32 * i, string_upper(theStuff[i]))
		}
		break;
	case menutype.options_fx:
		var theStuff = [
			"Particles: " + getToggled(global.particles),
			"Panic Shake: " + getToggled(global.panicshake),
			"Use Gamepads: " + getToggled(global.gamepad),
			"Back"
		]
		for (var i = 0; i < array_length(theStuff); i++) {
			draw_set_color(select == i ? c_red : c_white)
			draw_text(480, 260 + 32 * i, string_upper(theStuff[i]))
		}
		switch select
		{
			case 0:
				if global.particles {
					draw_sprite_ext(spr_player_sjump_prep, 1, 660, 300, 2, 2, 0, c_purple, 0.5)
					draw_sprite_ext(spr_player_sjump_prep, 1, 820, 300, 2, 2, 0, c_silver, 0.5)	
				}
				draw_sprite_ext(spr_player_sjump_prep, 2, 740, 300, 2, 2, 0, c_white, 1)
				break;
			case 1:
				var shake = 2 * global.panicshake
				draw_sprite_ext(global.panicshake ? spr_player_panicidle : spr_player_idle, -1, 740, 300 + irandom_range(-shake, shake), 2, 2, 0, c_white, 1)
				break;
		}
		break;
	case menutype.cleardata:
		draw_set_color(c_white)
		draw_text(480, 192, string_upper("Are you sure?"))
		for (var i = 0; i < array_length(curopt); i++) {
			draw_set_color(select == i ? c_red : c_white)
			draw_text(480, 260 + 32 * i, string_upper(curopt[i]))
		}
		break;
	default:
		for (var i = 0; i < array_length(curopt); i++) {
			draw_set_color(select == i ? c_red : c_white)
			draw_text(480, 260 + 32 * i, string_upper(curopt[i]))
		}
		break;
}
hbg++
vbg++
draw_set_halign(fa_left)