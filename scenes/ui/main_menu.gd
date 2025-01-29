extends CanvasLayer

@onready var start_game_button = $MarginContainer/PanelContainer/VBoxContainer/StartGameButton
@onready var quit_button = $MarginContainer/PanelContainer/VBoxContainer/QuitButton

func _ready():
	start_game_button.pressed.connect(on_start_game_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)


func on_start_game_button_pressed():
	Global.game_manager.change_gui_scene("res://scenes/ui/level_select.tscn")


func on_quit_button_pressed():
	get_tree().quit()
