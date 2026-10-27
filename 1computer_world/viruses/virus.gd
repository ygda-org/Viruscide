extends Area2D
class_name Virus

var to_scene: PackedScene

func _on_body_entered(body):
	if body is ComputerPlayer and to_scene:
		get_tree().change_scene_to_packed(to_scene)
