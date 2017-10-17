extends Patch9Frame

var buttons
signal changeScreenTo

func _ready():
	buttons = get_node("VBoxContainer").get_children()
	for child in buttons:
		# when user pressed a button we should tell the controler what screen we want to see next
		child.connect("switchScreen", self, "printName")

# this will get called when the user presses a button in menu
func printName(index):
	emit_signal("changeScreenTo", index)