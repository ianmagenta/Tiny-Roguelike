extends Node

func process_command(command: Command):
	command.receiver.propagate_call(command.method, [command])
