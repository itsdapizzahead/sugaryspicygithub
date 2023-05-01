function scr_plrscripts(){
	// do nothing hAHAHAH
}

#region normal
function scr_plr_normal() {
	if !canmove exit;
	image_speed = 0.35
	if keyboard_check(vk_up) and onground and !place_meeting(x,y,obj_leveldoorNEW){
		hsp = 0
		sprite_index = spr_player_hjump_prep
		for (var i = 0; i < 10; i += 1)
		{
			if room != temple_titlecard {
				scr_playbreakdance(mu_et)
			}
			instance_create(x,y - 50,obj_beatbox)
		}
		instance_create(x,y,obj_beatboxparticle)
		exit;
	} else {
		audio_stop_sound(mu_et)
		if scr_buttoncheck(vk_left, gp_padl) or scr_buttoncheck(vk_right, gp_padr) {
			var movecalc = scr_buttoncheck(vk_right, gp_padr) - scr_buttoncheck(vk_left, gp_padl)
			if movecalc != 0 {
				hsp = clamp(hsp + walkspeed * movecalc, -maxspeed, maxspeed)
				if image_xscale <= -1 and hsp > 0 hsp = 0
				if image_xscale >= 1 and hsp < 0 hsp = 0
				sprite_index = spr_player_move
				image_xscale = scr_buttoncheck(vk_right, gp_padr) ? 1 : -1
			}
			/*
			if crouched {
				sprite_index = spr_player_crouchmove
			}
			if crouched and !onground {
				sprite_index = spr_player_crouchfall
			}
			*/
		} else {
			hsp = 0
			switch idlemode
			{
				case 0: default:
					sprite_index = spr_idle
					break;
				case 1:
					sprite_index = spr_player_hurtidle
					break;
				case 2:
					sprite_index = spr_player_gunidle
					break;
				case 3:
					sprite_index = spr_player_crouchidle
					break;
				case 4:
					sprite_index = spr_player_panicidle
					break;
			}
		}
	}
	if !onground {
		sprite_index = spr_player_fall
	}
	if !scr_buttoncheck(vk_down, gp_padd) and instance_position(x, y - 36, obj_solid) exit; // don't crouch
	crouched = scr_buttoncheck(vk_down, gp_padd)
}
#endregion

#region grab
function scr_plr_grab() {
	sprite_index = spr_player_dash
	if !onground {
		sprite_index = spr_player_runmax_jump
	}
	image_speed = 0.25
	hsp = 8 * image_xscale
	var thing = instance_place(x + hsp, y, obj_solid)
	if thing != noone {
		switch thing.object_index
		{
			case obj_destructible: case obj_destroyable: case obj_bigdestroyable: case obj_secretdestroyable:
				var thing2 = ds_list_create()
				instance_place_list(x + hsp, y, obj_destructible, thing2, true)
				if ds_list_size(thing2) != 0 {
					for (var i = 0; i < ds_list_size(thing2); i++) {
						ds_list_find_value(thing2,i).hp -= 1
					}
				}
				ds_list_destroy(thing2)
				break;
			case obj_solid: case obj_panicblock: case obj_panicblock_alt:
				statetimer = 0
				changeState(states.normal)
				exit;
		}
	}
	if keyboard_check_pressed(vk_left) and image_xscale == 1
	or keyboard_check_pressed(vk_right) and image_xscale == -1 { // grab cancel
		statetimer = 0
		state = states.normal
	}
	statetimer -= 1
	if statetimer <= 0 changeState(states.normal)
}
#endregion

