extends Node2D

func _ready():
	RoomState.load_config(name)
	
	var key = null
	var collected = null
	var killed = null
	
	var hero = get_node("Hero")
	
	if GameState.life <= 0:
		hero.hero_died_cleanup()
	
	for idx in range(1, Globals.MAX_KEYS):
		collected = RoomState.get("key_" + str(idx) + "_collected")
		if collected:
			key = get_node("Keys/Key" + str(idx))
			key.queue_free()
				
	for idx in range(1, Globals.MAX_FIREBALLS):
		collected = RoomState.get("fireball_" + str(idx) + "_collected")
		if collected:
			key = get_node("Fireballs/Fireballs" + str(idx))
			key.queue_free() 
			
	for idx in range(1, Globals.MAX_LIFE):
		collected = RoomState.get("heart_" + str(idx) + "_collected")
		if collected:
			key = get_node("Life/Heart" + str(idx))
			key.queue_free()
			
	for idx in range(1, Globals.MAX_MYSTERY_BOXES):
		collected = RoomState.get("mystery_" + str(idx) + "_collected")
		if collected:
			key = get_node("MysteryBoxes/MysteryBox" + str(idx))
			key.queue_free()
	
	for coin in RoomState.coins_collected:
		collected = RoomState.coins_collected[coin]
		if collected:
			var coin_node = get_node("Coins/" + coin)
			coin_node.queue_free()
			
	for enemy in RoomState.enemies_killed:
		killed = RoomState.enemies_killed[enemy]
		if killed:
			var enemy_node = get_node("Enemies/" + enemy)
			enemy_node.queue_free()

func _exit_tree():
	RoomState.save_config(name)
	RoomState.clear()
	
	GameState.set_hud_to_gs_values()
	GameState.exit_from_door = true
	GameState.save_config()
