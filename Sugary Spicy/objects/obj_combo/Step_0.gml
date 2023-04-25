if global.combostart = true {
	combo -= 0.85
	if comboy < 100 {
		comboy += 10
	}
	visible = true
	if combo = 0 {
		global.combostart = false
		global.combocount = 0
		visible = false
	}
}