#region run
function scr_plr_run() {
	/*
	statevar 0 is for speed
	statevar 1 is for the run turn
	statevar 2 is for the step sounds
	statevar 3 is for the max speed sound and effects
	statevar 4 will be for the jump debounce, if false then do the jump amin
	
	to-do: make it so that if you jump--and ONLY when you jump--will the player's sprite do a jump
	*/
	image_speed = 0.30 * clamp(statevars[0] / 13, 0.2, 1)
	sprite_index = statevars[0] >= 12 ? spr_player_runmax : spr_player_run
	statevars[0] += 0.25
	statevars[0] = clamp(statevars[0], 0, 12)
	statevars[2] -= (statevars[0] / 1.75)
	var thing = instance_place(x + statevars[0] * image_xscale, y, obj_solid)
	if thing != noone {
		switch thing.object_index
		{
			case obj_destructible: case obj_destroyable: case obj_bigdestroyable: case obj_secretdestroyable:
				if statevars[0] < 12 {
					var xcalc = x + statevars[0] * image_xscale
					if place_meeting(xcalc, y, obj_destructible)
						instance_place(xcalc, y, obj_destructible).hp -= 1
					stunplayer()
					statevars[0] = 0
					break;
				}
				var thing2 = ds_list_create()
				instance_place_list(x + statevars[0] * image_xscale, y, obj_destructible, thing2, true)
				if ds_list_size(thing2) != 0 {
					for (var i = 0; i < ds_list_size(thing2); i++) {
						ds_list_find_value(thing2,i).hp -= 1
					}
				}
				ds_list_destroy(thing2)
				break;
			case obj_toughblock: case obj_secrettough:
				if statevars[0] < 12 {
					if statevars[0] >= 12 { // if running at full speed, stun
						stunplayer()
						statevars[0] = 0
						with instance_create_layer(x - image_xscale, y + 35, "Instances", obj_particle) {
							sprite_index = spr_bumpeffect
							duration = 8
							image_speed = 0.35
							depth = -2
						}
					} else {
						hsp = 0
						changeState(states.normal)
					}
					break;
				}
				var thing2 = ds_list_create()
				instance_place_list(x + statevars[0] * image_xscale, y, obj_toughblock, thing2, true)
				if ds_list_size(thing2) != 0 {
					for (var i = 0; i < ds_list_size(thing2); i++) {
						ds_list_find_value(thing2,i).hp -= 1
					}
				}
				ds_list_destroy(thing2)
				break;
			case obj_solid: case obj_panicblock: case obj_panicblock_alt:
				if statevars[0] >= 12 { // if running at full speed, stun, and regret your life choices
					if !onground and place_meeting(x,y + vsp,obj_solid) {
						changeState(states.wallrun)
					}
				} else {
					hsp = 0
					changeState(states.normal)
				}
		}
	}
	if onground {
		if scr_buttoncheck(vk_left, gp_padl) and image_xscale == 1
		or scr_buttoncheck(vk_right, gp_padr) and image_xscale == -1 {
			statevars[1] = 35
			changeState(states.runturn, false)
			scr_playsound(sfx_runturn)
			statevars[2] = 0
			statevars[3] = 0
			exit;
		}
	}
	if onground and scr_buttoncheck(vk_up, gp_padu) and statevars[0] >= 12 {
		statevars[0] = 11 // has to be 11 to prevent instant superjump nullification
		statevars[1] = false
		changeState(states.superjump, false)
		scr_playsound(sfx_sjump_prep)
		statevars[2] = 0
		hsp = 0
		scr_afterimages(afterimages.perpendicular, 5, 0)
		exit;
	}
	if !scr_buttoncheck(vk_shift, gp_shoulderrb) {
		hsp = 0
		statevars[3] = 0
		changeState(states.normal)
		if audio_is_playing(sfx_mach3) {
			audio_stop_sound(sfx_mach3)
		}
		if audio_is_playing(sfx_footstep) {
			audio_stop_sound(sfx_footstep)
		}
		if audio_is_playing(sfx_runturn) {
			audio_stop_sound(sfx_runturn)
		}
	}
	if statevars[2] <= 0 {
		if !audio_is_playing(sfx_footstep) {
			scr_playsound(sfx_footstep)
		}
		if global.particles and statevars[0] >= 12 {
			scr_afterimages(afterimages.run, 0, 0)
			if onground {
				with instance_create_layer(x - image_xscale, y + 35, "Instances", obj_particle) {
					sprite_index = spr_fire
					duration = 8
					image_speed = 0.60
					depth = -2
				}
			}
			if !audio_is_playing(sfx_mach3) {
				scr_playsound(sfx_mach3)
			}
		}
		statevars[2] = 35
	}
	hsp = statevars[0] * image_xscale
	if !onground {
		sprite_index = spr_player_runmax_fall
	}
	/*
	if onground and scr_buttoncheck_pressed(vk_down) {
		mask_index = spr_player_crouchmask
		sprite_index = spr_player_crouchidle
	} if !scr_buttoncheck_pressed(vk_down) {
		mask_index = spr_player_mask
		changeState(states.run, false)
		sprite_index = statevars[0] >= 12 ? spr_player_runmax : spr_player_run
	}
	*/
}
#endregion

