if place_meeting(x,y,obj_player) {
	if obj_player.state == states.grab
	or obj_player.state == states.run and abs(obj_player.hsp) >= 12 {
		toggleExitSwitch()
		global.panic = true
		instance_destroy(self)
		array_push(global.dslist, self.id)
		image_index = 1
	}
}