msgtext = "NPC TEXT/n HERE"
idlespr = spr_plrtransition
talkspr = spr_genemy_scared
talk = false
if !instance_exists(obj_dialogue) {
	instance_create(x,y,obj_dialogue)
}
if global.panic = true {
	instance_destroy(self)
}
image_speed = 0.35
