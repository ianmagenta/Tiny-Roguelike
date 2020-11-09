extends Node2D
class_name Entity

signal parent_freed(self_reference)

var grid_position: Vector2 = Vector2(0,0) setget _set_grid_position
var prev_direction: Vector2 = Vector2(0,0)

func _ready():
	for component in get_children():
		_register_component(component)

func _set_grid_position(new_grid_position):
	Globals.entity_map.erase(grid_position)
	grid_position = new_grid_position
	position = Globals.grid_to_world(grid_position)
	Globals.entity_map[grid_position] = self

func _register_component(component):
	_register_component_event_handlers(component)
	_register_component_event_emitters(component)
	component.parent = self
	component.connect("emit_event", self, "emit_event")
	component.added_to_parent(self)

func _register_component_event_handlers(component):
	for event_handler in component.get_event_handlers():
		if !has_user_signal(event_handler):
			add_user_signal(event_handler)
		connect(event_handler, component, event_handler)

func _register_component_event_emitters(component):
	for event_emitter in component.get_event_emitters():
		if !has_user_signal(event_emitter):
			add_user_signal(event_emitter)

func _disconnect_component(component):
	component.disconnect("emit_event", self, "emit_event")
	component.parent = null
	for event_handler in component.get_event_handlers():
		disconnect(event_handler, component, event_handler)
	component.removed_from_parent(self)

func add_child(node: Node, legible_unique_name=false):
	.add_child(node, legible_unique_name)
	_register_component(node)

func remove_child(node: Node):
	.remove_child(node)
	_disconnect_component(node)

func queue_free():
	emit_signal("parent_freed", {"parent": self})
	.queue_free()

func emit_event(event_name, data=null):
	if has_user_signal(event_name):
		emit_signal(event_name, data)
	if has_method(event_name):
		call(event_name, data)

func move(data: Dictionary):
	var new_grid_position = grid_position + data.direction
	if !Globals.space_is_wall(new_grid_position):
		var entity_at_position = Globals.entity_map.get(new_grid_position)
		if entity_at_position:
			entity_at_position.emit_event("space_entered", {"entity": self})
		else:
			self.grid_position = new_grid_position
			prev_direction = data.direction
			emit_event("moved", {"grid_position": new_grid_position})
