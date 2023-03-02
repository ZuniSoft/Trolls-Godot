extends Area2D

signal key_collected()

func _on_Key_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundKey.play()
	emit_signal("key_collected")
	set_collision_mask_bit(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
