class_name ArenaTilemap extends TileMapLayer

func _ready():
	GameEvents.emit_tilemap_bounds_changed(get_tilemap_bounds())


func get_tilemap_bounds() -> Array[Vector2]: 
	var bounds: Array[Vector2] = [
		# Top Left
		Vector2(get_used_rect().position * rendering_quadrant_size),
		# Bottom Right
		Vector2(get_used_rect().end * rendering_quadrant_size)
	]
	
	return bounds
