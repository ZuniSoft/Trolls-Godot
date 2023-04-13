class_name KinematicEnemy

extends CharacterBody2D

var WALK_SPEED = 60
var RUN_SPEED = 200
var HIT_JUMP_VELOCITY = 10
var HIT_POINTS = 2
var LIFE = 10

var speed = WALK_SPEED
var calc_velocity = Vector2.ZERO
var life = LIFE
var dying = false
var hero = null

@export var direction = -1
@export var detect_cliffs = true

func _ready():
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	
	$FloorChecker.target_position.x = $CollisionShape2D.shape.get_size().x * direction
	$FloorChecker.enabled = detect_cliffs
	
	safe_margin = 1
	
	$AnimatedSprite2D.play()
	
func _physics_process(_delta):
	calc_velocity = Vector2.ZERO	
		
	if is_on_wall() or not $FloorChecker.is_colliding() and detect_cliffs and is_on_floor():
		direction *= -1
		$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
		$FloorChecker.target_position.x = $CollisionShape2D.shape.get_size().x * direction
		
	if hero:
		calc_velocity.x = self.position.direction_to(hero.position).x * speed
		direction = sign(calc_velocity.x)
		
		if self.global_position > hero.global_position:
			$AnimatedSprite2D.flip_h = self.global_position > hero.global_position
		else:
			$AnimatedSprite2D.flip_h = false
		
		$FloorChecker.target_position.x = $CollisionShape2D.shape.get_size().x * direction
	else:
		calc_velocity.x = direction * speed
	
	calc_velocity.y += 20
	
	set_up_direction(Vector2.UP)
	velocity = calc_velocity
	move_and_slide()
	calc_velocity = velocity

func _on_DetectArea_body_entered(body):
	if body.name == "DoorBlock":
		return
		
	$AnimatedSprite2D.play("attacking")
	hero = body
	speed = RUN_SPEED

func _on_DetectArea_body_exited(_body):
	$AnimatedSprite2D.play("walking")
	hero = null
	speed = WALK_SPEED

func _on_TopChecker_body_entered(body):
	if body.name == "Hero":
		hit(body.JUMP_HIT_POINTS)
		body.bounce()
		$SoundHit.play()

func _on_SideChecker_body_entered(body):
	if body.name == "DoorBlock":
		var heading = (global_transform.origin - body.global_transform.origin).normalized()
		
		if heading.x >= 0:
			hero = null
		else:
			$AnimatedSprite2D.flip_h = false
		
		return
	elif body.name == "Hero":
		if not dying:
			if position.x < body.position.x:
				calc_velocity.x = -HIT_JUMP_VELOCITY
			elif position.x > body.position.x:
				calc_velocity.x = HIT_JUMP_VELOCITY
			
			calc_velocity = move_and_collide(calc_velocity)
			
			body.hit(position.x, HIT_POINTS)
			body.bounce()
			speed = WALK_SPEED

func hit(damage):
	if life > 0:
		life -= damage
	if life <= 0:
		speed = 0
		$AnimatedSprite2D.play("dying")	
		dying = true
		if $DieTimer.time_left == 0:
			$DieTimer.start()
	else:
		$AnimatedSprite2D.play("hurt")
		$HitTimer.start()
		
func _on_HitTimer_timeout():
	$AnimatedSprite2D.play("walking")
	
func _on_DieTimer_timeout():
	queue_free()
