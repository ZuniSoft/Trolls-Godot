extends Node

func _ready():
	$Timer.start()
	
func _on_Timer_timeout():
	var _retval = get_tree().change_scene("res://Scenes/Menu.tscn")
