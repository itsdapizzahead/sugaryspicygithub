if instance_exists(obj_mainmenu) {
if obj_mainmenu.select == 0 {
	image_index = 0
}
if obj_mainmenu.curmenu = menutype.options or obj_mainmenu.select = 1 or obj_mainmenu.curmenu != menutype.cleardata and obj_mainmenu.select != 0 and obj_mainmenu.select != 2 {
	image_index = 1
}
if obj_mainmenu.select = 2 or obj_mainmenu.curmenu = menutype.cleardata {
	image_index = 2
}
if obj_mainmenu.curmenu = menutype.options {
	visible = false
} 
if obj_mainmenu.curmenu = menutype.main {
	visible = true
}
}