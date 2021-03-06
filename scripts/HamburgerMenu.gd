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

var stateChanged = false

func _ready():
	tween.connect("tween_step", self, "emit_move_signal")
	get_node("../topBar/Expand").connect("OpenMenu", self, "changeMenuState")
	set_process_input(true)

func _input(ev):
	if is_visible() and ((ev.type==InputEvent.SCREEN_TOUCH) or (ev.type==InputEvent.SCREEN_DRAG)) and not changingScreen:
		if ev.type==InputEvent.SCREEN_TOUCH and touchUtils.checkIfInside(ev, get_pos(), get_size()):
			if ev.pressed:
				offset = get_pos().x - ev.pos.x
				touched = true
			if not ev.pressed:
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
				var nextPos = Vector2(ev.pos.x + offset,get_pos().y)
				if nextPos.x <= 0 and nextPos.x >= menuSize:
					moved = true
					set_pos(nextPos)
					emit_move_signal()
					if nextPos.x > -300:
						emit_signal("maxPos", true)
						stateChanged = true
					else:
						emit_signal("maxPos", false)
						stateChanged = false

func changeMenuState():
	if not stateChanged:
		tween.interpolate_property(self, "rect/pos", get_pos(), Vector2(0, get_pos().y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		stateChanged = true
	else:
		tween.interpolate_property(self, "rect/pos", get_pos(), Vector2(menuSize, get_pos().y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		stateChanged = false
	tween.start()

func emit_move_signal(object = null, key = null, elapsed = null, value = null):
	emit_signal("moveScreen", get_pos().x + get_size().x - 90)