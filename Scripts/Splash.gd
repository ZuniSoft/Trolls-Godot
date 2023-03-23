extends Node2D

func _ready():
	$Control/Timer.start()

func _on_Timer_timeout():
	Game.change_scene("res://Scenes/Menu.tscn", false, Globals.TRANSITION_SCENE)
