func execute(parent, command: Interact):
	Globals.process_command(command.interacting_entity, LeaveLevel.new(parent))
