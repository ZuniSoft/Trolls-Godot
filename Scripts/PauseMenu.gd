extends CanvasLayer

func _ready():
	if Globals.is_touch_platform:
		get_node("Controls/MenuButton").focus_mode = Control.FOCUS_NONE
		get_node("Controls/ResumeButton").focus_mode = Control.FOCUS_NONE
	else:
		get_node("Controls/ResumeButton").grab_focus()
	
