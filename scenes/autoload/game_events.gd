extends Node

signal ability_upgrade_added(ability: BaseAbility, upgrade: AbilityUpgrade)

func emit_ability_upgrade_adde(ability: BaseAbility, upgrade: AbilityUpgrade):
	ability_upgrade_added.emit(ability, upgrade)
