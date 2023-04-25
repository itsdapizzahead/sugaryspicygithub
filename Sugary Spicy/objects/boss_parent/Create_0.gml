hsp = 0
vsp = 0
boss_invuln = false
sprite_ded = spr_genemy_scared
function changeBossState(input) {
	boss_state = input
	image_index = 0 // just for good measure
}
enum boss_states {
	normal,
	attack,
	hurted
}
boss_invulm_timer = 0
boss_state = boss_states.normal
boss_hp = 3
boss_canmove = true
boss_statetimer = 0
boss_gravity = true
attack_timer = 0