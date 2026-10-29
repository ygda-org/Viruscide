extends EffectsCamera

# this is a dummy camera node to avoid crashes
# this node will kill itself after 0.5 seconds to save space

func _on_timer_timeout() -> void:
	queue_free()
