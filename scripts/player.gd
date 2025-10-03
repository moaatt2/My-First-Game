extends CharacterBody2D

@export var speed = 300
@export var gravity = 30

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y = min(velocity.y + gravity, 500)
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
	
	print(velocity)
