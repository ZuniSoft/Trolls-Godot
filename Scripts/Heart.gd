extends Area2D

signal heart_collected(life_cnt)

func _on_Heart_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundHeart.play()
	
	var room = self.get_node("../../")
	
	if "Room" in room.name and name != "Heart":
		RoomState.hearts_collected[name] = true
	elif "Level" in room.name and name != "Heart":
		GameState.hearts_collected[name] = true
	
	emit_signal("heart_collected", 5)
	set_collision_mask_value(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
