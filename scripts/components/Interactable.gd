extends Node

class_name Interactables

onready var parent: Entity = get_parent()

func _ready():
	parent.add_to_group("Interact")

