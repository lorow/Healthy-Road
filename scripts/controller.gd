extends Control

var tween
var actualScreen # this will be set by system controlling buttons and main screens

var buttonGroup

func _ready():
	tween = get_node("tween")
	actualScreen = get_node("TextureFrame")
	get_node("HamburgerMenu").connect("moveScreen", self, "_on_moveScreen")

func _on_moveScreen(actPosX, time):
	actualScreen.set_pos(Vector2(actPosX, actualScreen.get_pos().y))