if instance_exists(obj_player) { // should this be optimized?
	if obj_player.crouched obj_player.idlemode = 3
	else if global.timer[0] + global.timer[1] <= 0 obj_player.idlemode = 1
	//else if obj_player.inventory == invstuff.gun obj_player.idlemode = 2
	else if global.panic obj_player.idlemode = 4
	else obj_player.idlemode = 0
	
	if obj_player.state == states.run and abs(obj_player.hsp) >= 12 {
		camxoffset = clamp(camxoffset + obj_player.image_xscale, -80, 80)
	} else camxoffset -= sign(camxoffset)
	camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]) + camxoffset, camera_get_view_y(view_camera[0]))
	camera_set_view_border(view_camera[0], 440 - abs(camxoffset), 216)
}

if global.collect > 0 and global.timer[0] + global.timer[1] <= 0 {
	global.collect = max(global.collect - 1, 0)
}



// panic
if global.panic
{
	if global.panicshake {
		panictimespent += 0.5
		var thing = panictimespent / 2000
		view_yport[0] = random_range(-thing, thing)		
	}
	if global.lap {
		scr_playmusic(d_escapedemon)	
	} else if obj_player.character = "B" {
		scr_playmusic(d_escapebonoise)
	} else if obj_player.character = "P" {
		scr_playmusic(d_escape)
	}
	if !didpanicsound {
		var snd = scr_playsound(sfx_escapeon, false, true)
		audio_sound_gain(snd, 0.4, 0)
		didpanicsound = true
	}
	panictimer--
	if panictimer <= 0 {
		panictimer = 60
		if global.timer[0] < 1 and instance_exists(obj_hud) {
			obj_hud.panictime_color = 255
			audio_sound_gain(scr_playsound(sfx_clock, false, true), 2.25 * (global.sfxvol * 0.01), 0)
		}
		if global.timer[0] + global.timer[1] <= 0 exit;
		global.timer[1] -= 1
		if global.timer[1] < 0 {
			global.timer[0] -= 1
			global.timer[1] = 59
		}
	}
	if global.firemode = true {
		global.firemode = false
	}
}
if global.armorytimer
{
	if global.panicshake {
		panictimespent += 0.5
		var thing = panictimespent / 2000
		view_yport[0] = random_range(-thing, thing)		
	}
	if !didpanicsound {
		didpanicsound = true
	}
	panictimer--
	if panictimer <= 0 {
		panictimer = 60
		if global.settimer[0] < 6 and instance_exists(obj_hud) {
			obj_hud.panictime_color = 255
			scr_playsound(sfx_clock, false, true)
		}
		if global.settimer[0] + global.settimer[1] <= 0 exit;
		global.settimer[1] -= 1
		if global.settimer[1] < 0 {
			/*
			if global.timer[0] <= 0 {
				room_goto(timesup)
			}
			*/
			global.settimer[0] -= 1
			global.settimer[1] = 59
		}
	}
}
if global.lap {
	if global.panic {
		scr_playmusic(d_escapedemon)	
	}
	if !didlapsound {
		var snd = scr_playsound(Lap2, false, true)
		audio_sound_gain(snd, 2, 0)
		didlapsound = true
		if !global.lap {
			audio_stop_sound(Lap2)	
		}
	}
}
if global.lapstart {
	global.lap = true	
}
if global.firemode = true {
	scr_playmusic(mu_fire)	
}

if global.comboresult = 5 {
	global.heat = true
}
if !global.lap {
	audio_stop_sound(Lap2)	
}