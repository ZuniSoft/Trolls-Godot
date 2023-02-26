extends Area2D

export var exit_door = 1
export var door_type = "Wood"

onready var hero = get_node("../../Hero")
onready var door_exit = get_node("../DoorExit" + str(exit_door))

func _ready():
	var sprite_texture
	
	if door_type == "Wood":
		sprite_texture = load("res://Assets/CommonObjects/wood-door.png")
	elif door_type == "Metal":
		sprite_texture = load("res://Assets/CommonObjects/metal-door.png")
	else:
		pass
	
	var sprite = get_node("CollisionShape2D/Sprite")
	sprite.set_texture(sprite_texture)

func _teleport_to_other_door(body):
	hero.global_transform.origin = door_exit.global_transform.origin
