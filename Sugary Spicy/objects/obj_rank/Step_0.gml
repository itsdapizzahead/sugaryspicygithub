if instance_exists(obj_endscreen) {
	switch obj_endscreen.calcrank {
		case "S":
			image_index = 5
			break;
		case "A":
			image_index = 4
			break;
		case "B":
			image_index = 3
			break;
		case "C":
			image_index = 2
			break;
		case "D":
			image_index = 1
			break;
		case "F":
			image_index = 0
			break;
	}
}