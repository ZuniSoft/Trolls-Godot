extends Button

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_MenuButton_pressed():
	var hud = get_tree().get_root().find_child("HUD", true, false)
	var pause = get_tree().get_root().find_child("PauseMenu", true, false)
	
	if pause and hud:
		hud.visible = false
		pause.visible = false
	
	if get_tree().paused:
		get_tree().paused = false	
	
	Game.change_scene("res://Scenes/Menu.tscn", Globals.TRANSITION_LIGHT_WEIGHT_USE_SUB_THREADS, Globals.TRANSITION_SCENE)
