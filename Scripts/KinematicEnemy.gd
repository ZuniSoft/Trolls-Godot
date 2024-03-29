class_name KinematicEnemy

extends CharacterBody2D

const GRAVITY = 35

var WALK_SPEED = 60
var RUN_SPEED = 200
var HIT_JUMP_VELOCITY = 10
var HIT_POINTS = 2
var LIFE = 10

var speed = WALK_SPEED
var calc_velocity = null
var life = LIFE
var dying = false
var hero = null
var hit_hero = false

@export var direction = -1
@export var detect_cliffs = true

func _ready():
	calc_velocity = Vector2.ZERO
	
	$HealthBar.visible = false
	$HealthBar.set_max(life)
	
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	
	$FloorChecker.target_position.x = $CollisionShape2D.shape.get_size().x * direction
	$FloorChecker.enabled = detect_cliffs
	
	$AnimatedSprite2D.play()
	
func _physics_process(_delta):
	calc_velocity = velocity
		
	if is_on_wall() or not $FloorChecker.is_colliding() and detect_cliffs and is_on_floor():
		direction *= -1
		
		if (not hit_hero or direction == -1) and not dying:
			$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h
			
		$FloorChecker.target_position.x = $CollisionShape2D.shape.get_size().x * direction
	elif hero:
		calc_velocity.x = self.position.direction_to(hero.position).x * speed
		direction = sign(calc_velocity.x)
		
		if hit_hero and direction == 1:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = self.global_position > hero.global_position
		
		if self.global_position > hero.global_position:
			$FloorChecker.target_position.x = $CollisionShape2D.shape.get_size().x * direction
		else:
			calc_velocity.x *= direction
			$FloorChecker.target_position.x = $CollisionShape2D.shape.get_size().x
	else:
		calc_velocity.x = direction * speed
	
	if is_on_wall(): calc_velocity.x = 0
	
	calc_velocity.y += GRAVITY
	
	set_up_direction(Vector2.UP)
	
	velocity = calc_velocity
	move_and_slide()
	calc_velocity = velocity

func _on_DetectArea_body_entered(body):
	if body.name == "DoorBlock":
		return
		
	if not dying:
		$AnimatedSprite2D.play("attacking")
		hero = body
		speed = RUN_SPEED

func _on_DetectArea_body_exited(_body):
	if not dying:
		$AnimatedSprite2D.play("walking")
		hero = null
		speed = WALK_SPEED
		
		direction = sign(calc_velocity.x)

func _on_TopChecker_body_entered(body):
	if body.name == "Hero":
		hit(body.JUMP_HIT_POINTS)
		
		if dying:
			clear_collisions()
		else:
			body.bounce()
			$SoundHit.play()

func _on_SideChecker_body_exited(body):
	if body.name == "Hero":
		hit_hero = false
		
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
			hit_hero = true
			
			if position.x < body.position.x:
				calc_velocity.x = -HIT_JUMP_VELOCITY
			elif position.x > body.position.x:
				calc_velocity.x = HIT_JUMP_VELOCITY
			
			calc_velocity = move_and_collide(calc_velocity)
			
			body.hit(position.x, HIT_POINTS)
			body.bounce()
			speed = WALK_SPEED
		else:
			clear_collisions()

func hit(damage):	
	life -= damage
	
	$HealthBar.value = life
	
	if life > LIFE / 2.0:
		$HealthBar.set_modulate(Color(0,1,0))
	else:
		$HealthBar.set_modulate(Color(1,0,0))
	
	if life <= 0:
		dying = true
		speed = 0
		
		$HealthBar.value = 0
		$AnimatedSprite2D.play("dying")
		
		if $HitTimer.time_left != 0:
			$HitTimer.stop()
		
		if $DieTimer.time_left == 0:
			$DieTimer.start()
	else:
		$AnimatedSprite2D.play("hurt")
		$HealthBar.visible = true
		
		if $HitTimer.time_left == 0:
			$HitTimer.start()

func clear_collisions():
	set_collision_layer_value(5, false)
	set_collision_mask_value(1, false)
	
func _on_HitTimer_timeout():
	$AnimatedSprite2D.play("walking")
	$HealthBar.visible = false
	
func _on_DieTimer_timeout():
	queue_free()
