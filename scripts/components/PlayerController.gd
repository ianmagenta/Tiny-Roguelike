extends Node

class_name PlayerController

var has_turn = false
var parent: Node

func _init(new_parent):
	parent = new_parent
	parent.add_to_group("PC")

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
				Globals.process_command(Move.new(parent, parent, direction))
			else:
				Globals.process_command(Bump.new(parent, parent, new_position))

func start_turn(_command: StartTurn):
	has_turn = true

func end_turn(_command: EndTurn):
	has_turn = false
