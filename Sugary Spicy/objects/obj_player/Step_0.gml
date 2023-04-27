switch state
{
	case states.normal:
		scr_plr_normal()
		break;
	case states.ouch:
		scr_plr_hurt()
		break;
	case states.stunned:
		scr_plr_stun()
		break;
	case states.grab:
		scr_plr_grab()
		break;
	case states.run:
		scr_plr_run()
		break;
	case states.runturn:
		scr_plr_runturn()
		break;
	case states.superjump:
		scr_plr_superjump()
		break;
	case states.attack:
		scr_plr_attack()
		break;
	case states.stprep:
		scr_plr_spprep()
		break;
	case states.supertaunt:
		scr_plr_supertaunt()
		break;
	case states.rampjump:
		scr_plr_rampjump()
		break;
	case states.groundpound:
		scr_plr_groundpound()
		break;
	case states.spcancel:
		scr_plr_spcancel()
		break;
	case states.wallrun:
		scr_plr_wallrun()
		break;
	case states.flushed:
		scr_plr_flushed()
		break;
}
mask_index = crouched ? spr_player_crouchmask : spr_player_mask
walkspeed = 0.4 / (crouched + 1)
maxspeed = 7 / (crouched + 1)
if dogravity {
	onground = place_meeting(x, y + 1, obj_solid)
	var findplatform = instance_place(x, y + 1, obj_platform)
	var findsolid = place_meeting(x, y + 1, obj_solid)
		
	if findsolid or findplatform and bbox_bottom < findplatform.y + 1 and sign(vsp) != -1 onground = true
	
	if !onground {
		vsp += 0.4
	}
	scr_plr_collision()
}

if canmove { // disable moving, jumping, grabbing, and entering doors
	if onground and scr_buttoncheck_pressed(vk_up, gp_padu) {
		var possibleDoor = instance_place(x,y,obj_door)
		var checkExit = true
		if possibleDoor {
			global.targetDest = possibleDoor.targetDest
			instance_create_unique(x,y,obj_fadeNEW)
			room_goto(possibleDoor.targetRoom)
			changeState(states.normal, true) // reset the player state
			if possibleDoor.object_index == obj_leveldoorNEW and global.closed = false scr_resetlevel()
			checkExit = false
		}
		if checkExit and place_meeting(x, y, obj_exitdoor) and global.panic {
			global.panic = false
			global.timer = [2, 30]
			global.targetDest = "A"
			changeState(states.normal, true)
			obj_hud.visible = false
			obj_player.canmove = false
			room_goto(endscreen)		
		}
		if checkExit and place_meeting(x, y, obj_tutorialexitdoor) and global.panic {
			global.panic = false
			global.timer = [2, 30]
			global.targetDest = "A"
			changeState(states.normal, true)
			obj_hud.visible = true
			scr_resetlevel()
			room_goto(floor_1)		
		}
		if checkExit and place_meeting(x, y, obj_geromedoor) and global.panic and global.gerome {
			global.panic = false
			global.timer = [2, 30]
			global.targetDest = "F"
			changeState(states.normal, true)
			room_goto(obj_gerometriggerdoor.target)	
		}
	}

	if scr_buttoncheck_pressed(ord("Z"), gp_face3) and state != states.superjump {
		if onground {
			scr_playsound(sfx_jump)
			vsp -= 10
			onground = false
			if state == states.normal changeSprite(spr_player_fall)
			if global.firemode = true {
				if !onground and scr_buttoncheck_pressed(ord("Z"), gp_face3) and scr_buttoncheck_pressed(ord("Z"), gp_face3) and state != states.superjump {
					vsp -= 3
				}
			}
		}
	}
	if scr_buttoncheck_pressed(ord("X"), gp_face3) and scr_buttoncheck_pressed(vk_up) and state != states.grab and state != states.superjump and state != states.taunt{
		if onground {
			vsp -= 16
			onground = false
			if state == states.normal changeSprite(spr_player_fall)
		}
		if state = states.superjump and !onground and abs(obj_player.vsp) >= -12 {
			changeState(states.spcancel)
		}
	}
	
	if onground and scr_buttoncheck(vk_shift, gp_shoulderrb) and !place_meeting(x + image_xscale, y, obj_solid) {
		if !crouched and state != states.stunned and state != states.run and state != states.runturn and state != states.superjump and state != states.grab {
			changeState(states.run)
			if onground scr_playsound(sfx_footstep)
			if obj_player.state == states.run and abs(obj_player.hsp) >= 12 {
				scr_playsound(sfx_mach3)
			}
		}
	}
	 
	if scr_buttoncheck_pressed(ord("X"), gp_face4) and state != states.taunt and onground{
		if !crouched and state != states.stunned and state != states.grab and state != states.run and state != states.runturn and state != states.superjump {
			statetimer = 45
			changeState(states.grab)
			scr_playsound(sfx_grab, true)
		}
	}
}

