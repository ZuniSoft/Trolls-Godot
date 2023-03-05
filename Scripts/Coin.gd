extends Area2D

signal coin_collected(coin_name)

func _on_Coin_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundCoin.play()
	
	var room = self.get_node("../../")
	if "Room" in room.name:
		RoomState.coins_collected[name] = true
	
	emit_signal("coin_collected", name)
	set_collision_mask_bit(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
