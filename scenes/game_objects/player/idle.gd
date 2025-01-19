extends State

var state_owner: CharacterBody2D

@export var deceleration_smoothing = 25

@onready var move_state = $"../Move"

func handle_frame(delta) -> void:
	var direction = get_movement_vector()
	# The player is trying to move. Transition to the Move state
	if direction:
		state_changed.emit(move_state)
		return
	
	var target_velocity = Vector2.ZERO
	state_owner.velocity = state_owner.velocity.lerp(target_velocity, 1 - exp(-delta * deceleration_smoothing))
	state_owner.move_and_slide()

func get_movement_vector():
	var movement_vector = Vector2.ZERO
	movement_vector = Input.get_vector("move_left","move_right","move_up","move_down")
	return movement_vector
