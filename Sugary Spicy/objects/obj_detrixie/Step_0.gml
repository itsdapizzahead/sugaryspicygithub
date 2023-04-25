if place_meeting(x, y, obj_player) {
	if instance_exists(obj_message) instance_destroy(obj_message)
	with instance_create_layer(0, 0, "Instances", obj_message) {
		text = "You found the Detrixie!"
	}
	global.detrixies = true
	scr_playsound(sfx_collect)
	scr_playsound(sfx_detrixie, true)
	scr_playsound(sweet, true)
	with obj_hud {
		hudstate = hudstates.yippee
		hudstate_timer = 90
	}
	global.collect += 1000
	instance_create_unique(x,y,obj_detrixie_follower)
	instance_create_unique(x,y,obj_taunteffect)
	/*
	if instance_exists(obj_detrixie_follower) {
		instance_create_unique(x,y,obj_followertemp)	
	}
	*/
	instance_destroy(self)
	array_push(global.dslist, self.id)
	global.finish = true
}
if instance_exists(obj_candythief) {
	if global.stole = true {
		scr_playsound(sfx_stolen, true)
		instance_destroy(self)	
	}
}