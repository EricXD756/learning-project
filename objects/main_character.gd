extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0
var ACCEL = 1
var dirChange = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if dirChange != 0:
			ACCEL = 0.8
			dirChange = 0
		velocity.x = direction * SPEED * ACCEL
		if ACCEL < 1.2:
			ACCEL += 0.001
	else:
		if dirChange != 1:
			ACCEL = 0.8
			dirChange = 1
		velocity.x = move_toward(velocity.x, 0, SPEED * ACCEL)
		if ACCEL < 1.2:
			ACCEL += 0.001

	move_and_slide()
