array_push(global.dslist, self.id)
with instance_create_layer(x,y,"Instances",obj_enemyparticle) {
	depth = -1
	obj_enemyparticle.image_angle += 1
	sprite_index = other.sprite_ded
	image_index = other.image_index
	image_xscale = other.image_xscale
	image_yscale = other.image_yscale
	hspeed = choose(6,5,4,3,2,1,7,8) * image_xscale
	vspeed = choose(-6,-8)
	
	stepcode = function() {
		vspeed += 0.35
		duration = 2
		if y - sprite_yoffset > room_height instance_destroy(self)
	}
}
with instance_create_layer(x,y,"Instances",obj_enemyparticle) {
	sprite_index = spr_dust
	duration = 8
	image_speed = 0.8
	depth = -2
}