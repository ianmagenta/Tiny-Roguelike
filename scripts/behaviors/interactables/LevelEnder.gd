func execute(command: Interact):
	Globals.process_command(command.interacting_entity, LeaveLevel.new())
