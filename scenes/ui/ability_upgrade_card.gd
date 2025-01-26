class_name AbilityUpgradeCard extends PanelContainer

signal selected

@onready var ability_name = $VBoxContainer/AbilityName
@onready var ability_description = $VBoxContainer/AbilityDescription

func set_ability_upgrade(ability_upgrade: AbilityUpgrade):
	ability_name.text = ability_upgrade.name
	ability_description.text = ability_upgrade.description

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("ui_select"):
		selected.emit()
