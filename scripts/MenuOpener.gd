extends TextureButton

signal OpenMenu

func _ready():
	connect("pressed", self, "openMenu")
	
func openMenu():
	emit_signal("OpenMenu")