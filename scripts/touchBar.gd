extends Node

var barScene
var touchEvent = InputEvent()

func _ready():
	barScene = get_node("Menubar")
	touchEvent.type = InputEvent.KEY
	
func _update():
	if touchEvent.pressed:
		print("t")