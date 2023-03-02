extends Node

var current_level = 1

var coins = 0
var keys = 0
var fireballs = Globals.MAX_FIREBALLS
var life = Globals.MAX_LIFE

var door_1_locked = true
var door_2_locked = true
var door_3_locked = true

var key_1_collected = false
var key_2_collected = false
var key_3_collected = false

var last_position_x = Globals.DROP_POS_X
var last_position_y = Globals.DROP_POS_Y

var exit_from_door = false

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
		if section == "doors":
			door_1_locked = config.get_value(section, "door_1_locked")
			door_2_locked = config.get_value(section, "door_2_locked")
			door_3_locked = config.get_value(section, "door_3_locked")
		if section == "keys":
			key_1_collected = config.get_value(section, "key_1_collected")
			key_2_collected = config.get_value(section, "key_2_collected")
			key_3_collected = config.get_value(section, "key_3_collected")
		if section == "hero":
			last_position_x = config.get_value(section, "last_position_x")
			last_position_y = config.get_value(section, "last_position_y")
		
func save_config():
	var config = ConfigFile.new()
	
	config.set_value("state", "current_level", current_level)
	
	config.set_value("hud", "coins", coins)
	config.set_value("hud", "keys", keys)
	config.set_value("hud", "fireballs", fireballs)
	config.set_value("hud", "life", life)
	
	config.set_value("doors", "door_1_locked", door_1_locked)
	config.set_value("doors", "door_2_locked", door_2_locked)
	config.set_value("doors", "door_3_locked", door_3_locked)
	
	config.set_value("keys", "key_1_collected", key_1_collected)
	config.set_value("keys", "key_2_collected", key_2_collected)
	config.set_value("keys", "key_3_collected", key_3_collected)
	
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

	coins = 0
	keys = 0
	fireballs = 0
	life = 0

	door_1_locked = true
	door_2_locked = true
	door_3_locked = true
	
	key_1_collected = false
	key_2_collected = false
	key_3_collected = false
	
	last_position_x = Globals.DROP_POS_X
	last_position_y = Globals.DROP_POS_Y