if canmove and scr_buttoncheck_pressed(ord("C"), gp_face1) and state != states.taunt and state != states.ouch and state != states.run {
	canmove = false
	dogravity = false
	prevstate = state
	changeState(states.taunt)
	sprite_index = spr_player_taunt
	image_index = random_range(0, sprite_get_number(sprite_index))
	image_speed = 0
	alarm[0] = 25
	scr_playsound(choose(sfx_taunt1,sfx_taunt2,sfx_taunt3,sfx_taunt4))
	if instance_exists(obj_supertaunteffect) and obj_supertaunteffect.visible = true {
		if scr_buttoncheck_pressed(ord("C"), gp_face1) and state != states.supertaunt {
			scr_playsound(sfx_supertaunt)
			changeState(states.supertaunt)
			obj_supertaunteffect.visible = false
			obj_combo.visible = false
			image_speed = 0.35
			global.combostart = false
			global.combocount = 0
		}
	}
}
if state != states.ouch and place_meeting(x,y, obj_hurtblock) and !invuln {
	if global.firemode = false {
		hurtplayer(-6 * image_xscale, -4, true)
		scr_playsound(scream, true)
	}
}
if canmove = true {
	if scr_buttoncheck_pressed(vk_escape, gp_start) {
		instance_create_layer(0,0,"Instances",obj_pause)
	}
}

if state != states.ouch and invulm_timer > 0 {
	invulm_timer -= 1
	if invulm_timer <= 0 invuln = false
}
if instance_exists(obj_titlecard)
{
	audio_pause_sound(sfx_jump)
	audio_pause_sound(sfx_grab)
	audio_pause_sound(sfx_taunt)
	audio_pause_sound(sfx_hjump)
}
if !instance_exists(obj_titlecard)
{
	audio_resume_sound(sfx_jump)
	audio_resume_sound(sfx_grab)
	audio_resume_sound(sfx_taunt)
	audio_resume_sound(sfx_hjump)
}
if !instance_exists(obj_detrixie_follower) and global.detrixies = true{
	instance_create_layer(x,y,"Instances",obj_detrixie_follower)
}
/*
if scr_buttoncheck_pressed(ord("R")) 
room_restart()
if scr_buttoncheck_pressed(ord("P")) {
	audio_sound_pitch(global.music,1.3)
}
*/
/*
if !instance_exists(obj_gerome) and global.gerome = true {
	instance_create_layer(x,y,"Instances",obj_gerome)
}
if scr_buttoncheck_pressed(ord("D")) {
	instance_create_layer(x - 2,y,"Instances",obj_pizzaface)
}
*/
if scr_buttoncheck_pressed(ord("T")) {
	with instance_create_layer(x,y,"Instances",obj_transition) {
		targetRoom = floor_pisselle
		targetDest = "A"
	}
}
if scr_buttoncheck_pressed(vk_f5) {
	with instance_create_layer(x,y,"Instances",obj_shell) {
		obj_shell.isOpen = true
		obj_shell.open()
	}
}
/*
if global.timer[0] = 0 and global.timer[1] = 0{
	room_goto(timesup)
}
*/
if scr_buttoncheck_pressed(ord("P")) {
	global.panic = !global.panic
	room_restart()
}
if scr_buttoncheck_pressed(ord("B")) {
	character = "B"
	room_restart()
}