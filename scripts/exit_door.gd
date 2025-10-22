extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		print("Collison Detected")
		
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		var next_level_path = ""
		if next_level_number < 10:
			next_level_path = "res://levels/level_0" + str(next_level_number) + ".tscn"
		else:
			next_level_path = "res://levels/level_" + str(next_level_number) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
