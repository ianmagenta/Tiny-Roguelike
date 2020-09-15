extends Interactable

class_name LevelEnder

func interact(interacting_entity: Entity):
	if interacting_entity.is_in_group("PC"):
		var turn_manager = parent.scene.get_parent().get_node("TurnManager")
		turn_manager.stop()
		yield(turn_manager, "turn_loop_ended")
		parent.scene.level += 1
		turn_manager.start()
