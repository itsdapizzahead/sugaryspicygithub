if scr_buttoncheck_pressed(ord("Z"), gp_face3) {
	switch select
	{
		case 0:
			instance_activate_all()
			instance_destroy(self)
			break;
		case 1:
			var isValid = false
			switch room
			{
				case temple_1: case temple_2: case temple_3: case temple_inside1:
					room_goto(temple_1)
					isValid = true
					break;
			}
			if !isValid exit;
			scr_resetlevel()
			window_set_position(window_get_x(),window_get_y())
			instance_destroy(self)
			break;
		case 2:
			if room == testroom {
				room_goto(titlescreen)
				window_set_position(window_get_x(),window_get_y())
				instance_destroy(self)
			} else {
				room_goto(testroom)
				global.targetDest = "A"
				scr_resetlevel()
				window_set_position(window_get_x(),window_get_y())
				instance_destroy(self)
			}
			break;
		case 3:
			instance_create_layer(x,y,"Instances",obj_options)
			instance_destroy(self)
			break;
	}
}
scr_playbreakdance(mu_pause)
if scr_buttoncheck_pressed(vk_up, gp_padu) select--
if scr_buttoncheck_pressed(vk_down, gp_padd) select++

if select < 0 select = selmax
if select > selmax select = 0