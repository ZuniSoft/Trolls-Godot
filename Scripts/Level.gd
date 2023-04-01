extends Node2D

@onready var timer = Timer.new()
@onready var hud = get_node("HUD")
	
func _ready():
	GameState.load_config()
	
	timer.name = "CanvasLayerTimer"
	timer.wait_time = 1
	
	add_child(timer)
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	GameState.set_hud_to_gs_values(hud)
		
	var hero = get_node("Hero")
	
	hero.process_mode = Node.PROCESS_MODE_INHERIT
	
	if GameState.life <= 0:
		hero.hero_died_cleanup()
	
	if not GameState.exit_from_door:
		GameState.exit_from_door = false
		GameState.last_position_x = Globals.DROP_POS_X
		GameState.last_position_y = Globals.DROP_POS_Y
				
	var location = Vector2(GameState.last_position_x, GameState.last_position_y)
	hero.set_global_position(location)
	
	var key = null
	var collected = null
	var killed = null
	
	for idx in range(1, Globals.MAX_KEYS):
		collected = GameState.get("key_" + str(idx) + "_collected")
		if collected:
			key = get_node("Keys/Key" + str(idx))
			key.queue_free()
	
	for idx in range(1, Globals.MAX_LOCKED_DOORS):
		key = get_node_or_null("Doors/LockedDoor" + str(idx))
		if key:
			if  GameState.get("door_" + str(idx) + "_locked"):
				key.show_closed_door()
			else:
				key.show_open_door()
				
	for idx in range(1, Globals.MAX_FIREBALLS):
		collected = GameState.get("fireball_" + str(idx) + "_collected")
		if collected:
			key = get_node("Fireballs/Fireballs" + str(idx))
			key.queue_free()
			
	for idx in range(1, Globals.MAX_LIFE):
		collected = GameState.get("heart_" + str(idx) + "_collected")
		if collected:
			key = get_node("Life/Heart" + str(idx))
			key.queue_free()
			
	for idx in range(1, Globals.MAX_MYSTERY_BOXES):
		collected = GameState.get("mystery_" + str(idx) + "_collected")
		if collected:
			key = get_node("MysteryBoxes/MysteryBox" + str(idx))
			key.queue_free()
			
	for coin in GameState.coins_collected:
		collected = GameState.coins_collected[coin]
		if collected:
			var coin_node = get_node("Coins/" + coin)
			coin_node.queue_free()
			
	for enemy in GameState.enemies_killed:
		killed = GameState.enemies_killed[enemy]
		if killed:
			var enemy_node = get_node("Enemies/" + enemy)
			enemy_node.queue_free()

func _exit_tree():
	GameState.set_gs_values_from_hud(hud)
	GameState.save_config()
	
func _on_timer_timeout():
	timer.stop()
	hud.visible = true
