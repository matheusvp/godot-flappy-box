extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var label_score: Label = $LayerUI/LabelScore
@onready var label_gameover: Label = $LayerUI/LabelGameover
@onready var ground: StaticBody2D = $Ground
@onready var saw_spawner: Timer = $SawSpawner
@onready var button_restart: Button = $LayerUI/ButtonRestart
@onready var button_credits: Button = $LayerUI/ButtonCredits
@onready var touch_sprite: AnimatedSprite2D = $TouchSprite
@onready var title_art: Sprite2D = $TitleArt


var game_started: bool = false
var is_game_over: bool = false
var score: int = 0
var saw_node = preload("res://scenes/saw.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label_score.text = str(score)


func _on_touch_area_touched() -> void:
	if !game_started:
		game_start()
	else:
		player.jump()

func _on_clear_saws_score_up() -> void:
	if !is_game_over:
		score += 1

func _on_saw_colided_with_player() -> void:
	player.kill()
	
func _on_player_player_dead() -> void:
	game_over()

func game_start():
	player.visible = true
	label_score.visible = true
	touch_sprite.queue_free()
	game_started = true
	title_art.queue_free()
	player.toggle_movent()
	saw_spawner.start(2)

func game_over():
	is_game_over = true
	ground.stop_anim()
	saw_spawner.stop()
	button_restart.visible = true
	button_credits.visible = true
	label_gameover.visible = true
	

func _on_saw_spawner_timeout() -> void:
	var new_saw = saw_node.instantiate()
	new_saw.scale = Vector2(2, 2)
	new_saw.position = Vector2(490, randi_range(47,570))
	new_saw.connect("colided_with_player", _on_saw_colided_with_player)
	call_deferred("add_child", new_saw)


func _on_button_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_button_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
