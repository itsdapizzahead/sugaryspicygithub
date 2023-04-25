if time_gravity {
	time_onground = place_meeting(x, y + 1, obj_solid)
	if !time_onground {
		vsp += 0.3
	}
	scr_plr_collision()
}
audio_pause_sound(global.music)