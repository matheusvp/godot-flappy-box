extends Area2D

const SPEED: int = 180
const direction = Vector2.LEFT

var velocity = Vector2.ZERO
var did_emit: bool = false

signal colided_with_player

func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	position += velocity * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("colided_with_player")
		#queue_free()
