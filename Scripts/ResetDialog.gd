extends ConfirmationDialog

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
func _on_Control_confirmed():
	GameState.clear()
	GameState.current_level = 1
	GameState.reset_hud()
	GameState.save_config()
	
	RoomState.clear()
	RoomState.save_config("Room1")
	RoomState.save_config("Room2")
	hide()

func _on_Control_hide():
	get_tree().paused = false
	queue_free()
