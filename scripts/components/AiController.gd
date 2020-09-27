extends Node

class_name AiController

var turn_action
var parent
var ai_code

func _init(new_parent):
	parent = new_parent
	ai_code = parent.resource.behavior.code.new()

func _ready():
	parent.add_to_group("AI")

func pre_turn():
	turn_action = ai_code.execute(self)

func start_turn():
	if turn_action:
		parent.command(turn_action)
