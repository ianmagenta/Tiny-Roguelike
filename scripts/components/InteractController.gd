extends Node

class_name InteractController

var parent
var interact_code

func _init(new_parent):
	parent = new_parent
	interact_code = parent.resource.behavior.code.new()

func _ready():
	parent.add_to_group("Interact")

func interact(interacting_entity):
	interact_code.execute(parent, interacting_entity)
