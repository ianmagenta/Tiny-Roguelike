tool
extends Resource
class_name Component

signal component_event_emitted(name, data)
signal component_freed(self_reference)
signal free_entity

var priority = 1

func get_callback_list():
	return []

func added_to_entity(entity):
	pass

func removed_from_entity(entity):
	pass

func emit_event(name, data=null):
	emit_signal("component_event_emitted", name, data)

func free():
	emit_signal("component_freed", self)
	.free()
