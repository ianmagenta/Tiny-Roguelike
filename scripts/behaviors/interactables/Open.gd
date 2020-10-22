func execute(parent, command: Interact):
	Globals.message_log.add_message(command.interacting_entity.get_bbcode_name() + " opened " + parent.get_bbcode_name() + ".")
	parent.queue_free()
