extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		print("Collison Detected")
		
		# Get current level
		var current_scene_path = get_tree().current_scene.scene_file_path
		var current_scene_name = current_scene_path.get_file()

		# Get directory path
		var dir_path = current_scene_path.get_base_dir()
		var dir = DirAccess.open(dir_path)

		# Get list of all levels
		var files = []
		if dir:
			for file_name in dir.get_files():
				if file_name.ends_with(".tscn"):
					files.append(file_name)
				if file_name.ends_with(".tscn.remap"):
					files.append(file_name.trim_suffix(".remap"))
		files.sort()
		
		# Get index of current file
		var current_index = files.find(current_scene_name)
		if current_index + 1 < files.size():
			print("Going to next level")
			var next_scene_path = dir_path + "/" + files[current_index + 1]
			get_tree().change_scene_to_file(next_scene_path)
		else:
			print("No next level")
