extends Area2D

@export var exit_door = 1
@export_enum("Metal", "Wood") var door_type: String = "Metal"

@onready var door_exit = get_node("../PortalDoorExit" + str(exit_door))

func _ready():
	var _retval = get_node("../../Hero").connect("activate_door", Callable(self, "_on_activate_door"))
	
	var sprite_texture
	
	if door_type == "Wood":
		sprite_texture = load("res://Assets/CommonObjects/wood-door.png")
	elif door_type == "Metal":
		sprite_texture = load("res://Assets/CommonObjects/metal-door.png")
	else:
		pass
	
	var sprite = get_node("CollisionShape2D/Sprite2D")
	sprite.set_texture(sprite_texture)

func _on_activate_door(hero, door_name):
	if name == door_name:
		door_exit.show_portal()
		hero.global_transform.origin = door_exit.global_transform.origin

func _on_PortalDoor_body_entered(body):
	body.door_area_entered(name)

func _on_PortalDoor_body_exited(body):
	body.door_area_exited()
