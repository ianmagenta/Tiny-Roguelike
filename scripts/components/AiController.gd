extends Node

class_name AiController

var turn_action

onready var parent: Entity = get_parent()

func _ready():
	parent.add_to_group("AI")

func pre_turn():
	parent.resource.behavior.pre_turn.execute(self)
