extends Node

var enemies_killed = {}
var coins_collected = {}
var fireballs_collected = {}
var hearts_collected = {}
var mystery_boxes_collected = {}
var blocks_broken = {}
var key_1_collected = false

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
			fireballs_collected = config.get_value(section, "collected")
		if section == "hearts":
			hearts_collected = config.get_value(section, "collected")
		if section == "mystery_boxes":
			mystery_boxes_collected = config.get_value(section, "collected")
		if section == "blocks":
			blocks_broken = config.get_value(section, "broken")
		if section == "keys":
			key_1_collected = config.get_value(section, "key_1_collected")
		
func save_config(room_name):
	var config = ConfigFile.new()
	
	config.set_value("enemies", "killed", enemies_killed)
	config.set_value("coins", "collected", coins_collected)
	config.set_value("fireballs", "collected", fireballs_collected)
	config.set_value("hearts", "collected", hearts_collected)
	config.set_value("mystery_boxes", "collected", mystery_boxes_collected)
	config.set_value("blocks", "broken", blocks_broken)
	config.set_value("keys", "key_1_collected", key_1_collected)
	
	var node_idx = room_name.lstrip(Globals.NODE_ROOM_NAME)
	config.save("user://room_" + str(node_idx) + "_state.cfg")
	
func clear():
	enemies_killed = {}
	coins_collected = {}
	fireballs_collected = {}
	hearts_collected = {}
	mystery_boxes_collected = {}
	blocks_broken = {}
	key_1_collected = false
	
func reset_rooms():
	clear()
	save_config("Room1")
	save_config("Room2")
	save_config("Room3")
