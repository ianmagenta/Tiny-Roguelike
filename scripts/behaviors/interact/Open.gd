func execute(parent: Entity, interacting_entity: Entity):
	parent.queue_free()
	Globals.message_log.add_message(interacting_entity.get_bbcode_name() + " opened " + parent.get_bbcode_name(false) + ".")
