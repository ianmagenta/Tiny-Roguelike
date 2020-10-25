extends Controller

onready var parent = get_parent()

func interact(command: Interact):
	Globals.process_command(command.interacting_entity, LeaveLevel.new(parent))
