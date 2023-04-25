/*
ini_open(global.savedataname + ".ini")
ini_write_string(calcrank,"Rank",calcrank)
ini_close()
*/
if !audio_is_playing(asset_get_index("sfx_rank" + calcrank)) {
	scr_playmusic(sfx_rankloop)
	if scr_buttoncheck(ord("Z"), gp_face1) {
		game_restart()
	}
}