extends Node2D

class_name AiController

var turn_action
var parent
var ai_code
var pointer = Pointer.new(self)

func _init(new_parent):
	add_child(pointer)
	parent = new_parent
	ai_code = parent.resource.behavior.code.new()

func _ready():
	parent.add_to_group("AI")

func pre_turn():
	turn_action = ai_code.execute(self)
	pointer.update_action(turn_action)

func start_turn():
	if turn_action:
		parent.command(turn_action)
