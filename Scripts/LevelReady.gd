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
	
	for idx in range(1, Globals.MAX_KEYS):
		var collected = GameState.get("key_" + str(idx) + "_collected")
		if collected:
			key = get_node("Keys/Key" + str(idx))
			key.queue_free()
	
	var door = null
	
	for idx in range(1, Globals.MAX_DOORS):
		door = get_node_or_null("Doors/LockedDoor" + str(idx))
		if door:
			if  GameState.get("door_" + str(idx) + "_locked"):
				door.show_closed_door()
			else:
				door.show_open_door()
				
	for idx in range(1, Globals.MAX_FIREBALLS):
		var collected = GameState.get("fireball_" + str(idx) + "_collected")
		if collected:
			key = get_node("Fireballs/Fireballs" + str(idx))
			key.queue_free()
			
	for idx in range(1, Globals.MAX_LIFE):
		var collected = GameState.get("heart_" + str(idx) + "_collected")
		if collected:
			key = get_node("Life/Heart" + str(idx))
			key.queue_free()
			
	for idx in range(1, Globals.MAX_MYSTERY_BOXES):
		var collected = GameState.get("mystery_" + str(idx) + "_collected")
		if collected:
			key = get_node("MysteryBoxes/MysteryBox" + str(idx))
			key.queue_free()
			
	for coin in GameState.coins_collected:
		var collected = GameState.coins_collected[coin]
		if collected:
			var coin_node = get_node("Coins/" + coin)
			coin_node.queue_free()