#region run (old)
/*
function scr_plr_run() {
	image_speed = 0.30 * clamp(statevars[0] / 12, 0.2, 1)
	sprite_index = statevars[0] >= 12 ? spr_player_runmax : spr_player_run
	statevars[0] += 0.25
	statevars[0] = clamp(statevars[0], 0, 12)
	statevars[2] -= (statevars[0] / 1.75)
	var thing = instance_place(x + statevars[0] * image_xscale, y, obj_solid)
	if thing != noone {
		switch thing.object_index
		{
			case obj_destructible: case obj_destroyable: case obj_bigdestroyable: case obj_secretdestroyable:
				if statevars[0] < 12 {
					var xcalc = x + statevars[0] * image_xscale
					if place_meeting(xcalc, y, obj_destructible)
						instance_place(xcalc, y, obj_destructible).hp -= 1
					stunplayer()
					statevars[0] = 0
					break;
				}
				var thing2 = ds_list_create()
				instance_place_list(x + statevars[0] * image_xscale, y, obj_destructible, thing2, true)
				if ds_list_size(thing2) != 0 {
					for (var i = 0; i < ds_list_size(thing2); i++) {
						ds_list_find_value(thing2,i).hp -= 1
					}
				}
				ds_list_destroy(thing2)
				break;
			case obj_toughblock: case obj_secrettough:
				if statevars[0] < 12 {
					if statevars[0] >= 12 { // if running at full speed, stun
						stunplayer()
						statevars[0] = 0
					} else {
						hsp = 0
						changeState(states.normal)
					}
					break;
				}
				var thing2 = ds_list_create()
				instance_place_list(x + statevars[0] * image_xscale, y, obj_toughblock, thing2, true)
				if ds_list_size(thing2) != 0 {
					for (var i = 0; i < ds_list_size(thing2); i++) {
						ds_list_find_value(thing2,i).hp -= 1
					}
				}
				ds_list_destroy(thing2)
				break;
			case obj_solid: case obj_panicblock: case obj_panicblock_alt:
				if statevars[0] >= 12 { // if running at full speed, stun, and regret your life choices
					stunplayer()
					statevars[0] = 0
				} else {
					hsp = 0
					changeState(states.normal)
				}
				exit;
		}
	}
	if onground {
		if scr_buttoncheck(vk_left, gp_padl) and image_xscale == 1
		or scr_buttoncheck(vk_right, gp_padr) and image_xscale == -1 {
			statevars[1] = 35
			changeState(states.runturn, false)
			scr_playsound(sfx_runturn)
			statevars[2] = 0
			statevars[3] = 0
			exit;
		}
	}
	if onground and scr_buttoncheck(vk_up, gp_padu) and statevars[0] >= 12 {
		statevars[0] = 11 // has to be 11 to prevent instant superjump nullification
		statevars[1] = false
		changeState(states.superjump, false)
		scr_playsound(sfx_sjump_prep)
		statevars[2] = 0
		hsp = 0
		scr_afterimages(afterimages.perpendicular, 5, 0)
		exit;
	}
	if !scr_buttoncheck(vk_shift, gp_shoulderrb) {
		hsp = 0
		statevars[3] = 0
		changeState(states.normal)
	}
	if statevars[2] <= 0 {
		if onground scr_playsound(sfx_footstep)
		if abs(statevars[0]) >= 12 and statevars[3] == 0 {
			scr_afterimages(afterimages.perpendicular, 0, 5)
			statevars[3] = true
		} 
		statevars[2] = 35
	}
	hsp = statevars[0] * image_xscale
}
*/
#endregion

