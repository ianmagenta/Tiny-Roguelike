extends Node
class_name NodeComponent

signal emit_event(event_name, data)
signal queue_parent_free

func get_event_list():
	return []

func emit_event(event_name, data):
	emit_signal("emit_event", event_name, data)

func added_to_parent(parent: Entity):
	pass

func removed_from_parent(parent: Entity):
	pass
