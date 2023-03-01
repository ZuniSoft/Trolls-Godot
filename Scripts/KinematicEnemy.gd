extends KinematicBody2D

class_name KinematicEnemy

var WALK_SPEED = 60
var RUN_SPEED = 200
var HIT_POINTS = 2
var LIFE = 10

var speed = WALK_SPEED
var velocity = Vector2.ZERO
var life = LIFE
var dying = false
var hero = null

export var direction = -1
export var detect_cliffs = true

func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.cast_to.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorChecker.enabled = detect_cliffs
	
func _physics_process(_delta):
	velocity = Vector2.ZERO
		
	if is_on_wall() or not $FloorChecker.is_colliding() and detect_cliffs and is_on_floor():
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.cast_to.x = $CollisionShape2D.shape.get_extents().x * direction
		
	if hero:
		velocity.x = self.position.direction_to(hero.position).x * speed
		direction = sign(velocity.x)
		
		if self.global_position > hero.global_position:
			$AnimatedSprite.flip_h = self.global_position > hero.global_position
		else:
			$AnimatedSprite.flip_h = false
		
		$FloorChecker.cast_to.x = $CollisionShape2D.shape.get_extents().x * direction
	else:
		velocity.x = direction * speed
	
	velocity.y += 20
	velocity = move_and_slide(velocity, Vector2.UP)
	
func _on_DetectArea_body_entered(body):
	hero = body
	speed = RUN_SPEED

func _on_DetectArea_body_exited(_body):
	hero = null
	speed = WALK_SPEED

func _on_TopChecker_body_entered(body):
	if body.name == "Hero":
		hit(body.JUMP_HIT_POINTS)
		body.bounce()
		$SoundHit.play()

func _on_SideChecker_body_entered(body):
	if body.name == "DoorBlock":
		return
	if not dying:
		body.hit(position.x, HIT_POINTS)
		body.bounce()
		speed = WALK_SPEED

func hit(var damage):
	if life > 0:
		life -= damage
	if life <= 0:
		speed = 0
		$AnimatedSprite.play("dying")	
		dying = true
		if $DieTimer.time_left == 0:
			$DieTimer.start()
	else:
		$AnimatedSprite.play("hurt")
		$HitTimer.start()
		
func _on_HitTimer_timeout():
	$AnimatedSprite.play("walking")
	
func _on_DieTimer_timeout():
	queue_free()
