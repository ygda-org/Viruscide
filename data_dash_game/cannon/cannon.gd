extends Area2D



var cannon_hovered : bool = false
var cannon_active : bool = false
var holding_files : bool = true
var preview_number : int = 6
var velocity_mult : float = 2
var time_mult : float = 0.5
var game_gravity : float = 25

@export var camera_relative : Vector2

const CANNON_PREVIEW = preload("uid://ceuxquax5pp0a")

var preview = []


func _ready() -> void:
	for i in range(preview_number):
		var obj = CANNON_PREVIEW.instantiate()
		get_parent().add_child.call_deferred(obj)
		obj.visible(false)
		preview.append(obj)
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if holding_files:
		
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && cannon_active:
		hide_preview()
		cannon_active = false
	if cannon_active:
		show_preview()
	pass


func show_preview():
	var vel = (global_position - get_global_mouse_position()) * velocity_mult
	for i in range(1, preview_number+1):
		preview[i-1].visible(true)
		preview[i-1].global_position.x = global_position.x + (i * (vel.x)* time_mult)
		preview[i-1].global_position.y = global_position.y + (i * vel.y*time_mult) + 0.5 * (game_gravity * (i*time_mult)**2)
		
func hide_preview():
	for i in range(preview_number):
		preview[i].visible(false)


func _on_mouse_entered() -> void:
	cannon_hovered = true
	cannon_active = false
	hide_preview()
	pass


func _on_mouse_exited() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		cannon_active = true
	cannon_hovered = false
