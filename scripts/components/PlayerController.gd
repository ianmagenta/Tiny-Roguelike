extends Controller

class_name PlayerController

var has_turn = false
var parent: Node

func _init(new_parent):
	parent = new_parent

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
				Globals.process_command(parent, Move.new(direction))
				Globals.process_command(parent, EndTurn.new())
			else:
				Globals.process_command(parent, Bump.new(new_position))

func start_turn(_command: StartTurn):
	has_turn = true

func end_turn(_command: EndTurn):
	has_turn = false
