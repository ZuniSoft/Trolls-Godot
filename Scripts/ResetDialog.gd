extends ConfirmationDialog

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _on_Control_confirmed():
	RoomState.reset_rooms()
	GameState.set_next_level(1)
	GameState.save_config()
	
	close()
	
func _on_canceled():
	close()
	
func close():
	get_tree().paused = false
	queue_free()
