extends Node

var player: Player

@export var current_abilities: Array[BaseAbility]

func _ready():
	if player == null:
		return
