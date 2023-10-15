extends Node
	
func _ready():	
	match OS.get_name():
		"Windows", "UWP", "macOS", "Linux":
			var screen_size =  DisplayServer.screen_get_size()
			var screen_position = DisplayServer.screen_get_position()
		
			DisplayServer.window_set_position(Vector2(screen_position) + screen_size * 0.5 - get_window().size * 0.5)
		"iOS":
			Globals.is_touch_platform = true
			
	Game.current_scene = self
	Game.change_scene("res://Scenes/Splash.tscn", Globals.TRANSITION_LIGHT_WEIGHT_USE_SUB_THREADS, Globals.TRANSITION_SCENE)
