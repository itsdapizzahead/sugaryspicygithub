function boss_hurt(){
	if boss_invuln exit;
	image_speed = 0.25
	sprite_index = spr_hurt
	if boss_onground vsp = -3
	boss_statetimer -= 1
	sprite_index = spr_hurt
	
	if statetimer <= 0 {
		changeState(states.normal)
		boss_canmove = true
		boss_invuln = true
		boss_invulm_timer = 40
		sprite_index = spr_hurt
	}
}