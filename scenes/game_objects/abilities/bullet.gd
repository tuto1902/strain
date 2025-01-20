class_name Bullet extends Node2D

var direction_to_target: Vector2

@onready var hit_box = $HitBox
@onready var sfx_player = $BulletSound

@export var stats: AbilityStats
@export var state_machine: StateMachine

func _ready():
	hit_box.damage = stats.damage
	state_machine.init(self)

func _process(delta):
	state_machine.handle_frame(delta)
