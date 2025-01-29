extends Camera2D

@export var state_machine: StateMachine

func _ready():
	state_machine.init(self)
	GameEvents.tilemap_bounds_changed.connect(on_tilemap_bounds_changed)

func _physics_process(delta: float) -> void:
	state_machine.handle_physics_frame(delta)

func _process(delta: float) -> void:
	state_machine.handle_frame(delta)


func on_tilemap_bounds_changed(bounds: Array[Vector2]):
	update_camera_limits(bounds)

func update_camera_limits(bounds: Array[Vector2]):
	if bounds == []:
		return
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
