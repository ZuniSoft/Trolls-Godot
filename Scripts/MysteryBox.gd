extends Area2D

var mystery_items = ["res://Scenes/Fireballs.tscn", "res://Scenes/Heart.tscn", "res://Scenes/Coin.tscn"]

func _on_MysteryBox_body_entered(body):
	if position.y < body.position.y:
		$AnimationPlayer.play("Bounce")
		
		mystery_items.shuffle()	
		var scene = load(mystery_items[0])
		var scene_instance = scene.instance()
		var hud_instance = get_tree().get_root().find_node("HUD", true, false)
		
		if "Heart" in mystery_items[0]:
			scene_instance.connect("heart_collected", hud_instance, "_on_heart_collected")
		elif "Fireballs" in mystery_items[0]:
			scene_instance.connect("fireball_collected", hud_instance, "_on_fireball_collected")
		elif "Coin" in mystery_items[0]:
			scene_instance.connect("coin_collected", hud_instance, "_on_coin_collected")

		var room = self.get_node("../../")
		var node_idx = name.lstrip(Globals.NODE_MYSTERY_NAME)
		
		if "Room" in room.name:
			RoomState.set("mystery_" + str(node_idx) + "_collected", true)
		else:
			GameState.set("mystery_" + str(node_idx) + "_collected", true)

		scene_instance.set_position(position)
		get_parent().call_deferred("add_child", scene_instance)
		set_collision_mask_bit(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
