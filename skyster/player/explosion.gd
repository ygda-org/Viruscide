extends Area2D

const X_KB = 800.0
const Y_KB = 800.0

func _ready() -> void:
	await get_tree().physics_frame
	await get_tree().physics_frame
	for body in get_overlapping_bodies():
		if body.has_node("BaseVehicle"):
			body.queue_free()
		if body is Player:
			if body.global_position.x > global_position.x:
				body.velocity.x += X_KB * 1.5
			else:
				body.velocity.x += X_KB * -1
			if body.global_position.y + 10 > global_position.y:
				body.velocity.y += Y_KB
			else:
				body.velocity.y += Y_KB * -1.5

func _on_timer_timeout() -> void:
	if $CPUParticles2D.emitting:
		$CPUParticles2D.emitting = false
		$Timer.start(1)
		return
	queue_free()
	
