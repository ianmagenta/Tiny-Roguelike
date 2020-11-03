tool
extends Component
class_name PlayerController

signal move(data)
signal end_turn(data)
signal bump(data)
signal get_grid_position(data)

var has_turn = false

func _init():
	resource_name = "PlayerController"

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
			emit_signal("get_grid_position", parent_grid_position)
			var new_position = parent_grid_position + direction
			if !Globals.space_is_wall(new_position):
				emit_signal("move", {"direction": direction})
				emit_signal("end_turn")
				Events.emit_signal("player_turn_ended")
			else:
				emit_signal("bump")

func _on_start_turn_event(_data):
	has_turn = true

func _one_end_turn_event(_data):
	has_turn = false

func get_signal_list():
	return ["move", "end_turn", "bump", "get_grid_position"]

func get_callback_list():
	return ["start_turn", "end_turn"]
