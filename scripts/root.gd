extends Node

var startPos
var endPos

var maxXMargin
var maxYMargin

func _ready():
	set_process_input(true)
	set_process(true)

func _process(delta):
	detect_swipe()

func detect_swipe():
	if startPos != null and endPos != null:
		var distanceX = endPos.x - startPos.x
		var distanceY = endPos.y - startPos.y
		if abs(distanceX) > abs(distanceY):
			if distanceX > 0: pass
			else: pass
		else:
			if distanceX > 0: pass
			else: pass

func _input(ev):
	if ev.type == InputEvent.SCREEN_DRAG: endPos = ev.pos
	if ev.type == InputEvent.SCREEN_TOUCH and ev.pressed: startPos = ev.pos