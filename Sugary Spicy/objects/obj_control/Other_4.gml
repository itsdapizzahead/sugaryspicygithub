if global.panic = true {
	instance_create(x,y,obj_fadeNEW)
} else {
	instance_create(x,y,obj_fadeNEW)	
}
if layer_get_id("Tiles_1") != -1 {
	global.tileset = layer_get_id("Tiles_1")
	with obj_solid {
		switch object_index
		{
			case obj_destroyable: case obj_toughblock: case obj_bigdestroyable: case obj_destructible: case obj_panicblock: case obj_panicblock_alt: break;
			default: visible = false break;
		}
	}
}
didpanicsound = global.panic
switch room
{
	case room_template:
		checkSecret(room) // because why not?
		break;
}

if global.panic or room == endscreen exit;
var music_choice = -1

switch room
{
	case titlescreen:
		music_choice = d_title
		break;
	case temple_titlecard:
		music_choice = choco_swamp
		audio_stop_sound(d_hub)
		audio_stop_sound(mu_et)
		break;
	case floor_1:
		music_choice = d_hub
		break;
	case TheCreditsRoom:
		music_choice = mu_credits
		break;
	case temple_1:
		music_choice = mu_swamp
		break;
	case tutorial_entrance:
		music_choice = mu_tutorial
		break;
	case boss_painterTEST:
		music_choice = mu_painter
		break;
	case floor_pisselle:
		music_choice = just
		break;
	case boss_conefaceTEST:
		music_choice = mu_coneface
		break;
}

if music_choice != -1 scr_playmusic(music_choice)
switch room
{
	case room_init:
		window_set_caption("Are you ready for Sugary Spicy?")
		break;
	case titlescreen:
		window_set_caption("Welcome to Sugary Spicy!")
		break;
	case floor_1:
		window_set_caption("The hub in the Sugary Spicy.")
		break;
	case TheCreditsRoom:
		window_set_caption("Thank you for Sugary Spicy!")
		break;
	case temple_1:
		window_set_caption("The swamp temple in the Sugary Spicy.")
		global.rank_req = 10
		break;
	case timesup:
		window_set_caption("Times up! You lose! HA HA!")
		break;
}