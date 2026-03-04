extends Area2D

signal score_up

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("saws"):
		area.queue_free()
		emit_signal("score_up")
