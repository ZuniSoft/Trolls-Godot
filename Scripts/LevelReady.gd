extends Node2D

func _ready():
	GameState.load_config()
	
	var hero = get_node("Hero")
	var offset = Globals.DOOR_EXIT_OFFSET
	
	if not GameState.exit_from_door:
		GameState.exit_from_door = false
		GameState.last_position_x = Globals.DROP_POS_X
		GameState.last_position_y = Globals.DROP_POS_Y
		offset = 0
				
	var location = Vector2(GameState.last_position_x - offset, GameState.last_position_y)
	hero.set_global_position(location)
	
	var key = null 
	
	if GameState.key_1_collected:
		key = get_node("Keys/Key1")
		key.queue_free()
	if GameState.key_2_collected:
		key = get_node("Keys/Key2")
		key.queue_free()
	if GameState.key_3_collected:
		key = get_node("Keys/Key3")
		key.queue_free()
	
	var door = null
	
	door = get_node_or_null("Doors/LockedDoor1")
	if door:
		if GameState.door_1_locked:
			door.show_closed_door()
		else:
			door.show_open_door()
		
	door = get_node_or_null("Doors/LockedDoor2")
	if door:
		if GameState.door_2_locked:
			door.show_closed_door()
		else:
			door.show_open_door()
		
	door = get_node_or_null("Doors/LockedDoor3")
	if door:
		if GameState.door_3_locked:
			door.show_closed_door()
		else:
			door.show_open_door()
	

