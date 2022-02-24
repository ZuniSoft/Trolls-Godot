extends KinematicBody2D

var velocity = Vector2(0, 0)
var coins = 0
var is_hit = false
var is_dying = false

const WALK_SPEED = 120
const RUN_SPEED = 500
const GRAVITY = 35
const JUMPFORCE = -1100
const HIT_JUMP_VEL = 200 

func _physics_process(_delta):
	if not is_hit and not is_dying:
		if not is_on_floor() and velocity.y > 0:
			$AnimatedSprite.play("falling")
		elif not is_on_floor() and velocity.y < 0:
			if Input.is_action_pressed("ui_right"):
				velocity.x = WALK_SPEED
			elif Input.is_action_pressed("ui_left"):
				velocity.x = -WALK_SPEED
			else:
				velocity.x = 0
			$AnimatedSprite.play("jumping") 
		elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_run"):
			$AnimatedSprite.flip_h = false
			velocity.x = RUN_SPEED
			$AnimatedSprite.play("running")
		elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_run"):
			$AnimatedSprite.flip_h = true
			velocity.x = -RUN_SPEED	
			$AnimatedSprite.play("running")
		elif Input.is_action_pressed("ui_right"):
			$AnimatedSprite.flip_h = false
			velocity.x = WALK_SPEED
			$AnimatedSprite.play("walking")
		elif Input.is_action_pressed("ui_left"):
			$AnimatedSprite.flip_h = true
			velocity.x = -WALK_SPEED
			$AnimatedSprite.play("walking")
		else:
			velocity.x = 0
			$AnimatedSprite.play("idle")
	
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMPFORCE
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
func _on_FallZone_body_entered(_body):
	get_tree().change_scene("res://Levels/Level1/Level1.tscn")
	
func bounce():
	velocity.y = JUMPFORCE * 0.7
	
func hit(var enemy_pos_x):
	is_hit = true
	set_modulate(Color(1.0, 0.3, 0.3, 0.3))
	velocity.y = JUMPFORCE * 0.5

	if position.x < enemy_pos_x:
		velocity.x = -HIT_JUMP_VEL
	elif position.x > enemy_pos_x:
		velocity.x = HIT_JUMP_VEL

	Input.action_release("ui_left")
	Input.action_release("ui_right")
	
	$HitTimer.start()

func _on_HitTimer_timeout():
	set_modulate(Color(1, 1, 1, 1))
	is_hit = false

func dying():
	is_dying = true
	$AnimatedSprite.play("dying")
	$DieTimer.start()

func _on_DieTimer_timeout():
	queue_free()
	get_tree().change_scene("res://Levels/Level1/Level1.tscn")
