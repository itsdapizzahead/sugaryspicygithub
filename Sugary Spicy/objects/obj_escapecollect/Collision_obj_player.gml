if global.panic = true {
	switch object_index // doing it this way's less costly than the "add amount var" method
	{
		case obj_collectible: default:
			global.collect += 10
			audio_play_sound(sfx_collect,0,false)
			audio_sound_pitch(sfx_collect,choose(1,1.1,1.15,0.9,0.99,1.2,1.3,1.25))
			break;
		case obj_bigcollect:
			global.collect += 100
			break;
		case obj_escapecollect:
			global.collect += 15
			audio_play_sound(sfx_escapecollect,0,false)
			audio_sound_pitch(sfx_escapecollect,choose(1,1.1,1.15,0.9,0.99,1.2,1.3,1.25))
			break;
	}
	array_push(global.dslist, self.id)
	if global.particles {
		with instance_create_layer(x, y, "Instances", obj_particle) {
			sprite_index = spr_dust
			duration = 8
			image_speed = 0.60
		}
	}
	instance_destroy(self)
	obj_combo.combo = 100	
}