extends Area2D

signal heart_collected(life_cnt)

func _on_Heart_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundHeart.play()
	emit_signal("heart_collected", 5)
	set_collision_mask_bit(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
