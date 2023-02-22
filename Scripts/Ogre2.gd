extends KinematicBody2D

const WALK_SPEED = 60
const HIT_POINTS = 15

var speed = WALK_SPEED
var velocity = Vector2()
var life = 75
var dying = false

export var direction = -1
export var detect_cliffs = true

func _ready():
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorChecker.enabled = detect_cliffs
	
func _physics_process(_delta):
	if is_on_wall() or not $FloorChecker.is_colliding() and detect_cliffs and is_on_floor():
		direction *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	velocity.y += 20
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_TopChecker_body_entered(body):
	hit(body.JUMP_HIT_POINTS)
	body.bounce()
	$SoundHit.play()

func _on_SideChecker_body_entered(body):
	if not dying:
		body.hit(position.x, HIT_POINTS)

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
	
	GameState.current_level = 3
	GameState.save_config()
	
	var _retval = get_tree().change_scene("res://Levels/Level3/Scene.tscn")
