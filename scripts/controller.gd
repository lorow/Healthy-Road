extends Control

onready var screens = get_node("Screens").get_children()
onready var actualScreen = screens[0] # it's always the first visible screen - main
onready var nextScreen = -1
onready var tween = get_node("tween")
onready var screenSize = actualScreen.get_size().x # size of the whole device screen as the screens tend to take up to whole screen 

signal canMoveMenu

func _ready(): handle_signals()
func _on_moveScreen(actPosX): actualScreen.set_pos(Vector2(actPosX, actualScreen.get_pos().y))
func _on_change_actual_screen(index): 
	nextScreen = screens[index]
	moveScreens()
	
func moveScreens():
	tween.interpolate_property(actualScreen, "rect/pos", actualScreen.get_pos(), Vector2(1080,0),0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(nextScreen, "rect/pos", nextScreen.get_pos(), Vector2(0,0),0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)	
	tween.start()
	
func resetPreviousMainScreen(x,y):
	#first, check if actual screen is realy outside of the screen
	if (actualScreen.get_pos().x >= 1080):
		actualScreen.set_pos(Vector2(-1080, 0))
		actualScreen = nextScreen
		nextScreen = -1
	
func handle_signals():
	tween.connect("tween_complete", self, "resetPreviousMainScreen") # when the tween has finished it's job, we will reset the screens
	get_node("HamburgerMenu").connect("moveScreen", self, "_on_moveScreen")
	get_node("HamburgerMenu/menu").connect("changeScreenTo", self, "_on_change_actual_screen")