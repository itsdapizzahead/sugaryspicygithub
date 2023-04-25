if instance_exists(obj_player) and !instance_exists(obj_pause) {
	if (instance_number(object_index) > 1)
	{
		instance_destroy()
		exit;
	}
	if self.image_xscale = 1 {
		obj_detrixie_follower.x = obj_player.x - 30
	}
	if self.image_xscale = -1 {
		obj_detrixie_follower.x = obj_player.x + 30
	}
	if obj_player.state = states.runturn {
		self.x = obj_player.x
	}
	obj_detrixie_follower.y = obj_player.y + 10
	self.image_xscale = obj_player.image_xscale
	if obj_player.state = states.taunt {
		instance_create_unique(x,y,obj_taunteffecttoppin)
		if !global.sus {
			self.sprite_index = spr_toppinshroom_taunt
		}
		if global.sus {
			self.sprite_index = spr_toppinshroomsus_taunt
		}
	} else {
		if global.sus {
			self.sprite_index = spr_toppinshroomsus
		}
		if !global.sus {
			self.sprite_index = spr_toppinshroom
		}
	} if obj_player.hsp != 0 {
		if global.sus {
			self.sprite_index = spr_toppinshroomsus_run
		}
		if !global.sus {
			self.sprite_index = spr_toppinshroom_run
		}
		if obj_player.state = states.taunt {
			if !global.sus {
				self.sprite_index = spr_toppinshroom_taunt
			}
			if global.sus {
				self.sprite_index = spr_toppinshroomsus_taunt
			}
		}
	}
	if global.panic {
		if global.sus {
			self.sprite_index = spr_toppinshroomsus_panic
		}
		if !global.sus {
			self.sprite_index = spr_toppinshroom_panic
		}
		if obj_player.state = states.taunt {
			if global.sus {
				self.sprite_index = spr_toppinshroomsus_taunt
			}
			if !global.sus {
				self.sprite_index = spr_toppinshroom_taunt
			}
		}
	}
}