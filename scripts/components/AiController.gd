extends Node

class_name AiController

onready var parent = get_parent()

func _ready():
	parent.add_to_group("AI")

func destroy():
	parent.remove_from_group("AI")
