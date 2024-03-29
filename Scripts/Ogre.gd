extends KinematicEnemy

func _ready():
	super._ready()
	
	WALK_SPEED = 60
	RUN_SPEED = 300
	HIT_POINTS = 10
	LIFE = 100
	
	var _retval = get_node("TopChecker").connect("body_entered",Callable(self,"_on_TopChecker_body_entered"))
	_retval = get_node("SideChecker").connect("body_entered",Callable(self,"_on_SideChecker_body_entered"))
	_retval = get_node("SideChecker").connect("body_exited",Callable(self,"_on_SideChecker_body_exited"))
	_retval = get_node("DetectArea").connect("body_entered",Callable(self,"_on_DetectArea_body_entered"))
	_retval = get_node("DetectArea").connect("body_exited",Callable(self,"_on_DetectArea_body_exited"))
	_retval = get_node("HitTimer").connect("timeout",Callable(self,"_on_HitTimer_timeout"))
	_retval = get_node("DieTimer").connect("timeout",Callable(self,"_on_DieTimer_timeout"))
	
func _on_DieTimer_timeout():
	super._on_DieTimer_timeout()
	
	RoomState.reset_rooms()
	GameState.set_next_level(2, true)
	
	get_node("../../HUD").visible = false
	
	if Globals.is_touch_platform:
		get_node("../../UI").visible = false
	
	Game.change_scene("res://Levels/Level2/Scene.tscn", Globals.TRANSITION_USE_SUB_THREADS, Globals.TRANSITION_SCENE)
