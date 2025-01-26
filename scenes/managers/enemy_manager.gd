class_name EnemyManager extends Node

var current_enemy_level = 1

@export var spawn_radius: int = 350

@export var enemy_pool: Array[BasicEnemy]

@export var enemy_stats = {
	"level_1": {
		"health_multiplier": 0.0,
		"speed_multiplier": 0.0
	},
	"level_2": {
		"health_multiplier": 0.1,
		"speed_multiplier": 0.05
	},
	"level_3": {
		"health_multiplier": 0.15,
		"speed_multiplier": 0.10
	}
}


func _on_spawn_timer_timeout():
	var player = PlayerManager.player
	if player == null:
		push_error("Mising player")
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0.0, TAU))
	var spawn_postition = player.global_position + (random_direction * spawn_radius)
	var chosen_enemy = enemy_pool.pick_random() as BasicEnemy
	if chosen_enemy == null:
		push_error("Enemy pool is empty")
		return
	var enemy_scene = chosen_enemy.enemy_scene
	if enemy_scene == null:
		push_error("Missing enemy scene in resource")
		return
	var enemy_instance = enemy_scene.instantiate() as Node2D
	var current_enemy_stats = enemy_stats["level_" + str(current_enemy_level)]
	if current_enemy_stats:
		enemy_instance.health_multiplier = current_enemy_stats["health_multiplier"]
		enemy_instance.speed_multiplier = current_enemy_stats["speed_multiplier"]
	
	var entities_layer = get_tree().get_first_node_in_group("EntitiesLayer")
	
	entities_layer.add_child(enemy_instance)
	enemy_instance.global_position = spawn_postition
