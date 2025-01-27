class_name HealthComponent extends Node

signal death
signal health_changed

@export var max_healt: float = 10

var current_health: float


func _ready():
	current_health = max_healt


func take_damage(damage):
	current_health = max(current_health - damage, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()


func check_death():
	if current_health == 0:
		death.emit()


func get_health_percent():
	if current_health <= 0:
		return 0
	return min(current_health / max_healt, 1)
