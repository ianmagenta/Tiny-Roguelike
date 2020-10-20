extends Node2D

class_name AiController

var turn_action
var ai_code
var pointer = Pointer.new()

func _init(parent):
	add_child(pointer)
	parent.add_to_group("AI")
	ai_code = parent.resource.behavior.new()

func pre_turn(command: PreTurn):
	turn_action = ai_code.execute(command)
	pointer.update_action(turn_action)

func start_turn(_command: StartTurn):
	if turn_action:
		Globals.process_command(turn_action)
