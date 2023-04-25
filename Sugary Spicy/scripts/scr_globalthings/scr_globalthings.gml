// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_globalthings(){
	// nothing at all
}

function scr_buttoncheck() {
	var i = 0
	var retval = false
	while i < argument_count {
		if keyboard_check(argument[i]) or global.gamepad and gamepad_button_check(0, argument[i]) retval = true
		i++
	}
	return retval
}

function scr_buttoncheck_pressed() {
	var i = 0
	var retval = false
	while i < argument_count {
		if keyboard_check_pressed(argument[i]) or global.gamepad and gamepad_button_check_pressed(0, argument[i]) retval = true
		i++
	}
	return retval
}

function scr_cleardslists() {
	global.dslist = []
}

function scr_afterimages(type, _hsp, _vsp) {
	switch type
	{
		case afterimages.perpendicular: default:
			with instance_create_layer(x, y, "Instances", obj_particle) {
				sprite_index = other.sprite_index
				image_index = other.image_index
				image_speed = 0
				image_xscale = other.image_xscale
				image_yscale = other.image_yscale
				hspeed = _hsp
				vspeed = _vsp
				alpha = 1
				color = c_aqua
				duration = duration >> 2
			}
			with instance_create_layer(x, y, "Instances", obj_particle) {
				sprite_index = other.sprite_index
				image_index = other.image_index
				image_speed = 0
				image_xscale = other.image_xscale
				image_yscale = other.image_yscale
				hspeed = -_hsp
				vspeed = -_vsp
				alpha = 1
				color = c_white
				duration = duration >> 2
			}
			break;
		case afterimages.stationary:
			with instance_create_layer(x, y, "Instances", obj_particle) {
				sprite_index = other.sprite_index
				image_index = other.image_index
				image_speed = 0
				image_xscale = other.image_xscale
				image_yscale = other.image_yscale
				hspeed = _hsp
				vspeed = _vsp
				alpha = 1
				color = c_aqua
				duration = duration >> 2
			}
			break;
		case afterimages.run:
			with instance_create_layer(x, y, "Instances", obj_particle) {
				sprite_index = other.sprite_index
				image_index = other.image_index
				image_speed = 0
				image_xscale = other.image_xscale
				image_yscale = other.image_yscale
				hspeed = _hsp
				vspeed = _vsp
				alpha = 1
				color = choose(c_purple,c_blue)
				duration = duration >> 2
			}
	}
}

function scr_resetlevel() {
	window_set_position(480,540	/ 2)
	global.collect = 0
	global.targetDest = "A"
	global.panic = false
	global.timer = [2, 30]
	global.detrixies = [0, 0, 0, 0, 0]
	global.secrets = []
	global.armorytimer = false
	global.lap = false
	global.combostart = false
	global.comboresult = 0
	global.heat = false
	global.timerpos = 0
	if instance_exists(obj_player) {
		obj_player.hsp = 0
		obj_player.vsp = 0
		with obj_player
		{
			changeState(states.normal, true)
			for (var i = 0; i < instance_number(obj_plrtransition); i++)
			{
				var daTrans = instance_find(obj_plrtransition, i)
				if daTrans.doorindex == "A"
				{
					self.x = daTrans.x
					self.y = daTrans.y
				}
			}
		}
	}
	audio_sound_set_track_position(global.music, 0) // pseudo-restart music
	scr_cleardslists()
}

function scr_getallofvalue(array, value) {
	if typeof(array) != "array" exit;
	var instances = 0
	for (var i = 0; i < array_length(array); i++) {
		if array[i] == value {
			instances += 1
		}
	}
	return instances
}

function array_find(array, value) {
	if typeof(array) != "array" exit;
	for (var i = 0; i < array_length(array); i++) {
		if array[i] == value return true
	}
	return false
}
function create_debris(argument0, argument1, argument2, argument3) //gml_Script_create_debris
{
    if (argument3 == undefined)
        argument3 = 0
    var q = 
    {
        x: argument0,
        y: argument1,
        sprite_index: argument2,
        image_number: sprite_get_number(argument2),
        image_index: irandom((image_number - 1)),
        image_angle: random_range(1, 270),
        image_speed: 0.35,
        sprw: sprite_get_width(argument2),
        sprh: sprite_get_height(argument2),
        hsp: random_range(-4, 4),
        vsp: random_range(-4, 0),
        alpha: 1,
        grav: 0.4,
        type: (0 << 0),
        animated: argument3,
        destroyonanimation: 0
    }

    ds_list_add(global.debris_list, q)
    return q;
}
function draw_set_alpha_object(setalpha,object) {
	object.draw_set_alpha(setalpha)
}