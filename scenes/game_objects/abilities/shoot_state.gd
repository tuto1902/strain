extends State

var state_owner: Bullet

func handle_frame(delta):
	state_owner.global_position += state_owner.direction_to_target * state_owner.stats.speed * delta
