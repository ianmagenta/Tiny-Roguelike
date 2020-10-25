extends Controller

onready var parent = get_parent()

func interact(command: Interact):
	Globals.message_log.add_message(command.interacting_entity.get_bbcode_name() + " opened " + parent.get_bbcode_name(false) + ".")
	parent.queue_free()
