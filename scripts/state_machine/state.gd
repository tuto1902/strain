class_name State extends Node

signal state_changed(new_state: State)

var state_machine: Node

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
func handle_frame(_delta) -> void:
	pass

# Called every physics frame
func handle_physics_frame(_delta) -> void:
	pass

# Update blend position for state's animation
func update_animation_blend_position():
	pass

func update_state_animation():
	pass
