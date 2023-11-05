extends Node2D

@export var design_mode = false

@onready var timer = Timer.new()
@onready var hud = get_node("HUD")
@onready var ui = get_node("UI")

func _ready():
	if design_mode:
		GameState.load_config()
		GameState.set_hud_to_gs_values(hud)
	
	RoomState.load_config(name)
	
	timer.name = "CanvasLayerTimer"
	timer.wait_time = 1
	
	add_child(timer)
	
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	
	var key = null
	var collected = null
	var killed = null
	var broken = null
	
	var hero = get_node("Hero")
	
	hero.process_mode = Node.PROCESS_MODE_INHERIT
	
	if GameState.life <= 0:
		hero.hero_died_cleanup()
	
	for idx in range(1, Globals.MAX_KEYS):
		collected = RoomState.get("key_" + str(idx) + "_collected")
		if collected:
			key = get_node("Keys/Key" + str(idx))
			key.queue_free()
	
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
	
	for coin in RoomState.coins_collected:
		collected = RoomState.coins_collected[coin]
		if collected:
			var coin_node = get_node("Coins/" + coin)
			coin_node.queue_free()
			
	for block in RoomState.blocks_broken:
		broken = RoomState.blocks_broken[block]
		if broken:
			var block_node = get_node("Breakables/" + block)
			block_node.queue_free()
			
	for enemy in RoomState.enemies_killed:
		killed = RoomState.enemies_killed[enemy]
		if killed:
			var enemy_node = get_node("Enemies/" + enemy)
			enemy_node.queue_free()

func _exit_tree():
	RoomState.save_config(name)
	RoomState.clear()
	
	GameState.exit_from_door = true
	GameState.save_config()
	
func _on_timer_timeout():
	timer.stop()
	hud.visible = true
	
	if Globals.is_touch_platform:
		ui.visible = true
	else:
		ui.free()
