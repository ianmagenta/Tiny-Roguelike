tool
extends Component
class_name PlayerController

var has_turn = false

func _init():
	resource_name = "PlayerController"
	priority = -1

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
			var parent_grid_position = {"grid_position": Vector2(0,0)}
			emit_event("get_grid_position", parent_grid_position)
			var new_position = parent_grid_position + direction
			if !Globals.space_is_wall(new_position):
				emit_event("move", {"direction": direction})
				emit_event("end_turn")
				Events.emit_event("player_turn_ended")
			else:
				emit_event("bump")

func start_turn(_data):
	has_turn = true

func end_turn(_data):
	has_turn = false

func get_signal_list():
	return ["move", "end_turn", "bump", "get_grid_position"]

func get_callback_list():
	return ["start_turn", "end_turn"]
