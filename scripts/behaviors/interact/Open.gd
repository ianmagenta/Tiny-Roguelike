func execute(ic_parent: Node, interacting_entity: Node):
	ic_parent.queue_free()
	emit_message(ic_parent.resource, interacting_entity.resource)

func emit_message(ic_resource: Actor, ie_resource: Actor):
	if ie_resource is PlayerCharacter:
		Globals.message_log.add_message(ie_resource.get_fp_bbcode_name() + " opened " + ic_resource.get_bbcode_name(false))
	else:
		Globals.message_log.add_message(ie_resource.get_bbcode_name() + " opened " + ic_resource.get_bbcode_name(false))
