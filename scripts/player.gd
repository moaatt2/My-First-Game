extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300

var DASH_SPEED = 4
var is_dashing = false
var ability_queue = []

const ability_dash = preload("res://scenes/ability_dash.tscn")
const ability_jump = preload("res://scenes/ability_jump.tscn")

func _physics_process(delta: float) -> void:
	# Falling logic
	if !is_on_floor():
		velocity.y = min(velocity.y + gravity, 500)

	# Movement logic
	var horizontal_direction = Input.get_axis("move_left", "move_right")

	# Handle action
	if Input.is_action_just_pressed("action"):
		if ability_queue.size() > 0:
			var level_node = get_parent()
			var action = ability_queue.pop_front()
			if action[0] == "jump":
				velocity.y = -jump_force
				await get_tree().create_timer(0.5).timeout # Delay respawn by 0.5 seconds
				var new_jump = ability_jump.instantiate()
				level_node.add_child(new_jump)
				new_jump.position = Vector2(action[1], action[2])
			elif action[0] == "dash":
				start_dash()
				await get_tree().create_timer(0.5).timeout # Delay respawn by 0.5 seconds
				var new_dash = ability_dash.instantiate()
				level_node.add_child(new_dash)
				new_dash.position = Vector2(action[1], action[2])
			else:
				print("Unknown Action: " + str(action))

	# Handle Dash
	if is_dashing:
		velocity.x = speed * DASH_SPEED * horizontal_direction
		velocity.y = 0
	else:
		velocity.x = speed * horizontal_direction
	move_and_slide()

	#print(velocity)

# Set up dashtimer connection
func _ready():
	$DashTimer.connect("timeout", stop_dash)

func start_dash():
	is_dashing = true
	$DashTimer.start()

func stop_dash():
	is_dashing = false

func add_charge(ability) -> void:
	ability_queue.append(ability)
	print(ability_queue)
