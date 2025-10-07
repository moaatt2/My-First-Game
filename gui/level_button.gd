extends Button

var original_size := scale
var grow_size := Vector2(1.1, 1.1)

func _on_level_button_mouse_entered() -> void:
	grow_button(grow_size, .1)

func _on_level_button_mouse_exited() -> void:
	grow_button(original_size, .1)

func grow_button(end_size: Vector2, duration:float) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", end_size, duration)
