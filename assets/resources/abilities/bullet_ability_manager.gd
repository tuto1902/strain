extends Node

@export var bullet_scene: PackedScene
@export var max_range: float = 150

func get_enemies_in_range(player: Player):
	var enemies = get_tree().get_nodes_in_group("Enemies")
	
	enemies = enemies.filter(func (enemy: CharacterBody2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	enemies.sort_custom(func(a: CharacterBody2D, b: CharacterBody2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	return enemies

func _on_shoot_timer_timeout():
	var player = PlayerManager.player
	if player == null:
		push_error("Missing player")
		return
	
	var enemies = get_enemies_in_range(player)
	
	if enemies.size() == 0:
		return
	
	var bullet_instance = bullet_scene.instantiate() as Bullet
	player.get_parent().add_child(bullet_instance)
	bullet_instance.global_position = player.global_position
	bullet_instance.direction_to_target = player.global_position.direction_to(enemies[0].global_position)
