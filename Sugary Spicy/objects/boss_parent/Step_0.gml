switch boss_state {
	case boss_states.normal:
		boss_normal()	
		break;
	case boss_states.hurted:
		boss_hurt()
		break;
}
if boss_canmove {
	if boss_state != boss_states.hurted and boss_invulm_timer > 0 {
		boss_invulm_timer -= 1
		if boss_invulm_timer <= 0 boss_invuln = false
	}
}
if place_meeting(x,y,obj_player) {
	if obj_player.state = states.grab and boss_state != boss_states.hurted {
		hurtboss()
		boss_hp -= 1
		with obj_player {
			obj_player.changeState(states.attack)
			obj_player.statetimer = 40
		}
	}
}
if boss_hp = 0 {
	instance_destroy(self)	
}
if boss_gravity {
	boss_onground = place_meeting(x, y + 1, obj_solid)
	if !boss_onground {
		vsp += 0.4
	}
	boss_collision()
}