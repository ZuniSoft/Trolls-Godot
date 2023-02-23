extends Button

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _on_MenuButton_pressed():
	if get_tree().paused:
		get_tree().paused = false	
		
	var _retval = get_tree().change_scene("res://Scenes/Menu.tscn")
