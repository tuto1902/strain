extends Node

signal ability_upgrade_added(ability: BaseAbility, upgrade: AbilityUpgrade)
signal player_died

func emit_ability_upgrade_added(ability: BaseAbility, upgrade: AbilityUpgrade):
	ability_upgrade_added.emit(ability, upgrade)

func emit_player_died():
	player_died.emit()
