if !visible exit; // even when invisible, this still calls stuff. amazing game engine I tell ya

if state == states.taunt instance_create_unique(x,y,obj_taunteffect)
var usingShader = false
if invuln {
	usingShader = true
	shader_set(shd_invuln)
	shader_set_uniform_f(shader_get_uniform(shd_invuln, "time"), invulm_timer)
}
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, 1)
if global.firemode = true {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_red, 1)
}
if usingShader shader_reset()