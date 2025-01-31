extends CharacterBody2D

var speed_multiplier: float
var health_multiplier: float

@export var state_machine: EnemyStateMachine
@export var death_fx_scene: PackedScene

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_component = $HealthComponent


func _ready():
	health_component.death.connect(on_death)
	state_machine.init(self)
	animated_sprite_2d.play("Move")


func _physics_process(delta: float) -> void:
	state_machine.handle_physics_frame(delta)


func _process(delta: float) -> void:
	state_machine.handle_frame(delta)


func on_death():
	var foreground_layer = get_tree().get_first_node_in_group("ForegroundLayer")
	if foreground_layer:
		var death_fx_instance = death_fx_scene.instantiate()
		foreground_layer.add_child(death_fx_instance)
	queue_free()
