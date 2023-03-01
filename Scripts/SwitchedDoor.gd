extends Area2D

var door_state = false

func _ready():
	$AnimatedSprite.play("closed")

func open_door():
	door_state = true
	$AnimatedSprite.play("opening")
	
func close_door():
	door_state = false
	$AnimatedSprite.play("closing")
	
func _on_AnimatedSprite_animation_finished():
	if door_state:
		$AnimatedSprite.play("open")
		$DoorBlock/CollisionShape2D.disabled = true
	else:
		$AnimatedSprite.play("closed")
		$DoorBlock/CollisionShape2D.disabled = false
