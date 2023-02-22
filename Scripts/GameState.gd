extends Node

var current_level = 1

func load_config():
	var config = ConfigFile.new()
	
	var err = config.load("user://game_state.cfg")
	
	if err != OK:
		return
		
	for section in config.get_sections():
		current_level = config.get_value(section, "current_level")
		
func save_config():
	var config = ConfigFile.new()
	
	config.set_value("state", "current_level", current_level)
	
	config.save("user://game_state.cfg")
