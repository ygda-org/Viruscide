extends Area2D
class_name VirusSpawn

func _on_body_entered(body):
	if body is ComputerPlayer:
		print("Virus minigame entered!")
