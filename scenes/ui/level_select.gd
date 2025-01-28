class_name LevelSelect extends Control

@export var start_level: Level
@onready var player_icon: Sprite2D = $PlayerIcon
@onready var level_select_sfx = $LevelSelectSfx
@onready var level_confirm_sfx = $LevelConfirmSfx
@onready var upgrade_manager = $UpgradeManager
@onready var levels = $Levels

var current_level: Level
var icon_tween: Tween


func _ready():
	player_icon.global_position = start_level.player_anchor.global_position
	set_current_level(start_level)
	start_level.update_icon()
	if ! LevelSelectManager.level_state.is_empty():
		for level: Level in levels.get_children():
			level.level_status = LevelSelectManager.get_level_status(level.level_id)
			level.update_icon()
			if LevelSelectManager.is_current_level(level.level_id):
				set_current_level(level)
	move_player_to_current_level()


func _input(event):
	if icon_tween and icon_tween.is_running():
		return
	
	if event.is_action_pressed("ui_accept"):
		if current_level.level_type == "shop":
			var chosen_ability = PlayerManager.current_abilities.pick_random()
			if chosen_ability == null:
				return
			upgrade_manager.on_show_ability_upgrade_screen(chosen_ability)
			clear_current_level()
		elif current_level.level_type == "mutate":
			clear_current_level()
		else:
			clear_current_level()
			Global.game_manager.change_arena_scene("res://scenes/arenas/test_arena.tscn")
	
	if event.is_action_pressed("ui_left") and current_level.level_left != null and current_level.level_left.level_status == "Unlocked":
		set_current_level(current_level.level_left)
		tween_player_to_current_level()
	elif event.is_action_pressed("ui_right") and current_level.level_right != null and current_level.level_right.level_status == "Unlocked":
		set_current_level(current_level.level_right)
		tween_player_to_current_level()
	elif event.is_action_pressed("ui_up") and current_level.level_up != null and current_level.level_up.level_status == "Unlocked":
		set_current_level(current_level.level_up)
		tween_player_to_current_level()
	elif event.is_action_pressed("ui_down") and current_level.level_down != null and current_level.level_down.level_status == "Unlocked":
		set_current_level(current_level.level_down)
		tween_player_to_current_level()
	else:
		return


func unlock_connected_levels():
	if current_level.level_left != null and current_level.level_left.level_status == "Locked":
		current_level.level_left.unlock()
	if current_level.level_right != null and current_level.level_right.level_status == "Locked":
		current_level.level_right.unlock()
	if current_level.level_up != null and current_level.level_up.level_status == "Locked":
		current_level.level_up.unlock()
	if current_level.level_down != null and current_level.level_down.level_status == "Locked":
		current_level.level_down.unlock()


func clear_current_level():
	current_level.level_cleared()
	level_confirm_sfx.play()
	unlock_connected_levels()


func select_level():
	level_select_sfx.play()


func set_current_level(level: Level):
	if current_level != null:
		current_level.set_as_not_current()
	current_level = level
	current_level.set_as_current()


func tween_player_to_current_level():
	icon_tween = get_tree().create_tween()
	icon_tween.tween_property(player_icon, "global_position", current_level.player_anchor.global_position, 0.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	icon_tween.finished.connect(select_level)

func move_player_to_current_level():
	player_icon.global_position = current_level.player_anchor.global_position
