class_name State extends Node

signal state_changed(new_state: State)

static var player: CharacterBody2D

static var state_machine: Node

func _ready():
	pass

func init():
	pass

# Handle state initialization
func enter():
	pass

# Handle state cleanup
func exit():
	pass

# Called every frame
func process(_delta) -> void:
	pass

# Called every physics frame
func physics(_delta) -> void:
	pass

# Handle user input events
func input(_event: InputEvent) -> void:
	pass

# Update blend position for state's animation
func update_animation_blend_position():
	pass
