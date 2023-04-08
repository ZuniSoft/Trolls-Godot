extends Node

@onready var loader = load("res://Loader/ThreadedLoader.gd").new()

var LOADER_WAIT_TIME : float = 0.25

func _ready():
	var timer = Timer.new()
	timer.name = "ThreadedLoaderUpdateStatusTimer"
	timer.wait_time = LOADER_WAIT_TIME
	add_child(timer)
	loader.set_timer(timer)
