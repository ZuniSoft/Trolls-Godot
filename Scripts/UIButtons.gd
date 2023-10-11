extends TextureButton

func _on_AttackButton_down():
	Input.action_press("ui_attack")

func _on_AttackButton_up():
	Input.action_release("ui_attack")

func _on_JumpButton_down():
	Input.action_press("ui_jump")

func _on_JumpButton_up():
	Input.action_release("ui_jump")

func _on_FireballButton_down():
	Input.action_press("ui_shoot")

func _on_FireballButton_up():
	Input.action_release("ui_shoot")

func _on_PauseButton_down():
	Input.action_press("ui_pause")

func _on_PauseButton_up():
	Input.action_release("ui_pause")
