extends Node

var enemies_killed = {}

var coins_collected = {}

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

func load_config(room_name):
	var config = ConfigFile.new()
	
	var node_idx = room_name.lstrip(Globals.NODE_ROOM_NAME)
	var err = config.load("user://room_" + str(node_idx) + "_state.cfg")
	
	if err != OK:
		return
		
	for section in config.get_sections():
		if section == "enemies":
			enemies_killed = config.get_value(section, "killed")
		if section == "coins":
			coins_collected = config.get_value(section, "collected")
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
		
func save_config(room_name):
	var config = ConfigFile.new()
	
	config.set_value("enemies", "killed", enemies_killed)
	
	config.set_value("coins", "collected", coins_collected)
	
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
	
	var node_idx = room_name.lstrip(Globals.NODE_ROOM_NAME)
	config.save("user://room_" + str(node_idx) + "_state.cfg")
	
func clear():
	enemies_killed = {}
	coins_collected = {}

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
	
func reset_rooms():
	clear()
	save_config("Room1")
	save_config("Room2")
