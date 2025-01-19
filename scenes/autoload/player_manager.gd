extends Node

var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		push_error("Missing Player scene")
