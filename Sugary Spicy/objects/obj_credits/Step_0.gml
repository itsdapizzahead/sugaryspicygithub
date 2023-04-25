y -= scroll_speed;
if keyboard_check_pressed(ord("Z")) {
	scroll_speed = 2
}
if keyboard_check_released(ord("Z")) {
	scroll_speed = 0.4	
}
if (y <= -text_height) {
	game_restart()
}