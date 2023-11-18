extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION = 600.0
const FRICTION = 600.0
const JUMP_VELOCITY = -300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Runs x ticks every second
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		# adds inertia to movement. Acceleration is not handled by move_and_slide()
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

	# moves character by velocity, sliding on static bodies
	move_and_slide()
