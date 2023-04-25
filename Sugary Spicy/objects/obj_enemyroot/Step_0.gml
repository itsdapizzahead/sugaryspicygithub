onground = place_meeting(x, y + 1, obj_solid)

if !onground {
	vsp += 0.35
}
scr_plr_collision() // I know this is meant for PLAYERS, but I assume it works for enemies too

if place_meeting(x,y + vsp,obj_solid) {
	if image_xscale = 1 {
		image_xscale = -1	
	}
	if image_xscale = -1 {
		image_xscale = 1	
	}
}
var plrsight = collision_line(x - 250, y, x + 250, y, obj_player, false, true)
if plrsight {
	if plrsight.state == states.run and abs(plrsight.hsp) >= 12 {
		sprite_index = sprite_scared
		image_index = sign(obj_player.x - x)
		scared = true
		hsp = 0
	} else scared = false
}

if hptimer != 0 {
	hptimer--	
}

if place_meeting(x,y,obj_player) {
	if obj_player.state == states.grab {
		if global.heat or global.lap {
			if object_index != obj_stabber {
				if obj_player.image_xscale = -1 {
					hsp = -5
					image_xscale = 1
				} else if obj_player.image_xscale = 1 {
					hsp = 5
					image_xscale = -1
				}
			}
			if object_index = obj_stabber {
				kill()	
			}
			vsp = -5
			hp -= 1
			hptimer = 50
			with obj_player {
				if obj_player.state != states.supertaunt {
					obj_player.changeState(states.attack)
					obj_player.statetimer = 40
				}
			}
			if hptimer = 0 {
				hsp = 0
				vsp = 0
			}
			sprite_index = sprite_stun
			if hp = 0 {
				kill()
			}
		}
		if !global.heat {
			kill()	
		}
		//addcomboresult()
	}
	if obj_player.state == states.run and abs(obj_player.hsp) >= 12 {
		killrun()
		//addcomboresult()
	}
}

if !scared sprite_index = sprite_idle
