with instance_create_layer(random(room_width),10,"Instances",obj_enemyparticle) {
	depth = -1
	sprite_index = spr_descrutible_debris1
	image_index = other.image_index
	image_xscale = other.image_xscale
	image_yscale = other.image_yscale
	hspeed = choose(10,-10,5,-5)
	vspeed = 0
	
	stepcode = function() {
		vspeed += 0.35
		duration = 2
		if y - sprite_yoffset > room_height instance_destroy(self)
	}
}
alarm[0] = 5
