if vs != 0 {
	var findsolid = instance_place(x, y + vs, obj_solid)
	if findsolid {
		while !place_meeting(x, y + sign(vs), obj_solid)
			y += sign(vs)
		vs = 0
	}
}
y += vs
vs += 0.4
if obj_player.sprite_index != spr_player_hjump_prep {
	with instance_create_layer(x, y, "Instances", obj_beatboxparticle) {
		sprite_index = spr_genericpoofeffect
		depth = -2
	}
	image_alpha -= 0.1
}
if (image_alpha <= 0) {
    instance_destroy(self)
}