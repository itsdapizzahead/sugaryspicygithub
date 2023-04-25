displaymessage = false
msg_text = "LEVEL NAME HERE"
msg_lap = "YOU DID THE LAP"

enum hudstates {
	normal,
	hurt,
	yippee,
	dash,
	adbelike
}
hudstate = hudstates.normal
hudstate_timer = 0

global.timerpos = -16

panictime_color = 0 // how red the text should be
panictime_lerp = false // used to interpolate the color
dashhud = spr_plrhud_dash;
dashhud_frame = 0;
dashhud_speed = 0.35;

hud = spr_heatmeter2;
hud_frame = 0;
hud_speed = 0.35;

rank = spr_rankhud_d

savedstats2 = [
	global.collect,
	global.detrixies,
	global.comboresult
]
shakeit = 0
shakeit2 = 0