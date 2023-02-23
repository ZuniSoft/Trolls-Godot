extends Button

func _ready():
	pass # Replace with function body.

func _on_ResetButton_pressed():
	#var reset_dialog_instance = get_tree().get_root().find_node("ResetDialog", true, false)
	var reset_dialog = load("res://Scenes/ResetDialog.tscn")
	var reset_dialog_instance = reset_dialog.instance()
	
	add_child(reset_dialog_instance)
	reset_dialog_instance.show()
	get_tree().paused = true
