if global.lap {
	visible = true
}
if global.lapstart {
	instance_create_layer(x,y,"Instances",obj_lapstart)	
	instance_activate_object(obj_lapspawn)
}