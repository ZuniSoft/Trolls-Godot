extends Area2D

signal key_used

export var door_scene = "res://Levels/Level1/Room1.tscn"
export var door_type = "Wood"

func _ready():
	if "Room1" in door_scene:
		if GameState.door_1_locked:
			show_closed_door()
		else	:
			show_open_door()
		return
	elif "Room2" in door_scene:
		if GameState.door_2_locked:
			show_closed_door()
		else	:
			show_open_door()
		return
	elif "Room3" in door_scene:
		if GameState.door_3_locked:
			show_closed_door()
		else	:
			show_open_door()

func _on_LockedDoor_body_entered(body):
	if body.name == "Hero":
		if "Room1" in door_scene:
			if not GameState.door_1_locked:
					open_door_scene()
			else	:
				if body.has_keys:
					unlock_door()
					GameState.door_1_locked = false
			return
		if "Room2" in door_scene:
			if not GameState.door_2_locked:
				open_door_scene()
			else	:
				if body.has_keys:
					unlock_door()
					GameState.door_2_locked = false
			return
		if "Room3" in door_scene:
			if not GameState.door_3_locked:
				open_door_scene()
			else	:
				if body.has_keys:
					unlock_door()
					GameState.door_3_locked = false

func show_open_door():
	var sprite_texture
	
	if door_type == "Wood":
		sprite_texture = load("res://Assets/CommonObjects/wood-door.png")
	elif door_type == "Metal":
		sprite_texture = load("res://Assets/CommonObjects/metal-door.png")
	
	var sprite = get_node("CollisionShape2D/Sprite")
	sprite.set_texture(sprite_texture)

func show_closed_door():
	var sprite_texture
	
	if door_type == "Wood":
		sprite_texture = load("res://Assets/CommonObjects/locked-wood-door.png")
	elif door_type == "Metal":
		sprite_texture = load("res://Assets/CommonObjects/locked-metal-door.png")
	
	var sprite = get_node("CollisionShape2D/Sprite")
	sprite.set_texture(sprite_texture)
		
func unlock_door():
	$SoundPlayTimer.start()
	$SoundUnlockDoor.play()
			
func open_door_scene():
	var hero = get_node("../../Hero")
	
	GameState.last_position_x = hero.position.x
	GameState.last_position_y = hero.position.y
	GameState.save_config()
	
	var _retval = get_tree().change_scene(door_scene)

func _on_SoundPlayTimer_timeout():
	emit_signal("key_used")
	open_door_scene()
