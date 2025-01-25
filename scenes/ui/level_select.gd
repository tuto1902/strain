extends Control

@export var start_level: Level
@onready var player_icon: Sprite2D = $PlayerIcon
@onready var level_select_sfx = $LevelSelectSfx
@onready var level_confirm_sfx = $LevelConfirmSfx

var current_level: Level
var icon_tween: Tween

func _ready():
	player_icon.global_position = start_level.player_anchor.global_position
	current_level = start_level

func _input(event):
	if icon_tween and icon_tween.is_running():
		return
	if event.is_action_pressed("ui_accept"):
		on_level_cleared()
	
	if event.is_action_pressed("ui_left") and current_level.level_left != null and current_level.level_left.level_status == "Unlocked":
		current_level = current_level.level_left
	elif event.is_action_pressed("ui_right") and current_level.level_right != null and current_level.level_right.level_status == "Unlocked":
		current_level = current_level.level_right
	elif event.is_action_pressed("ui_up") and current_level.level_up != null and current_level.level_up.level_status == "Unlocked":
		current_level = current_level.level_up
	elif event.is_action_pressed("ui_down") and current_level.level_down != null and current_level.level_down.level_status == "Unlocked":
		current_level = current_level.level_down
	else:
		return
	
	icon_tween = get_tree().create_tween()
	icon_tween.tween_property(player_icon, "global_position", current_level.player_anchor.global_position, 0.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	icon_tween.finished.connect(on_level_select)

func unlock_connected_levels():
	if current_level.level_left != null and current_level.level_left.level_status == "Locked":
		current_level.level_left.unlock()
	if current_level.level_right != null and current_level.level_right.level_status == "Locked":
		current_level.level_right.unlock()
	if current_level.level_up != null and current_level.level_up.level_status == "Locked":
		current_level.level_up.unlock()
	if current_level.level_down != null and current_level.level_down.level_status == "Locked":
		current_level.level_down.unlock()

func on_level_cleared():
	current_level.level_cleared()
	level_confirm_sfx.play()
	unlock_connected_levels()

func on_level_select():
	level_select_sfx.play()
