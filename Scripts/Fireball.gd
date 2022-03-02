extends Area2D

const SPEED = 200
const HIT_POINTS = 1

var velocity = Vector2()
var direction = 1

func _ready():
	pass
	
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shooting")
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func set_fireball_dir(var dir):
	direction = dir
	
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _on_Fireball_body_entered(body):
	if body.is_in_group("enemies"):
		body.hit(HIT_POINTS)
	queue_free()
