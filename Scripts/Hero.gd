extends KinematicBody2D

signal life_lost(hit_points)
signal fireball_used

var velocity = Vector2(0, 0)
var is_hit = false
var is_dying = false
var is_throwing = false
var in_ladder_area = false
var on_ladder = false
var has_fireballs = true
var mystery_items = ["res://Scenes/Fireballs.tscn", "res://Scenes/Heart.tscn", "res://Scenes/Coin.tscn"]

const WALK_SPEED = 120
const RUN_SPEED = 500
const ATTACK_SPEED = 90
const GRAVITY = 35
const JUMPFORCE = -1100
const HIT_JUMP_VEL = 200 
const LADDER_STEP_HT = 1
const FIREBALL = preload("res://Scenes/Fireball.tscn")
const ATTACK_HIT_POINTS = 10
const JUMP_HIT_POINTS = 2
const SWORD_X_POS = 310

func _physics_process(_delta):
	if not is_hit and not is_dying:
		$SwordHit/Sword.disabled = true
		
		if is_on_floor():
			on_ladder = false
			
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
		elif Input.is_action_just_pressed("ui_focus_next") and not on_ladder and has_fireballs:
			is_throwing = true
			$ThrowTimer.start()
			$AnimatedSprite.play("throwing")
		elif Input.is_action_pressed("ui_right") and not on_ladder and Input.is_action_pressed("ui_attack"):
			$SoundSword.play()
			$SwordHit/Sword.disabled = false
			velocity.x = ATTACK_SPEED
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("fighting")
		elif Input.is_action_pressed("ui_left") and not on_ladder and Input.is_action_pressed("ui_attack"):
			$SoundSword.play()
			$SwordHit/Sword.disabled = false
			velocity.x = -ATTACK_SPEED
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("fighting")
		elif Input.is_action_pressed("ui_attack") and not on_ladder:
			$SoundSword.play()
			$SwordHit/Sword.disabled = false
			velocity.x = 0
			$AnimatedSprite.play("fighting")
		elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_run"):
			$SwordHit/Sword.position.x = SWORD_X_POS
			$AnimatedSprite.flip_h = false
			velocity.x = RUN_SPEED
			$AnimatedSprite.play("running")
		elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_run"):
			$SwordHit/Sword.position.x = -SWORD_X_POS
			$AnimatedSprite.flip_h = true
			velocity.x = -RUN_SPEED	
			$AnimatedSprite.play("running")
		elif Input.is_action_pressed("ui_right"):
			$SwordHit/Sword.position.x = SWORD_X_POS
			$AnimatedSprite.flip_h = false
			velocity.x = WALK_SPEED
			if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
			$AnimatedSprite.play("walking")
		elif Input.is_action_pressed("ui_left"):
			$SwordHit/Sword.position.x = -SWORD_X_POS
			$AnimatedSprite.flip_h = true
			velocity.x = -WALK_SPEED
			if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
			$AnimatedSprite.play("walking")
		elif Input.is_action_pressed("ui_up") and in_ladder_area:
			on_ladder = true
			global_transform.origin.y -= LADDER_STEP_HT
			$AnimatedSprite.play("climbing")
		elif Input.is_action_pressed("ui_down") and in_ladder_area:
			on_ladder = true
			global_transform.origin.y += LADDER_STEP_HT
			$AnimatedSprite.play("climbing")
		else:
			if not is_throwing:
				velocity.x = 0
				$AnimatedSprite.play("idle")
				
	if not in_ladder_area:
		velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor() and not in_ladder_area:
		velocity.y = JUMPFORCE
		$SoundJump.play()
	
	var snap = Vector2.DOWN * 16 if is_on_floor() else Vector2.ZERO		
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "MysteryBox":
			reveal_mystery_box(collision)
			
func reveal_mystery_box(collision):
	if collision.normal.y == 1:
		var tilemap = get_parent().get_node("Tilesets/MysteryBox")
		var local_position = tilemap.to_local(collision.position)
		var cell_position = tilemap.world_to_map(local_position)
		
		cell_position -= collision.normal
		tilemap.set_cell(cell_position.x, cell_position.y, -1)
		mystery_items.shuffle()
		
		var scene = load(mystery_items[0])
		var scene_instance = scene.instance()
		var hud_instance = get_tree().get_root().find_node("HUD", true, false)
		
		if "Heart" in mystery_items[0]:
			scene_instance.connect("heart_collected", hud_instance, "_on_heart_collected")
		elif "Fireballs" in mystery_items[0]:
			scene_instance.connect("fireball_collected", hud_instance, "_on_fireball_collected")
		elif "Coin" in mystery_items[0]:
			scene_instance.connect("coin_collected", hud_instance, "_on_coin_collected")

		scene_instance.set_position(collision.position)
		get_parent().add_child(scene_instance)
		tilemap.queue_free()
	
func bounce():
	velocity.y = JUMPFORCE * 0.7
	
func hit(var enemy_pos_x, var hit_points):
	is_hit = true
	set_modulate(Color(1.0, 0.3, 0.3, 0.3))
	velocity.y = JUMPFORCE * 0.5

	if position.x < enemy_pos_x:
		velocity.x = -HIT_JUMP_VEL
	elif position.x > enemy_pos_x:
		velocity.x = HIT_JUMP_VEL

	Input.action_release("ui_left")
	Input.action_release("ui_right")
	
	$SoundBump.play()
	emit_signal("life_lost", hit_points)
	$HitTimer.start()

func dying():
	set_modulate(Color(1, 1, 1, 1))
	is_dying = true
	$AnimatedSprite.play("dying")
	$SoundDie.play()
	if $DieTimer.time_left == 0:
		$DieTimer.start()

func hero_died_cleanup():
	var _retval = get_tree().change_scene("res://Scenes/GameOver.tscn")

func _on_HitTimer_timeout():
	set_modulate(Color(1, 1, 1, 1))
	is_hit = false

func _on_DieTimer_timeout():
	queue_free()
	hero_died_cleanup()

func _on_ThrowTimer_timeout():
	var fireball = FIREBALL.instance()
		
	if sign($Position2D.position.x) == 1:
		fireball.set_fireball_dir(1)
	else:
		fireball.set_fireball_dir(-1)
	
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
	$SoundFireball.play()
	emit_signal("fireball_used")
	is_throwing = false

func _on_Ladder_body_entered(body):
	if body.name == "Hero":
		in_ladder_area = true
		velocity.y = 0
			
func _on_Ladder_body_exited(body):
	if body.name == "Hero":
		in_ladder_area = false

func _on_SwordHit_body_entered(body):
	if body.is_in_group("enemies") and not $SwordHit/Sword.disabled:
		body.hit(ATTACK_HIT_POINTS)
		
func _on_HUD_hero_dead():
	dying()

func _on_HUD_fireballs_empty():
	has_fireballs = false

func _on_HUD_has_fireballs():
	has_fireballs = true

func _on_FallZone_body_entered(_body):
	hero_died_cleanup()
