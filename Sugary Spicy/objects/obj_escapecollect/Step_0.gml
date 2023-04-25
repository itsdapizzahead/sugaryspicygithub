if global.panic = false {
	instance_create(x,y,obj_noescapecollect)
}
if global.panic = true {
	visible = true
	if instance_exists(obj_noescapecollect) {
		instance_destroy(obj_noescapecollect)	
	}
}