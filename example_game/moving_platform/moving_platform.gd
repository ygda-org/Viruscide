extends AnimatableBody2D


var dir: float = 1.0
var speed: float = 200.0

func _physics_process(delta):
	position.x += dir * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	await get_tree().create_timer(1.0).timeout
	call_deferred("queue_free")
