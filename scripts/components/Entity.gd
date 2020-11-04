extends Node2D
class_name Entity

var _components: Array = []
var _event_map = {}

func _init(entity: EntityComponent):
	for component in entity.components:
		insert_component(component.duplicate())
	insert_component(preload("res://scripts/resources/Physics.gd").new())
	name = entity.resource_name

func insert_component(component: Component):
	_register_callbacks(component)
	_register_signals(component)
	component.connect("free_entity", self, "queue_free")
	if component.priority == 1:
		_components.push_front(component)
	elif component.priority == -1:
		_components.push_back(component)
	else:
		var insertion_point = floor(_components.size() / 2)
		_components.insert(insertion_point, component)
	component.added_to_entity(self)

func remove_component(component: Component):
	_un_register_component(component)
	_components.erase(component)
	component.removed_from_entity(self)

func _register_callbacks(component: Component):
	for callback in component.get_callback_list():
		if _event_map.has(callback):
			_event_map[callback].append(component)
		else:
			_event_map[callback] = [component]

func _register_signals(component: Component):
	component.connect("component_event_emitted", self, "emit_event")
	component.connect("component_freed", self, "_un_register_callbacks")

func _un_register_component(component: Component):
	_un_register_callbacks(component)
	component.disconnect("component_event_emitted", self, "emit_event")
	component.disconnect("component_freed", self, "_un_register_callbacks")	
	component.removed_from_entity(self)

func _un_register_callbacks(component: Component):
	for callback in component.get_callback_list():
		var event_map_callback_list = _event_map[callback]
		event_map_callback_list.erase(component)
		if event_map_callback_list.size() == 0:
			_event_map.erase(callback)

func emit_event(event_name, data={}):
	for component in _event_map.get(event_name, []):
		component.call(event_name, data)

func queue_free():
	emit_event("entity_freed", {"entity": self})
	.queue_free()
