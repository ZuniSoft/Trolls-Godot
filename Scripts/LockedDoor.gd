extends Area2D

signal key_used

@export var door_scene = "res://Levels/Level1/Room1.tscn"
@export var door_type = "Wood"

func _ready():
	var path_items = door_scene.split("/", true)
	var door = path_items[Globals.SCENE_FILE_NAME_IDX].rstrip(Globals.SCENE_FILE_NAME_EXT)
	var node_idx = door.lstrip(Globals.NODE_ROOM_NAME)
	var locked = GameState.get("door_" + str(node_idx) + "_locked")
	
	var _retval = get_node("../../Hero").connect("activate_door", Callable(self, "_on_activate_door"))
	
	if locked:
		show_closed_door()
	else	:
		show_open_door()

func _on_activate_door(hero, door_name):
	if name == door_name:
		var path_items = door_scene.split("/", true)
		var door = path_items[Globals.SCENE_FILE_NAME_IDX].rstrip(Globals.SCENE_FILE_NAME_EXT)
		var node_idx = door.lstrip(Globals.NODE_ROOM_NAME)
		var locked = GameState.get("door_" + str(node_idx) + "_locked")
		
		if not locked:
			open_door_scene()
		else:
			if hero.has_keys:
				unlock_door()
				GameState.set("door_" + str(node_idx) + "_locked", false)

func show_open_door():
	var sprite_texture
	
	if door_type == "Wood":
		sprite_texture = load("res://Assets/CommonObjects/wood-door.png")
	elif door_type == "Metal":
		sprite_texture = load("res://Assets/CommonObjects/metal-door.png")
	
	var sprite = get_node("CollisionShape2D/Sprite2D")
	sprite.set_texture(sprite_texture)

func show_closed_door():
	var sprite_texture
	
	if door_type == "Wood":
		sprite_texture = load("res://Assets/CommonObjects/locked-wood-door.png")
	elif door_type == "Metal":
		sprite_texture = load("res://Assets/CommonObjects/locked-metal-door.png")
	
	var sprite = get_node("CollisionShape2D/Sprite2D")
	sprite.set_texture(sprite_texture)
		
func unlock_door():
	$SoundPlayTimer.start()
	$SoundUnlockDoor.play()
			
func open_door_scene():
	var hero = get_node("../../Hero")
	var hud = get_node("../../HUD")
	
	hero.process_mode = Node.PROCESS_MODE_DISABLED
	hud.visible = false
	
	GameState.last_position_x = hero.position.x
	GameState.last_position_y = hero.position.y
	
	Game.change_scene(door_scene, true, Globals.TRANSITION_SCENE)

func _on_SoundPlayTimer_timeout():
	emit_signal("key_used")
	open_door_scene()

func _on_LockedDoor_body_entered(body):
	body.door_area_entered(name)

func _on_LockedDoor_body_exited(body):
	body.door_area_exited()
