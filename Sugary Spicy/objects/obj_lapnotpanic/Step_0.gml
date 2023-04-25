if !global.panic {
	image_alpha = 0.5
}
if global.panic {
	instance_destroy(self)
}