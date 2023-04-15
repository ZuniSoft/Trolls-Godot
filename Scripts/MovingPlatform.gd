extends Node2D

@export_enum("Horizontal", "Vertical") var move_direction: String = "Horizontal"
@export var move_distance = 192
@export var speed = 3.0

var move_to = null
var follow = Vector2.ZERO

@onready var platform = $Platform
@onready var tween = create_tween()

func _ready():
	if "Horizontal" in move_direction:
		move_to = Vector2.RIGHT
	elif "Vertical" in move_direction:
		move_to = Vector2.UP
			
	move_to *= move_distance
	_init_tween()

func _init_tween():
	var duration = move_to.length() / float(speed * 128)

	tween.bind_node($Platform)
	tween.set_loops()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "follow", move_to, duration).from(Vector2.ZERO)
	tween.tween_property(self, "follow", Vector2.ZERO, duration).from(move_to)
	
func _process(_delta):
	platform.position = platform.position.lerp(follow, 0.075)
