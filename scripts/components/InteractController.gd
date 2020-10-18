extends Node

class_name InteractController

func _init(parent):
	parent.add_to_group("Interact")

func interact(command: Interact):
	var resource = command.receiver.resource
	var message = resource.message
	if message:
		message.emit(command.invoker, command.receiver)
	for cmd in resource.receiver_behavior:
		cmd.invoker = command.invoker
		cmd.receiver = command.receiver
		Globals.process_command(cmd)
	for cmd in resource.invoker_behavior:
		cmd.invoker = command.receiver
		cmd.receiver = command.invoker
		Globals.process_command(cmd)
