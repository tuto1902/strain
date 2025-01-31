extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	audio_stream_player.pitch_scale = randf_range(0.9, 1.2)
	audio_stream_player.finished.connect(on_audio_stream_player_finished)
	audio_stream_player.play()

func on_audio_stream_player_finished():
	queue_free()
