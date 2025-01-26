class_name AbilityUpgradeScreen extends CanvasLayer

signal ability_upgrade_selected

@onready var card_container: HBoxContainer = $MarginContainer/CardContainer

@export var ability_upgrade_card_scene: PackedScene


func _ready():
	get_tree().paused = true


func set_ability_upgrades(ability: BaseAbility):
	var chosen_upgrade = ability.upgrade_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
	# TO-DO: Pick three random upgrades from the ability upgrade pool
	# Setting this as a single item array for testing
	var upgrades = [chosen_upgrade]
	for upgrade in upgrades:
		var card_instance = ability_upgrade_card_scene.instantiate() as AbilityUpgradeCard
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.selected.connect(on_selected.bind(ability, upgrade))
	card_container.get_child(0).grab_focus()


func on_selected(ability: BaseAbility, upgrade: AbilityUpgrade):
	ability_upgrade_selected.emit(ability, upgrade)
	get_tree().paused = false
	queue_free()
