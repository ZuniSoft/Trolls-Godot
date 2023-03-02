extends Button

func _on_RetryButton_pressed():
	var current_level = GameState.current_level
	
	GameState.clear()
	GameState.current_level = current_level
	GameState.exit_from_door = false
	GameState.reset_hud()
	GameState.save_config()
	
	var level = "res://Levels/Level" + str(GameState.current_level) + "/Scene.tscn"
	var _retval = get_tree().change_scene(level)