#region runturn
function scr_plr_runturn() {
	image_speed = 0.25
	sprite_index = spr_player_runturn
	if statevars[1] > 0 statevars[1] -= 1
	if image_index >= 3 image_index = 1
	if statevars[1] <= 0 {
		image_xscale = -image_xscale
		changeState(states.run, false)
		sprite_index = statevars[0] >= 12 ? spr_player_runmax : spr_player_run
		exit;
	}
	hsp = statevars[0] * image_xscale // lerp(hsp, 0, 0.02)
}
#endregion

#region hurt
function scr_plr_hurt() {
	if invuln exit;
	image_speed = 0.25
	sprite_index = spr_player_hurt
	if onground vsp = -3
	statetimer -= 1
	if statetimer <= 0 {
		changeState(states.normal)
		canmove = true
		invuln = true
		invulm_timer = 40
		global.timeshurt++
	}
}
#endregion

#region stun
function scr_plr_stun() {
	sprite_index = spr_player_hurt
	image_speed = 0.25
	statetimer -= 1
	if statetimer <= 0 {
		changeState(states.normal)
		canmove = true
	}
}
#endregion

#region superjump
function scr_plr_superjump() {
	/*
	statevar 0 is for the initial timer
	statevar 1 is a debounce for the superjump start
	*/
	sprite_index = statevars[1] ? spr_player_superjump : spr_player_sjump_prep
	image_speed = 0.25
	var thing = instance_place(x, y - 1, obj_solid)
	if thing != noone {
		switch thing.object_index
		{
			case obj_destructible: case obj_destroyable: case obj_bigdestroyable: case obj_secretdestroyable:
				thing.hp -= 1
				break;
			case obj_solid: case obj_toughblock: case obj_panicblock: case obj_panicblock_alt:
				hsp = 0
				changeState(states.normal)
				exit;
		}
	}
	
	if statevars[1] and statevars[2] <= 0 {
		changeState(states.normal)
		exit;
	}
	
	if statevars[0] <= 1 and statevars[1] == false {
		vsp = -12
		scr_playsound(sfx_superjump)
		canmove = true
		statevars[1] = true
		statevars[2] = 16
	} else { statevars[0] -= 1 }
	
	if statevars[1] == true and statevars[2] > 0 {
		vsp = -statevars[2]
		statevars[2] -= 0.5
	}
	/*
	if scr_buttoncheck_pressed(ord("X")) && sprite_index != spr_player_Sjumpcancelstart
    {
        image_index = 0
        image_speed = 0.5
        dogravity = false
        sprite_index = spr_player_Sjumpcancelstart
    }
    if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_Sjumpcancelstart)
    {
		changeState(states.run)
		statevars[0] = 12
		dogravity = true
        image_index = 0
        sprite_index = spr_player_runmax
    }
	*/
}
#endregion

