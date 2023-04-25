if global.lap = true {
	sinywindow = (sin(thing2 * 75) * 5)
	sinxwindow = (sin(thing2 * 25) * 10)
	window_set_position(((sinxwindow * (15/3)) + (display_get_width() / 5)),((sinywindow * (15/3)) + (display_get_height() / 5)))
	thing2 += 0.001
}