extends Button

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _on_ResumeButton_pressed():
	var pause_menu_instance = get_tree().get_root().find_node("PauseMenu", true, false)
	var pause_button_instance = get_tree().get_root().find_node("PauseButton", true, false)
	
	pause_menu_instance.queue_free()
	pause_button_instance.show()
	get_tree().paused = false
