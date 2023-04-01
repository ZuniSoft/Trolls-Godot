extends CharacterBody2D

signal life_lost(hit_points)
signal fireball_used
signal activate_door(hero, door_name)

var calc_velocity = Vector2(0, 0)
var is_hit = false
var is_dying = false
var is_throwing = false
var in_ladder_area = false
var on_ladder = false
var in_door_area = false
var door_name = ""
var has_fireballs = true
var has_keys = false

const WALK_SPEED = 120
const RUN_SPEED = 500
const ATTACK_SPEED = 90
const GRAVITY = 35
const JUMPFORCE = -1100
const HIT_JUMP_VEL = 200 
const LADDER_STEP_HT = 1
const FIREBALL = preload("res://Scenes/Fireball.tscn")
const ATTACK_HIT_POINTS = 5
const JUMP_HIT_POINTS = 2
const SWORD_X_POS = 310

func _ready():
	has_fireballs = GameState.has_fireballs
	has_keys = GameState.has_keys
	
func _physics_process(_delta):
	if not is_hit and not is_dying:
		$SwordHit/Sword.disabled = true
		
		if is_on_floor():
			on_ladder = false
			
		if not is_on_floor() and calc_velocity.y > 0:
			$AnimatedSprite2D.play("falling")
		elif not is_on_floor() and calc_velocity.y < 0:
			if Input.is_action_pressed("ui_right"):
				calc_velocity.x = WALK_SPEED
			elif Input.is_action_pressed("ui_left"):
				calc_velocity.x = -WALK_SPEED
			else:
				calc_velocity.x = 0
			$AnimatedSprite2D.play("jumping")
			
		if Input.is_action_just_pressed("ui_pause"):
			var pause_menu = load("res://Scenes/PauseMenu.tscn")
			var pause_menu_instance = pause_menu.instantiate()
			get_tree().paused = true
			add_child(pause_menu_instance)
		elif Input.is_action_just_pressed("ui_shoot") and not on_ladder and has_fireballs:
			is_throwing = true
			$ThrowTimer.start()
			$AnimatedSprite2D.play("throwing")
		elif Input.is_action_pressed("ui_right") and not on_ladder and Input.is_action_pressed("ui_attack"):
			$SoundSword.play()
			$SwordHit/Sword.disabled = false
			calc_velocity.x = ATTACK_SPEED
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("fighting")
		elif Input.is_action_pressed("ui_left") and not on_ladder and Input.is_action_pressed("ui_attack"):
			$SoundSword.play()
			$SwordHit/Sword.disabled = false
			calc_velocity.x = -ATTACK_SPEED
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("fighting")
		elif Input.is_action_pressed("ui_attack") and not on_ladder:
			$SoundSword.play()
			$SwordHit/Sword.disabled = false
			calc_velocity.x = 0
			$AnimatedSprite2D.play("fighting")
		elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_run"):
			$SwordHit/Sword.position.x = SWORD_X_POS
			$AnimatedSprite2D.flip_h = false
			calc_velocity.x = RUN_SPEED
			$AnimatedSprite2D.play("running")
		elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_run"):
			$SwordHit/Sword.position.x = -SWORD_X_POS
			$AnimatedSprite2D.flip_h = true
			calc_velocity.x = -RUN_SPEED	
			$AnimatedSprite2D.play("running")
		elif Input.is_action_pressed("ui_right"):
			$SwordHit/Sword.position.x = SWORD_X_POS
			$AnimatedSprite2D.flip_h = false
			calc_velocity.x = WALK_SPEED
			if sign($Marker2D.position.x) == -1:
					$Marker2D.position.x *= -1
			$AnimatedSprite2D.play("walking")
		elif Input.is_action_pressed("ui_left"):
			$SwordHit/Sword.position.x = -SWORD_X_POS
			$AnimatedSprite2D.flip_h = true
			calc_velocity.x = -WALK_SPEED
			if sign($Marker2D.position.x) == 1:
					$Marker2D.position.x *= -1
			$AnimatedSprite2D.play("walking")
		elif Input.is_action_pressed("ui_up") and in_door_area:
			emit_signal("activate_door", self, door_name)
			return
		elif Input.is_action_pressed("ui_up") and in_ladder_area:
			on_ladder = true
			global_transform.origin.y -= LADDER_STEP_HT
			$AnimatedSprite2D.play("climbing")
		elif Input.is_action_pressed("ui_down") and in_ladder_area:
			on_ladder = true
			global_transform.origin.y += LADDER_STEP_HT
			$AnimatedSprite2D.play("climbing")
		else:
			if not is_throwing and in_ladder_area or is_on_floor():
				calc_velocity.x = 0
				$AnimatedSprite2D.play("idle")
	
	if Input.is_action_just_pressed("ui_jump") and is_on_floor() and not in_ladder_area:
		calc_velocity.y = JUMPFORCE
		$SoundJump.play()
	elif in_ladder_area:
		calc_velocity.y = 0
	else:
		calc_velocity.y = calc_velocity.y + GRAVITY
			
	set_up_direction(Vector2.UP)
	velocity = calc_velocity
	move_and_slide()
	calc_velocity = velocity
	
