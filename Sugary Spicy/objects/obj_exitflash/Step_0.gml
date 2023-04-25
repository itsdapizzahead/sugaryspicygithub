cval -= 0.5

if cval > 0 {
	cval = clamp(cval - 10 + (cval >> 6), 0, 255)
}