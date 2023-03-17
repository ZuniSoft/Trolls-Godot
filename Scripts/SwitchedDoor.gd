extends Area2D

var door_state = false

func _ready():
	$AnimatedSprite2D.play("closed")

func open_door():
	door_state = true
	$AnimatedSprite2D.play("opening")
	
func close_door():
	door_state = false
	$AnimatedSprite2D.play("closing")
	
func _on_AnimatedSprite_animation_finished():
	if door_state:
		$AnimatedSprite2D.play("open")
		$DoorBlock/CollisionShape2D.disabled = true
	else:
		$AnimatedSprite2D.play("closed")
		$DoorBlock/CollisionShape2D.disabled = false
