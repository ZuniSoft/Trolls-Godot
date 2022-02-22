extends KinematicBody2D

var velocity = Vector2(0, 0)

const SPEED = 120
const GRAVITY = 35
const JUMPFORCE = -1100

func _physics_process(_delta):
	if not is_on_floor() and velocity.y > 0:
		$AnimatedSprite.play("falling")
	elif not is_on_floor() and velocity.y < 0:
		$AnimatedSprite.play("jumping")
		
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.flip_h = false
		velocity.x = SPEED
		$AnimatedSprite.play("walking")
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.flip_h = true
		velocity.x = -SPEED
		$AnimatedSprite.play("walking")
	else:
		velocity.x = 0
		$AnimatedSprite.play("idle")
	
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMPFORCE
		
	velocity = move_and_slide(velocity, Vector2.UP)
