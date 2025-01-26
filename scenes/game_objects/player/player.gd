class_name Player 
extends CharacterBody2D

@export var state_machine: StateMachine

func _ready():
	PlayerManager.player = self
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.handle_physics_frame(delta)

func _process(delta: float) -> void:
	state_machine.handle_frame(delta)
