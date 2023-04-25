draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, 0, c_white, 1)
var boss_usingShader = false
if boss_invuln {
	boss_usingShader = true
	shader_set(shd_invuln)
	shader_set_uniform_f(shader_get_uniform(shd_invuln, "time"), boss_invulm_timer)
}
if boss_usingShader shader_reset()