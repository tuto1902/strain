extends Node

signal ability_upgrade_added(ability: BaseAbility, upgrade: AbilityUpgrade)
signal player_died
signal tilemap_bounds_changed(bounds: Array[Vector2])

func emit_ability_upgrade_added(ability: BaseAbility, upgrade: AbilityUpgrade):
	ability_upgrade_added.emit(ability, upgrade)


func emit_player_died():
	player_died.emit()


func emit_tilemap_bounds_changed(bounds: Array[Vector2]):
	tilemap_bounds_changed.emit(bounds)
