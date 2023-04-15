extends Area2D

@export var spring_velocity = -1600

func _ready():
	$AnimatedSprite2D.play("idle")
	
func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite2D.play("idle")

func _on_TopChecker_body_entered(body):
	$SoundSpring.play()
	$AnimatedSprite2D.play("active")
	body.calc_velocity.y = spring_velocity
	
