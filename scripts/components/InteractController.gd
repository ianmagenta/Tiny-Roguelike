extends Node

class_name InteractController

func _init(parent):
	parent.add_to_group("Interact")

func interact(command: Interact):
	command.receiver.resource.behavior.execute(command)
