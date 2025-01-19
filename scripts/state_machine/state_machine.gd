class_name StateMachine extends Node

var states: Array[State]
var prev_state: State = null
var current_state: State = null

func _ready():
	# Disable the node by default. This will be enabled after
	# a new state is selected
	process_mode = Node.PROCESS_MODE_DISABLED

func handle_frame(delta):
	# Update blend positions for all animations
	update_animation_blend_positions()
	current_state.handle_frame(delta)

func handle_physics_frame(delta):
	current_state.handle_physics_frame(delta)

func init(state_owner: Node2D):
	states = []
	for node in get_children():
		if node is State:
			node.state_owner = state_owner
			node.state_machine = self
			states.append(node)

	if states.size() == 0:
		return

	# Connect to the state change signal and initialize
	# each state
	for state in states:
		state.state_changed.connect(change_state)
		state.init()
	
	# Default to the first state in the list. Should be Idle
	change_state(states[0])

	process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state: State):
	if new_state == null or new_state == current_state:
		return

	if current_state != null:
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state

	current_state.enter()

func update_animation_blend_positions():
	for state in states:
		state.update_animation_blend_position()
