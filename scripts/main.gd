extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var texture_tap_left: Sprite2D = $LayerUI/TextureTapLeft
@onready var texture_tap_right: Sprite2D = $LayerUI/TextureTapRight

var game_started: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_touch_area_touched() -> void:
	if !game_started:
		game_started = true
		player.visible = true
		player.toggle_movent()
		texture_tap_left.visible = false
		texture_tap_right.visible = false
	else:
		player.jump()
