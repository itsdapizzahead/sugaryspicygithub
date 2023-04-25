with instance_create_layer(x,y,"Instances",obj_enemyparticle) {
	depth = -1
	sprite_index = other.sprite_ded
	image_index = other.image_index
	image_xscale = other.image_xscale
	image_yscale = other.image_yscale
	hspeed = 6 * image_xscale
	vspeed = -6
	
	stepcode = function() {
		vspeed += 0.35
		duration = 2
		if y - sprite_yoffset > room_height instance_destroy(self)
	}
}
instance_create_layer(x,y,"Instances",obj_glgt)
instance_create_layer(x,y,"Instances",obj_exitflash)
obj_control.begin_prompt_pillar()