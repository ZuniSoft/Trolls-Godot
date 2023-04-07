extends Node2D

func _ready():
	$Control/Timer.start()

func _on_Timer_timeout():
	Game.change_scene("res://Scenes/Menu.tscn", Globals.TRANSITION_LIGHT_WEIGHT_USE_SUB_THREADS, Globals.TRANSITION_SCENE)
