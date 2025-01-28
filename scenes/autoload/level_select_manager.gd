extends Node

var level_state: Dictionary = {}

func _ready():
	pass
	#Global.level_select_manager = self


func update_level_status(level_id: String, status: String):
	if level_state.has(level_id):
		level_state[level_id]["status"] = status
	else:
		level_state[level_id] = {
			"status": status,
		}


func set_level_as_current(level_id: String, level_status: String):
	level_state[level_id] = {
		"is_current": true,
		"status": level_status
	}


func set_level_as_not_current(level_id: String, level_status: String):
	level_state[level_id] = {
		"is_current": false,
		"status": level_status
	}


func get_level_status(level_id) -> String:
	if level_state.has(level_id) and level_state[level_id].has("status"):
		return level_state[level_id]["status"]
	return "Locked"


func is_current_level(level_id) -> bool:
	if level_state.has(level_id) and level_state[level_id].has("is_current"):
		return level_state[level_id]["is_current"]
	return false


func reset():
	level_state = {}
