extends Node2D

func _on_PlayButton_pressed():
	GameState.load_config()
	var level = "res://Levels/Level" + str(GameState.current_level) + "/Scene.tscn"
	Game.change_scene(level, true, Globals.TRANSITION_IMAGE_SCENE)
	
func _on_ResetButton_pressed():
	var reset_dialog = load("res://Scenes/ResetDialog.tscn")
	var reset_dialog_instance = reset_dialog.instantiate()
	
	add_child(reset_dialog_instance)
	reset_dialog_instance.show()
	get_tree().paused = true