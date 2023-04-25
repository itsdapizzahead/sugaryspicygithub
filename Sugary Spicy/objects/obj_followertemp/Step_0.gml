if instance_exists(obj_player) {
	obj_followertemp.x = obj_player.x
	obj_followertemp.y = obj_player.y
	/*
	if instance_exists(obj_detrixie_follower) {
		obj_followertemp.x =obj_detrixie_follower.x
		obj_followertemp.y = obj_detrixie_follower.y	
	}
	*/
	if obj_player.key_left or obj_player.key_right {
		obj_followertemp.x = obj_player.x * 5
		sprite_index = spr_toppincheese_run
		if scr_buttoncheck_pressed(vk_left) {
			image_xscale = -1	
		} else {
			image_xscale = 1	
		}
	} else {
		sprite_index = spr_toppinshroom
		if scr_buttoncheck_pressed(vk_left) {
			image_xscale = -1	
		} else {
			image_xscale = 1	
		}
	}
	if global.panic {
		sprite_index = spr_toppinshroom_panic
	}
}