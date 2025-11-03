extends CanvasLayer

@export var max_slots: int = 5
@export var jump_color: Color = Color.BLUE
@export var dash_color: Color = Color.RED
@export var empt_color: Color = Color.GRAY

@onready var slots: Array = $HBoxContainer.get_children()
var player: Node
var last_charge_count: int = -1

# Find player and instantiate UI
func _ready() -> void:
	player = get_tree().get_root().find_child("Player", true, false) # Find the player
	update_slots() # Update the UI

# Update function - Update UI when number of charges changes
func _process(delta: float) -> void:
	if player and player.ability_queue.size() != last_charge_count:
		update_slots()

# Get current charges and update UI
func update_slots() -> void:
	if not player:
		return

	last_charge_count = player.ability_queue.size() # Update last charge count

	for i in range(max_slots):
		if i < last_charge_count:
			match player.ability_queue[i][0]:
				"jump":
					slots[i].color = jump_color
				"dash":
					slots[i].color = dash_color
				_:
					slots[i].color = empt_color

		# Use empty color if there is no charge
		else:
			slots[i].color = empt_color
