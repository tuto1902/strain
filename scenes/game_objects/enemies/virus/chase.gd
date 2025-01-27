extends State

var state_owner: CharacterBody2D
var speed_multiplier: float = 0.0

@export var max_speed = 45

func enter():
	if "speed_multiplier" in state_owner:
		speed_multiplier = state_owner.speed_multiplier

func handle_frame(delta) -> void:
	var direction = get_direction_to_player()
	state_owner.velocity = direction * (max_speed + (max_speed * speed_multiplier) )
	state_owner.move_and_slide()

func get_direction_to_player():
	var player = PlayerManager.player
	if player != null:
		return (player.global_position - state_owner.global_position).normalized()
	return Vector2.ZERO
