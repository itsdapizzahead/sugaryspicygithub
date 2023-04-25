if (instance_number(obj_pause) > 1)
{
	instance_destroy(obj_pause)
	exit;
}
instance_create_layer(x,y,"Instances",obj_pause)