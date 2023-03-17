extends Area2D

signal coin_collected()

func _ready():
	$AnimatedSprite2D.play()

func _on_Coin_body_entered(_body):
	$AnimationPlayer.play("Bounce")
	$SoundCoin.play()
	
	var room = self.get_node("../../")
	if "Room" in room.name and name != "Coin":
		RoomState.coins_collected[name] = true
	elif "Level" in room.name and name != "Coin":
		GameState.coins_collected[name] = true
	
	emit_signal("coin_collected")
	set_collision_mask_value(1, false)

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
