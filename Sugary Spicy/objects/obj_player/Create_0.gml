if (instance_number(object_index) > 1)
{
	instance_destroy()
	exit;
}
hsp = 0
vsp = 0
onground = false
crouched = false
canmove = true
dogravity = true
//jumpbuffer = 40

walkspeed = 0.8
maxspeed = 7
idlemode = 0 // 0 = normal, 1 = hurt, 2 = panic (UNUSED), 3 = crouched

statevars = array_create(32) // if you want to add or change a player state and it has a variable, chuck it here
global.targetDest = "A"

enum states {
	normal,
	stunned,
	crouch,
	grab,
	run,
	runturn,
	wallrun,
	superjump,
	taunt,
	ouch,
	stand,
	attack,
	stprep,
	supertaunt,
	rampjump,
	groundpound,
	spcancel,
	flushed
}
state = 0
prevstate = state
statetimer = 0 // used to switch between certain states

invuln = false
invulm_timer = 0


depth = -2
image_speed = 0.25

if !instance_exists(obj_hud) instance_create_layer(0,0,"Instances",obj_hud)

function changeSprite(input) {
	if sprite_index != input sprite_index = input
}

function changeState(input, resetvars = true) {
	state = input
	image_index = 0 // just for good measure
	if resetvars statevars = array_create(32)
}
character = "P"
key_left = scr_buttoncheck_pressed(vk_left)
key_right = scr_buttoncheck_pressed(vk_right)
meets_platform = place_meeting(x,y,obj_platform)
