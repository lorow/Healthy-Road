extends Patch9Frame

var buttons

func _ready():
	buttons = get_node("VBoxContainer").get_children()
	for child in buttons:
		child.connect("switchScreen", self, "printName")

func printName(name):
	print(name)