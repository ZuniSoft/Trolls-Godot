extends "res://Scripts/KinematicEnemy.gd"

func _ready():
	WALK_SPEED = 65
	RUN_SPEED = 200
	HIT_POINTS = 5
	LIFE = 15
	
	var _retval = get_node("TopChecker").connect("body_entered", self, "_on_TopChecker_body_entered")
	_retval = get_node("SideChecker").connect("body_entered", self, "_on_SideChecker_body_entered")
	_retval = get_node("DetectArea").connect("body_entered", self, "_on_DetectArea_body_entered")
	_retval = get_node("DetectArea").connect("body_exited", self, "_on_DetectArea_body_exited")
	_retval = get_node("HitTimer").connect("timeout", self, "_on_HitTimer_timeout")
	_retval = get_node("DieTimer").connect("timeout", self, "_on_DieTimer_timeout")
	
func _on_DieTimer_timeout():
	._on_DieTimer_timeout()
	
	var room = self.get_node("../../")
	if "Room" in room.name:
		RoomState.enemies_killed[name] = true
	else:
		GameState.enemies_killed[name] = true
