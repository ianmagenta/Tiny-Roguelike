extends Interactables

class_name LevelEnder

func interact(interacting_entity: Entity):
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
