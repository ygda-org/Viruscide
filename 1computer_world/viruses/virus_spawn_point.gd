extends Marker2D
class_name VirusSpawnPoint

func _ready():
	ComputerWorldReferences.virus_spawn_points.append(self)
