extends Area2D

export var door_exit_scene = "res://Levels/Level1/Scene.tscn"
export var door_type = "Wood"

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

func _on_LockedDoorExit_body_entered(_body):
	GameState.save_config()
	
	var room = get_tree().get_root().get_node("Room1")
	room.queue_free()
	var _retval = get_tree().change_scene(door_exit_scene)
