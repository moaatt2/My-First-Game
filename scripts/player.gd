extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300


func _physics_process(delta: float) -> void:
	# Falling logic
	if !is_on_floor():
		velocity.y = min(velocity.y + gravity, 500)

	# Jump logic
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force

	# Movement logic
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
	
	print(velocity)
