class_name Bullet extends Ability

@onready var hit_box = $HitBox
@onready var sfx_player = $BulletSound

@export var state_machine: StateMachine

func _ready():
	hit_box.damage = stats.damage
	sfx_player.pitch_scale = randf_range(0.9, 1.2)
	state_machine.init(self)

func _process(delta):
	state_machine.handle_frame(delta)
