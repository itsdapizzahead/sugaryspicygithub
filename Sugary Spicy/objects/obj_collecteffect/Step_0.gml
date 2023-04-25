var scale = 1.25
var distance = point_distance(drawx, drawy, targetx, targety)
if (biggening == 1)
    drawxscale = Approach(drawxscale, scale, 0.15)
else if (biggening == 0 && distance >= 96)
    drawxscale = Approach(drawxscale, 0.85, 0.15)
else
    drawxscale = Approach(drawxscale, 0, 0.25)
if (drawxscale == scale)
    biggening = 0
var angle = point_direction(drawx, drawy, targetx, targety)
drawx += lengthdir_x(16, angle)
drawy += lengthdir_y(16, angle)
if point_in_circle(drawx, drawy, targetx, targety, 32)
{
	drawx = targetx
    drawy = targety
    instance_destroy()
}
drawyscale = drawxscale
