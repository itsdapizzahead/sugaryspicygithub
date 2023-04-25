// door check goes first
for (var i = 0; i < instance_number(obj_plrtransition); i++) {
	var daTrans = instance_find(obj_plrtransition, i)
	if daTrans.doorindex == global.targetDest {
		self.x = daTrans.x
		self.y = daTrans.y
	}
}

if instance_exists(obj_roomtitle) instance_destroy(obj_roomtitle)

var titlethingy = instance_create_layer(0,0,"Instances",obj_roomtitle)

switch room
{
	case titlescreen: titlethingy.text = "Libre Tower: the free, open-source\nPizza Tower-like game" break;
	case room_init: titlethingy.text = "HOW ARE YOU HERE????" break;
	case testroom: 
		titlethingy.text = "WELCOME TO THE DEMO!"
		global.rank_req = 0
		break;
	case floor_1: titlethingy.text = "Choose your level." break;
	case endscreen: instance_destroy(obj_roomtitle) break;
	case temple_1:  break;
	case TheCreditsRoom: instance_destroy(obj_roomtitle) break;// No more obj_roomtitle. It's gone. Go home, it's over.
}
scr_playerspr()