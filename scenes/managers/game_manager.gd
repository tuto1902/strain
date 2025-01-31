class_name GameManager extends Node

@onready var arena = $ArenaScene
@onready var gui = $GUI

var current_gui_scene: Control
var current_arena_scene: Node2D

func _ready():
	Global.game_manager = self
	current_gui_scene = $GUI/MainMenu

func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false):
	if current_arena_scene != null:
		current_arena_scene.queue_free()
	
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free()
		elif keep_running:
			current_gui_scene.visible = false
		else:
			gui.remove_child(current_gui_scene)
	
	var new_gui_scene = load(new_scene).instantiate() as Control
	gui.add_child(new_gui_scene)
	current_gui_scene = new_gui_scene

func change_arena_scene(new_scene: String, delete: bool = true, keep_running: bool = false):
	if current_gui_scene != null:
		current_gui_scene.queue_free()
	
	if current_arena_scene != null:
		if delete:
			current_arena_scene.queue_free()
		elif keep_running:
			current_arena_scene.visible = false
		else:
			arena.remove_child(current_arena_scene)
	
	var new_arena_scene = load(new_scene).instantiate() as Node2D
	arena.add_child(new_arena_scene)
	current_arena_scene = new_arena_scene

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		change_gui_scene("res://scenes/ui/main_menu.tscn")
