extends Area2D
class_name Virus

var to_scene: PackedScene

func _on_body_entered(body):
	if body is ComputerPlayer and to_scene:
		SceneSwitcher.switch_scene_and_save_computer_world(to_scene)
