extends StaticBody2D

func _ready():
	if get_node_or_null("AnimatedSprite2D"):
		$AnimatedSprite2D.play()

func _on_TopChecker_body_entered(body):
	body.dying()

func _on_SideChecker_body_entered(body):
	body.dying()
	
