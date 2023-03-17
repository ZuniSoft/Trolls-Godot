extends Button

func _on_PauseButton_pressed():
	var pause_menu = load("res://Scenes/PauseMenu.tscn")
	var pause_menu_instance = pause_menu.instantiate()
	
	get_tree().paused = true
	visible = false
	add_child(pause_menu_instance)
