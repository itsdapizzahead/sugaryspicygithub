/*
if place_meeting(x, y, obj_player)
	alpha = Approach(alpha, 0, 0.05)
else
	alpha = Approach(alpha, 1, 0.05)
*/
if place_meeting(x,y,obj_player) {
	removeTiles()	
}
if !place_meeting(x,y,obj_player) {
	if !instance_exists(obj_tileshow) {
		instance_create(x,y,obj_tileshow)
	}
	if instance_exists(obj_tileshow) {
		instance_create(x,y,obj_null)
	}
}