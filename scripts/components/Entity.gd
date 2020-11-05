extends Node2D
class_name Entity

var _event_map = {}

var grid_position: Vector2 = Vector2(0,0) setget _set_grid_position

func _ready():
	for component in get_children():
		_register_component(component)

func _set_grid_position(new_grid_position):
	Globals.entity_map.erase(grid_position)
	grid_position = new_grid_position
	position = Globals.grid_to_world(grid_position)
	Globals.entity_map[grid_position] = self

func _register_component(component):
	_register_component_events(component)
	component.connect("emit_event", self, "emit_event")
	component.connect("queue_parent_free", self, "queue_free")
	component.added_to_parent(self)

func _register_component_events(component):
	for callback in component.get_event_list():
		if _event_map.has(callback):
			_event_map[callback].push_front(component)
		else:
			_event_map[callback] = [component]

func add_child(node: Node, legible_unique_name=false):
	.add_child(node, legible_unique_name)
	_register_component(node)

func remove_child(node: Node):
	.remove_child(node)
	node.removed_from_parent(self)

func queue_free():
	emit_event("parent_freed")
	.queue_free()

func emit_event(event_name: String, data=null):
	for component in _event_map.get(event_name, []):
		component.call(event_name, data)
