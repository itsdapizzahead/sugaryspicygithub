#macro debug true

global.music = audio_play_sound(d_null,-1,true)
global.ltfont = font_add_sprite_ext(spr_font,"0123456789",false,0)
global.dslist = [] // using a DS list was too buggy
global.collect = 0
global.panic = false
global.timer = [2, 30]
global.armorytimer = false
global.settimer = [5, 30]
global.armoryfont = font_add_sprite_ext(spr_blank,"1234567890:",false,11)
global.lap = false
global.lapstart = false
global.font = font_add_sprite_ext(spr_font_combo,"0123456789:",false,11)
global.combofont = font_add_sprite(spr_font_combo2,"0123456789",false,10)
global.ltfontREAL = font_add_sprite_ext(spr_fontREAL,string("ABCDEFGHIJKLMNOPQRSTUVWXYZ!.0123456789:"),true,0)
global.firemode = false
global.dialoguefnt = font_add_sprite_ext(spr_creditsfont,"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!,.:0123456789'?_",false,0)

global.heat = false

global.comboresult = 0

global.tileset = noone // used for secret destructibles

global.detrixies = [0, 0, 0, 0, 0]
global.secrets = [] // stores secret rooms the player visited

global.camshake = [0, 0]

camxoffset = 0

panictimer = 60
panictimespent = 0 // used for screen shake
didpanicsound = false

didlapsound = false

#region enums

enum afterimages {
	perpendicular,
	stationary,
	run
}

#endregion
#region functions

function checkSecret(input) {
	if !array_find(global.secrets, input) {
		array_push(global.secrets, input)
		if instance_exists(obj_message) instance_destroy(obj_message)
		with instance_create_layer(0, 0, "Instances", obj_message) {
			var len = array_length(global.secrets)
			var suffix = len != 1 ? "s" : ""
			if array_length(global.secrets) == global.secret_req {
				text = "You found all of the secrets!"
			} else {
				text = "You found " + string(len) + " secret" + suffix + "!"
			}
		}
	}
}

#endregion
#region rank-related
/*
the ranks go in order from worst to best: F, D, C, B, A, and S

F rank requirements are that you collect NO detrixies or secrets and get enough points for D rank

D, C, B, and A ranks are judged by points (global.rank_req)
A is at or above rank_req, B is 3/4ths of rank_req, C is 1/2 of rank_req, and D is 1/4 of rank_req.
in bitshift terms, A is >>0, B is >>1 > >>2, C is >>1, and D is >>2.
don't worry, points aren't meant to be decimals anyway

S rank requirements are that you find every detrixie, find all the secrets, don't get hurt, and get enough points for an A rank.
*/

global.rank_req = 980
global.secret_req = 1
global.detrixie_req = 1
global.timeshurt = 0
#endregion
instance_create_layer(x,y,"Instances",obj_shell)
function begin_prompt_pillar() {
	if instance_destroy(obj_exitswitch)	{
		scr_playsound(sfx_placeholder)
		scr_playsound(sfx_escapeon)
		scr_playsound(sfx_enemyhit)
	}
}
