class_name Bullet extends Ability

@onready var hit_box = $HitBox
@onready var sfx_player = $BulletSound

@export var state_machine: StateMachine

func _ready():
	hit_box.damage = stats.damage
	state_machine.init(self)

func _process(delta):
	state_machine.handle_frame(delta)
