extends Node

## returns the active EffectsCamera if found. Else returns a dummy camera and pushes an error
func get_active_effects_camera() -> EffectsCamera:
	var cam = get_viewport().get_camera_2d()
	if cam is EffectsCamera:
		return cam
	else:
		var dummy = load("uid://cwba72xilc4ck").instantiate()
		get_tree().current_scene.add_child(dummy)
		push_error("NO ACTIVE EFFECTS CAMERA FOUND ON CALL TO Utils.get_active_effects_camera")
		return dummy
