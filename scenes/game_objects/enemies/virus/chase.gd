extends State

var state_owner: CharacterBody2D

@export var max_speed = 45

func handle_frame(delta) -> void:
	var direction = get_direction_to_player()
	state_owner.velocity = direction * max_speed
	state_owner.move_and_slide()

func get_direction_to_player():
	var player = PlayerManager.player
	if player:
		return (player.global_position - state_owner.global_position).normalized()
	return Vector2.ZERO
