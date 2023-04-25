if down
{
    var ty = 200
    y = Approach(y, ty, movespeed)
    if (y >= ty && alarm[0] == -1)
        alarm[0] = 80
}
else
{
    ty = (-sprite_height)
    y = Approach(y, ty, movespeed)
    if (y <= ty)
        instance_destroy()
}
x = (960 / 2)
