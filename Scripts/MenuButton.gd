extends Button

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_MenuButton_pressed():
	if get_tree().paused:
		get_tree().paused = false	
	
	Game.change_scene("res://Scenes/Menu.tscn", false, Globals.TRANSITION_SCENE)
