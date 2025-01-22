class_name HurtBoxComponent extends Area2D

@export var health_component: HealthComponent
@onready var hurt_buffer = $HurtBuffer

var hit: bool = false

func _ready():
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D):
	if hit and hurt_buffer.time_left > 0:
		return
	
	if hurt_buffer.is_stopped():
		hurt_buffer.start()
		hit = true
	
	if not area is HitBoxComponent:
		return
	
	if health_component == null:
		return
	
	var hit_box = area as HitBoxComponent
	
	health_component.take_damage(hit_box.damage)
