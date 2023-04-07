extends Area2D

signal fireball_collected(fireball_cnt)

func _on_Fireballs_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundFireball.play()
	
	var room = self.get_node("../../")
	var node_idx = name.lstrip(Globals.NODE_FIREBALLS_NAME)
	
	if "Room" in room.name and name != "Fireballs":
		RoomState.set("fireball_" + str(node_idx) + "_collected", true)
	elif "Level" in room.name and name != "Fireballs":
		GameState.set("fireball_" + str(node_idx) + "_collected", true)
	
	emit_signal("fireball_collected", 5)
	set_collision_mask_value(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
