if instance_exists(obj_endscreen) {
	switch obj_endscreen.calcrank {
		case "S":
			sprite_index = spr_rank2
			layer_set_visible("Background_2_1_1_1",true)
			break;
		case "A":
			sprite_index = spr_rank3
			layer_set_visible("Background_2_1_1",true)
			break;
		case "B":
			sprite_index = spr_rank4
			layer_set_visible("Background_2_1",true)
			break;
		case "C":
			sprite_index = spr_rank5
			layer_set_visible("Background_2",true)
			break;
		case "D":
			sprite_index = spr_rank6
			layer_set_visible("Background",true)
			break;
		case "F":
			sprite_index = spr_rank7
			layer_set_visible("Background_1",true)
			break;
	}
}