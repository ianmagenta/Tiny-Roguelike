tool
extends Node2D

class_name Entity

signal end_turn

export var base_health = 1
export var base_damage = 1

var num_commands = 0
var signal_end_turn = false
var grid_position = Vector2(0, 0) setget _set_grid_position

onready var scene = get_parent()

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
	if signal_end_turn and num_commands == 0:
		signal_end_turn = false
		emit_signal("end_turn")

func end_turn():
	signal_end_turn = true

func destroy():
	remove_from_group("Entity")
	queue_free()

func move(direction):
	var new_grid_position = grid_position + direction
	if _valid_move(new_grid_position):
#		get_parent().add_child(Shadow.new($Visual, position))
		self.grid_position = new_grid_position
		command(EndTurn.new())

func _valid_move(new_grid_position: Vector2):
	if Globals.space_is_wall(new_grid_position):
		command(Bump.new(new_grid_position))
		return false
	for entity in Globals.entity_group:
		if entity and entity.grid_position == new_grid_position:
			if entity.is_in_group("Interact"):
#				entity.command(Interact.new(entity.grid_position - grid_position))
				command(EndTurn.new())
			elif is_in_group("AI") and entity.is_in_group("AI"):
				command(Bump.new(new_grid_position))
			else:
				command(Attack.new(entity, entity.grid_position - grid_position))
				command(EndTurn.new())
			return false
	return true

func bump(target_position):
	pass

func attack(target, attack_vector, damage):
	damage += base_damage
