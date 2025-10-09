extends Node2D

const LEVEL_BUTTON = preload("res://gui/level_button.tscn")

@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path) -> void:
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name)
			create_level_button('{0}/{1}'.format([dir.get_current_dir(), file_name]), file_name)
			file_name = dir.get_next()
		dir.list_dir_end()

	else:
		print('An error has occured when trying to access the path')

func create_level_button(level_path: String, level_name: String) -> void:
	var button = LEVEL_BUTTON.instantiate()
	button.text = level_name
	button.level_path = level_path
	
	print('Button made with')
	print("Level Path: ", level_path)
	print("Level Name: ", level_name)
	
	grid.add_child(button)
