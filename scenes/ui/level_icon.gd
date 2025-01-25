@tool class_name Level
extends VBoxContainer

@export var level_index: int = 1
@export var level_name: String = ""

@onready var label: Label = $Label
@onready var node_icon = $NodeIcon
@onready var player_anchor: Marker2D = $PlayerAnchor

@export var level_left: Level
@export var level_right: Level
@export var level_up: Level
@export var level_down: Level

@export_enum("Unlocked", "Locked", "Cleared") var level_status = "Unlocked"
@export var locked_icon_texture: AtlasTexture
@export var unlocked_icon_texture: AtlasTexture
@export var cleared_icon_texture: AtlasTexture

func _ready():
	label.text = level_name
	match level_status:
		"Unlocked":
			if unlocked_icon_texture:
				node_icon.texture = unlocked_icon_texture
		"Locked":
			if locked_icon_texture:
				node_icon.texture = locked_icon_texture
		"Cleared":
			if cleared_icon_texture:
				node_icon.texture = cleared_icon_texture

func _process(_delta):
	if Engine.is_editor_hint():
		label.text = level_name
		match level_status:
			"Unlocked":
				if unlocked_icon_texture:
					node_icon.texture = unlocked_icon_texture
			"Locked":
				if locked_icon_texture:
					node_icon.texture = locked_icon_texture
			"Cleared":
				if cleared_icon_texture:
					node_icon.texture = cleared_icon_texture

func unlock():
	level_status = "Unlocked"
	node_icon.texture = unlocked_icon_texture

func level_cleared():
	level_status = "Cleared"
	node_icon.texture = cleared_icon_texture
