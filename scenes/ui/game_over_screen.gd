extends CanvasLayer

@onready var restart_button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/RestartButton
@onready var quit_button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton

func _ready():
	get_tree().paused = true
	restart_button.pressed.connect(on_restart_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)


func on_restart_button_pressed():
	get_tree().paused = false
	LevelSelectManager.reset()
	Global.game_manager.change_gui_scene("res://scenes/ui/level_select.tscn")


func on_quit_button_pressed():
	get_tree().quit()
