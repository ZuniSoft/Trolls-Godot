extends Area2D

var show_portal = false

func _ready():
	hide()

func show_portal():
	show_portal = true
	
func _on_DoorExit_body_entered(body):
	if show_portal:
		show()
		$Timer.start()

func _on_Timer_timeout():
	show_portal = false
	hide()
