extends Node2D

const MIN_Y_POS1: float = -500
const MIN_Y_POS2: float = -500

const START_Y_POS2: float = -600


func _ready():
	generate_platform_spawns()


func generate_platform_spawns():
	var y_pos: float = -55.0
	while y_pos > MIN_Y_POS1:
		create_spawner(y_pos)
		y_pos -= randf_range(35, 60)
	y_pos = START_Y_POS2
	while y_pos > MIN_Y_POS2:
		create_spawner(y_pos)
		y_pos -= randf_range(35, 60)

func create_spawner(y_pos):
	var spawner = load("uid://cbpoph56miijv").instantiate()
	spawner.spawn_frequency = randf_range(3, 5)
	spawner.position = Vector2(randi_range(0,1) * 480, y_pos)
	spawner.spawn_speed = randf_range(40, 70)
	add_child(spawner)
