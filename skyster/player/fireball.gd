extends Area2D
const EXPLOSION = preload("uid://bqcse30eodpx1")

@export var velocity: Vector2

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body is SkysterVehicle and not body.exploded:
		body.exploded = true
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = body.global_position
		get_tree().current_scene.add_child(explosion)
		body.queue_free()
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
