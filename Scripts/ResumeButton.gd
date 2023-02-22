extends Button

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _on_ResumeButton_pressed():
	var pause_menu_instance = get_tree().get_root().find_node("PauseMenu", true, false)
	
	pause_menu_instance.queue_free()
	get_tree().paused = false
