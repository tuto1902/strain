class_name BaseAbility extends Resource

@export var ability_scene: PackedScene
@export var stats: AbilityStats
@export var upgrade_pool: Array[AbilityUpgrade]

var current_upgrades = {}
