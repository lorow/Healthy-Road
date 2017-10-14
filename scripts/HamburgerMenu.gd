extends Control

signal moveScreen

onready var touchDetector = get_node("TouchDetecor")
onready var tween = get_node("Tween")
var timeTween = 0.2

var initPos = null
var inside = false
var move = false
var startPos = null
var actPos = null
var direction = null

var pos

var maxPos = 221
var minPos = 0

func _ready():
	set_process_input(true)
	set_process(true)

func _process(delta):
	pos = get_pos()
	if move:
		if direction == 1 and pos.x < maxPos:
			tween.interpolate_property(self,"rect/pos", pos, Vector2(actPos.x - (pos.x - startPos.x)/2, pos.y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
		if direction == 2 and pos.x > minPos:
			tween.interpolate_property(self,"rect/pos", pos, Vector2(actPos.x - (pos.x - startPos.x)/2, pos.y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			
		if pos.x > maxPos + 1:
			tween.stop(self, "rect/pos")
			set_pos(Vector2(maxPos, pos.y))
		if pos.x < minPos - 1:
			tween.stop(self, "rect/pos")
			set_pos(Vector2(minPos, pos.y))
			
		emit_signal("moveScreen", pos.x , timeTween)
			
func _input(ev):
	if ev.type == InputEvent.SCREEN_TOUCH and touchUtils.checkIfInside(ev, touchDetector.get_pos(), touchDetector.get_size()):
		if ev.pressed:
			startPos = ev.pos
			inside = true
		else:
			inside = false
			move = false
	if ev.type == InputEvent.SCREEN_DRAG and inside:
		actPos = ev.pos
		direction = touchUtils.detectDirection(startPos, actPos)
		move = true
