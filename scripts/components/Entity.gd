tool
extends Node2D

class_name Entity

var num_commands = 0
var end_turn = false
var grid_position = Vector2(0, 0) setget _set_grid_position

func _set_grid_position(value: Vector2):
	grid_position = value
	position = Globals.grid_to_world(grid_position)

func _init():
	add_to_group("Entity")

func command(command):
	num_commands += 1
	var components = get_children()
	for component in components:
		command.execute(component)
	command.execute(self)
	num_commands -= 1
	if end_turn and num_commands == 0:
		end_turn = false
		emit_signal("end_turn")

func end_turn():
	end_turn = true

func destroy():
	remove_from_group("Entity")
