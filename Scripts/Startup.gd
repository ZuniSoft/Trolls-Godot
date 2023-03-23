extends Node
	
func _ready():
	Game.current_scene = self
	Game.change_scene("res://Scenes/Splash.tscn", false, Globals.TRANSITION_SCENE)
