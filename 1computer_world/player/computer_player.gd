extends Player
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

var was_in_air: bool = false
var target_scale: Vector2 = Vector2(1,1)

func _physics_process(delta: float) -> void:
	# vertical
	if not is_on_floor():
		$Anim.play("fall")
		was_in_air = true
		var grav_mult: float = 1.0
		if velocity.y < 0:
			grav_mult = grav_curve_asc.sample(abs(velocity.y/JUMP_STRENGTH))
		else:
			grav_mult = grav_curve_dec.sample(velocity.y/MAX_FALL_SPEED)
		velocity.y += GRAVITY * grav_mult * delta
	else: 
		$CoyoteTime.start()
		if was_in_air:
			target_scale = Vector2(2, 0.5)
			was_in_air = false
		if velocity.x:
			$Anim.play("run")
		else:
			$Anim.play("idle")
	if not $JumpBuffer.is_stopped() and not $CoyoteTime.is_stopped():
		velocity.y -= JUMP_STRENGTH
		$JumpBuffer.stop()
		$CoyoteTime.stop()
		target_scale = Vector2(0.4, 1.5)
		#Utils.get_active_effects_camera().add_trauma(0.01)
	if Input.is_action_just_pressed("jump"):
		$JumpBuffer.start()
	elif Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y /= 2.15
	# fall through platforms
	set_collision_mask_value(2, not Input.is_action_pressed("down"))
	
	
	# horizontal
	var dir: float = Input.get_axis("left", "right")
	if dir:
		velocity.x += dir * ACCELERATION * accel_curve.sample(abs(velocity.x)/MAX_SPEED) * delta
	if dir * velocity.x <= 0:
		velocity.x = move_toward(velocity.x, 0, DECELERATION * decel_curve.sample(abs(velocity.x/MAX_SPEED)) * delta)
	velocity.x = clampf(velocity.x, -MAX_SPEED, MAX_SPEED)
	
	# animation/vfx stuff
	
	if velocity.x > 0:
		$Anim.flip_h = false
	elif velocity.x < 0:
		$Anim.flip_h = true
	
	$Anim.scale = $Anim.scale.lerp(target_scale, delta*25)
	if $Anim.scale.distance_to(target_scale) < 0.1:
		target_scale = Vector2(1,1)
	
	
	move_and_slide()
