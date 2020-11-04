extends Node
class_name PlayerControllerNode

signal emit_event_to_resource(event_name, data)

var has_turn = true setget _set_has_turn

func _set_has_turn(new_has_turn):
	has_turn = new_has_turn

func _init():
	name = "PlayerControllerNode"

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
			_emit_event_to_resource("move", {"direction": direction})
			_emit_event_to_resource("end_turn")
#				Events.emit_signal("player_turn_ended")
			_emit_event_to_resource("start_turn")

func _emit_event_to_resource(event_name, data=null):
	emit_signal("emit_event_to_resource", event_name, data)
