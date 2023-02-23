extends Button

func _on_RetryButton_pressed():
	var level = "res://Levels/Level" + str(GameState.current_level) + "/Scene.tscn"
	var _retval = get_tree().change_scene(level)
