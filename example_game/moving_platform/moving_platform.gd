extends AnimatableBody2D


var dir: float = 1.0
var speed: float = 200.0

func _physics_process(delta):
	position.x += dir * speed * delta




func _on_timer_timeout():
	call_deferred("queue_free")
