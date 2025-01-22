class_name HealthComponent extends Node

signal death

@export var max_healt: float = 10

var current_health: float

func _ready():
	current_health = max_healt

func take_damage(damage):
	current_health = max(current_health - damage, 0)
	Callable(check_death).call_deferred()

func check_death():
	if current_health == 0:
		death.emit()
		owner.queue_free()
