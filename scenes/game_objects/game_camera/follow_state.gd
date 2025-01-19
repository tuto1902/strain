extends State

var state_owner: Camera2D

@export var smooth_speed = 20

func enter():
	state_owner.make_current()

func handle_frame(delta):
	var player = PlayerManager.player
	if player == null:
		return
	
	var player_position = player.global_position
	state_owner.global_position = state_owner.global_position.lerp(player_position, 1.0 - exp(-delta * smooth_speed))
