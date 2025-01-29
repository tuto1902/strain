class_name ArenaTimeManager extends Node

@onready var timer = $Timer

@export var victory_screen_scene: PackedScene
@export var game_over_screen_scene: PackedScene

var current_tilemap_bounds: Array[Vector2]

func _ready():
	timer.timeout.connect(on_timer_timeout)
	GameEvents.player_died.connect(on_player_died)

func get_time_left():
	return timer.time_left


func on_timer_timeout():
	var victory_screen_instance = victory_screen_scene.instantiate()
	add_child(victory_screen_instance)


func on_player_died():
	var game_over_screen_instance = game_over_screen_scene.instantiate()
	add_child(game_over_screen_instance)
