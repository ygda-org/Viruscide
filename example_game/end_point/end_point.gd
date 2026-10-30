extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneSwitcher.return_to_computer_world()
