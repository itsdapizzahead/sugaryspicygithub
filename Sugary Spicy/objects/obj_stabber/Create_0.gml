event_inherited()

sprite_move = spr_knight
sprite_scared = spr_knight_scared
sprite_ded = spr_knight_dead

hurtbox = instance_create_layer(x, y, "Instances", obj_hurtblock)
with hurtbox {
	image_xscale = 1.5
}