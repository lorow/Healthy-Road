extends Control

onready var touchDetector = get_node("TouchDetecor")
onready var tween = get_node("Tween")

var initPos = null

var inside = false
var move = false

var startPos = null
var actPos = null

var direction = null

func _ready():
	set_process_input(true)
	set_process(true)

func _process(delta):
	
	if move:
		tween.interpolate_property(self,"rect/pos", get_pos(), Vector2(actPos.x - (get_pos().x - startPos.x)/2, get_pos().y), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
		if touchUtils.detectDirection(startPos, actPos) == 1 and get_pos().x >= 220: resetPos(220)
		if touchUtils.detectDirection(startPos, actPos) == 2 and get_pos().x <= 0:   resetPos(0)

func resetPos(end):
	move = false
	tween.stop(self, "rect/pos")
	set_pos(Vector2(end, get_pos().y))

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