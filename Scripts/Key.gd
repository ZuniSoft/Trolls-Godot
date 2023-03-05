extends Area2D

signal key_collected()

func _on_Key_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundKey.play()
	
	var room = self.get_node("../../")
	var node_idx = name.lstrip(Globals.NODE_KEY_NAME)
	
	if "Room" in room.name:
		RoomState.set("key_" + str(node_idx) + "_collected", true)
	else:
		GameState.set("key_" + str(node_idx) + "_collected", true)
		
	GameState.has_keys = true
	
	emit_signal("key_collected")
	set_collision_mask_bit(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
