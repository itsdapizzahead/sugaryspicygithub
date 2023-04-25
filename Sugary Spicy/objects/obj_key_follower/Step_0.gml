if instance_exists(obj_player) and !instance_exists(obj_pause) {
	if (instance_number(object_index) > 1)
	{
		instance_destroy()
		exit;
	}
	if self.image_xscale = 1 {
		self.x = obj_player.x - 30
	}
	if self.image_xscale = -1 {
		self.x = obj_player.x + 30
	}
	if obj_player.state = states.runturn {
		self.x = obj_player.x
	}
	self.y = obj_player.y + 100
	self.image_xscale = obj_player.image_xscale
	sprite_index = spr_toppinshroom
	if obj_player.hsp != 0 {
		sprite_index = spr_toppinshroom_run	
		if obj_player.state = states.taunt {
			self.sprite_index = spr_toppinshroom_taunt
		}
	}
	if global.panic {
		sprite_index = spr_toppinshroom_panic
		if obj_player.state = states.taunt {
			self.sprite_index = spr_toppinshroom_taunt
		}
	}
}