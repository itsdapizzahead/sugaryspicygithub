if global.panic {
	global.targetDest = targetDest
	room_goto(targetRoom)
	global.lapstart = false
}