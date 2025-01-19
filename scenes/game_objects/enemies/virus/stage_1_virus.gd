extends CharacterBody2D

@export var state_machine: EnemyStateMachine
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	state_machine.init(self)
	animated_sprite_2d.play("Move")

func _physics_process(delta: float) -> void:
	state_machine.handle_physics_frame(delta)

func _process(delta: float) -> void:
	state_machine.handle_frame(delta)
