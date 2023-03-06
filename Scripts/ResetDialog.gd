extends ConfirmationDialog

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
func _on_Control_confirmed():
	RoomState.reset_rooms()
	GameState.set_next_level(1)
	GameState.save_config()
	
	hide()

func _on_Control_hide():
	get_tree().paused = false
	queue_free()
