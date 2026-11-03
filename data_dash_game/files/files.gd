extends CharacterBody2D


@onready var sprite : Sprite2D = $Sprite2D
var visibility: bool = false
var held = false
var gravity = Vector2.DOWN * DatadashGlobal.gravity
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DatadashGlobal.files = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not held:
		velocity += gravity * delta
	move_and_slide()

func visible(i : bool) -> void:
	visibility = i
