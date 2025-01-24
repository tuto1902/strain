@tool class_name Level
extends VBoxContainer

@export var level_index: int = 1
@export var level_name: String = ""
@export var level_icon: AtlasTexture

@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect
@onready var player_anchor: Marker2D = $PlayerAnchor

@export var level_left: Level
@export var level_right: Level
@export var level_up: Level
@export var level_down: Level

func _ready():
	label.text = level_name
	if level_icon != null:
		texture_rect.texture = level_icon

func _process(_delta):
	if Engine.is_editor_hint():
		label.text = level_name
		if level_icon != null:
			texture_rect.texture = level_icon
