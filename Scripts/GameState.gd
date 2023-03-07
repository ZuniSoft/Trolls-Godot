extends Node

var current_level = 1

var coins = 0
var keys = 0
var fireballs = Globals.MAX_FIREBALLS
var life = Globals.MAX_LIFE

var enemies_killed = {}

var coins_collected = {}

var door_1_locked = true
var door_2_locked = true
var door_3_locked = true

var fireball_1_collected = false

var heart_1_collected = false

var key_1_collected = false
var key_2_collected = false
var key_3_collected = false

var mystery_1_collected = false
var mystery_2_collected = false
var mystery_3_collected = false
var mystery_4_collected = false
var mystery_5_collected = false

var last_position_x = Globals.DROP_POS_X
var last_position_y = Globals.DROP_POS_Y

var exit_from_door = false

var has_fireballs = true
var has_keys = false

func load_config():
	var config = ConfigFile.new()
	
	var err = config.load("user://game_state.cfg")
	
	if err != OK:
		return
		
	for section in config.get_sections():
		if section == "state":
			current_level = config.get_value(section, "current_level")
		if section == "hud":
			coins = config.get_value(section, "coins")
			keys = config.get_value(section, "keys")
			fireballs = config.get_value(section, "fireballs")
			life = config.get_value(section, "life")
		if section == "enemies":
			enemies_killed = config.get_value(section, "killed")
		if section == "coins":
			coins_collected = config.get_value(section, "collected")
		if section == "doors":
			door_1_locked = config.get_value(section, "door_1_locked")
			door_2_locked = config.get_value(section, "door_2_locked")
			door_3_locked = config.get_value(section, "door_3_locked")
		if section == "fireballs":
			fireball_1_collected = config.get_value(section, "fireball_1_collected")
		if section == "hearts":
			heart_1_collected = config.get_value(section, "heart_1_collected")
		if section == "keys":
			key_1_collected = config.get_value(section, "key_1_collected")
			key_2_collected = config.get_value(section, "key_2_collected")
			key_3_collected = config.get_value(section, "key_3_collected")
		if section == "mystery":
			mystery_1_collected = config.get_value(section, "mystery_1_collected")
			mystery_2_collected = config.get_value(section, "mystery_2_collected")
			mystery_3_collected = config.get_value(section, "mystery_3_collected")
			mystery_4_collected = config.get_value(section, "mystery_4_collected")
			mystery_5_collected = config.get_value(section, "mystery_5_collected")
		if section == "hero":
			last_position_x = config.get_value(section, "last_position_x")
			last_position_y = config.get_value(section, "last_position_y")
			
	if keys > 0:
		has_keys = true
	
	if fireballs > 0:
		has_fireballs = true
		
func save_config():
	var config = ConfigFile.new()
	
	config.set_value("state", "current_level", current_level)
	
	config.set_value("hud", "coins", coins)
	config.set_value("hud", "keys", keys)
	config.set_value("hud", "fireballs", fireballs)
	config.set_value("hud", "life", life)
	
	config.set_value("enemies", "killed", enemies_killed)
	
	config.set_value("coins", "collected", coins_collected)
	
	config.set_value("doors", "door_1_locked", door_1_locked)
	config.set_value("doors", "door_2_locked", door_2_locked)
	config.set_value("doors", "door_3_locked", door_3_locked)
	
	config.set_value("fireballs", "fireball_1_collected", fireball_1_collected)
	
	config.set_value("hearts", "heart_1_collected", heart_1_collected)
	
	config.set_value("keys", "key_1_collected", key_1_collected)
	config.set_value("keys", "key_2_collected", key_2_collected)
	config.set_value("keys", "key_3_collected", key_3_collected)
	
	config.set_value("mystery", "mystery_1_collected", mystery_1_collected)
	config.set_value("mystery", "mystery_2_collected", mystery_2_collected)
	config.set_value("mystery", "mystery_3_collected", mystery_3_collected)
	config.set_value("mystery", "mystery_4_collected", mystery_4_collected)
	config.set_value("mystery", "mystery_5_collected", mystery_5_collected)
	
	config.set_value("hero", "last_position_x", last_position_x)
	config.set_value("hero", "last_position_y", last_position_y)
	
	config.save("user://game_state.cfg")

func reset_hud():
	coins = 0
	keys = 0
	fireballs = Globals.MAX_FIREBALLS
	life = Globals.MAX_LIFE	
	
func clear():
	current_level = 0
	
	has_fireballs = false
	has_keys = false

	coins = 0
	keys = 0
	fireballs = 0
	life = 0

	enemies_killed = {}

	coins_collected = {}

	door_1_locked = true
	door_2_locked = true
	door_3_locked = true
	
	fireball_1_collected = false
	
	heart_1_collected = false
	
	key_1_collected = false
	key_2_collected = false
	key_3_collected = false
	
	mystery_1_collected = false
	mystery_2_collected = false
	mystery_3_collected = false
	mystery_4_collected = false
	mystery_5_collected = false
	
	last_position_x = Globals.DROP_POS_X
	last_position_y = Globals.DROP_POS_Y
	
func set_next_level(level):
	clear()
	reset_hud()
	current_level = level
