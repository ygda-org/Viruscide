extends Player

signal fuel_changed
const FIREBALL = preload("uid://dapjyrtcd5wji")
const EXPLOSION = preload("uid://bqcse30eodpx1")

const SPEED = 400
const BOOST = 600
const ACCEL = 600
const JUMP_VEL = -600
const FALL_VEL = 3200
const HOVER_VEL = -1200
const MAX_FUEL = 100.0
const PASSIVE_FUEL_LOSS = 10.0
const THRUSTER_FUEL_LOSS = 2.5
const DAMAGE_FUEL_LOSS = 5.0
const FIREBALL_SPEED = 2000.0
var jumped_last_frame: bool = false
var fuel: float = 100.0:
	set(new):
		if new == fuel:
			return
		fuel = new
		fuel_changed.emit()
func _process(_delta: float) -> void:
	$Camera.global_position.y = 0
	$Camera.global_position.x = global_position.x + 300
	
func shoot(thruster: Node, vel: Vector2) -> void:
	var fireball = FIREBALL.instantiate()
	fireball.velocity = vel
	fireball.global_position = thruster.global_position
	get_tree().current_scene.add_child(fireball)

func _physics_process(delta: float) -> void:
	fuel -= delta
	$Thrusters/BottomFire.visible = is_jumping()
	$Thrusters/LeftFire.visible = is_accelerating()
	if is_on_floor():
		velocity.y = min(velocity.y, 0)
	elif not is_jumping():
		velocity.y += FALL_VEL * delta
	velocity.y = clamp(velocity.y, JUMP_VEL, FALL_VEL)
	if is_jumping():
		fuel -= THRUSTER_FUEL_LOSS * 2 * delta
		if jumped_last_frame or not is_on_floor():
			var mult = 1
			if velocity.y > 0:
				mult = 2
			velocity.y += HOVER_VEL * mult * delta
		else:
			velocity.y += JUMP_VEL
		if $BottomFireballCooldown.is_stopped():
			$BottomFireballCooldown.start()
		
	jumped_last_frame = is_jumping()
	
	
	var target_speed = SPEED
	if is_accelerating():
		fuel -= THRUSTER_FUEL_LOSS * delta
		target_speed += BOOST
		velocity.x = move_toward(velocity.x, target_speed, ACCEL * delta * 2)
		if $LeftFireballCooldown.is_stopped():
			$LeftFireballCooldown.start()
	if fuel <= 0:
		target_speed = 0
	velocity.x = move_toward(velocity.x, target_speed, ACCEL * delta)
	$Wheels/LeftWheel.rotation += velocity.x * delta * 0.03
	$Wheels/RightWheel.rotation += velocity.x * delta * 0.03
	move_and_slide()

func is_jumping() -> bool:
	return fuel > 0 and (Input.is_action_pressed("jump") or Input.is_action_pressed("up") or Input.is_action_pressed("down"))

func is_accelerating() -> bool:
	return fuel > 0 and (Input.is_action_pressed("left") or Input.is_action_pressed("right"))

func _on_bottom_fireball_cooldown_timeout() -> void:
	shoot($Thrusters/BottomFire/LeftFire, Vector2(0, FIREBALL_SPEED))
	shoot($Thrusters/BottomFire/RightFire, Vector2(0, FIREBALL_SPEED))

func _on_left_fireball_cooldown_timeout() -> void:
	shoot($Thrusters/LeftFire, Vector2(FIREBALL_SPEED * -1, 0))


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is SkysterVehicle and not body.exploded:
		body.exploded = true
		var explosion = EXPLOSION.instantiate()
		explosion.global_position = body.global_position
		get_tree().current_scene.add_child(explosion)
		body.queue_free()
		fuel -= DAMAGE_FUEL_LOSS
