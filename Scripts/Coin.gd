extends Area2D

signal coin_collected

func _on_Coin_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	emit_signal("coin_collected")
	set_collision_mask_bit(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
