if global.panic {
	var sight = instance_nearest(x + 200,y + 200,obj_player)
	if sight {
		instance_create_unique(x,y,escapeenemy)
		visible = true
		image_index = 0
	}
}
if !global.panic {
	instance_destroy(self)
	instance_destroy(escapeenemy)
	instance_destroy(obj_enemyparticle)
}