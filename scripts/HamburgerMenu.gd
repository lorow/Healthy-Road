extends Control

var offset
var moved = false
onready var tween = get_node("Tween")
signal moveScreen

func _ready():
	tween.connect("tween_step", self, "tweenStep")
	set_process_input(true)

func _input(ev):
	if is_visible() and ((ev.type==InputEvent.SCREEN_TOUCH) or (ev.type==InputEvent.SCREEN_DRAG)):
		if ev.type==InputEvent.SCREEN_TOUCH:
			if ev.pressed and touchUtils.checkIfInside(ev, get_pos(), get_size()): offset = (get_size().x/2) - ev.pos.x
			if not ev.pressed and moved:
				var leftOffset = abs(-220 - get_pos().x)
				var rightOffset = abs(0 - get_pos().x)
				if leftOffset < rightOffset:
					tween.interpolate_property(self, "rect/pos", get_pos(), Vector2(-220, get_pos().y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				else:
					tween.interpolate_property(self, "rect/pos", get_pos(), Vector2(0, get_pos().y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.start()
				emit_move_signal()
				moved = false 
		if ev.type==InputEvent.SCREEN_DRAG:
			if not offset == null:
				var nextPos = Vector2(ev.pos.x - (get_size().x - 90 /2),get_pos().y)
				if nextPos.x <= 0 and nextPos.x >= -220:
					moved = true
					set_pos(nextPos)
					emit_move_signal()

func tweenStep(object, key, elapsed, value):
	emit_move_signal()

func emit_move_signal():
	emit_signal("moveScreen", get_pos().x + 220)