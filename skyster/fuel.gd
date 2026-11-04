extends Area2D

var default_y: float

func _ready() -> void:
	print('woa')
	default_y = global_position.y

func _physics_process(delta: float) -> void:
	global_position.y = default_y + sin(Time.get_ticks_msec() * 0.005) * 10

func _on_body_entered(body: Node2D) -> void:
	body.fuel = 100
	queue_free()
