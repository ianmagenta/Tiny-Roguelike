extends Node
class_name NodeComponent

signal emit_event(event_name, data)

var parent: Entity

func get_event_handlers():
	return []

func get_event_emitters():
	return []

func emit_event(event_name, data=null):
	emit_signal("emit_event", event_name, data)

func added_to_parent():
	pass

func removed_from_parent():
	pass
