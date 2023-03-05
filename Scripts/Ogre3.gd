extends "res://Scripts/KinematicEnemy.gd"

func _ready():
	WALK_SPEED = 60
	RUN_SPEED = 300
	HIT_POINTS = 20
	LIFE = 100
	
	var _retval = get_node("TopChecker").connect("body_entered", self, "_on_TopChecker_body_entered")
	_retval = get_node("SideChecker").connect("body_entered", self, "_on_SideChecker_body_entered")
	_retval = get_node("DetectArea").connect("body_entered", self, "_on_DetectArea_body_entered")
	_retval = get_node("DetectArea").connect("body_exited", self, "_on_DetectArea_body_exited")
	_retval = get_node("HitTimer").connect("timeout", self, "_on_HitTimer_timeout")
	_retval = get_node("DieTimer").connect("timeout", self, "_on_DieTimer_timeout")
	
func _on_DieTimer_timeout():
	._on_DieTimer_timeout()
	
	# clear rooms here
	GameState.clear()
	GameState.current_level = 1
	GameState.reset_hud()
	GameState.save_config()
	
	var _retval = get_tree().change_scene("res://Scenes/Win.tscn")
