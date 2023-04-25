event_inherited();
cfattack--
switch phase {
	case bossphase.phase1:
		scr_coneface_phase1()
		break;
	case bossphase.phase2:
		scr_coneface_phase2()
		break;
}
if phase = bossphase.phase1 and boss_hp = 0 {
	phase = bossphase.phase2
	boss_hp = 10
}
