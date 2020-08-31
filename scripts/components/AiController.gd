extends Node

class_name AiController

export var ai_type : Script

onready var parent = get_parent()

func _ready():
	parent.add_to_group("AI")

func start_turn():
	if ai_type.has_method("start_turn"):
		ai_type.start_turn()

func end_turn():
	if ai_type.has_method("end_turn"):
		ai_type.end_turn()

func destroy():
	remove_from_group("PC")
	if ai_type.has_method("destroy"):
		ai_type.destroy()
	queue_free()
