extends Node
	
func _ready():
	
	
	match OS.get_name():
		"Windows", "UWP", "macOS", "Linux":
			var screen_size =  DisplayServer.screen_get_size()
			var screen_position = DisplayServer.screen_get_position()
	
			get_window().size = Vector2i(screen_size.x * 0.5 , screen_size.y * 0.5)
			DisplayServer.window_set_position(Vector2(screen_position) + screen_size * 0.5 - get_window().size * 0.5)
		"iOS":
			Globals.is_touch_platform = true
			
			get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
			get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE
	
	Game.current_scene = self
	Game.change_scene("res://Scenes/Splash.tscn", Globals.TRANSITION_LIGHT_WEIGHT_USE_SUB_THREADS, Globals.TRANSITION_SCENE)
