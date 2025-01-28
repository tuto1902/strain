extends CanvasLayer

@export var arena_time_manager: ArenaTimeManager
@onready var time = $MarginContainer/TimeLabel

func _process(_delta):
	var time_left = arena_time_manager.get_time_left() as int
	var minutes_left = floor(time_left/60)
	var seconds_left = time_left % 60
	time.text = str(minutes_left) + ":" + "%2d" % seconds_left
