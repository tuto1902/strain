class_name AbilityManager extends Node

func _ready():
	for ability_resource: BaseAbility in PlayerManager.current_abilities:
		create_one_shot_ability_timer(ability_resource)


func get_enemies_in_range(player: Player, max_range: float):
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


func _on_ability_timer_timeout(ability_resource: BaseAbility):
	var player = PlayerManager.player
	if player == null:
		push_error("Missing player")
		return
	
	# This resets the timer at a rate defined by the ability resource
	# It is required to reset the timer since scene tree timers are
	# destroyed after they time out
	create_one_shot_ability_timer(ability_resource)
	
	var enemies = get_enemies_in_range(player, ability_resource.stats.max_range)
	
	if enemies.size() == 0:
		return
	
	var ability_instance = ability_resource.ability_scene.instantiate() as Ability
	#TO-DO: Apply abiliy upgrades once the ability instance is created
	ability_instance.stats = ability_resource.stats
	player.get_parent().add_child(ability_instance)
	var scale_increase = 0.0
	if ability_resource.current_upgrades.has("bullet_size"):
		scale_increase = ability_resource.current_upgrades["bullet_size"]["quantity"] * 0.2
		ability_instance.scale = Vector2(
			ability_resource.stats.size * (1 + scale_increase),
			ability_resource.stats.size * (1 + scale_increase),
		)
	ability_instance.global_position = player.global_position
	ability_instance.direction_to_target = player.global_position.direction_to(enemies[0].global_position)


func create_one_shot_ability_timer(ability_resource: BaseAbility):
	var rate_reduction = 0.0
	if ability_resource.current_upgrades.has("bullet_rate"):
		rate_reduction = ability_resource.current_upgrades["bullet_rate"]["quantity"] * 0.1
	var ability_rate = ability_resource.stats.rate * (1 - rate_reduction)
	get_tree().create_timer(ability_rate).timeout.connect(_on_ability_timer_timeout.bind(ability_resource))
