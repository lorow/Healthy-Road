extends TextureButton

export var screenIndexToShow = 0 # index of the screen to show after click
signal switchScreen

func _ready():
	connect("pressed", self, "change_screen")

func change_screen():
	emit_signal("switchScreen", screenIndexToShow)