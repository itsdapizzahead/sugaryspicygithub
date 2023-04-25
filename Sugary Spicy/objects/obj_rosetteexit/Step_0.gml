switch state
{
    case 3:
        if obj_player.sprite_index != spr_player_taunt
        {
            state = 0
            sprite_index = spr_rosette_exitsign
            image_index = 0
        }
        break
    case 2:
        x = -100
        y = -100
        if (global.panic && point_distance(xstart, ystart, obj_player.x, obj_player.y) <= 375)
        {
            state = 1
            vsp = 20
            sprite_index = spr_rosette_fall
            x = xstart
            y = (camera_get_view_y(view_camera[0]) - 100)
        }
        break
    case 1:
        y += vsp
        if (vsp < 20)
            vsp += 0.5
        if (y >= ystart)
        {
            y = ystart
            state = 0
            sprite_index = spr_rosette_exitsign
            image_index = 0
        }
        break
 
}

if (state == 2)
    visible = false
else
    visible = true
