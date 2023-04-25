global.detrixies = true
gerome = obj_gerome
dextrixie = obj_detrixie_follower
if !instance_exists(obj_pause) {
	depth = obj_player.depth
}
if (instance_number(object_index) > 1)
{
	instance_destroy()
	exit;
}