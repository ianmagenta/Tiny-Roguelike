static func execute(command: Interact):
	Globals.process_command(EndLevel.new(command.invoker, command.receiver))
