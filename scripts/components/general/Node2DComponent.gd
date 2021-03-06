extends Node2D
class_name Node2DComponent

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
