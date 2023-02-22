extends Button

func _on_PlayButton_pressed():
	GameState.load_config()
	var level = "res://Levels/Level" + str(GameState.current_level) + "/Scene.tscn"
	var _retval = get_tree().change_scene(level)
