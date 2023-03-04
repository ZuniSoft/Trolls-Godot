extends Area2D

signal fireball_collected(fireball_cnt, fireball_name, mystery_box)

export var mystery_box = true

func _on_Fireballs_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundFireball.play()
	emit_signal("fireball_collected", 5, name, mystery_box)
	set_collision_mask_bit(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
