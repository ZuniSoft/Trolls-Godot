extends Node2D

func _ready():
	GameState.load_config()
	
	var hero = get_node("/root/Level1/Hero")
	hero.position.x = GameState.last_position_x
	hero.position.y = GameState.last_position_y
