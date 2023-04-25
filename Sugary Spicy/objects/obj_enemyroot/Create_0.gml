hp = 2
isHurt = false
onGround = false

hsp = 0
vsp = 0

hptimer = 0

sprite_idle = spr_plrtransition
sprite_move = spr_plrtransition
sprite_scared = spr_genemy_scared
sprite_ded = spr_genemy_dead
sprite_stun = spr_genemy_scared

mask_index = spr_player_mask

scared = false
scaretimer = 0

function kill() {
	scr_playsound(sfx_enemyhit)
	if global.particles {
		repeat (3) {
			with instance_create_layer(x,y,"Instances",obj_particle) {
				depth = -1
				sprite_index = spr_gibs
				image_index = irandom_range(0, image_number)
				hspeed = irandom_range(-6, 6)
				vspeed = irandom_range(-3, -6)
	
				stepcode = function() {
					vspeed += 0.35
					duration = 2
					if y - sprite_yoffset > room_height instance_destroy(self)
				}
			}
		}
	}
	instance_destroy(self)
	with obj_player {
		obj_player.changeState(states.attack)
		obj_player.statetimer = 40
	}
	global.combocount += 1
	global.comboresult += 1
	if global.combostart = false {
		global.combostart = true
	}
	with obj_combo {
		if combo = 0 {
			combo = 200	
		}
	}
}
function killrun() {
	scr_playsound(sfx_enemyhit)
	if global.particles {
		repeat (3) {
			with instance_create_layer(x,y,"Instances",obj_particle) {
				depth = -1
				sprite_index = spr_gibs
				image_index = irandom_range(0, image_number)
				hspeed = irandom_range(-6, 6)
				vspeed = irandom_range(-3, -6)
	
				stepcode = function() {
					vspeed += 0.35
					duration = 2
					if y - sprite_yoffset > room_height instance_destroy(self)
				}
			}
		}
	}
	instance_destroy(self)
	global.combocount += 1
	global.comboresult += 1
	if global.combostart = false {
		global.combostart = true
	}
	with obj_combo {
		if combo = 0 {
			combo = 200	
		}
	}
}
/*
function addcomboresult() {
	global.comboresult += 1
}
*/