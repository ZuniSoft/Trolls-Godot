extends StaticBody2D

func _on_TopChecker_body_entered(body):
	body.dying()


func _on_SideChecker_body_entered(body):
	body.dying()
	
