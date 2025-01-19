extends State

var state_owner: CharacterBody2D

@export var max_speed = 100
@export var acceleration_smoothing = 25

@onready var idle = $"../Idle"

func handle_frame(delta) -> void:
	var direction = get_movement_vector()
	if !direction:
		state_changed.emit(idle)
		return
	var target_velocity = direction * max_speed
	state_owner.velocity = state_owner.velocity.lerp(target_velocity, 1 - exp(-delta * acceleration_smoothing))
	state_owner.move_and_slide()

func get_movement_vector():
	var movement_vector = Vector2.ZERO
	movement_vector = Input.get_vector("move_left","move_right","move_up","move_down")
	return movement_vector
