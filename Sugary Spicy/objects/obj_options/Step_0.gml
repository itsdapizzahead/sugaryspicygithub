if scr_buttoncheck_pressed(ord("Z"), gp_face3) {
	switch curmenu
	{
		#region bitch.main
		case bitch.main:
			switch select
			{
				case 0:
					curmenu = bitch.options
					break;
				case 1:
					instance_destroy(self)
					break;
			}
			break;
		#endregion
		#region bitch.options
		case bitch.options:
			switch select
			{
				case 0:
					curmenu = bitch.options_video
					select = 0
					break;
				case 1:
					curmenu = bitch.options_audio
					select = 0
					preview_music = choose(
						d_agmsecret,
						d_agm,
						d_entrance,
						d_hub,
						d_military,
					)
					scr_playmusic(preview_music)
					preview_sfx()
					break;
				case 2:
					curmenu = bitch.options_misc
					select = 0
					break;
				case 3:
					curmenu = bitch.options_fx
					select = 0
					break;
				case 4:
					curmenu = bitch.main
					select = 0
					break;
			}
			break;
		#endregion
		#region bitch.options_video
		case bitch.options_video:
			switch select
			{
				case 0:
					global.fullscreen = changeOpt("Fullscreen", !global.fullscreen)
					window_set_fullscreen(global.fullscreen)
					break;
				// resolution changes with left-right
				case 2:
					curmenu = bitch.options
					select = 0
					break;
			}
			break;
		#endregion
		#region bitch.options_audio
		case bitch.options_audio:
			switch select
			{
				case 2:
					curmenu = bitch.options
					select = 0
					audio_stop_sound(global.music)
					preview_soundtimer = 0
					audio_stop_sound(preview_sound)
					break;
			}
			break;
		#endregion
		case bitch.options_misc:
			switch select
			{
				case 0:
					global.sus = changeOpt("Minus8Mode", !global.sus)
					break;
				// resolution changes with left-right
				case 1:
					curmenu = bitch.options
					select = 0
					break;
			}
			break;
		#region bitch.options_fx
		case bitch.options_fx:
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
					curmenu = bitch.options
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
	if scr_buttoncheck(vk_shift, gp_shoulderrb) or curmenu == bitch.options_video and select == 1 {
		if !keyboard_check_pressed(vk_left) and !keyboard_check_pressed(vk_right) exit;
	}
	switch curmenu
	{
		#region bitch.options_audio
		case bitch.options_audio:
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
		#region bitch.options_video
		case bitch.options_video:
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

if preview_soundtimer > 0 preview_soundtimer--
if curmenu == bitch.options_audio and preview_soundtimer == 0 {
	preview_sfx()
}