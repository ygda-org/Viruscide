extends Area2D

const SWARM_SPEED = 35.0

func _physics_process(delta):
	position.y -= SWARM_SPEED * delta


func _on_body_entered(body):
	if body is ComputerPlayer:
		print("player died!")
