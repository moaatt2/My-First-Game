extends Control

@export var deadzone = 20  # pixels

var dragging = false
var start_x = 0.0

func _gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			start_x = event.position.x
		# release movement when finger lifts
		else:
			dragging = false
			Input.action_release("move_left")
			Input.action_release("move_right")
	elif event is InputEventScreenDrag and dragging:
		var delta_x = event.position.x - start_x
		if delta_x > deadzone:
			Input.action_press("move_right")
			Input.action_release("move_left")
		elif delta_x < -deadzone:
			Input.action_press("move_left")
			Input.action_release("move_right")
		else:
			# inside deadzone, release both
			Input.action_release("move_left")
			Input.action_release("move_right")

func _exit_tree() -> void:
	Input.action_release("move_left")
	Input.action_release("move_right")