#region wallrun (commented)
function scr_plr_wallrun() { // this gives me bad memories
	hsp = 0
	statevars[0] += 0.3
	if !place_meeting(x + image_xscale, y - 1, obj_solid) {
		changeState(states.run, false)
		vsp = 0
		if image_xscale == 1 statevars[0] *= -1
		exit;
	}
	var thing = instance_place(x, y + statevars[0], obj_solid)
	if thing != noone {
		switch thing.object_index
		{
			case obj_destructible: case obj_destroyable: case obj_bigdestroyable: case obj_secretdestroyable:
				var thing2 = ds_list_create()
				instance_place_list(x, y + statevars[0], obj_destructible, thing2, true)
				if ds_list_size(thing2) != 0 {
					for (var i = 0; i < ds_list_size(thing2); i++) {
						ds_list_find_value(thing2,i).hp -= 1
					}
				}
				ds_list_destroy(thing2)
				break;
			case obj_toughblock: case obj_secrettough: case obj_solid: case obj_slope:
				stunplayer()
				statevars[0] = 0
				exit;
		}
	}
	
	if scr_buttoncheck_pressed(ord("Z"), gp_face3) {
		var svar = statevars[0]
		changeState(states.run, false)
		hsp = svar * -image_xscale
		vsp = -3
		image_xscale = -image_xscale
		if image_xscale == 1 statevars[0] *= -1
		exit;
	}
	vsp = statevars[0]
}
#endregion

// NOTE: in cases where this, stunplayer() or scr_playerspr() are used, MAKE SURE THE PLAYER CALLS IT!
function hurtplayer(sethsp = -6 * image_xscale, setvsp = -4, removepoints = false) {
	if invuln or state == states.ouch return;
	scr_playsound(sfx_hurt)
	vsp = setvsp
	hsp = sethsp
	canmove = false
	changeState(states.ouch)
	statetimer = 90
	if removepoints {
		var hasPoints = global.collect ? true : false
		global.collect = max(0, global.collect - 100)
		if global.particles and hasPoints {
			repeat(10) {
				with instance_create_layer(x,y,"Instances",obj_particle) {
					depth = -1
					sprite_index = choose(spr_collect_1, spr_collect_2, spr_collect_3, spr_collect_4)
					hspeed = random_range(-6, 6)
					vspeed = random_range(-3, -6)
	
					stepcode = function() {
						vspeed += 0.35
						duration = 2
						if y - sprite_yoffset > room_height instance_destroy(self)
					}
				}
			}
		}
	}
}

function stunplayer(sethsp = -2 * image_xscale, setvsp = -1, time = 30) {
	scr_playsound(sfx_bump)
	vsp = setvsp
	hsp = sethsp
	canmove = false
	changeState(states.stunned)
	statetimer = time
}

