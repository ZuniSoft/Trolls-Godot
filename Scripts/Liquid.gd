extends StaticBody2D

@export var liquid_type = "Swamp"

func _ready():
	var sprite_texture
	
	if liquid_type == "Swamp":
		sprite_texture = load("res://Assets/CommonObjects/swamp-water-surface.png")
	elif liquid_type == "Toxic":
		sprite_texture = load("res://Assets/CommonObjects/toxic-water-surface.png")
	elif liquid_type == "Dungeon":
		sprite_texture = load("res://Assets/CommonObjects/dungeon-water-surface.png")
	else:
		pass
	
	var sprite = get_node("Sprite2D")
	sprite.set_texture(sprite_texture)
	
func _on_TopChecker_body_entered(body):
	body.dying()
