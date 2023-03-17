extends Area2D

signal heart_collected(life_cnt)

@export var mystery_box = true

func _on_Heart_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundHeart.play()
	
	var room = self.get_node("../../")
	var node_idx = name.lstrip(Globals.NODE_HEART_NAME)
	
	if "Room" in room.name:
		RoomState.set("heart_" + str(node_idx) + "_collected", true)
	else:
		GameState.set("heart_" + str(node_idx) + "_collected", true)
	
	emit_signal("heart_collected", 5)
	set_collision_mask_value(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
