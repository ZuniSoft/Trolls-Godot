extends Node

var current_level = 1
var total_coins = 0

var coins = 0
var keys = 0
var fireballs = Globals.MAX_FIREBALLS
var life = Globals.MAX_LIFE

var enemies_killed = {}
var coins_collected = {}
var fireballs_collected = {}
var hearts_collected = {}
var mystery_boxes_collected = {}
var blocks_broken = {}

var door_1_locked = true
var door_2_locked = true
var door_3_locked = true

var key_1_collected = false
var key_2_collected = false
var key_3_collected = false

var last_position_x = Globals.DROP_POS_X
var last_position_y = Globals.DROP_POS_Y

var exit_from_door = false

var has_fireballs = false
var has_keys = false

var transition_x = 0
var transition_y = 0

func load_config():
	var config = ConfigFile.new()
	
	var err = config.load("user://game_state.cfg")
	
	if err != OK:
		return
		
	for section in config.get_sections():
		if section == "state":
			current_level = config.get_value(section, "current_level")
			total_coins = config.get_value(section, "total_coins")
		if section == "hud":
			coins = config.get_value(section, "coins")
			keys = config.get_value(section, "keys")
			fireballs = config.get_value(section, "fireballs")
			life = config.get_value(section, "life")
		if section == "enemies":
			enemies_killed = config.get_value(section, "killed")
		if section == "coins":
			coins_collected = config.get_value(section, "collected")
		if section == "blocks":
			blocks_broken = config.get_value(section, "broken")
		if section == "doors":
			door_1_locked = config.get_value(section, "door_1_locked")
			door_2_locked = config.get_value(section, "door_2_locked")
			door_3_locked = config.get_value(section, "door_3_locked")
		if section == "fireballs":
			fireballs_collected = config.get_value(section, "collected")
		if section == "hearts":
			hearts_collected = config.get_value(section, "collected")
		if section == "keys":
			key_1_collected = config.get_value(section, "key_1_collected")
			key_2_collected = config.get_value(section, "key_2_collected")
			key_3_collected = config.get_value(section, "key_3_collected")
		if section == "mystery_boxes":
			mystery_boxes_collected = config.get_value(section, "collected")
		if section == "hero":
			last_position_x = config.get_value(section, "last_position_x")
			last_position_y = config.get_value(section, "last_position_y")
			
	if keys > 0:
		has_keys = true
	elif keys == 0:
		has_keys = false
		
	if fireballs > 0:
		has_fireballs = true
	elif fireballs == 0:
		has_fireballs = false
		
func save_config():
	var config = ConfigFile.new()
	
	config.set_value("state", "current_level", current_level)
	config.set_value("state", "total_coins", total_coins)
	
	config.set_value("hud", "coins", coins)
	config.set_value("hud", "keys", keys)
	config.set_value("hud", "fireballs", fireballs)
	config.set_value("hud", "life", life)
	
	config.set_value("enemies", "killed", enemies_killed)
	config.set_value("coins", "collected", coins_collected)
	config.set_value("fireballs", "collected", fireballs_collected)
	config.set_value("hearts", "collected", hearts_collected)
	config.set_value("mystery_boxes", "collected", mystery_boxes_collected)
	config.set_value("blocks", "broken", blocks_broken)
	
	config.set_value("doors", "door_1_locked", door_1_locked)
	config.set_value("doors", "door_2_locked", door_2_locked)
	config.set_value("doors", "door_3_locked", door_3_locked)
	
	config.set_value("keys", "key_1_collected", key_1_collected)
	config.set_value("keys", "key_2_collected", key_2_collected)
	config.set_value("keys", "key_3_collected", key_3_collected)
	
	config.set_value("hero", "last_position_x", last_position_x)
	config.set_value("hero", "last_position_y", last_position_y)
	
	config.save("user://game_state.cfg")

func reset_hud_values():
	keys = 0
	fireballs = Globals.MAX_FIREBALLS
	life = Globals.MAX_LIFE	

func set_hud_to_gs_values(hud):
	hud.set_display_from_game_state()
	save_config()

func set_gs_values_from_hud(hud):
	hud.set_game_state_from_display()
	save_config()

func clear():
	current_level = 0
	total_coins = 0
	
	has_fireballs = false
	has_keys = false

	coins = 0
	keys = 0
	fireballs = 0
	life = 0

	enemies_killed = {}
	coins_collected = {}
	fireballs_collected = {}
	hearts_collected = {}
	mystery_boxes_collected = {}
	blocks_broken = {}

	door_1_locked = true
	door_2_locked = true
	door_3_locked = true
	
	key_1_collected = false
	key_2_collected = false
	key_3_collected = false
	
	last_position_x = Globals.DROP_POS_X
	last_position_y = Globals.DROP_POS_Y

func set_next_level(level, retry):
	var tmp_coins = coins
	var tmp_total_coins = total_coins
	
	if retry:
		clear()
		reset_hud_values()
		tmp_coins = 0
	
	if tmp_coins > tmp_total_coins:
		total_coins = tmp_total_coins + (tmp_coins - tmp_total_coins)
	else:
		coins = tmp_total_coins
	
	current_level = level
		
	save_config()
