extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

signal player_dead
const JUMP_VELOCITY = -450.0

var alive: bool = true
var can_move: bool = false

func _physics_process(delta: float) -> void:
	if !can_move:
		return
	
	if get_slide_collision_count() > 0:
		kill()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if alive:
		if velocity.y > 0:
			animation.play("falling")
		else:
			animation.play("jumping")
	
	move_and_slide()

func toggle_movent():
	can_move = !can_move

func jump():
	if alive:
		velocity.y = JUMP_VELOCITY

func kill():
	animation.play("dead")
	alive = false
	emit_signal("player_dead")
