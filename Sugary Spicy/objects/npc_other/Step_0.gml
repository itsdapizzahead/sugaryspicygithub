if !place_meeting(x,y,obj_player) {
	talk = false	
}
if talk = true {
    sprite_index = talkspr
} else if talk = false {
    sprite_index = idlespr
}