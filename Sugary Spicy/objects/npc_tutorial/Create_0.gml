msgtext = "NPC TEXT/n HERE"
if global.panic {
	msgtext = "GET OUTTA HERE!!"	
}
idlespr = spr_coneboy
talkspr = spr_coneboy_talk
talk = false
if !instance_exists(obj_dialogue) {
	instance_create(x,y,obj_dialogue)
}
image_speed = 0.35
