if !global.lap {
	audio_stop_sound(Lap2)
	visible = false
}
if global.panic and global.lap {
	visible = true	
}
scr_playsound(Lap2,true)
y = (-sprite_height)
down = 1
movespeed = 2
depth = -100