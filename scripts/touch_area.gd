extends Area2D

signal touched

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		emit_signal("touched")
