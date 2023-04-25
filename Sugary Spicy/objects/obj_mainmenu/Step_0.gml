if scr_buttoncheck_pressed(ord("Z"), gp_face3) {
	switch curmenu
	{
		#region menutype.main
		case menutype.main:
			switch select
			{
				case 0:
					room_goto(rpg_template)
					instance_create(x,y,obj_fadeNEW)
					break;
				case 1:
					curmenu = menutype.options
					select = 0
					break;
				case 2:
					curmenu = menutype.cleardata
					select = 0
					break;
				case 3:
					game_end()
					break;
			}
			break;
		#endregion
		#region menutype.options
		case menutype.options:
			switch select
			{
				case 0:
					curmenu = menutype.options_video
					select = 0
					break;
				case 1:
					curmenu = menutype.options_audio
					select = 0
					break;
				case 2:
					curmenu = menutype.options_fx
					select = 0
					break;
				case 3:
					curmenu = menutype.main
					select = 0
					break;
			}
			break;
		#endregion
		#region menutype.options_video
		case menutype.options_video:
			switch select
			{
				case 0:
					global.fullscreen = changeOpt("Fullscreen", !global.fullscreen)
					window_set_fullscreen(global.fullscreen)
					break;
				// resolution changes with left-right
				case 2:
					curmenu = menutype.options
					select = 0
					break;
			}
			break;
		#endregion
		#region menutype.options_audio
		case menutype.options_audio:
			switch select
			{
				case 2:
					curmenu = menutype.options
					select = 0
					break;
			}
			break;
		#endregion
		#region menutype.options_fx
		case menutype.options_fx:
			switch select
			{
				case 0:
					global.particles = changeOpt("Particles", !global.particles)
					break;
				case 1:
					global.panicshake = changeOpt("PanicShake", !global.panicshake)
					break;
				case 2:
					global.gamepad = changeOpt("UseGamepad", !global.gamepad)
					break;
				case 3:
					curmenu = menutype.options
					select = 0
					break;
			}
			break;
		#endregion
		#region menutype.cleardatqa
		case menutype.cleardata:
			switch select
			{
				case 0: // yes
					file_delete(global.savedataname + ".ini")
					game_restart()
					break;
				case 1: // no
					curmenu = menutype.main
					select = 0
					break;
			}
			break;
		#endregion
	}

	switchOpts()
}

if scr_buttoncheck_pressed(vk_up, gp_padu) select--
if scr_buttoncheck_pressed(vk_down, gp_padd) select++

if scr_buttoncheck(vk_left, gp_padl) or scr_buttoncheck(vk_right, gp_padr)
{
	if scr_buttoncheck(vk_shift, gp_shoulderrb) or curmenu == menutype.options_video and select == 1 {
		if !keyboard_check_pressed(vk_left) and !keyboard_check_pressed(vk_right) exit;
	}
	switch curmenu
	{
		#region menutype.options_audio
		case menutype.options_audio:
			switch select
			{
				case 0: // sfx volume
					global.sfxvol = changeOpt("SoundVol", clamp(global.sfxvol + scr_buttoncheck(vk_right, gp_padr) - scr_buttoncheck(vk_left, gp_padl), 0, 100) )
					break;
				case 1: // music volume
					global.musvol = changeOpt("MusicVol", clamp(global.musvol + scr_buttoncheck(vk_right, gp_padr) - scr_buttoncheck(vk_left, gp_padl), 0, 100) )
					audio_sound_gain(global.music, global.musvol / 100, 0)
					break;
			}
			break;
		#endregion
		#region menutype.options_video
		case menutype.options_video:
			switch select
			{
				case 1:
					global.resolution += scr_buttoncheck(vk_right, gp_padr) - scr_buttoncheck(vk_left, gp_padl)
					if global.resolution < 1 global.resolution = 4
					if global.resolution > 4 global.resolution = 1
					changeOpt("Resolution", global.resolution)
					
					switch global.resolution
					{
						case 1: default: window_set_size(960, 540) break;
						case 2: window_set_size(1280, 720) break;
						case 3: window_set_size(1600, 900) break;
						case 4: window_set_size(1920, 1080) break;
					}
					break;
			}
			break;
		#endregion
	}
}

if select < 0 select = selectmax
if select > selectmax select = 0

if curmenu = menutype.options {
	alpher = 1
	alpher2 = 0
}
if curmenu = menutype.main {
	alpher = 0
	alpher2 = 1
}