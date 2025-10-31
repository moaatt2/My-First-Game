extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Ran into jump")
	if body.has_method("add_charge"):
		var x = body.position.x
		var y = body.position.y
		body.add_charge(["jump", x, y])
		queue_free()
