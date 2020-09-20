extends Node2D

class_name AiController

onready var parent: Entity = get_parent()
onready var visual: Visual = parent.get_node("Visual")

func _ready():
	parent.add_to_group("AI")
