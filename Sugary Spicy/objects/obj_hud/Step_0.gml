if instance_exists(obj_player)
{
	switch obj_player.state
	{
		case states.ouch:
			hudstate = hudstates.hurt
			break;
		default:
			if hudstate_timer <= 0 hudstate = hudstates.normal
			break;
	}
	if abs(obj_player.hsp) >= 12
	hudstate = hudstates.dash		
}
if global.panic {
	if global.timerpos < 32 {
		global.timerpos += 0.291
	}
}


if panictime_color > 0 {
	panictime_color = clamp(panictime_color - 15 + (panictime_color >> 6), 0, 255)
	// this gets an approximation of the value needed. APPROXIMATION. of the value needed
	// basically, 255 >> 6 is basically 255 / 100 rounded, that's what I based this off of
}
if room = TheCreditsRoom {
	visible = false
	instance_destroy(obj_player)
}
if instance_exists(obj_titlecard) {
	if obj_titlecard.istitlecard = true {
		visible = false
	}
	visible = false
} else if room = endscreen {
	visible = false
} else {
	visible = true
	obj_player.canmove = true
}
/*
if savedstats2[0] >= global.rank_req {
	if global.lap = true {
		rank = spr_rankhud_p
	} else if global.timeshurt <= 0 and scr_getallofvalue(savedstats2[1], 1) >= global.detrixie_req {
		rank = spr_rankhud_s
	} else {
		rank = spr_rankhud_a
	}
} else if savedstats2[0] >= (global.rank_req >> 1) + (global.rank_req >> 2)
	rank = spr_rankhud_b
else if savedstats2[0] >= global.rank_req >> 1 
	rank = spr_rankhud_c
else {
	if !array_find(savedstats2[1], 1){
		rank = spr_rankhud_f
	} else {
		rank = spr_rankhud_d
	}
}
*/
if shakeit < 0 {
	shakeit--
}
if shakeit2 < 0 {
	shakeit2--
}