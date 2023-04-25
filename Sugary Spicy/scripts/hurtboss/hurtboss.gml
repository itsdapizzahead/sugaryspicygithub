function hurtboss(sethsp = -6 * image_xscale, setvsp = -4, removepoints = false) {
	if boss_invuln or boss_state == boss_states.hurted return;
	scr_playsound(sfx_hurt)
	scr_playsound(sfx_attack)
	vsp = setvsp
	hsp = sethsp
	sprite_index = spr_hurt
	changeBossState(states.ouch)
	boss_statetimer = 20
}