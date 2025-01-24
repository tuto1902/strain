extends Control

@export var start_level: Level
@onready var player_icon: Sprite2D = $PlayerIcon

var current_level: Level
var icon_tween: Tween

func _ready():
	player_icon.global_position = start_level.player_anchor.global_position
	current_level = start_level

func _input(event):
	if icon_tween and icon_tween.is_running():
		return
	
	if event.is_action_pressed("ui_left") and current_level.level_left != null:
		current_level = current_level.level_left
	elif event.is_action_pressed("ui_right") and current_level.level_right != null:
		current_level = current_level.level_right
	elif event.is_action_pressed("ui_up") and current_level.level_up != null:
		current_level = current_level.level_up
	elif event.is_action_pressed("ui_down") and current_level.level_down != null:
		current_level = current_level.level_down
	
	icon_tween = get_tree().create_tween()
	icon_tween.tween_property(player_icon, "global_position", current_level.player_anchor.global_position, 0.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	#player_icon.global_position = current_level.player_anchor.global_position
