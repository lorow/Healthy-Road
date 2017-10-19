extends Control

var buttons
export var buttonsContainerNode = "VBoxContainer"
onready var path_to_pressed_texture = load("res://sprites/homescreen/pomidor.tex")
signal changeScreenTo

func _ready():
	buttons = get_node(buttonsContainerNode).get_children()
	for child in buttons:
		# when user pressed a button we should tell the controler what screen we want to see next
		child.connect("switchScreen", self, "sendIndex")
		child.connect("switchScreen", self, "setActiveTexture")
		
# this will get called when the user presses a button in menu
func setActiveTexture(index):
	if not path_to_pressed_texture == null:
		for child in buttons:
			child.resetTexture()
		buttons[index].set_normal_texture(path_to_pressed_texture)
	else: print("jebać godot")

func sendIndex(index):
	emit_signal("changeScreenTo", index)