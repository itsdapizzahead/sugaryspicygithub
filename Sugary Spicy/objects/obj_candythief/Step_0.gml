if place_meeting(x + 30,y,obj_detrixie) {
	ysp = 0
	xsp = 0
	sprite_index = spr_candythief_win
	global.stole = true
}
x += xsp
y += ysp
if global.finish = true {
	xsp = 0
	ysp = 0
	sprite_index = spr_candythief_lose
	global.stole = true
}