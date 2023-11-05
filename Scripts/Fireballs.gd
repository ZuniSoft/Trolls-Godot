extends Area2D

signal fireball_collected(fireball_cnt)

func _on_Fireballs_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundFireball.play()
	
	var room = self.get_node("../../")
	
	if "Room" in room.name and name != "Fireballs":
		RoomState.fireballs_collected[name] = true
	elif "Level" in room.name and name != "Fireballs":
		GameState.fireballs_collected[name] = true
	
	emit_signal("fireball_collected", 5)
	set_collision_mask_value(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
