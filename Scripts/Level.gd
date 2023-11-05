extends Node2D

@export var design_mode = false

@onready var timer = Timer.new()
@onready var hud = get_node("HUD")
@onready var ui = get_node("UI")
	
func _ready():	
	GameState.load_config()
	
	if design_mode:
		GameState.set_hud_to_gs_values(hud)
	
	timer.name = "CanvasLayerTimer"
	timer.wait_time = 1
	
	add_child(timer)
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

	if GameState.total_coins >= GameState.coins:
		GameState.coins = GameState.total_coins
	else:
		GameState.total_coins = GameState.coins
	
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
	var broken = null
	
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
		
	for fireball in GameState.fireballs_collected:
		collected = GameState.fireballs_collected[fireball]
		if collected:
			var fireball_node = get_node("Fireballs/" + fireball)
			fireball_node.queue_free()
			
	for heart in GameState.hearts_collected:
		collected = GameState.hearts_collected[heart]
		if collected:
			var heart_node = get_node("Life/" + heart)
			heart_node.queue_free()
			
	for mystery_box in GameState.mystery_boxes_collected:
		collected = GameState.mystery_boxes_collected[mystery_box]
		if collected:
			var mystery_box_node = get_node("MysteryBoxes/" + mystery_box)
			mystery_box_node.queue_free()
	
	for coin in GameState.coins_collected:
		collected = GameState.coins_collected[coin]
		if collected:
			var coin_node = get_node("Coins/" + coin)
			coin_node.queue_free()
	
	for block in GameState.blocks_broken:
		broken = GameState.blocks_broken[block]
		if broken:
			var block_node = get_node("Breakables/" + block)
			block_node.queue_free()
			
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
	
	if Globals.is_touch_platform:
		ui.visible = true
	else:
		ui.free()
