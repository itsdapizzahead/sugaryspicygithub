xx += 0.6
xx2 += 0.4
xx3 += 0.2
alpha = clamp(alpha, 0, 1)
var threshold = 200
var max_dis = (sprite_width + threshold)
var dis = distance_to_object(obj_player)
alpha = ((dis / max_dis) * 1)
txt_alpha = ((dis / max_dis) * 1)
if (xx > max_xx)
    xx = 0
if (xx2 > max_xx)
    xx2 = 0
if (xx3 > max_xx)
    xx3 = 0
drawing = place_meeting(x, y, obj_player)
if place_meeting(x, y, obj_player)
{
    if (!drawing)
    {
        drawing = 1
        with (obj_hud)
        {
			alarm[0] = 1
			displaymessage = true
			msg_text = other.msg_replace
        }
    }
}
else
    drawing = 0
if global.panic {
	global.closed = true
	sprite_index = spr_coneboy
} else {
	global.closed = false	
}