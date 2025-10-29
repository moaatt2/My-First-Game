extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300

var DASH_SPEED = 4
var is_dashing = false

func _physics_process(delta: float) -> void:
	# Falling logic
	if !is_on_floor():
		velocity.y = min(velocity.y + gravity, 500)

	# Jump logic
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -jump_force

	# Movement logic
	var horizontal_direction = Input.get_axis("move_left", "move_right")

	if Input.is_action_just_pressed("dash"):
		if !is_dashing and horizontal_direction:
			start_dash()

	if is_dashing:
		velocity.x = speed * DASH_SPEED * horizontal_direction
	else:
		velocity.x = speed * horizontal_direction
	move_and_slide()
	
	print(velocity)

func start_dash():
	is_dashing = true
	$DashTimer.connect("timeout", stop_dash)
	$DashTimer.start()

func stop_dash():
	is_dashing = false

func add_charge(ability) -> void:
	print("Adding Charge")
