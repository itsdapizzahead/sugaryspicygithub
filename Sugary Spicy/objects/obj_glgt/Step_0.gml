high -= 5
if high <= -200
	instance_destroy()

if !global.panic
{
	image_alpha -= 0.1;
	if image_alpha <= 0
		instance_destroy();
}
else
	image_alpha = 1;
