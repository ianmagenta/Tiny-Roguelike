extends NodeComponent
class_name PlayerController

var has_turn = false

func _unhandled_input(event):
	if has_turn:
		var direction: Vector2
		if event.is_action_pressed("ui_up"):
			direction = Vector2(0, -1)
		elif event.is_action_pressed("ui_right"):
			direction = Vector2(1, 0)
		elif event.is_action_pressed("ui_down"):
			direction = Vector2(0, 1)
		elif event.is_action_pressed("ui_left"):
			direction = Vector2(-1, 0)
		if direction:
			var new_position = parent.grid_position + direction
			if !Globals.space_is_wall(new_position):
				emit_event("move", {"direction": direction})
				emit_event("end_turn")
				# Enemy Turn
				emit_event("start_turn")

func start_turn(_data):
	has_turn = true

func end_turn(_data):
	has_turn = false

func moved(data: Dictionary):
	Events.emit_signal("player_moved", Globals.grid_to_world(data.grid_position))

func get_entity_name(data: Dictionary):
	data["entity_name"] = "You"
	data["article"] = ""

func get_event_handlers():
	return ["start_turn", "end_turn", "moved", "get_entity_name"]

func get_event_emitters():
	return ["move"]
