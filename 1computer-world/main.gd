extends Node2D

const Virus = preload("uid://baq4adqedkv00")

func _on_virus_spawn_timer_timeout():
	$VirusSpawnTimer.start()
	var spawn_point: VirusSpawnPoint = ComputerWorldReferences.virus_spawn_points.pick_random()
	if not spawn_point:
		return
	var virus = Virus.instantiate()
	add_child(virus)
	virus.global_position = spawn_point.global_position
