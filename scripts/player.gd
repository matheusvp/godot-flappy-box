extends CharacterBody2D

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var no_jump_timer = $NoJumpTimer

signal player_dead
const JUMP_VELOCITY = -450.0

var alive: bool = true
var can_move: bool = false
var jump_enabled: bool = true

func _physics_process(delta: float) -> void:
	if !can_move:
		return
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("ceiling"):
			jump_enabled = false
			no_jump_timer.start()
			modulate = Color(0.9, 0.4, 0.4)
			#TODO PLAY AUDIO
		else:
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
	if alive and jump_enabled:
		velocity.y = JUMP_VELOCITY

func kill():
	animation.play("dead")
	alive = false
	emit_signal("player_dead")

func _on_no_jump_timer_timeout():
	jump_enabled = true
	modulate = Color(1, 1, 1)
