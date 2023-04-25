if place_meeting(x,y,obj_player) and obj_player.state = states.run and abs(obj_player.hsp >= 12) {
	changeState(states.rampjump)	
}