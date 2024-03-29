extends Area2D

@export var door_exit_scene = "res://Levels/Level1/Scene.tscn"
@export_enum("Metal", "Wood") var door_type: String = "Metal"

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
		var hud = get_tree().get_root().find_child("HUD", true, false)
		var ui = get_tree().get_root().find_child("UI", true, false)
		
		GameState.set_hud_to_gs_values(hud)
		
		hero.process_mode = Node.PROCESS_MODE_DISABLED
		hud.visible = false
		
		if Globals.is_touch_platform:
			ui.visible = false
		
		Game.change_scene(door_exit_scene, Globals.TRANSITION_USE_SUB_THREADS, Globals.TRANSITION_SCENE)

func _on_LockedDoorExit_body_entered(body):
	body.door_area_entered(name)

func _on_LockedDoorExit_body_exited(body):
	body.door_area_exited()
