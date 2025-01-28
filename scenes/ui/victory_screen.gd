extends CanvasLayer

@onready var continue_button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/ContinueButton
@onready var quit_button = $MarginContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton

func _ready():
	get_tree().paused = true
	continue_button.pressed.connect(on_continue_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)


func on_continue_button_pressed():
	get_tree().paused = false
	Global.game_manager.change_gui_scene("res://scenes/ui/level_select.tscn")


func on_quit_button_pressed():
	get_tree().quit()
