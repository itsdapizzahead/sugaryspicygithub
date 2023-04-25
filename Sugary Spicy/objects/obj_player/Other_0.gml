if room == endscreen exit;
if room == timesup {
	canmove = false
	exit;
}
if instance_exists(obj_titlecard) {
	if obj_titlecard.istitlecard = true {
		canmove = false
		exit;
	}
}
instance_create_layer(x,y,"Instances",obj_oops)
for (var i = 0; i < instance_number(obj_plrtransition); i++) {
	var daTrans = instance_find(obj_plrtransition, i)
	if daTrans.doorindex == global.targetDest {
		self.x = daTrans.x
		self.y = daTrans.y
	}
}
