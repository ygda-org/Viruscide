extends CharacterBody2D
class_name ComputerPlayer

# this script is not for club members to alter.
# you may use it as reference though! (or extend it, though beware it may change over time)

const JUMP_STRENGTH = 280
const GRAVITY: float = 700
const MAX_FALL_SPEED: float = 300

const ACCELERATION: float = 900.0
const DECELERATION: float = 1500.0
const MAX_SPEED: float = 130.0

@export var accel_curve: Curve
@export var decel_curve: Curve

@export var grav_curve_asc: Curve
@export var grav_curve_dec: Curve

func _physics_process(delta: float) -> void:
	# vertical
	if not is_on_floor():
		var grav_mult: float = 1.0
		if velocity.y < 0:
			grav_mult = grav_curve_asc.sample(abs(velocity.y/JUMP_STRENGTH))
		else:
			grav_mult = grav_curve_dec.sample(velocity.y/MAX_FALL_SPEED)
		velocity.y += GRAVITY * grav_mult * delta
	else: 
		$CoyoteTime.start()
	if not $JumpBuffer.is_stopped() and not $CoyoteTime.is_stopped():
		velocity.y -= JUMP_STRENGTH
		$JumpBuffer.stop()
		$CoyoteTime.stop()
	if Input.is_action_just_pressed("jump"):
		$JumpBuffer.start()
	elif Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y /= 2.15
	
	# horizontal
	var dir: float = Input.get_axis("left", "right")
	if dir:
		velocity.x += dir * ACCELERATION * accel_curve.sample(abs(velocity.x)/MAX_SPEED) * delta
	if dir * velocity.x <= 0:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * decel_curve.sample(abs(velocity.x/MAX_SPEED)) * delta)
	velocity.x = clampf(velocity.x, -MAX_SPEED, MAX_SPEED)
	
	
	move_and_slide()