func bounce():
	calc_velocity.y = JUMPFORCE * 0.7
	
func hit(enemy_pos_x, hit_points):
	is_hit = true
	set_modulate(Color(1.0, 0.3, 0.3, 0.3))
	calc_velocity.y = JUMPFORCE * 0.5

	if position.x < enemy_pos_x:
		calc_velocity.x = -HIT_JUMP_VEL
	elif position.x > enemy_pos_x:
		calc_velocity.x = HIT_JUMP_VEL

	Input.action_release("ui_left")
	Input.action_release("ui_right")
	
	$SoundBump.play()
	emit_signal("life_lost", hit_points)
	$HitTimer.start()

func dying():
	set_modulate(Color(1, 1, 1, 1))
	is_dying = true
	$AnimatedSprite2D.play("dying")
	$SoundDie.play()
	if $DieTimer.time_left == 0:
		$DieTimer.start()

func hero_died_cleanup():
	get_node("../HUD").visible = false
	Game.change_scene("res://Scenes/GameOver.tscn", false, Globals.TRANSITION_SCENE)

func _on_HitTimer_timeout():
	set_modulate(Color(1, 1, 1, 1))
	is_hit = false

func _on_DieTimer_timeout():
	queue_free()
	hero_died_cleanup()

func _on_ThrowTimer_timeout():
	var fireball = FIREBALL.instantiate()
		
	if sign($Marker2D.position.x) == 1:
		fireball.set_fireball_dir(1)
	else:
		fireball.set_fireball_dir(-1)
	
	get_parent().add_child(fireball)
	fireball.position = $Marker2D.global_position
	$SoundFireball.play()
	emit_signal("fireball_used")
	is_throwing = false

func _on_Ladder_body_entered(_body):
	in_ladder_area = true
			
func _on_Ladder_body_exited(_body):
	in_ladder_area = false
	
func door_area_entered(door_entered_name):
	in_door_area = true
	self.door_name = door_entered_name
			
func door_area_exited():
	in_door_area = false

func _on_SwordHit_body_entered(body):
	if body.is_in_group("enemies") and not $SwordHit/Sword.disabled:
		body.hit(ATTACK_HIT_POINTS)
		
func _on_HUD_hero_dead():
	dying()

func _on_HUD_fireballs_empty():
	has_fireballs = false

func _on_HUD_has_fireballs():
	has_fireballs = true
	
func _on_HUD_keys_empty():
	has_keys = false

func _on_HUD_has_keys():
	has_keys = true

func _on_FallZone_body_entered(_body):
	hero_died_cleanup()
