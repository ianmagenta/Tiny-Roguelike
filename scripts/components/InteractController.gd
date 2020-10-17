extends Node

class_name InteractController

var interact_code

func _init(parent):
	parent.add_to_group("Interact")
	interact_code = parent.resource.behavior.new()


func interact(command: Interact):
	interact_code.execute(command.receiver, command.invoker)
