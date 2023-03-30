extends Area2D

const SPRING_VELOCITY = -1600

func _ready():
	$AnimatedSprite2D.play("idle")
	
func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite2D.play("idle")

func _on_TopChecker_body_entered(body):
	$AnimatedSprite2D.play("active")
	body.calc_velocity.y = SPRING_VELOCITY
	
