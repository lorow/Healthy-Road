extends Control

onready var actualScreen = get_node("TextureFrame")

func _ready():
	handle_signals()

func _on_moveScreen(actPosX):
	actualScreen.set_pos(Vector2(actPosX, actualScreen.get_pos().y))

func handle_signals():
	get_node("HamburgerMenu").connect("moveScreen", self, "_on_moveScreen")
