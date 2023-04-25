array_push(global.dslist, self.id)
scr_playsound(sfx_break, true)
with instance_create_layer(x,y,"Instances",obj_particle) {
	depth = -1
	sprite_index = other.sprite_debris
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
with (instance_place((x - (32 * image_xscale)), y, obj_onewaysolid)) {
	instance_destroy()
}