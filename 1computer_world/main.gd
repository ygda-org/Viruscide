extends Node2D

const VIRUS = preload("uid://baq4adqedkv00")

func _ready():
	spawn_viruses(1)
	var level : Node2D = $Level
	for dir in [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT, Vector2(1,1), Vector2(-1,1), Vector2(1,-1), Vector2(-1,-1)]:
		var level_copy_1 : Node2D = level.duplicate()
		level_copy_1.position.x += 928 * dir.x
		level_copy_1.position.y += 432 * dir.y
		add_child(level_copy_1)
		move_child(level_copy_1,1)

func spawn_viruses(amount):
	for i in range(amount):
		var spawn_point: VirusSpawnPoint = ComputerWorldReferences.virus_spawn_points.pick_random()
		if not spawn_point:
			return
		var virus = VIRUS.instantiate()
		virus.to_scene = load("uid://bnnlwyrxlig3d")
		$Level.add_child(virus)
		virus.global_position = spawn_point.global_position
		virus.z_index = 1
