extends Control

func _ready():
	if Globals.is_touch_platform:
		get_node("Controls/MenuButton").focus_mode = FOCUS_NONE
		get_node("Controls/RetryButton").focus_mode = FOCUS_NONE
	else:
		get_node("Controls/MenuButton").grab_focus()
