func execute(parent: Node, interacting_entity: Node):
	var scene = parent.get_parent()
	if interacting_entity.is_in_group("PC"):
		var turn_manager = scene.get_node("../TurnManager")
		turn_manager.stop()
		yield(turn_manager, "turn_loop_ended")
		scene.level += 1
		turn_manager.start()
	elif interacting_entity.is_in_group("AI"):
		var next_level_enemies = scene.level_props[scene.level + 1].enemies
		var enemy_scene = load(interacting_entity.filename)
		if !(enemy_scene in next_level_enemies):
			next_level_enemies.append(enemy_scene)
		interacting_entity.queue_free()
	Globals.message_log.add_message(interacting_entity.get_bbcode_name() + " descended " + parent.get_bbcode_name(false) + "...")
