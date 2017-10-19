extends TextureButton

export var screenIndexToShow = 0 # index of the screen to show after click
onready var starterTexture = get_normal_texture()
signal switchScreen

func _ready():
	connect("pressed", self, "change_screen")

func resetTexture():
	if not starterTexture == null:
		self.set_normal_texture(starterTexture)

func change_screen():
	emit_signal("switchScreen", screenIndexToShow)