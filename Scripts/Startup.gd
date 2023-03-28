extends Node
	
func _ready():
	var screen_size =  DisplayServer.screen_get_size()
	var screen_position = DisplayServer.screen_get_position()
	
	get_window().size = Vector2i(screen_size.x / 2 , screen_size.y / 2)
	DisplayServer.window_set_position(Vector2(screen_position) + screen_size * 0.5 - get_window().size * 0.5)
	
	Game.current_scene = self
	Game.change_scene("res://Scenes/Splash.tscn", false, Globals.TRANSITION_SCENE)
