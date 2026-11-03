extends Area2D

var cannon_hovered : bool = false
var cannon_active : bool = false
var holding_files : bool = false
var preview_number : int = 6
var velocity_mult : float = 5
var time_mult : float = 0.125

@export var camera_relative : Marker2D

const CANNON_PREVIEW = preload("uid://ceuxquax5pp0a")

var preview = []

func _ready() -> void:
	for i in range(preview_number):
		var obj = CANNON_PREVIEW.instantiate()
		get_parent().add_child.call_deferred(obj)
		obj.visible(false)
		preview.append(obj)
	pass # Replace with function body.

func _process(delta: float) -> void:
	if holding_files and DatadashGlobal.camera:
		var camera_pos = DatadashGlobal.camera.global_position
		var new_camera_pos = camera_relative.global_position
		DatadashGlobal.camera.global_position = camera_pos.lerp(new_camera_pos, 30*delta)
		
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && cannon_active:
		hide_preview()
		cannon_active = false
		DatadashGlobal.files.held = false
		DatadashGlobal.files.velocity = (global_position - get_global_mouse_position()) * velocity_mult
		DatadashGlobal.camera.add_trauma(0.5)
		DatadashGlobal.camera.add_zoom_trauma(1)
		holding_files = false
	if cannon_active:
		show_preview()
	pass

func show_preview():
	var vel = (global_position - get_global_mouse_position()) * velocity_mult
	for i in range(1, preview_number+1):
		preview[i-1].visible(true)
		preview[i-1].global_position.x = global_position.x + (i * (vel.x)* time_mult)
		preview[i-1].global_position.y = global_position.y + (i * vel.y*time_mult) + 0.5 * (DatadashGlobal.gravity * (i*time_mult)**2)

func hide_preview():
	for i in range(preview_number):
		preview[i].visible(false)

func _on_mouse_entered() -> void:
	cannon_hovered = true
	cannon_active = false
	hide_preview()
	pass

func _on_mouse_exited() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && holding_files:
		cannon_active = true
	cannon_hovered = false

func _on_body_entered(body: Node2D) -> void:
	print("yay")
	DatadashGlobal.files.global_position = global_position
	DatadashGlobal.files.held = true
	DatadashGlobal.files.velocity = Vector2.ZERO
	holding_files = true
