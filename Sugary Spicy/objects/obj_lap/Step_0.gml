if !global.panic {
	instance_destroy(self)
	instance_create(x,y,obj_lapnotpanic)
}
if global.lap = true {
	instance_destroy(self)	
}