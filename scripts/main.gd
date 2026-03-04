extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var texture_tap_left: Sprite2D = $LayerUI/TextureTapLeft
@onready var texture_tap_right: Sprite2D = $LayerUI/TextureTapRight
@onready var label_score: Label = $LayerUI/LabelScore
@onready var ground: StaticBody2D = $Ground
@onready var saw_spawner: Timer = $SawSpawner
@onready var button_restart: Button = $LayerUI/ButtonRestart



var game_started: bool = false
var score: int = 0
var saw_node = preload("res://scenes/saw.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label_score.text = str(score)


func _on_touch_area_touched() -> void:
	if !game_started:
		game_start()
	else:
		player.jump()

func _on_clear_saws_score_up() -> void:
	score += 1

func _on_saw_colided_with_player() -> void:
	player.kill()
	
func _on_player_player_dead() -> void:
	game_over()

func game_start():
	game_started = true
	player.visible = true
	player.toggle_movent()
	texture_tap_left.visible = false
	texture_tap_right.visible = false
	saw_spawner.start(2)

func game_over():
	var saws = get_tree().get_nodes_in_group("saws")
	for saw in saws:
		saw.queue_free()
	ground.stop_anim()
	saw_spawner.stop()
	button_restart.visible = true


func _on_saw_spawner_timeout() -> void:
	var new_saw = saw_node.instantiate()
	new_saw.scale = Vector2(2, 2)
	new_saw.position = Vector2(490, randi_range(47,570))
	new_saw.connect("colided_with_player", _on_saw_colided_with_player)
	call_deferred("add_child", new_saw)


func _on_button_restart_pressed() -> void:
	get_tree().reload_current_scene()
