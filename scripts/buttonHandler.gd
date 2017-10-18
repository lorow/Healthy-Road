extends Control

var buttons
export var buttonsContainerNode = "VBoxContainer"
signal changeScreenTo

func _ready():
	buttons = get_node(buttonsContainerNode).get_children()
	for child in buttons:
		# when user pressed a button we should tell the controler what screen we want to see next
		child.connect("switchScreen", self, "sendIndex")

# this will get called when the user presses a button in menu
func sendIndex(index):
	emit_signal("changeScreenTo", index)