function scr_playerspr()
{
	switch character
	{
		case "P": // regular player / "libbino"
			spr_idle = spr_player_idle
			break;
		case "B": // demon thing
			spr_idle = spr_playerN_idle
			break;
	}
}
/*
function scr_plr_stand() {
	canmove = false
	dogravity = false
	hsp = 0
	vsp = 0
}
*/
/* rocket
function scr_plr_rocket() {
	sprite_index = spr_player_rocket
	hsp = 10
	vsp = 0
	if scr_buttoncheck_pressed(vk_up) {
		vsp = 3	
	}
	if scr_buttoncheck_pressed(vk_down) {
		vsp = -3
	}
	if onground {
		sprite_index = spr_player_rocketground
		if scr_buttoncheck(vk_left) and image_xscale == 1
		or scr_buttoncheck(vk_right) and image_xscale == -1 {
			hsp = 0
			vsp = 0
			changeState(states.rocketturn, false)
			scr_playsound(sfx_runturn)
			exit;
		}
	}
	with obj_player {
		if place_meeting(obj_solidrocket) {
			stunplayer(1,1,10)
		}
	}
}
function scr_plr_rocketturn() {
	image_speed = 0.25
	sprite_index = spr_player_rocketturn
	if hsp > 0 hsp -= 1
	if image_index >= 3 image_index = 1
	if hsp <= 0 {
		image_xscale = -image_xscale
		changeState(states.rocket, false)
		hsp = 10
		exit;
	}
	hsp = 0 * image_xscale // lerp(hsp, 0, 0.02)
}
*/
function scr_plr_attack() {
	hsp = 0
	vsp = 0
	if sprite_index != spr_player_taunt {
		sprite_index = spr_player_attack
	}
	image_speed = 0.35
	if (image_index+image_speed >= image_number) {
		changeState(states.normal)
	}
}
/* supertaunt old
function scr_plr_spprep() {
	if instance_exists(obj_supertaunteffect) {
		if scr_buttoncheck_pressed(ord("C")) and scr_buttoncheck_pressed(vk_up) and state != states.supertaunt {
			changeState(states.supertaunt)
		}
	}
}
function scr_plr_supertaunt() {
	with global.enemy {
		kill()
	}
	canmove = false
	sprite_index = spr_player_supertaunt
	image_speed = 0.35
	if (image_index+image_speed >= image_number) {
		changeState(states.normal)
		canmove = true
	}
}
*/
function scr_plr_supertaunt() {
	if instance_exists(obj_enemyroot){
		obj_enemyroot.kill()
	}
	if instance_exists(obj_stabber){
		obj_stabber.kill()
	}
	if instance_exists(obj_slime){
		obj_slime.kill()
	}
	canmove = false
	sprite_index = spr_player_supertaunt
	statetimer = 30
	scr_afterimages(afterimages.perpendicular, 5, 0)
	scr_afterimages(afterimages.perpendicular, 0, 5)
}
function scr_plr_rampjump(){
	vsp = 5
	hsp = 8 * image_xscale
	sprite_index = spr_player_runmax_fall
	if place_meeting(x,y,obj_solid) and onground {
		changeState(states.normal)	
	}
}
/*
function scr_plr_groundpound() {
	sprite_index = spr_player_groundpound
	image_speed = 0.35
	hsp = 0
	vsp++
	if vsp > 12 {
		vsp = 12	
	}
	var thing = instance_place(x * image_xscale, y + vsp, obj_solid)
	if thing != noone {
		switch thing.object_index
		{
			case obj_destructible: case obj_destroyable: case obj_bigdestroyable: case obj_secretdestroyable:
				var xcalc = y + vsp * image_xscale
				if place_meeting(xcalc, y, obj_destructible)
				instance_place(xcalc, y, obj_destructible).hp -= 1
				var thing2 = ds_list_create()
				instance_place_list(x * image_xscale,y + vsp, obj_destructible, thing2, true)
				if ds_list_size(thing2) != 0 {
					for (var i = 0; i < ds_list_size(thing2); i++) {
						ds_list_find_value(thing2,i).hp -= 1
					}
				}
				ds_list_destroy(thing2)
				break;
			case obj_toughblock: case obj_secrettough:
				changeState(states.normal)
				vsp = -3
				var thing2 = ds_list_create()
				instance_place_list(x * image_xscale, y + vsp, obj_toughblock, thing2, true)
				if ds_list_size(thing2) != 0 {
					for (var i = 0; i < ds_list_size(thing2); i++) {
						ds_list_find_value(thing2,i).hp -= 1
					}
				}
				ds_list_destroy(thing2)
				scr_playsound(sfx_bump)
				break;
			case obj_solid: case obj_panicblock: case obj_panicblock_alt:
				changeState(states.normal)
				scr_playsound(sfx_bump)
		}
	}
}
*/
function scr_plr_spcancel() {
	hsp = 12
	vsp = -5
	sprite_index = spr_player_runmax_fall
	if onground {
		changeState(states.run)	
	}
}
function scr_plr_flushed() {
	sprite_index = spr_player_flushed
	hsp = 5 * image_xscale
	statetimer = 90
}
function flush() {
	if state == states.flushed return;
	scr_playsound(sfx_whistle)
	changeState(states.flushed)
	statetimer = 90
	if statetimer <= 0 {
		changeState(states.normal)
		sprite_index = spr_player_idle
	}
}