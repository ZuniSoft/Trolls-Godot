extends Button

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_ResumeButton_pressed():
	var pause_menu_instance = get_tree().get_root().find_child("PauseMenu", true, false)
	var pause_button_instance = get_tree().get_root().find_child("PauseButton", true, false)
	
	pause_menu_instance.queue_free()
	pause_button_instance.show()
	get_tree().paused = false
