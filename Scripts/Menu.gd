extends Control

func _ready():
	if Globals.is_touch_platform:
		get_node("Menu/Keys").free()
		get_node("Menu/Legend").free()
		get_node("Menu/PlayButton").focus_mode = FOCUS_NONE
		get_node("Menu/ResetButton").focus_mode = FOCUS_NONE
	else:
		get_node("Menu/PlayButton").grab_focus()

func _on_PlayButton_pressed():
	GameState.load_config()
	var level = "res://Levels/Level" + str(GameState.current_level) + "/Scene.tscn"
	
	Game.change_scene(level, Globals.TRANSITION_USE_SUB_THREADS, Globals.TRANSITION_SCENE)
	
func _on_ResetButton_pressed():
	var reset_dialog = load("res://Scenes/ResetDialog.tscn")
	var reset_dialog_instance = reset_dialog.instantiate()
	
	add_child(reset_dialog_instance)
	reset_dialog_instance.show()
	get_tree().paused = true
