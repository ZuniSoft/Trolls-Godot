extends Button

func _on_RetryButton_pressed():
	RoomState.reset_rooms()
	
	GameState.set_next_level(GameState.current_level)
	GameState.exit_from_door = false
	GameState.save_config()
	
	var level = "res://Levels/Level" + str(GameState.current_level) + "/Scene.tscn"
	Game.change_scene(level, true, Globals.TRANSITION_IMAGE_SCENE)
