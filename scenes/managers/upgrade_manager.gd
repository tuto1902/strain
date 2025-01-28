extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var ability_upgrade_scene: PackedScene

func on_show_ability_upgrade_screen(ability: BaseAbility):
	
	var  upgrade_screen_instance = ability_upgrade_scene.instantiate() as AbilityUpgradeScreen
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades(ability)
	upgrade_screen_instance.ability_upgrade_selected.connect(apply_upgrade)


func apply_upgrade(ability: BaseAbility, upgrade: AbilityUpgrade):
	var has_upgrade = ability.current_upgrades.has(upgrade.id)
	
	if not has_upgrade:
		ability.current_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		ability.current_upgrades[upgrade.id]["quantity"] += 1
	
	print(ability.current_upgrades)
	GameEvents.emit_ability_upgrade_added(ability, upgrade)
