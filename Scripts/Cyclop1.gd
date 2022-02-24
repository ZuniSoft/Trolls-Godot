extends KinematicBody2D

var speed = 50
var velocity = Vector2()

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
	$AnimatedSprite.play("hurt")
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$TopChecker.set_collision_layer_bit(4, false)
	$TopChecker.set_collision_mask_bit(0, false)
	$SideChecker.set_collision_layer_bit(4, false)
	$SideChecker.set_collision_mask_bit(0, false)
	speed = 0
	$HitTimer.start()
	body.bounce()

func _on_SideChecker_body_entered(body):
	body.hit(position.x)

func _on_HitTimer_timeout():
	queue_free()
