class_name Player 
extends CharacterBody2D

@export var state_machine: StateMachine
@onready var collision_area = $CollisionArea
@onready var damage_timer = $DamageTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar

var colliding_bodies: int = 0

func _ready():
	PlayerManager.player = self
	update_health_bar()
	health_component.death.connect(on_death)
	health_component.health_changed.connect(on_health_changed)
	collision_area.body_entered.connect(on_body_entered)
	collision_area.body_exited.connect(on_body_exited)
	damage_timer.timeout.connect(on_damage_timer_timeout)
	state_machine.init(self)


func _physics_process(delta: float) -> void:
	state_machine.handle_physics_frame(delta)


func _process(delta: float) -> void:
	state_machine.handle_frame(delta)


func deal_damage():
	if colliding_bodies == 0 || !damage_timer.is_stopped():
		return
	health_component.take_damage(1)
	damage_timer.start()
	print(health_component.current_health)


func update_health_bar():
	health_bar.value = health_component.get_health_percent()

func on_body_entered(other_body: Node2D):
	colliding_bodies += 1
	deal_damage()


func on_body_exited(other_body: Node2D):
	colliding_bodies -= 1


func on_damage_timer_timeout():
	deal_damage()


func on_death():
	#TO-DO: Show the Game Over screen at this point
	queue_free()
	#get_tree().paused = true


func on_health_changed():
	update_health_bar()
