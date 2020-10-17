func execute(parent: Node, interacting_entity: Node):
	if interacting_entity.is_in_group("PC"):
		var turn_manager = parent.scene.get_parent().get_node("TurnManager")
		turn_manager.stop()
		yield(turn_manager, "turn_loop_ended")
		parent.scene.level += 1
		turn_manager.start()
	elif interacting_entity.is_in_group("AI"):
		var next_level_enemies = parent.scene.level_props[parent.scene.level + 1].enemies
		var enemy_scene = load(interacting_entity.filename)
		if !(enemy_scene in next_level_enemies):
			next_level_enemies.append(enemy_scene)
		interacting_entity.queue_free()
	emit_message(parent.resource, interacting_entity.resource)

func emit_message(ic_resource: Actor, ie_resource: Actor):
	if ie_resource is PlayerCharacter:
		Globals.message_log.add_message(ie_resource.get_fp_bbcode_name() + " decended " + ic_resource.get_bbcode_name(false) + "...")
	else:
		Globals.message_log.add_message(ie_resource.get_bbcode_name() + " decended " + ic_resource.get_bbcode_name(false) + "...")
