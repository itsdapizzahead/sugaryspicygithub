function scr_coneface_phases(){

}
function scr_coneface_phase1(){
	if cfattack <= 0 {
		if image_xscale = 1 {
			hsp = -5
		}
		if image_xscale = -1 {
			hsp = 5
		}
	}
	if place_meeting(x + hsp,y,obj_solid) {
		cfattack = 40
		if image_xscale = 1 image_xscale = -1
		if image_xscale = -1 image_xscale = 1
	}
}
function scr_coneface_phase2(){

}