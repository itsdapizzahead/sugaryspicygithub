if array_find(global.dslist, self.id) {
	instance_destroy(self, false)
	with (instance_nearest(x, y, obj_onewaysolid)) {
		instance_destroy()
	}
}