event_inherited()

var plrsight = collision_line(x - 250, y, x + 250, y, obj_player, false, true)
if plrsight {
	if plrsight.state == states.run and abs(plrsight.hsp) >= 12 {
		sprite_index = sprite_scared
		image_xscale = x > plrsight.x ? 1 : -1
		scared = true
		hsp = 0
	} else scared = false
} else scared = false

if !scared {
	if sprite_index != sprite_move sprite_index = sprite_move
	if place_meeting(x * image_xscale, y, obj_solid) or !place_meeting(x + 20 * image_xscale, y + 51, obj_solid) {
		image_xscale = -image_xscale
	}
	hsp = 1 * image_xscale
}