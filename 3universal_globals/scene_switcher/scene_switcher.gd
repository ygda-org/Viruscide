extends CanvasLayer

signal transition_in_finished

var computer_world_save: Node2D

@onready var animation = $AnimationPlayer

## screen transition type.
enum Transition {
	FADE_TO_BLACK
}

func switch_scene(new_scene: PackedScene, transition_type: Transition = Transition.FADE_TO_BLACK):
	call_deferred("_scene_switch", new_scene, transition_type)

func switch_scene_and_save_computer_world(new_scene: PackedScene, transition_type: Transition = Transition.FADE_TO_BLACK):
	computer_world_save = get_tree().current_scene
	call_deferred("_scene_switch", new_scene, transition_type)

func return_to_computer_world(transition_type: Transition = Transition.FADE_TO_BLACK):
	if not computer_world_save:
		push_error("NO COMPUTER WORLD SAVE FOUND")
		return
	call_deferred("_scene_switch", computer_world_save, transition_type)

## helper function only
func _scene_switch(new_scene: Variant, transition_type: Transition = Transition.FADE_TO_BLACK):
	if animation.is_playing():
		return
	animation.play(Transition.keys()[transition_type].to_lower())
	await transition_in_finished
	get_tree().root.remove_child(get_tree().current_scene)
	if new_scene is PackedScene:
		get_tree().root.add_child(new_scene.instantiate())
	elif new_scene is Node2D:
		get_tree().root.add_child(new_scene)

func _transition_in_finish():
	transition_in_finished.emit()
