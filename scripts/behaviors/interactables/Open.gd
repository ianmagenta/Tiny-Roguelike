static func execute(command: Interact):
	Globals.message_log.add_message(command.invoker.get_bbcode_name() + " opened " + command.receiver.get_bbcode_name() + ".")
	Globals.process_command(Destroy.new(command.invoker, command.receiver))
