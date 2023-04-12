extends CharacterBody2D

const SPEED = 200
const HIT_POINTS = 1

var calc_velocity = Vector2()
var direction = 1
var collision = null
var collided = false
	
func _physics_process(delta):
	if !collided:
		calc_velocity.x = SPEED * delta * direction
		collision = move_and_collide(calc_velocity)
		$AnimatedSprite2D.play("shooting")
	
	if collision != null and !collided:
		collided = true
		var body = collision.get_collider()
		if body.is_in_group("enemies"):
			body.hit(HIT_POINTS)
		
		queue_free()
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func set_fireball_dir(dir):
	direction = dir
	
	if dir == -1:
		$AnimatedSprite2D.flip_h = true
