if (scr_buttoncheck_pressed(vk_right) && i < 13)
{
	i += 1
	if (i = 3) {
		scr_playsound(sfx_arablaugh)	
	} else {
		scr_playsound(sfx_footstep)
	}
}
if (scr_buttoncheck_pressed(vk_left) && i > 0)
{
	i -= 1
	if (i = 3) {
		scr_playsound(sfx_arablaugh)	
	} else {
		scr_playsound(sfx_footstep)
	}
}
if (scr_buttoncheck_pressed(vk_escape) or keyboard_check_pressed(vk_f5))
{
	instance_destroy(self)
	instance_create_layer(x,y,"Instances",obj_mainmenu)
}