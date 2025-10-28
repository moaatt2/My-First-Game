extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Ran into jump")
	if body.has_method("add_charge"):
		body.add_charge("jump")
		queue_free()
