extends CharacterBody2D
class_name SkysterVehicle
@export var speed: float
var exploded: bool = false
func _ready() -> void:
	velocity = Vector2(speed * -1, 3000)

func _physics_process(_delta: float) -> void:
	if velocity.y != 0 and is_on_floor():
		velocity.y = 0
	move_and_slide()
