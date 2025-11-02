extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Ran into dash")
	if body.has_method("add_charge"):
		var x = self.position.x
		var y = self.position.y
		body.add_charge(["dash", x, y])
		queue_free()
