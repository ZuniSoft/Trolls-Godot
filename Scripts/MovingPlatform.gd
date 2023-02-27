extends Node2D

const IDLE_DURATION = 1.0

export var move_direction = "Horizontal"
export var move_distance = 192
export var speed = 3.0

var move_to = null
var follow = Vector2.ZERO

onready var platform = $Platform
onready var tween = $MoveTween

func _ready():
	if "Horizontal" in move_direction:
		move_to = Vector2.RIGHT
	elif "Vertical" in move_direction:
		move_to = Vector2.UP
			
	move_to *= move_distance
	_init_tween()

func _init_tween():
	var duration = move_to.length() / float(speed * 128)
	
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION * 2)
	tween.start()
	
func _process(_delta):
	platform.position = platform.position.linear_interpolate(follow, 0.075)
