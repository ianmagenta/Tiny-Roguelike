extends Command
class_name EndLevel

func _init(invoker: Node=null, receiver: Node=null).(invoker, receiver, "end_level"):
	pass

func execute():
	var scene = receiver.get_parent()
	var types = invoker.types
	if invoker.type == types.PLAYER:
		var turn_manager = scene.get_node("../TurnManager")
		turn_manager.stop()
		yield(turn_manager, "turn_loop_ended")
		scene.level += 1
		turn_manager.start()
	elif invoker.type == types.ENEMY:
		var next_level_enemies = scene.level_props[scene.level + 1].enemies
		var enemy_scene = load(invoker.resource.filename)
		if !(enemy_scene in next_level_enemies):
			next_level_enemies.append(enemy_scene)
		invoker.queue_free()
