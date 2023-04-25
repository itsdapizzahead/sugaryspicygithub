instance_deactivate_all(true)
enum bitch {
	main,
	options,
	options_audio,
	options_video,
	options_misc,
	options_fx
}
curmenu = bitch.main

option_main = [
	"Go to Options",
	"Exit Options"
]
// the settings menu is handled without a variable
options_yesno = [
	"Yes",
	"No"
]
curopt = option_main
select = 0
selectmax = array_length(curopt) - 1
draw_set_font(fnt_textregular)

#region preview vars
//these variables are used for the previews you get when changing options

preview_music = "?"
preview_sound = -1

preview_soundtimer = 0
function preview_sfx() {
	preview_sound = choose(
		sfx_jump,
		sfx_hjump,
		sfx_bump,
		sfx_collect,
		sfx_detrixie,
		sfx_grab,
		sfx_hurt,
	)
	scr_playsound(preview_sound)
	preview_soundtimer = irandom_range(30, 50)
}

#endregion

global.savedataname = "LibreTower"
function changeOpt(name, value) {
	ini_open(global.savedataname + ".ini")
	ini_write_real("Options",name,value)
	ini_close()
	return value
}

if !file_exists(global.savedataname + ".ini") {
	ini_open(global.savedataname + ".ini")
	global.sfxvol = ini_write_real("Options","SoundVol",100)
	global.musvol = ini_write_real("Options","MusicVol",100)
	
	global.particles = ini_write_real("Options","Particles",true)
	global.panicshake = ini_write_real("Options","PanicShake",true)
	
	global.resolution = ini_write_real("Options","Resolution",1) // 1 is 960 x 540
	global.fullscreen = ini_write_real("Options","Fullscreen",false)
	
	global.gamepad = ini_write_real("Options","UseGamepad",false)
	global.sus = ini_write_real("Options","Minus8Mode",false)
	ini_close()
} else {
	ini_open(global.savedataname + ".ini")
	global.sfxvol = ini_read_real("Options","SoundVol",100)
	global.musvol = ini_read_real("Options","MusicVol",100)
	
	global.particles = ini_read_real("Options","Particles",true)
	global.panicshake = ini_read_real("Options","PanicShake",true)
	
	global.resolution = ini_read_real("Options","Resolution",1)
	global.fullscreen = ini_read_real("Options","Fullscreen",false)
	
	global.gamepad = ini_read_real("Options","UseGamepad",false)
	global.sus = ini_read_real("Options","Minus8Mode",false)
	ini_close()
}
window_set_fullscreen(global.fullscreen)

function switchOpts() {
	switch curmenu
	{
		case bitch.main:
			curopt = option_main
			break;
		case bitch.options: case bitch.options_video: case bitch.options_audio: case bitch.options_fx:
			break;
	}
	selectmax = 4
}

function getToggled(input, isCustom = false, custom_on = "On", custom_off = "Off") {
	if isCustom {
		return input ? custom_on : custom_off
	} else {
		return input ? "On" : "Off"
	}
}

image_speed = 0.25
bgx = 0
bgy = 0