extends KinematicEnemy

func _ready():
	super._ready()
	
	WALK_SPEED = 75
	RUN_SPEED = 275
	HIT_POINTS = 15
	LIFE = 50
	
	var _retval = get_node("TopChecker").connect("body_entered",Callable(self,"_on_TopChecker_body_entered"))
	_retval = get_node("SideChecker").connect("body_entered",Callable(self,"_on_SideChecker_body_entered"))
	_retval = get_node("SideChecker").connect("body_exited",Callable(self,"_on_SideChecker_body_exited"))
	_retval = get_node("DetectArea").connect("body_entered",Callable(self,"_on_DetectArea_body_entered"))
	_retval = get_node("DetectArea").connect("body_exited",Callable(self,"_on_DetectArea_body_exited"))
	_retval = get_node("HitTimer").connect("timeout",Callable(self,"_on_HitTimer_timeout"))
	_retval = get_node("DieTimer").connect("timeout",Callable(self,"_on_DieTimer_timeout"))
	
func _on_DieTimer_timeout():
	super._on_DieTimer_timeout()
	
	var room = self.get_node("../../")
	if "Room" in room.name:
		RoomState.enemies_killed[name] = true
	else:
		GameState.enemies_killed[name] = true
