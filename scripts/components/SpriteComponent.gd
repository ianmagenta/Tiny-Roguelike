extends Sprite
class_name SpriteComponent

signal emit_event(event_name, data)
signal queue_parent_free

func get_event_handlers():
	return []

func get_event_emitters():
	return []

func emit_event(event_name, data):
	emit_signal("emit_event", event_name, data)

func added_to_parent(parent: Entity):
	pass

func removed_from_parent(parent: Entity):
	pass
