extends Node2D

const PLATFORM = preload("uid://bqa0hh5hg003g")

var spawn_frequency: float = 2.0
var spawn_speed: float = 50.0

var side: int

func _ready():
	$Timer.wait_time = spawn_frequency
	$Timer.start()
	if not side: # just in case, calculate side by position
		side = 1 if position.x < 240 else -1
	_on_timer_timeout()


func _on_timer_timeout():
	var platform = PLATFORM.instantiate()
	platform.dir = side
	platform.speed = spawn_speed
	add_child(platform)
