toggled = false
image_speed = 0
image_index = toggled ? 1 : 0
sprite_index = spr_pillaridle
sprite_ded = spr_pillarprep
settime = [2, 30]
if global.armorytimer settime = [5, 30]

function toggleExitSwitch() {
	toggled = true
	array_push(global.dslist, self.id)
	if global.panic exit;
	global.panic = true
	global.timer = settime
}
if array_find(global.dslist, self.id) instance_destroy(self, false)