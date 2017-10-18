extends Control

export var menuSize = -400

var offset
var moved = false
var touched = true
onready var tween = get_node("Tween")
onready var touch = get_node("TouchDetecor")
signal moveScreen
signal maxPos
var changingScreen = false


func _ready():
	tween.connect("tween_step", self, "emit_move_signal")
	set_process_input(true)

func _input(ev):
	if is_visible() and ((ev.type==InputEvent.SCREEN_TOUCH) or (ev.type==InputEvent.SCREEN_DRAG)) and not changingScreen:
		if ev.type==InputEvent.SCREEN_TOUCH:
			if ev.pressed and touchUtils.checkIfInside(ev, get_pos(), get_size()):
				offset = (get_size().x/2) - ev.pos.x
				touched = true
			if not ev.pressed :
				touched = false
				if moved:
					if abs(menuSize - get_pos().x) < abs(0 - get_pos().x):
						tween.interpolate_property(self, "rect/pos", get_pos(), Vector2(menuSize, get_pos().y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
					else:
						tween.interpolate_property(self, "rect/pos", get_pos(), Vector2(0, get_pos().y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
					tween.start()
					emit_move_signal()
					moved = false

		if ev.type==InputEvent.SCREEN_DRAG and touched:
			if not offset == null:
				var nextPos = Vector2(ev.pos.x - (get_size().x - 90 /2),get_pos().y)
				if nextPos.x <= 0 and nextPos.x >= menuSize:
					moved = true
					set_pos(nextPos)
					emit_move_signal()
					if get_pos().x >= menuSize: emit_signal("maxPos")

func emit_move_signal(object = null, key = null, elapsed = null, value = null):
	emit_signal("moveScreen", get_pos().x + get_size().x - 90)