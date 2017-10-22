extends Control

var top = Vector2(0,0)
var bottom = Vector2(0, get_size().y)
var allowMove = false
var touched
var offset

onready var contentNode = get_node("contentNode")
onready var maxContentPos = get_size().y - contentNode.get_size().y
export(int) var minContentPos = 0

func _ready():
	allowMove = checkIfBigger()
	set_process_input(true)
	
func _input(ev):
	if is_visible() and ((ev.type==InputEvent.SCREEN_TOUCH) or (ev.type==InputEvent.SCREEN_DRAG)) \
	and touchUtils.checkIfInside(ev, get_pos(), get_size()) and allowMove:
		if ev.type==InputEvent.SCREEN_TOUCH:
			if ev.pressed:
				offset = contentNode.get_pos().y - ev.pos.y
				touched = true
			else:
				touched = false

		if ev.type==InputEvent.SCREEN_DRAG and touched:
			if not offset == null:
				var nextPos = Vector2(contentNode.get_pos().x, ev.pos.y + offset)
				if nextPos.y <= minContentPos and nextPos.y >= maxContentPos:
					contentNode.set_pos(nextPos)

func checkIfBigger():
	if get_size().y >= contentNode.get_size().y:
		return false
	return true