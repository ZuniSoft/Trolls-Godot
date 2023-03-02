extends Area2D

var show_portal_state = false

func _ready():
	hide()

func show_portal():
	show_portal_state = true
	
func _on_DoorExit_body_entered(_body):
	if show_portal_state:
		show()
		$SoundPortal.play()
		$Timer.start()

func _on_Timer_timeout():
	show_portal_state = false
	hide()
