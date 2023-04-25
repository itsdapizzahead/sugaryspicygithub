var offsetX = 0
var offsetY = 0
if (!surface_exists(bg_surf))
    bg_surf = surface_create(sprite_width, (sprite_height + offsetY))
else
{
    var light_index = 1
    surface_set_target(bg_surf)
    draw_sprite_ext(spr_gate, light_index, offsetX, offsetY, 1, 1, 0, c_white, 1)
    gpu_set_colorwriteenable(1, 1, 1, 0)
	draw_sprite(spr_gateBG, light_index, offsetX, offsetY)
    gpu_set_colorwriteenable(1, 1, 1, 1)
    surface_reset_target()
    draw_surface_ext(bg_surf, (x - offsetX), (y - offsetY), 1, 1, 0, c_white, 1)
}
draw_sprite_ext(spr_gate, 1, x, y, 1, 1, 0, c_white, alpha)
draw_sprite_ext(spr_gate, 0, x, y, 1, 1, 0, c_white, 1)
draw_set_font(fnt_textregular)
draw_set_color(c_white)