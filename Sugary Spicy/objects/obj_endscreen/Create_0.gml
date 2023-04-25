savedstats = [
	global.collect,
	global.detrixies,
	global.comboresult
]

calcrank = "N/A"

if savedstats[0] >= global.rank_req {
	if global.detrixies = true {
		calcrank = "S"
	} else {
		calcrank = "F"
	}
} else if savedstats[0] >= (global.rank_req >> 1) + (global.rank_req >> 2)
	calcrank = "B"
else if savedstats[0] >= global.rank_req >> 1 
	calcrank = "C"
else {
	if global.detrixies = false{
		calcrank = "F"
	} else {
		calcrank = "D"
	}
}

#region rank explanation
/*
If score is over or at the A rank requirement:
- If the player was never hurt, all secrets were found, and all Detrixies were collected, give an S Rank
- Else, give an A Rank

If score is in the B Rank threshold, give a B Rank

If score is in the C Rank threshold, give a C Rank

If score is below the C Rank threshold:
- If the player didn't bother to find a secret or get a Detrixie, give an F Rank.
- Else, give a D Rank
*/
#endregion
audio_stop_all()

if calcrank != "N/A" {
	scr_playsound(asset_get_index("sfx_rank" + calcrank), false, false)
}