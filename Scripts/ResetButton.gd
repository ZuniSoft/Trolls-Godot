extends Button

func _on_ResetButton_pressed():
	var reset_dialog = load("res://Scenes/ResetDialog.tscn")
	var reset_dialog_instance = reset_dialog.instance()
	
	add_child(reset_dialog_instance)
	reset_dialog_instance.show()
	get_tree().paused = true
